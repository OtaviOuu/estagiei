defmodule EstagieiWeb.EstagioLive.Show do
  use EstagieiWeb, :live_view

  alias Estagiei.Internships

  def mount(%{"id" => _id}, _session, socket) do
    json_string = "{
      \"company\": \"CloudWalk\",
      \"title\": \"Robotics Research & Development Engineer – Humanoid Robotics\",
      \"description\": \"Help build CloudWalk's ambitious R&D program around humanoid robotics. Own the full cycle of developing locomotion and high-level behaviors: design tasks and environments in NVIDIA IsaacLab/Sim/Gym, train policies with RL/IL, validate on simulation, and deploy on physical humanoid robots (Sim2Real).\",
      \"metadata\": {
        \"division\": \"The Robotics Division\",
        \"location\": \"São Paulo, Brazil\",
        \"work_model\": \"Hybrid (remote collaboration + on-site lab sessions)\",
        \"responsibilities\": [
          \"Invent and build humanoid tasks and environments\",
          \"Train and refine policies using RSL-RL, RL-Games, Stable-Baselines3 or similar\",
          \"Explore reinforcement learning, imitation learning, diffusion and transformer-based policies\",
          \"Close the Sim2Real gap via domain/dynamics randomization, calibration, and staged deployment\",
          \"Integrate with ROS 2 and NVIDIA robotics stack (Isaac ROS, cuRobo/cuMotion, NVBlox)\",
          \"Orchestrate behaviors with BehaviorTree.CPP/Groot and experiment with Isaac GR00T\",
          \"Measure and iterate with reproducible pipelines, dashboards, and documentation\"
        ],
        \"requirements\": [
          \"Solid ML and RL foundations (PPO, SAC, TD3) with hands-on PyTorch experience\",
          \"Proficiency in NVIDIA Isaac ecosystem – Isaac Sim/Isaac Lab, Isaac Gym, OmniIsaacGymEnvs, Orbit\",
          \"Strong ROS 2 skills – ros2_control, lifecycle nodes, planning, perception integration\",
          \"Sim2Real expertise – domain randomization, dynamics tuning, safe hardware deployment\",
          \"Engineering best practices – version control, containerization, reproducibility, documentation\",
          \"Must work on-site in São Paulo for robotics lab sessions\"
        ],
        \"bonus_points\": [
          \"Legged locomotion experience with humanoid control tasks (Legged Gym, ETH Zurich RSL)\",
          \"MuJoCo-based RL workflows (Gymnasium, dm_control, robosuite)\",
          \"Advanced policy architectures – Diffusion/Transformer policies\",
          \"NVIDIA robotics stack experience – GPU-accelerated planning (cuRobo, cuMotion), Isaac ROS perception (NVBlox, VSLAM)\",
          \"Real-time systems and mechatronics knowledge (PREEMPT_RT, C++ optimization)\",
          \"Strong portfolio of robotics and ML projects (GitHub, demonstrations, papers)\"
        ],
        \"recruiting_process\": [
          \"Technical challenge (robotics, simulation, machine learning)\",
          \"Technical interview\",
          \"Cultural interview\"
        ],
        \"notes\": [
          \"Candidates must be willing to take an online quiz and demonstrate technical capabilities with both simulation and physical robotics\"
        ],
        \"diversity_inclusion\": \"CloudWalk promotes social inclusion, respect, and a welcoming environment for all people regardless of gender, ethnicity, race, religion, sexuality, mobility, disability, or education.\",
        \"apply_link\": \"https://www.linkedin.com/jobs/view/4286706067\",
        \"image\": \"https://media.licdn.com/dms/image/v2/D4D3DAQGqhryEldQBJg/image-scale_191_1128/image-scale_191_1128/0/1738710383040/cloudwalk_inc_cover?e=1757959200&v=beta&t=ofnIv89WJRTN6CwAu_gWyedjjgQ5-3b_KnM0uPTYflk\"
      }
    }"

    {:ok, job_map} = Jason.decode(json_string)

    {:ok, assign(socket, :internship, job_map)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="min-h-screen bg-base-200">
        <!-- Hero Section -->
        <div class="hero bg-gradient-to-r from-primary to-secondary text-primary-content py-16">
          <div class="hero-content text-center max-w-4xl">
            <div>
              <div class="mb-4">
                <img
                  src={@internship["metadata"]["image"]}
                  alt={@internship["company"]}
                  class="w-32 h-32 mx-auto rounded-xl shadow-lg object-cover"
                />
              </div>
              <h1 class="text-5xl font-bold mb-4">{@internship["title"]}</h1>
              <div class="flex flex-wrap justify-center gap-4 mb-6">
                <div class="badge badge-accent badge-lg">{@internship["company"]}</div>
                <div class="badge badge-outline badge-lg">{@internship["metadata"]["location"]}</div>
                <div class="badge badge-outline badge-lg">
                  {@internship["metadata"]["work_model"]}
                </div>
              </div>
              <p class="text-xl leading-relaxed max-w-3xl">{@internship["description"]}</p>
            </div>
          </div>
        </div>

        <div class="container mx-auto px-4 py-12">
          <div class="grid lg:grid-cols-3 gap-8">
            <!-- Main Content -->
            <div class="lg:col-span-2 space-y-8">
              <!-- Responsibilities -->
              <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                  <h2 class="card-title text-2xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                      >
                      </path>
                    </svg>
                    Responsibilities
                  </h2>
                  <ul class="space-y-3">
                    <li
                      :for={item <- @internship["metadata"]["responsibilities"]}
                      class="flex items-start gap-3"
                    >
                      <span class="badge badge-primary badge-sm mt-1 flex-shrink-0"></span>
                      <span class="text-base">{item}</span>
                    </li>
                  </ul>
                </div>
              </div>
              
    <!-- Requirements -->
              <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                  <h2 class="card-title text-2xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
                      >
                      </path>
                    </svg>
                    Requirements
                  </h2>
                  <ul class="space-y-3">
                    <li
                      :for={item <- @internship["metadata"]["requirements"]}
                      class="flex items-start gap-3"
                    >
                      <span class="badge badge-error badge-sm mt-1 flex-shrink-0"></span>
                      <span class="text-base">{item}</span>
                    </li>
                  </ul>
                </div>
              </div>
              
    <!-- Bonus Points -->
              <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                  <h2 class="card-title text-2xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"
                      >
                      </path>
                    </svg>
                    Bonus Points
                  </h2>
                  <ul class="space-y-3">
                    <li
                      :for={item <- @internship["metadata"]["bonus_points"]}
                      class="flex items-start gap-3"
                    >
                      <span class="badge badge-warning badge-sm mt-1 flex-shrink-0"></span>
                      <span class="text-base">{item}</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
    <!-- Sidebar -->
            <div class="space-y-8">
              <!-- Division Info -->
              <div class="card bg-gradient-to-br from-primary to-secondary text-primary-content shadow-xl">
                <div class="card-body">
                  <h2 class="card-title text-xl">Division</h2>
                  <p class="text-lg font-semibold">{@internship["metadata"]["division"]}</p>
                </div>
              </div>
              
    <!-- Apply Button -->
              <div class="card bg-base-100 shadow-xl">
                <div class="card-body text-center">
                  <h2 class="card-title justify-center mb-4">Ready to Apply?</h2>
                  <a
                    href={@internship["metadata"]["apply_link"]}
                    target="_blank"
                    class="btn btn-primary btn-lg w-full"
                  >
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M13 10V3L4 14h7v7l9-11h-7z"
                      >
                      </path>
                    </svg>
                    Apply Now
                  </a>
                </div>
              </div>
              
    <!-- Recruiting Process -->
              <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                  <h2 class="card-title text-xl mb-4">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M9 5l7 7-7 7"
                      >
                      </path>
                    </svg>
                    Process
                  </h2>
                  <ul class="steps steps-vertical">
                    <li
                      :for={
                        {step, index} <-
                          Enum.with_index(@internship["metadata"]["recruiting_process"], 1)
                      }
                      class="step step-primary"
                    >
                      <div class="text-left">
                        <div class="font-semibold">Step {index}</div>
                        <div class="text-sm opacity-70">{step}</div>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
              
    <!-- Important Notes -->
              <div class="alert alert-info shadow-lg">
                <svg class="stroke-current shrink-0 w-6 h-6" fill="none" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                  >
                  </path>
                </svg>
                <div>
                  <h3 class="font-bold">Important Note!</h3>
                  <div class="text-sm">
                    <p :for={note <- @internship["metadata"]["notes"]}>{note}</p>
                  </div>
                </div>
              </div>
              
    <!-- Diversity & Inclusion -->
              <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                  <h2 class="card-title text-lg">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"
                      >
                      </path>
                    </svg>
                    Diversity & Inclusion
                  </h2>
                  <p class="text-sm leading-relaxed">
                    {@internship["metadata"]["diversity_inclusion"]}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
