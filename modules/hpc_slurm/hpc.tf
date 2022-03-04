/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

data "google_compute_image" "schedmd_slurm_img" {
  project = "schedmd-slurm-public"
  family  = "schedmd-slurm-21-08-4-hpc-centos-7"
}

module "slurm_cluster_controller" {
  source = "git::https://github.com/SchedMD/slurm-gcp.git//tf/modules/controller?ref=v4.1.5"

  project      = module.slurm_project.project_id
  image        = data.google_compute_image.schedmd_slurm_img.self_link
  cluster_name = var.slurm_controller_cluster_name
  region       = var.region
  partitions   = var.slurm_controller_partitions
}