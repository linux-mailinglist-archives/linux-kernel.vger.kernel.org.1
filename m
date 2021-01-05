Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78A72EA395
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbhAEC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:41800 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbhAEC7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:49 -0500
IronPort-SDR: 8DJrphAAFzvutX8/0DfpXOa9aVGwTAHWOT6iRWFdkqCZHDnIzULvQnNvUoHPOsg0KDATDDWWA1
 YwNlaJefVHgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827530"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827530"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:19 -0800
IronPort-SDR: 5RHKIOFGUH9M8DxqdulyZWJLLVZa/xFp8kVkTSPXGNIuTSqHD9Mx8EmwNH67L0DcximdkC4u1S
 bqreMUw1THfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632174"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:18 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 15/20] dlb: add queue map, unmap, and pending unmap operations
Date:   Mon,  4 Jan 2021 20:58:34 -0600
Message-Id: <20210105025839.23169-16-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the high-level code for queue map, unmap, and pending unmap query ioctl
commands and argument verification -- with stubs for the low-level register
accesses and the queue map/unmap state machine, to be filled in a later
commit.

The queue map/unmap in this commit refers to link/unlink between DLB's
load-balanced queues (internal) and consumer ports.See Documentation/
misc-devices/dlb.rst for details.

Load-balanced queues can be "mapped" to any number of load-balanced ports.
Once mapped, the port becomes a candidate to which the device can schedule
queue entries from the queue. If a port is unmapped from a queue, it is no
longer a candidate for scheduling from that queue.

The pending unmaps function queries how many unmap operations are
in-progress for a given port. These operations are asynchronous, so
multiple may be in-flight at any given time.

These operations support rte_event_port_link(), rte_event_port_unlink()
and rte_event_port_unlinks_in_progress() functions of DPDK's eventdev
library.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_ioctl.c    |  13 +-
 drivers/misc/dlb/dlb_main.h     |  12 +
 drivers/misc/dlb/dlb_pf_ops.c   |  30 +++
 drivers/misc/dlb/dlb_resource.c | 424 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_resource.h |  21 ++
 include/uapi/linux/dlb.h        |  81 ++++++
 6 files changed, 579 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
index a4cd5490e425..c6ddf1db41d1 100644
--- a/drivers/misc/dlb/dlb_ioctl.c
+++ b/drivers/misc/dlb/dlb_ioctl.c
@@ -45,6 +45,9 @@ DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(start_domain)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(map_qid)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(unmap_qid)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(pending_port_unmaps)
 
 /*
  * Port creation ioctls don't use the callback template macro.
@@ -305,7 +308,10 @@ static dlb_domain_ioctl_fn_t dlb_domain_ioctl_fns[NUM_DLB_DOMAIN_CMD] = {
 	dlb_domain_ioctl_get_ldb_port_cq_fd,
 	dlb_domain_ioctl_get_dir_port_pp_fd,
 	dlb_domain_ioctl_get_dir_port_cq_fd,
-	dlb_domain_ioctl_start_domain
+	dlb_domain_ioctl_start_domain,
+	dlb_domain_ioctl_map_qid,
+	dlb_domain_ioctl_unmap_qid,
+	dlb_domain_ioctl_pending_port_unmaps
 };
 
 static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
@@ -319,7 +325,10 @@ static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
 	sizeof(struct dlb_get_port_fd_args),
 	sizeof(struct dlb_get_port_fd_args),
 	sizeof(struct dlb_get_port_fd_args),
-	sizeof(struct dlb_start_domain_args)
+	sizeof(struct dlb_start_domain_args),
+	sizeof(struct dlb_map_qid_args),
+	sizeof(struct dlb_unmap_qid_args),
+	sizeof(struct dlb_pending_port_unmaps_args)
 };
 
 long
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 63dffdf56d6f..28fef9897e40 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -66,6 +66,18 @@ struct dlb_device_ops {
 			    u32 domain_id,
 			    struct dlb_start_domain_args *args,
 			    struct dlb_cmd_response *resp);
+	int (*map_qid)(struct dlb_hw *hw,
+		       u32 domain_id,
+		       struct dlb_map_qid_args *args,
+		       struct dlb_cmd_response *resp);
+	int (*unmap_qid)(struct dlb_hw *hw,
+			 u32 domain_id,
+			 struct dlb_unmap_qid_args *args,
+			 struct dlb_cmd_response *resp);
+	int (*pending_port_unmaps)(struct dlb_hw *hw,
+				   u32 domain_id,
+				   struct dlb_pending_port_unmaps_args *args,
+				   struct dlb_cmd_response *resp);
 	int (*get_num_resources)(struct dlb_hw *hw,
 				 struct dlb_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb_hw *hw, u32 domain_id);
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
index 9823ce1da2fc..4805d8890ec0 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -181,6 +181,33 @@ dlb_pf_start_domain(struct dlb_hw *hw,
 	return dlb_hw_start_domain(hw, id, args, resp, false, 0);
 }
 
+static int
+dlb_pf_map_qid(struct dlb_hw *hw,
+	       u32 id,
+	       struct dlb_map_qid_args *args,
+	       struct dlb_cmd_response *resp)
+{
+	return dlb_hw_map_qid(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb_pf_unmap_qid(struct dlb_hw *hw,
+		 u32 id,
+		 struct dlb_unmap_qid_args *args,
+		 struct dlb_cmd_response *resp)
+{
+	return dlb_hw_unmap_qid(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb_pf_pending_port_unmaps(struct dlb_hw *hw,
+			   u32 id,
+			   struct dlb_pending_port_unmaps_args *args,
+			   struct dlb_cmd_response *resp)
+{
+	return dlb_hw_pending_port_unmaps(hw, id, args, resp, false, 0);
+}
+
 static int
 dlb_pf_get_num_resources(struct dlb_hw *hw,
 			 struct dlb_get_num_resources_args *args)
@@ -262,6 +289,9 @@ struct dlb_device_ops dlb_pf_ops = {
 	.create_ldb_port = dlb_pf_create_ldb_port,
 	.create_dir_port = dlb_pf_create_dir_port,
 	.start_domain = dlb_pf_start_domain,
+	.map_qid = dlb_pf_map_qid,
+	.unmap_qid = dlb_pf_unmap_qid,
+	.pending_port_unmaps = dlb_pf_pending_port_unmaps,
 	.get_num_resources = dlb_pf_get_num_resources,
 	.reset_domain = dlb_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb_pf_ldb_port_owned_by_domain,
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 40f4679b716d..2e10cb249b7d 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -237,6 +237,34 @@ static struct dlb_hw_domain *dlb_get_domain_from_id(struct dlb_hw *hw,
 	return NULL;
 }
 
+static struct dlb_ldb_port *
+dlb_get_domain_used_ldb_port(u32 id,
+			     bool vdev_req,
+			     struct dlb_hw_domain *domain)
+{
+	struct dlb_ldb_port *port;
+	int i;
+
+	if (id >= DLB_MAX_NUM_LDB_PORTS)
+		return NULL;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+		}
+
+		list_for_each_entry(port, &domain->avail_ldb_ports[i], domain_list) {
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+		}
+	}
+
+	return NULL;
+}
+
 static struct dlb_ldb_port *
 dlb_get_domain_ldb_port(u32 id,
 			bool vdev_req,
@@ -1291,6 +1319,128 @@ static int dlb_verify_start_domain_args(struct dlb_hw *hw,
 	return 0;
 }
 
+static int dlb_verify_map_qid_args(struct dlb_hw *hw,
+				   u32 domain_id,
+				   struct dlb_map_qid_args *args,
+				   struct dlb_cmd_response *resp,
+				   bool vdev_req,
+				   unsigned int vdev_id,
+				   struct dlb_hw_domain **out_domain,
+				   struct dlb_ldb_port **out_port,
+				   struct dlb_ldb_queue **out_queue)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+	struct dlb_ldb_port *port;
+	int id;
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
+	id = args->port_id;
+
+	port = dlb_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	if (!port || !port->configured) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	if (args->priority >= DLB_QID_PRIORITIES) {
+		resp->status = DLB_ST_INVALID_PRIORITY;
+		return -EINVAL;
+	}
+
+	queue = dlb_get_domain_ldb_queue(args->qid, vdev_req, domain);
+
+	if (!queue || !queue->configured) {
+		resp->status = DLB_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	if (queue->domain_id.phys_id != domain->id.phys_id) {
+		resp->status = DLB_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	if (port->domain_id.phys_id != domain->id.phys_id) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_queue = queue;
+	*out_port = port;
+
+	return 0;
+}
+
+static int dlb_verify_unmap_qid_args(struct dlb_hw *hw,
+				     u32 domain_id,
+				     struct dlb_unmap_qid_args *args,
+				     struct dlb_cmd_response *resp,
+				     bool vdev_req,
+				     unsigned int vdev_id,
+				     struct dlb_hw_domain **out_domain,
+				     struct dlb_ldb_port **out_port,
+				     struct dlb_ldb_queue **out_queue)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+	struct dlb_ldb_port *port;
+	int id;
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
+	id = args->port_id;
+
+	port = dlb_get_domain_used_ldb_port(id, vdev_req, domain);
+
+	if (!port || !port->configured) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	if (port->domain_id.phys_id != domain->id.phys_id) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	queue = dlb_get_domain_ldb_queue(args->qid, vdev_req, domain);
+
+	if (!queue || !queue->configured) {
+		DLB_HW_ERR(hw, "[%s()] Can't unmap unconfigured queue %d\n",
+			   __func__, args->qid);
+		resp->status = DLB_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_port = port;
+	*out_queue = queue;
+
+	return 0;
+}
+
 static void dlb_configure_domain_credits(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
 {
@@ -2328,6 +2478,201 @@ int dlb_hw_create_dir_port(struct dlb_hw *hw,
 	return 0;
 }
 
+static unsigned int
+dlb_domain_finish_unmap_qid_procedures(struct dlb_hw *hw,
+				       struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static unsigned int
+dlb_domain_finish_map_qid_procedures(struct dlb_hw *hw,
+				     struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static void dlb_log_map_qid(struct dlb_hw *hw,
+			    u32 domain_id,
+			    struct dlb_map_qid_args *args,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB map QID arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID: %d\n",
+		   domain_id);
+	DLB_HW_DBG(hw, "\tPort ID:   %d\n",
+		   args->port_id);
+	DLB_HW_DBG(hw, "\tQueue ID:  %d\n",
+		   args->qid);
+	DLB_HW_DBG(hw, "\tPriority:  %d\n",
+		   args->priority);
+}
+
+/**
+ * dlb_hw_map_qid() - map a load-balanced queue to a load-balanced port
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: map QID arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to schedule QEs from the specified queue
+ * to the specified port. Each load-balanced port can be mapped to up to 8
+ * queues; each load-balanced queue can potentially map to all the
+ * load-balanced ports.
+ *
+ * A successful return does not necessarily mean the mapping was configured. If
+ * this function is unable to immediately map the queue to the port, it will
+ * add the requested operation to a per-port list of pending map/unmap
+ * operations, and (if it's not already running) launch a kernel thread that
+ * periodically attempts to process all pending operations. In a sense, this is
+ * an asynchronous function.
+ *
+ * This asynchronicity creates two views of the state of hardware: the actual
+ * hardware state and the requested state (as if every request completed
+ * immediately). If there are any pending map/unmap operations, the requested
+ * state will differ from the actual state. All validation is performed with
+ * respect to the pending state; for instance, if there are 8 pending map
+ * operations for port X, a request for a 9th will fail because a load-balanced
+ * port can only map up to 8 queues.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, invalid port or queue ID, or
+ *	    the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb_hw_map_qid(struct dlb_hw *hw,
+		   u32 domain_id,
+		   struct dlb_map_qid_args *args,
+		   struct dlb_cmd_response *resp,
+		   bool vdev_req,
+		   unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+	struct dlb_ldb_port *port;
+	int ret;
+
+	dlb_log_map_qid(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb_verify_map_qid_args(hw,
+				      domain_id,
+				      args,
+				      resp,
+				      vdev_req,
+				      vdev_id,
+				      &domain,
+				      &port,
+				      &queue);
+	if (ret)
+		return ret;
+
+	resp->status = 0;
+
+	return 0;
+}
+
+static void dlb_log_unmap_qid(struct dlb_hw *hw,
+			      u32 domain_id,
+			      struct dlb_unmap_qid_args *args,
+			      bool vdev_req,
+			      unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB unmap QID arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID: %d\n",
+		   domain_id);
+	DLB_HW_DBG(hw, "\tPort ID:   %d\n",
+		   args->port_id);
+	DLB_HW_DBG(hw, "\tQueue ID:  %d\n",
+		   args->qid);
+	if (args->qid < DLB_MAX_NUM_LDB_QUEUES)
+		DLB_HW_DBG(hw, "\tQueue's num mappings:  %d\n",
+			   hw->rsrcs.ldb_queues[args->qid].num_mappings);
+}
+
+/**
+ * dlb_hw_unmap_qid() - Unmap a load-balanced queue from a load-balanced port
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: unmap QID arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function configures the DLB to stop scheduling QEs from the specified
+ * queue to the specified port.
+ *
+ * A successful return does not necessarily mean the mapping was removed. If
+ * this function is unable to immediately unmap the queue from the port, it
+ * will add the requested operation to a per-port list of pending map/unmap
+ * operations, and (if it's not already running) launch a kernel thread that
+ * periodically attempts to process all pending operations. See
+ * dlb_hw_map_qid() for more details.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, invalid port or queue ID, or
+ *	    the domain is not configured.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb_hw_unmap_qid(struct dlb_hw *hw,
+		     u32 domain_id,
+		     struct dlb_unmap_qid_args *args,
+		     struct dlb_cmd_response *resp,
+		     bool vdev_req,
+		     unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+	struct dlb_ldb_port *port;
+	int ret;
+
+	dlb_log_unmap_qid(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb_verify_unmap_qid_args(hw,
+					domain_id,
+					args,
+					resp,
+					vdev_req,
+					vdev_id,
+					&domain,
+					&port,
+					&queue);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static u32 dlb_ldb_cq_inflight_count(struct dlb_hw *hw,
 				     struct dlb_ldb_port *port)
 {
@@ -2674,6 +3019,66 @@ int dlb_hw_get_dir_queue_depth(struct dlb_hw *hw,
 	return 0;
 }
 
+static void
+dlb_log_pending_port_unmaps_args(struct dlb_hw *hw,
+				 struct dlb_pending_port_unmaps_args *args,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB unmaps in progress arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from VF %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tPort ID: %d\n", args->port_id);
+}
+
+/**
+ * dlb_hw_pending_port_unmaps() - returns the number of unmap operations in
+ *	progress.
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: number of unmaps in progress args
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the number of unmaps in progress.
+ *
+ * Errors:
+ * EINVAL - Invalid port ID.
+ */
+int dlb_hw_pending_port_unmaps(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_pending_port_unmaps_args *args,
+			       struct dlb_cmd_response *resp,
+			       bool vdev_req,
+			       unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_port *port;
+
+	dlb_log_pending_port_unmaps_args(hw, args, vdev_req, vdev_id);
+
+	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain) {
+		resp->status = DLB_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	port = dlb_get_domain_used_ldb_port(args->port_id, vdev_req, domain);
+	if (!port || !port->configured) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		return -EINVAL;
+	}
+
+	resp->id = port->num_pending_removals;
+
+	return 0;
+}
+
 static u32 dlb_ldb_queue_depth(struct dlb_hw *hw,
 			       struct dlb_ldb_queue *queue)
 {
@@ -3386,6 +3791,13 @@ static int dlb_domain_drain_mapped_queues(struct dlb_hw *hw,
 	return 0;
 }
 
+static int dlb_domain_drain_unmapped_queues(struct dlb_hw *hw,
+					    struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+	return 0;
+}
+
 static int dlb_drain_dir_cq(struct dlb_hw *hw,
 			    struct dlb_dir_pq_pair *port)
 {
@@ -3693,6 +4105,14 @@ int dlb_reset_domain(struct dlb_hw *hw,
 	if (ret)
 		return ret;
 
+	ret = dlb_domain_finish_unmap_qid_procedures(hw, domain);
+	if (ret)
+		return ret;
+
+	ret = dlb_domain_finish_map_qid_procedures(hw, domain);
+	if (ret)
+		return ret;
+
 	/* Re-enable the CQs in order to drain the mapped queues. */
 	dlb_domain_enable_ldb_cqs(hw, domain);
 
@@ -3700,6 +4120,10 @@ int dlb_reset_domain(struct dlb_hw *hw,
 	if (ret)
 		return ret;
 
+	ret = dlb_domain_drain_unmapped_queues(hw, domain);
+	if (ret)
+		return ret;
+
 	/* Done draining LDB QEs, so disable the CQs. */
 	dlb_domain_disable_ldb_cqs(hw, domain);
 
diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
index 7a1798c9505b..5fbc9d0b5e96 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -57,6 +57,20 @@ int dlb_hw_start_domain(struct dlb_hw *hw,
 			bool vdev_req,
 			unsigned int vdev_id);
 
+int dlb_hw_map_qid(struct dlb_hw *hw,
+		   u32 domain_id,
+		   struct dlb_map_qid_args *args,
+		   struct dlb_cmd_response *resp,
+		   bool vdev_req,
+		   unsigned int vdev_id);
+
+int dlb_hw_unmap_qid(struct dlb_hw *hw,
+		     u32 domain_id,
+		     struct dlb_unmap_qid_args *args,
+		     struct dlb_cmd_response *resp,
+		     bool vdev_req,
+		     unsigned int vdev_id);
+
 int dlb_reset_domain(struct dlb_hw *hw,
 		     u32 domain_id,
 		     bool vdev_req,
@@ -95,6 +109,13 @@ int dlb_hw_get_dir_queue_depth(struct dlb_hw *hw,
 			       bool vdev_req,
 			       unsigned int vdev_id);
 
+int dlb_hw_pending_port_unmaps(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_pending_port_unmaps_args *args,
+			       struct dlb_cmd_response *resp,
+			       bool vdev_req,
+			       unsigned int vdev_id);
+
 void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw);
 
 void dlb_hw_enable_sparse_dir_cq_mode(struct dlb_hw *hw);
diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
index fdc5fd7eb41f..14b0618803e4 100644
--- a/include/uapi/linux/dlb.h
+++ b/include/uapi/linux/dlb.h
@@ -35,6 +35,8 @@ enum dlb_error {
 	DLB_ST_INVALID_CQ_DEPTH,
 	DLB_ST_INVALID_HIST_LIST_DEPTH,
 	DLB_ST_INVALID_DIR_QUEUE_ID,
+	DLB_ST_INVALID_PRIORITY,
+	DLB_ST_NO_QID_SLOTS_AVAILABLE,
 };
 
 struct dlb_cmd_response {
@@ -420,6 +422,70 @@ struct dlb_start_domain_args {
 	struct dlb_cmd_response response;
 };
 
+/*
+ * DLB_DOMAIN_CMD_MAP_QID: Map a load-balanced queue to a load-balanced port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - qid: Load-balanced queue ID.
+ * - priority: Queue->port service priority.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb_map_qid_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 qid;
+	__u32 priority;
+	__u32 padding0;
+};
+
+/*
+ * DLB_DOMAIN_CMD_UNMAP_QID: Unmap a load-balanced queue to a load-balanced
+ *	port.
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ * - qid: Load-balanced queue ID.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb_unmap_qid_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 qid;
+};
+
+/*
+ * DLB_DOMAIN_CMD_PENDING_PORT_UNMAPS: Get number of queue unmap operations in
+ *	progress for a load-balanced port.
+ *
+ *	Note: This is a snapshot; the number of unmap operations in progress
+ *	is subject to change at any time.
+ *
+ * Input parameters:
+ * - port_id: Load-balanced port ID.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: number of unmaps in progress.
+ */
+struct dlb_pending_port_unmaps_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 padding0;
+};
+
 enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -432,6 +498,9 @@ enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_GET_DIR_PORT_PP_FD,
 	DLB_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,
 	DLB_DOMAIN_CMD_START_DOMAIN,
+	DLB_DOMAIN_CMD_MAP_QID,
+	DLB_DOMAIN_CMD_UNMAP_QID,
+	DLB_DOMAIN_CMD_PENDING_PORT_UNMAPS,
 
 	/* NUM_DLB_DOMAIN_CMD must be last */
 	NUM_DLB_DOMAIN_CMD,
@@ -510,5 +579,17 @@ enum dlb_domain_user_interface_commands {
 		_IOR(DLB_IOC_MAGIC,				\
 		     DLB_DOMAIN_CMD_START_DOMAIN,		\
 		     struct dlb_start_domain_args)
+#define DLB_IOC_MAP_QID						\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_MAP_QID,			\
+		      struct dlb_map_qid_args)
+#define DLB_IOC_UNMAP_QID					\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_UNMAP_QID,			\
+		      struct dlb_unmap_qid_args)
+#define DLB_IOC_PENDING_PORT_UNMAPS				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_PENDING_PORT_UNMAPS,	\
+		      struct dlb_pending_port_unmaps_args)
 
 #endif /* __DLB_H */
-- 
2.17.1

