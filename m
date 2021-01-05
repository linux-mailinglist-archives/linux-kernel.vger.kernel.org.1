Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7132EA391
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbhAEC7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:41800 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbhAEC7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:33 -0500
IronPort-SDR: WDzRUvQV1Rakk2YzHbhxwmP+/E0ghPrDv8Uhz+pV7V+ENfkCEBCoJbVNKi81YusdBTAwOrDMWF
 2xYED0zB4HmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827523"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827523"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:17 -0800
IronPort-SDR: 8mKE4N+ZE4H1DqJNPYWGR6fgtRP2kbX/QcsAsa7nWcH9kEqKqJE6L8uVQYlkwMW/Ax1QZGMUpj
 QafgmgYmqbfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632158"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:17 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 11/20] dlb: add ioctl to configure ports and query poll mode
Date:   Mon,  4 Jan 2021 20:58:30 -0600
Message-Id: <20210105025839.23169-12-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add high-level code for port configuration and poll-mode query ioctl
commands, argument verification, and placeholder functions for the
low-level register accesses. A subsequent commit will add the low-level
logic.

The port is a core's interface to the DLB, and it consists of an MMIO page
(the "producer port" (PP)) through which the core enqueues queue entries
and an in-memory queue (the "consumer queue" (CQ)) to which the device
schedules QEs. A subsequent commit will add the mmap interface for an
application to directly access the PP and CQ regions.

The driver allocates DMA memory for each port's CQ, and frees this memory
during domain reset or driver removal. Domain reset will also drains each
port's CQ and disables them from further scheduling.

The device supports two formats ("standard" and "sparse") for CQ entries,
dubbed the "poll mode". This (device-wide) mode is selected by the driver;
to determine the mode at run time, the driver provides an ioctl for
user-space software to query which mode the driver has configured. In this
way, the policy of which mode to use is decoupled from user-space software.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_ioctl.c    | 141 ++++++++-
 drivers/misc/dlb/dlb_main.c     |  51 ++++
 drivers/misc/dlb/dlb_main.h     |  24 ++
 drivers/misc/dlb/dlb_pf_ops.c   |  52 ++++
 drivers/misc/dlb/dlb_resource.c | 492 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_resource.h |  20 ++
 include/uapi/linux/dlb.h        | 105 +++++++
 7 files changed, 881 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
index b875221a16c6..75ffa75a0a7b 100644
--- a/drivers/misc/dlb/dlb_ioctl.c
+++ b/drivers/misc/dlb/dlb_ioctl.c
@@ -44,6 +44,115 @@ DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
 
+/*
+ * Port creation ioctls don't use the callback template macro.
+ */
+static int dlb_domain_ioctl_create_ldb_port(struct dlb *dlb,
+					    struct dlb_domain *domain,
+					    void *karg)
+{
+	struct dlb_create_ldb_port_args *arg = karg;
+	struct dlb_cmd_response *resp;
+	dma_addr_t cq_dma_base = 0;
+	void *cq_base;
+	int ret;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	BUILD_BUG_ON(offsetof(typeof(*arg), response) != 0);
+	resp = &arg->response;
+
+	cq_base = dma_alloc_coherent(&dlb->pdev->dev,
+				     DLB_CQ_SIZE,
+				     &cq_dma_base,
+				     GFP_KERNEL);
+	if (!cq_base) {
+		resp->status = DLB_ST_NO_MEMORY;
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = dlb->ops->create_ldb_port(&dlb->hw,
+					domain->id,
+					arg,
+					(uintptr_t)cq_dma_base,
+					resp);
+	if (ret)
+		goto unlock;
+
+	/* Fill out the per-port data structure */
+	dlb->ldb_port[resp->id].id = resp->id;
+	dlb->ldb_port[resp->id].is_ldb = true;
+	dlb->ldb_port[resp->id].domain = domain;
+	dlb->ldb_port[resp->id].cq_base = cq_base;
+	dlb->ldb_port[resp->id].cq_dma_base = cq_dma_base;
+	dlb->ldb_port[resp->id].valid = true;
+
+unlock:
+	if (ret && cq_dma_base)
+		dma_free_coherent(&dlb->pdev->dev,
+				  DLB_CQ_SIZE,
+				  cq_base,
+				  cq_dma_base);
+
+	mutex_unlock(&dlb->resource_mutex);
+
+	return ret;
+}
+
+static int dlb_domain_ioctl_create_dir_port(struct dlb *dlb,
+					    struct dlb_domain *domain,
+					    void *karg)
+{
+	struct dlb_create_dir_port_args *arg = karg;
+	struct dlb_cmd_response *resp;
+	dma_addr_t cq_dma_base = 0;
+	void *cq_base;
+	int ret;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	BUILD_BUG_ON(offsetof(typeof(*arg), response) != 0);
+	resp = &arg->response;
+
+	cq_base = dma_alloc_coherent(&dlb->pdev->dev,
+				     DLB_CQ_SIZE,
+				     &cq_dma_base,
+				     GFP_KERNEL);
+	if (!cq_base) {
+		resp->status = DLB_ST_NO_MEMORY;
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = dlb->ops->create_dir_port(&dlb->hw,
+					 domain->id,
+					 arg,
+					 (uintptr_t)cq_dma_base,
+					 resp);
+	if (ret)
+		goto unlock;
+
+	/* Fill out the per-port data structure */
+	dlb->dir_port[resp->id].id = resp->id;
+	dlb->dir_port[resp->id].is_ldb = false;
+	dlb->dir_port[resp->id].domain = domain;
+	dlb->dir_port[resp->id].cq_base = cq_base;
+	dlb->dir_port[resp->id].cq_dma_base = cq_dma_base;
+	dlb->dir_port[resp->id].valid = true;
+
+unlock:
+	if (ret && cq_dma_base)
+		dma_free_coherent(&dlb->pdev->dev,
+				  DLB_CQ_SIZE,
+				  cq_base,
+				  cq_dma_base);
+
+	mutex_unlock(&dlb->resource_mutex);
+
+	return ret;
+}
+
 typedef int (*dlb_domain_ioctl_fn_t)(struct dlb *dlb,
 				     struct dlb_domain *domain,
 				     void *karg);
@@ -52,14 +161,18 @@ static dlb_domain_ioctl_fn_t dlb_domain_ioctl_fns[NUM_DLB_DOMAIN_CMD] = {
 	dlb_domain_ioctl_create_ldb_queue,
 	dlb_domain_ioctl_create_dir_queue,
 	dlb_domain_ioctl_get_ldb_queue_depth,
-	dlb_domain_ioctl_get_dir_queue_depth
+	dlb_domain_ioctl_get_dir_queue_depth,
+	dlb_domain_ioctl_create_ldb_port,
+	dlb_domain_ioctl_create_dir_port
 };
 
 static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
 	sizeof(struct dlb_create_ldb_queue_args),
 	sizeof(struct dlb_create_dir_queue_args),
 	sizeof(struct dlb_get_ldb_queue_depth_args),
-	sizeof(struct dlb_get_dir_queue_depth_args)
+	sizeof(struct dlb_get_dir_queue_depth_args),
+	sizeof(struct dlb_create_ldb_port_args),
+	sizeof(struct dlb_create_dir_port_args)
 };
 
 long
@@ -189,19 +302,39 @@ static int dlb_ioctl_get_num_resources(struct dlb *dlb,
 	return ret;
 }
 
+static int dlb_ioctl_query_cq_poll_mode(struct dlb *dlb,
+					void *karg)
+{
+	struct dlb_query_cq_poll_mode_args *arg = karg;
+	struct dlb_cmd_response *resp;
+	int ret;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	BUILD_BUG_ON(offsetof(typeof(*arg), response) != 0);
+	resp = &arg->response;
+
+	ret = dlb->ops->query_cq_poll_mode(dlb, resp);
+	mutex_unlock(&dlb->resource_mutex);
+
+	return ret;
+}
+
 typedef int (*dlb_ioctl_fn_t)(struct dlb *dlb,
 			      void *karg);
 
 static dlb_ioctl_fn_t dlb_ioctl_fns[NUM_DLB_CMD] = {
 	dlb_ioctl_get_device_version,
 	dlb_ioctl_create_sched_domain,
-	dlb_ioctl_get_num_resources
+	dlb_ioctl_get_num_resources,
+	dlb_ioctl_query_cq_poll_mode
 };
 
 static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
 	sizeof(struct dlb_get_device_version_args),
 	sizeof(struct dlb_create_sched_domain_args),
-	sizeof(struct dlb_get_num_resources_args)
+	sizeof(struct dlb_get_num_resources_args),
+	sizeof(struct dlb_query_cq_poll_mode_args)
 };
 
 long
diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index b5aef228c6db..21cea1399c95 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -143,12 +143,56 @@ int dlb_init_domain(struct dlb *dlb, u32 domain_id)
 	return 0;
 }
 
+static void dlb_release_port_memory(struct dlb *dlb,
+				    struct dlb_port *port,
+				    bool check_domain,
+				    u32 domain_id)
+{
+	if (port->valid &&
+	    (!check_domain || port->domain->id == domain_id))
+		dma_free_coherent(&dlb->pdev->dev,
+				  DLB_CQ_SIZE,
+				  port->cq_base,
+				  port->cq_dma_base);
+
+	port->valid = false;
+}
+
+static void dlb_release_domain_memory(struct dlb *dlb,
+				      bool check_domain,
+				      u32 domain_id)
+{
+	struct dlb_port *port;
+	int i;
+
+	for (i = 0; i < DLB_MAX_NUM_LDB_PORTS; i++) {
+		port = &dlb->ldb_port[i];
+
+		dlb_release_port_memory(dlb, port, check_domain, domain_id);
+	}
+
+	for (i = 0; i < DLB_MAX_NUM_DIR_PORTS; i++) {
+		port = &dlb->dir_port[i];
+
+		dlb_release_port_memory(dlb, port, check_domain, domain_id);
+	}
+}
+
+static void dlb_release_device_memory(struct dlb *dlb)
+{
+	dlb_release_domain_memory(dlb, false, 0);
+}
+
 static int __dlb_free_domain(struct dlb_domain *domain)
 {
 	struct dlb *dlb = domain->dlb;
 	int ret;
 
 	ret = dlb->ops->reset_domain(&dlb->hw, domain->id);
+
+	/* Unpin and free all memory pages associated with the domain */
+	dlb_release_domain_memory(dlb, true, domain->id);
+
 	if (ret) {
 		dlb->domain_reset_failed = true;
 		dev_err(dlb->dev,
@@ -293,6 +337,8 @@ static int dlb_probe(struct pci_dev *pdev,
 	if (ret)
 		goto init_driver_state_fail;
 
+	dlb->ops->init_hardware(dlb);
+
 	/*
 	 * Undo the 'get' operation by the PCI layer during probe and
 	 * (if PF) immediately suspend the device. Since the device is only
@@ -329,6 +375,8 @@ static void dlb_remove(struct pci_dev *pdev)
 
 	dlb_resource_free(&dlb->hw);
 
+	dlb_release_device_memory(dlb);
+
 	device_destroy(dlb_class, dlb->dev_number);
 
 	pci_disable_pcie_error_reporting(pdev);
@@ -342,6 +390,9 @@ static void dlb_remove(struct pci_dev *pdev)
 static void dlb_reset_hardware_state(struct dlb *dlb)
 {
 	dlb_reset_device(dlb->pdev);
+
+	/* Reinitialize any other hardware state */
+	dlb->ops->init_hardware(dlb);
 }
 
 static int dlb_runtime_suspend(struct device *dev)
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 6f913ec3e84d..6b06ba42e50a 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -50,6 +50,16 @@ struct dlb_device_ops {
 				u32 domain_id,
 				struct dlb_create_dir_queue_args *args,
 				struct dlb_cmd_response *resp);
+	int (*create_ldb_port)(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_create_ldb_port_args *args,
+			       uintptr_t cq_dma_base,
+			       struct dlb_cmd_response *resp);
+	int (*create_dir_port)(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_create_dir_port_args *args,
+			       uintptr_t cq_dma_base,
+			       struct dlb_cmd_response *resp);
 	int (*get_num_resources)(struct dlb_hw *hw,
 				 struct dlb_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb_hw *hw, u32 domain_id);
@@ -61,11 +71,23 @@ struct dlb_device_ops {
 				   u32 domain_id,
 				   struct dlb_get_dir_queue_depth_args *args,
 				   struct dlb_cmd_response *resp);
+	void (*init_hardware)(struct dlb *dlb);
+	int (*query_cq_poll_mode)(struct dlb *dlb,
+				  struct dlb_cmd_response *user_resp);
 };
 
 extern struct dlb_device_ops dlb_pf_ops;
 extern const struct file_operations dlb_domain_fops;
 
+struct dlb_port {
+	void *cq_base;
+	dma_addr_t cq_dma_base;
+	struct dlb_domain *domain;
+	int id;
+	u8 is_ldb;
+	u8 valid;
+};
+
 struct dlb_domain {
 	struct dlb *dlb;
 	struct kref refcnt;
@@ -79,6 +101,8 @@ struct dlb {
 	struct device *dev;
 	struct dlb_domain *sched_domains[DLB_MAX_NUM_DOMAINS];
 	struct file *f;
+	struct dlb_port ldb_port[DLB_MAX_NUM_LDB_PORTS];
+	struct dlb_port dir_port[DLB_MAX_NUM_DIR_PORTS];
 	/*
 	 * The resource mutex serializes access to driver data structures and
 	 * hardware registers.
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
index 5f8e2bc2ece9..74393fb1e944 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -108,6 +108,18 @@ dlb_pf_wait_for_device_ready(struct dlb *dlb, struct pci_dev *pdev)
 	return 0;
 }
 
+static bool dlb_sparse_cq_enabled = true;
+
+static void
+dlb_pf_init_hardware(struct dlb *dlb)
+{
+	if (dlb_sparse_cq_enabled) {
+		dlb_hw_enable_sparse_ldb_cq_mode(&dlb->hw);
+
+		dlb_hw_enable_sparse_dir_cq_mode(&dlb->hw);
+	}
+}
+
 /*****************************/
 /****** IOCTL callbacks ******/
 /*****************************/
@@ -138,6 +150,28 @@ dlb_pf_create_dir_queue(struct dlb_hw *hw,
 	return dlb_hw_create_dir_queue(hw, id, args, resp, false, 0);
 }
 
+static int
+dlb_pf_create_ldb_port(struct dlb_hw *hw,
+		       u32 id,
+		       struct dlb_create_ldb_port_args *args,
+		       uintptr_t cq_dma_base,
+		       struct dlb_cmd_response *resp)
+{
+	return dlb_hw_create_ldb_port(hw, id, args, cq_dma_base,
+				       resp, false, 0);
+}
+
+static int
+dlb_pf_create_dir_port(struct dlb_hw *hw,
+		       u32 id,
+		       struct dlb_create_dir_port_args *args,
+		       uintptr_t cq_dma_base,
+		       struct dlb_cmd_response *resp)
+{
+	return dlb_hw_create_dir_port(hw, id, args, cq_dma_base,
+				       resp, false, 0);
+}
+
 static int
 dlb_pf_get_num_resources(struct dlb_hw *hw,
 			 struct dlb_get_num_resources_args *args)
@@ -169,6 +203,20 @@ dlb_pf_get_dir_queue_depth(struct dlb_hw *hw,
 	return dlb_hw_get_dir_queue_depth(hw, id, args, resp, false, 0);
 }
 
+static int
+dlb_pf_query_cq_poll_mode(struct dlb *dlb,
+			  struct dlb_cmd_response *user_resp)
+{
+	user_resp->status = 0;
+
+	if (dlb_sparse_cq_enabled)
+		user_resp->id = DLB_CQ_POLL_MODE_SPARSE;
+	else
+		user_resp->id = DLB_CQ_POLL_MODE_STD;
+
+	return 0;
+}
+
 /********************************/
 /****** DLB PF Device Ops ******/
 /********************************/
@@ -182,8 +230,12 @@ struct dlb_device_ops dlb_pf_ops = {
 	.create_sched_domain = dlb_pf_create_sched_domain,
 	.create_ldb_queue = dlb_pf_create_ldb_queue,
 	.create_dir_queue = dlb_pf_create_dir_queue,
+	.create_ldb_port = dlb_pf_create_ldb_port,
+	.create_dir_port = dlb_pf_create_dir_port,
 	.get_num_resources = dlb_pf_get_num_resources,
 	.reset_domain = dlb_pf_reset_domain,
 	.get_ldb_queue_depth = dlb_pf_get_ldb_queue_depth,
 	.get_dir_queue_depth = dlb_pf_get_dir_queue_depth,
+	.init_hardware = dlb_pf_init_hardware,
+	.query_cq_poll_mode = dlb_pf_query_cq_poll_mode,
 };
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index c022f67a1366..1abbca56aa49 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -1032,6 +1032,183 @@ static void dlb_configure_dir_queue(struct dlb_hw *hw,
 	queue->queue_configured = true;
 }
 
+static bool
+dlb_cq_depth_is_valid(u32 depth)
+{
+	u32 n = ilog2(depth);
+
+	/* Valid values for depth are
+	 * 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, and 1024.
+	 */
+	if (depth > 1024 || ((1U << n) != depth))
+		return false;
+
+	return true;
+}
+
+static int
+dlb_verify_create_ldb_port_args(struct dlb_hw *hw,
+				u32 domain_id,
+				uintptr_t cq_dma_base,
+				struct dlb_create_ldb_port_args *args,
+				struct dlb_cmd_response *resp,
+				bool vdev_req,
+				unsigned int vdev_id,
+				struct dlb_hw_domain **out_domain,
+				struct dlb_ldb_port **out_port,
+				int *out_cos_id)
+{
+	struct dlb_ldb_port *port = NULL;
+	struct dlb_hw_domain *domain;
+	int i, id;
+
+	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	if (domain->started) {
+		resp->status = DLB_ST_DOMAIN_STARTED;
+		return -EINVAL;
+	}
+
+	if (args->cos_id >= DLB_NUM_COS_DOMAINS) {
+		resp->status = DLB_ST_INVALID_COS_ID;
+		return -EINVAL;
+	}
+
+	if (args->cos_strict) {
+		id = args->cos_id;
+		port = list_first_entry_or_null(&domain->avail_ldb_ports[id],
+						typeof(*port), domain_list);
+	} else {
+		for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+			id = (args->cos_id + i) % DLB_NUM_COS_DOMAINS;
+
+			port = list_first_entry_or_null(&domain->avail_ldb_ports[id],
+							typeof(*port), domain_list);
+			if (port)
+				break;
+		}
+	}
+
+	if (!port) {
+		resp->status = DLB_ST_LDB_PORTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	/* DLB requires 64B alignment */
+	if (!IS_ALIGNED(cq_dma_base, 64)) {
+		resp->status = DLB_ST_INVALID_CQ_VIRT_ADDR;
+		return -EINVAL;
+	}
+
+	if (!dlb_cq_depth_is_valid(args->cq_depth)) {
+		resp->status = DLB_ST_INVALID_CQ_DEPTH;
+		return -EINVAL;
+	}
+
+	/* The history list size must be >= 1 */
+	if (!args->cq_history_list_size) {
+		resp->status = DLB_ST_INVALID_HIST_LIST_DEPTH;
+		return -EINVAL;
+	}
+
+	if (args->cq_history_list_size > domain->avail_hist_list_entries) {
+		resp->status = DLB_ST_HIST_LIST_ENTRIES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = port;
+	*out_cos_id = id;
+
+	return 0;
+}
+
+static int
+dlb_verify_create_dir_port_args(struct dlb_hw *hw,
+				u32 domain_id,
+				uintptr_t cq_dma_base,
+				struct dlb_create_dir_port_args *args,
+				struct dlb_cmd_response *resp,
+				bool vdev_req,
+				unsigned int vdev_id,
+				struct dlb_hw_domain **out_domain,
+				struct dlb_dir_pq_pair **out_port)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_dir_pq_pair *pq;
+
+	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	if (!domain->configured) {
+		resp->status = DLB_ST_DOMAIN_NOT_CONFIGURED;
+		return -EINVAL;
+	}
+
+	if (domain->started) {
+		resp->status = DLB_ST_DOMAIN_STARTED;
+		return -EINVAL;
+	}
+
+	if (args->queue_id != -1) {
+		/*
+		 * If the user claims the queue is already configured, validate
+		 * the queue ID, its domain, and whether the queue is
+		 * configured.
+		 */
+		pq = dlb_get_domain_used_dir_pq(args->queue_id,
+						vdev_req,
+						domain);
+
+		if (!pq || pq->domain_id.phys_id != domain->id.phys_id ||
+		    !pq->queue_configured) {
+			resp->status = DLB_ST_INVALID_DIR_QUEUE_ID;
+			return -EINVAL;
+		}
+	} else {
+		/*
+		 * If the port's queue is not configured, validate that a free
+		 * port-queue pair is available.
+		 */
+		pq = list_first_entry_or_null(&domain->avail_dir_pq_pairs,
+					      typeof(*pq), domain_list);
+		if (!pq) {
+			resp->status = DLB_ST_DIR_PORTS_UNAVAILABLE;
+			return -EINVAL;
+		}
+	}
+
+	/* DLB requires 64B alignment */
+	if (!IS_ALIGNED(cq_dma_base, 64)) {
+		resp->status = DLB_ST_INVALID_CQ_VIRT_ADDR;
+		return -EINVAL;
+	}
+
+	if (!dlb_cq_depth_is_valid(args->cq_depth)) {
+		resp->status = DLB_ST_INVALID_CQ_DEPTH;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = pq;
+
+	return 0;
+}
+
 static void dlb_configure_domain_credits(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
 {
@@ -1229,6 +1406,30 @@ static void dlb_dir_port_cq_disable(struct dlb_hw *hw,
 	dlb_flush_csr(hw);
 }
 
+static int dlb_configure_ldb_port(struct dlb_hw *hw,
+				  struct dlb_hw_domain *domain,
+				  struct dlb_ldb_port *port,
+				  uintptr_t cq_dma_base,
+				  struct dlb_create_ldb_port_args *args,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static int dlb_configure_dir_port(struct dlb_hw *hw,
+				  struct dlb_hw_domain *domain,
+				  struct dlb_dir_pq_pair *port,
+				  uintptr_t cq_dma_base,
+				  struct dlb_create_dir_port_args *args,
+				  bool vdev_req,
+				  unsigned int vdev_id)
+{
+	/* Placeholder */
+	return 0;
+}
+
 static void
 dlb_log_create_sched_domain_args(struct dlb_hw *hw,
 				 struct dlb_create_sched_domain_args *args,
@@ -1524,6 +1725,226 @@ int dlb_hw_create_dir_queue(struct dlb_hw *hw,
 	return 0;
 }
 
+static void
+dlb_log_create_ldb_port_args(struct dlb_hw *hw,
+			     u32 domain_id,
+			     uintptr_t cq_dma_base,
+			     struct dlb_create_ldb_port_args *args,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB create load-balanced port arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID:                 %d\n",
+		   domain_id);
+	DLB_HW_DBG(hw, "\tCQ depth:                  %d\n",
+		   args->cq_depth);
+	DLB_HW_DBG(hw, "\tCQ hist list size:         %d\n",
+		   args->cq_history_list_size);
+	DLB_HW_DBG(hw, "\tCQ base address:           0x%lx\n",
+		   cq_dma_base);
+	DLB_HW_DBG(hw, "\tCoS ID:                    %u\n", args->cos_id);
+	DLB_HW_DBG(hw, "\tStrict CoS allocation:     %u\n",
+		   args->cos_strict);
+}
+
+/**
+ * dlb_hw_create_ldb_port() - create a load-balanced port
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port creation arguments.
+ * @cq_dma_base: base address of the CQ memory. This can be a PA or an IOVA.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function creates a load-balanced port.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the port ID.
+ *
+ * resp->id contains a virtual ID if vdev_req is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, a credit setting is invalid, a
+ *	    pointer address is not properly aligned, the domain is not
+ *	    configured, or the domain has already been started.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb_hw_create_ldb_port(struct dlb_hw *hw,
+			   u32 domain_id,
+			   struct dlb_create_ldb_port_args *args,
+			   uintptr_t cq_dma_base,
+			   struct dlb_cmd_response *resp,
+			   bool vdev_req,
+			   unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_port *port;
+	int ret, cos_id;
+
+	dlb_log_create_ldb_port_args(hw,
+				     domain_id,
+				     cq_dma_base,
+				     args,
+				     vdev_req,
+				     vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb_verify_create_ldb_port_args(hw,
+					      domain_id,
+					      cq_dma_base,
+					      args,
+					      resp,
+					      vdev_req,
+					      vdev_id,
+					      &domain,
+					      &port,
+					      &cos_id);
+	if (ret)
+		return ret;
+
+	ret = dlb_configure_ldb_port(hw,
+				     domain,
+				     port,
+				     cq_dma_base,
+				     args,
+				     vdev_req,
+				     vdev_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list.
+	 */
+	list_del(&port->domain_list);
+
+	list_add(&port->domain_list, &domain->used_ldb_ports[cos_id]);
+
+	resp->status = 0;
+	resp->id = (vdev_req) ? port->id.virt_id : port->id.phys_id;
+
+	return 0;
+}
+
+static void
+dlb_log_create_dir_port_args(struct dlb_hw *hw,
+			     u32 domain_id,
+			     uintptr_t cq_dma_base,
+			     struct dlb_create_dir_port_args *args,
+			     bool vdev_req,
+			     unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB create directed port arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID:                 %d\n",
+		   domain_id);
+	DLB_HW_DBG(hw, "\tCQ depth:                  %d\n",
+		   args->cq_depth);
+	DLB_HW_DBG(hw, "\tCQ base address:           0x%lx\n",
+		   cq_dma_base);
+}
+
+/**
+ * dlb_hw_create_dir_port() - create a directed port
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: port creation arguments.
+ * @cq_dma_base: base address of the CQ memory. This can be a PA or an IOVA.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function creates a directed port.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the port ID.
+ *
+ * resp->id contains a virtual ID if vdev_req is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, a credit setting is invalid, a
+ *	    pointer address is not properly aligned, the domain is not
+ *	    configured, or the domain has already been started.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb_hw_create_dir_port(struct dlb_hw *hw,
+			   u32 domain_id,
+			   struct dlb_create_dir_port_args *args,
+			   uintptr_t cq_dma_base,
+			   struct dlb_cmd_response *resp,
+			   bool vdev_req,
+			   unsigned int vdev_id)
+{
+	struct dlb_dir_pq_pair *port;
+	struct dlb_hw_domain *domain;
+	int ret;
+
+	dlb_log_create_dir_port_args(hw,
+				     domain_id,
+				     cq_dma_base,
+				     args,
+				     vdev_req,
+				     vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb_verify_create_dir_port_args(hw,
+					      domain_id,
+					      cq_dma_base,
+					      args,
+					      resp,
+					      vdev_req,
+					      vdev_id,
+					      &domain,
+					      &port);
+	if (ret)
+		return ret;
+
+	ret = dlb_configure_dir_port(hw,
+				     domain,
+				     port,
+				     cq_dma_base,
+				     args,
+				     vdev_req,
+				     vdev_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list (if it's not already there).
+	 */
+	if (args->queue_id == -1) {
+		list_del(&port->domain_list);
+
+		list_add(&port->domain_list, &domain->used_dir_pq_pairs);
+	}
+
+	resp->status = 0;
+	resp->id = (vdev_req) ? port->id.virt_id : port->id.phys_id;
+
+	return 0;
+}
+
 static u32 dlb_ldb_cq_inflight_count(struct dlb_hw *hw,
 				     struct dlb_ldb_port *port)
 {
@@ -1612,6 +2033,13 @@ static void dlb_drain_ldb_cq(struct dlb_hw *hw, struct dlb_ldb_port *port)
 	}
 }
 
+static int dlb_domain_wait_for_ldb_cqs_to_empty(struct dlb_hw *hw,
+						struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+	return 0;
+}
+
 static int dlb_domain_reset_software_state(struct dlb_hw *hw,
 					   struct dlb_hw_domain *domain)
 {
@@ -2543,6 +2971,26 @@ static int dlb_domain_drain_dir_queues(struct dlb_hw *hw,
 	return 0;
 }
 
+static void
+dlb_domain_disable_dir_producer_ports(struct dlb_hw *hw,
+				      struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
+static void
+dlb_domain_disable_ldb_producer_ports(struct dlb_hw *hw,
+				      struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
+static void dlb_domain_disable_ldb_seq_checks(struct dlb_hw *hw,
+					      struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
 static void
 dlb_domain_disable_ldb_queue_write_perms(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
@@ -2673,6 +3121,22 @@ int dlb_reset_domain(struct dlb_hw *hw,
 
 	dlb_domain_disable_ldb_queue_write_perms(hw, domain);
 
+	/* Turn off completion tracking on all the domain's PPs. */
+	dlb_domain_disable_ldb_seq_checks(hw, domain);
+
+	/*
+	 * Disable the LDB CQs and drain them in order to complete the map and
+	 * unmap procedures, which require zero CQ inflights and zero QID
+	 * inflights respectively.
+	 */
+	dlb_domain_disable_ldb_cqs(hw, domain);
+
+	dlb_domain_drain_ldb_cqs(hw, domain, false);
+
+	ret = dlb_domain_wait_for_ldb_cqs_to_empty(hw, domain);
+	if (ret)
+		return ret;
+
 	/* Re-enable the CQs in order to drain the mapped queues. */
 	dlb_domain_enable_ldb_cqs(hw, domain);
 
@@ -2688,6 +3152,11 @@ int dlb_reset_domain(struct dlb_hw *hw,
 	/* Done draining DIR QEs, so disable the CQs. */
 	dlb_domain_disable_dir_cqs(hw, domain);
 
+	/* Disable PPs */
+	dlb_domain_disable_dir_producer_ports(hw, domain);
+
+	dlb_domain_disable_ldb_producer_ports(hw, domain);
+
 	ret = dlb_domain_verify_reset_success(hw, domain);
 	if (ret)
 		return ret;
@@ -2778,3 +3247,26 @@ void dlb_clr_pmcsr_disable(struct dlb_hw *hw)
 
 	DLB_CSR_WR(hw, CM_CFG_PM_PMCSR_DISABLE, pmcsr_dis);
 }
+
+/**
+ * dlb_hw_enable_sparse_ldb_cq_mode() - enable sparse mode for load-balanced
+ *	ports.
+ * @hw: dlb_hw handle for a particular device.
+ *
+ * This function must be called prior to configuring scheduling domains.
+ */
+void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw)
+{
+	/* Placeholder */
+}
+
+/**
+ * dlb_hw_enable_sparse_dir_cq_mode() - enable sparse mode for directed ports.
+ * @hw: dlb_hw handle for a particular device.
+ *
+ * This function must be called prior to configuring scheduling domains.
+ */
+void dlb_hw_enable_sparse_dir_cq_mode(struct dlb_hw *hw)
+{
+	/* Placeholder */
+}
diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
index d11b8c062e90..9cec0102ed12 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -34,6 +34,22 @@ int dlb_hw_create_dir_queue(struct dlb_hw *hw,
 			    bool vdev_req,
 			    unsigned int vdev_id);
 
+int dlb_hw_create_dir_port(struct dlb_hw *hw,
+			   u32 domain_id,
+			   struct dlb_create_dir_port_args *args,
+			   uintptr_t cq_dma_base,
+			   struct dlb_cmd_response *resp,
+			   bool vdev_req,
+			   unsigned int vdev_id);
+
+int dlb_hw_create_ldb_port(struct dlb_hw *hw,
+			   u32 domain_id,
+			   struct dlb_create_ldb_port_args *args,
+			   uintptr_t cq_dma_base,
+			   struct dlb_cmd_response *resp,
+			   bool vdev_req,
+			   unsigned int vdev_id);
+
 int dlb_reset_domain(struct dlb_hw *hw,
 		     u32 domain_id,
 		     bool vdev_req,
@@ -60,4 +76,8 @@ int dlb_hw_get_dir_queue_depth(struct dlb_hw *hw,
 			       bool vdev_req,
 			       unsigned int vdev_id);
 
+void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw);
+
+void dlb_hw_enable_sparse_dir_cq_mode(struct dlb_hw *hw);
+
 #endif /* __DLB_RESOURCE_H */
diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
index d3bf6e01b4ed..54d81a03d5cb 100644
--- a/include/uapi/linux/dlb.h
+++ b/include/uapi/linux/dlb.h
@@ -29,6 +29,12 @@ enum dlb_error {
 	DLB_ST_DIR_QUEUES_UNAVAILABLE,
 	DLB_ST_INVALID_PORT_ID,
 	DLB_ST_INVALID_LOCK_ID_COMP_LEVEL,
+	DLB_ST_NO_MEMORY,
+	DLB_ST_INVALID_COS_ID,
+	DLB_ST_INVALID_CQ_VIRT_ADDR,
+	DLB_ST_INVALID_CQ_DEPTH,
+	DLB_ST_INVALID_HIST_LIST_DEPTH,
+	DLB_ST_INVALID_DIR_QUEUE_ID,
 };
 
 struct dlb_cmd_response {
@@ -159,10 +165,32 @@ struct dlb_get_num_resources_args {
 	__u32 num_dir_credits;
 };
 
+enum dlb_cq_poll_modes {
+	DLB_CQ_POLL_MODE_STD,
+	DLB_CQ_POLL_MODE_SPARSE,
+
+	/* NUM_DLB_CQ_POLL_MODE must be last */
+	NUM_DLB_CQ_POLL_MODE,
+};
+
+/*
+ * DLB_CMD_QUERY_CQ_POLL_MODE: Query the CQ poll mode setting
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: CQ poll mode (see enum dlb_cq_poll_modes).
+ */
+struct dlb_query_cq_poll_mode_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+};
+
 enum dlb_user_interface_commands {
 	DLB_CMD_GET_DEVICE_VERSION,
 	DLB_CMD_CREATE_SCHED_DOMAIN,
 	DLB_CMD_GET_NUM_RESOURCES,
+	DLB_CMD_QUERY_CQ_POLL_MODE,
 
 	/* NUM_DLB_CMD must be last */
 	NUM_DLB_CMD,
@@ -280,16 +308,81 @@ struct dlb_get_dir_queue_depth_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB_DOMAIN_CMD_CREATE_LDB_PORT: Configure a load-balanced port.
+ * Input parameters:
+ * - cq_depth: Depth of the port's CQ. Must be a power-of-two between 8 and
+ *	1024, inclusive.
+ * - cq_depth_threshold: CQ depth interrupt threshold. A value of N means that
+ *	the CQ interrupt won't fire until there are N or more outstanding CQ
+ *	tokens.
+ * - num_hist_list_entries: Number of history list entries. This must be
+ *	greater than or equal cq_depth.
+ * - cos_id: class-of-service to allocate this port from. Must be between 0 and
+ *	3, inclusive.
+ * - cos_strict: If set, return an error if there are no available ports in the
+ *	requested class-of-service. Else, allocate the port from a different
+ *	class-of-service if the requested class has no available ports.
+ *
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: port ID.
+ */
+
+struct dlb_create_ldb_port_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u16 cq_depth;
+	__u16 cq_depth_threshold;
+	__u16 cq_history_list_size;
+	__u8 cos_id;
+	__u8 cos_strict;
+};
+
+/*
+ * DLB_DOMAIN_CMD_CREATE_DIR_PORT: Configure a directed port.
+ * Input parameters:
+ * - cq_depth: Depth of the port's CQ. Must be a power-of-two between 8 and
+ *	1024, inclusive.
+ * - cq_depth_threshold: CQ depth interrupt threshold. A value of N means that
+ *	the CQ interrupt won't fire until there are N or more outstanding CQ
+ *	tokens.
+ * - qid: Queue ID. If the corresponding directed queue is already created,
+ *	specify its ID here. Else this argument must be 0xFFFFFFFF to indicate
+ *	that the port is being created before the queue.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Port ID.
+ */
+struct dlb_create_dir_port_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u16 cq_depth;
+	__u16 cq_depth_threshold;
+	__s32 queue_id;
+};
+
 enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB_DOMAIN_CMD_CREATE_DIR_QUEUE,
 	DLB_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
 	DLB_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
+	DLB_DOMAIN_CMD_CREATE_LDB_PORT,
+	DLB_DOMAIN_CMD_CREATE_DIR_PORT,
 
 	/* NUM_DLB_DOMAIN_CMD must be last */
 	NUM_DLB_DOMAIN_CMD,
 };
 
+#define DLB_CQ_SIZE 65536
+
 /********************/
 /* dlb ioctl codes */
 /********************/
@@ -308,6 +401,10 @@ enum dlb_domain_user_interface_commands {
 		_IOR(DLB_IOC_MAGIC,				\
 		     DLB_CMD_GET_NUM_RESOURCES,			\
 		     struct dlb_get_num_resources_args)
+#define DLB_IOC_QUERY_CQ_POLL_MODE				\
+		_IOR(DLB_IOC_MAGIC,				\
+		     DLB_CMD_QUERY_CQ_POLL_MODE,		\
+		     struct dlb_query_cq_poll_mode_args)
 #define DLB_IOC_CREATE_LDB_QUEUE				\
 		_IOWR(DLB_IOC_MAGIC,				\
 		      DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,		\
@@ -324,5 +421,13 @@ enum dlb_domain_user_interface_commands {
 		_IOWR(DLB_IOC_MAGIC,				\
 		      DLB_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,	\
 		      struct dlb_get_dir_queue_depth_args)
+#define DLB_IOC_CREATE_LDB_PORT					\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_CREATE_LDB_PORT,		\
+		      struct dlb_create_ldb_port_args)
+#define DLB_IOC_CREATE_DIR_PORT					\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_CREATE_DIR_PORT,		\
+		      struct dlb_create_dir_port_args)
 
 #endif /* __DLB_H */
-- 
2.17.1

