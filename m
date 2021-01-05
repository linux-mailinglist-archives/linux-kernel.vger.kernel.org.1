Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18B2EA394
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbhAEC7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:41796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbhAEC7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:42 -0500
IronPort-SDR: D5SnP0Ugag9H5UMCV+B0q+gZCsTKxHl4YFpAQVgGy31Nlbgo3ihIdm0PHJrXUOb+MK7dQPOm3e
 rHt/ure/LQLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827529"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827529"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:18 -0800
IronPort-SDR: kBfxJiXv74TtR6R161TWdah2KQhyYolVnR0+jIZ4vh/oXCc73SWNL2lqfOn3U7x0kMhm5FGtdY
 6x1HWPqb2FHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632168"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:18 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 14/20] dlb: add start domain ioctl
Date:   Mon,  4 Jan 2021 20:58:33 -0600
Message-Id: <20210105025839.23169-15-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctl to start a domain. Once a scheduling domain and its resources
have been configured, this ioctl is called to allow the domain's ports to
begin enqueueing to the device. Once started, the domain's resources cannot
be configured again until after the domain is reset.

This ioctl instructs the DLB device to start load-balancing operations.
It corresponds to rte_event_dev_start() function in DPDK' eventdev library.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_ioctl.c    |   7 +-
 drivers/misc/dlb/dlb_main.h     |   4 +
 drivers/misc/dlb/dlb_pf_ops.c   |  10 +++
 drivers/misc/dlb/dlb_resource.c | 127 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_resource.h |   7 ++
 include/uapi/linux/dlb.h        |  22 ++++++
 6 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
index 4a11595671a7..a4cd5490e425 100644
--- a/drivers/misc/dlb/dlb_ioctl.c
+++ b/drivers/misc/dlb/dlb_ioctl.c
@@ -44,6 +44,7 @@ DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_ldb_queue)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
 DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(start_domain)
 
 /*
  * Port creation ioctls don't use the callback template macro.
@@ -303,7 +304,8 @@ static dlb_domain_ioctl_fn_t dlb_domain_ioctl_fns[NUM_DLB_DOMAIN_CMD] = {
 	dlb_domain_ioctl_get_ldb_port_pp_fd,
 	dlb_domain_ioctl_get_ldb_port_cq_fd,
 	dlb_domain_ioctl_get_dir_port_pp_fd,
-	dlb_domain_ioctl_get_dir_port_cq_fd
+	dlb_domain_ioctl_get_dir_port_cq_fd,
+	dlb_domain_ioctl_start_domain
 };
 
 static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
@@ -316,7 +318,8 @@ static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
 	sizeof(struct dlb_get_port_fd_args),
 	sizeof(struct dlb_get_port_fd_args),
 	sizeof(struct dlb_get_port_fd_args),
-	sizeof(struct dlb_get_port_fd_args)
+	sizeof(struct dlb_get_port_fd_args),
+	sizeof(struct dlb_start_domain_args)
 };
 
 long
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 6458fea7c1be..63dffdf56d6f 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -62,6 +62,10 @@ struct dlb_device_ops {
 			       struct dlb_create_dir_port_args *args,
 			       uintptr_t cq_dma_base,
 			       struct dlb_cmd_response *resp);
+	int (*start_domain)(struct dlb_hw *hw,
+			    u32 domain_id,
+			    struct dlb_start_domain_args *args,
+			    struct dlb_cmd_response *resp);
 	int (*get_num_resources)(struct dlb_hw *hw,
 				 struct dlb_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb_hw *hw, u32 domain_id);
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
index 8065f880ba99..9823ce1da2fc 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -172,6 +172,15 @@ dlb_pf_create_dir_port(struct dlb_hw *hw,
 				       resp, false, 0);
 }
 
+static int
+dlb_pf_start_domain(struct dlb_hw *hw,
+		    u32 id,
+		    struct dlb_start_domain_args *args,
+		    struct dlb_cmd_response *resp)
+{
+	return dlb_hw_start_domain(hw, id, args, resp, false, 0);
+}
+
 static int
 dlb_pf_get_num_resources(struct dlb_hw *hw,
 			 struct dlb_get_num_resources_args *args)
@@ -252,6 +261,7 @@ struct dlb_device_ops dlb_pf_ops = {
 	.create_dir_queue = dlb_pf_create_dir_queue,
 	.create_ldb_port = dlb_pf_create_ldb_port,
 	.create_dir_port = dlb_pf_create_dir_port,
+	.start_domain = dlb_pf_start_domain,
 	.get_num_resources = dlb_pf_get_num_resources,
 	.reset_domain = dlb_pf_reset_domain,
 	.ldb_port_owned_by_domain = dlb_pf_ldb_port_owned_by_domain,
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 6947353afe34..40f4679b716d 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -1260,6 +1260,37 @@ dlb_verify_create_dir_port_args(struct dlb_hw *hw,
 	return 0;
 }
 
+static int dlb_verify_start_domain_args(struct dlb_hw *hw,
+					u32 domain_id,
+					struct dlb_cmd_response *resp,
+					bool vdev_req,
+					unsigned int vdev_id,
+					struct dlb_hw_domain **out_domain)
+{
+	struct dlb_hw_domain *domain;
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
+	*out_domain = domain;
+
+	return 0;
+}
+
 static void dlb_configure_domain_credits(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
 {
@@ -2860,6 +2891,102 @@ static void dlb_domain_reset_ldb_port_registers(struct dlb_hw *hw,
 	}
 }
 
+static void dlb_log_start_domain(struct dlb_hw *hw,
+				 u32 domain_id,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB start domain arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+}
+
+/**
+ * dlb_hw_start_domain() - start a scheduling domain
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @unused: unused.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function starts a scheduling domain, which allows applications to send
+ * traffic through it. Once a domain is started, its resources can no longer be
+ * configured (besides QID remapping and port enable/disable).
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error.
+ *
+ * Errors:
+ * EINVAL - the domain is not configured, or the domain is already started.
+ */
+int
+dlb_hw_start_domain(struct dlb_hw *hw,
+		    u32 domain_id,
+		    void *unused,
+		    struct dlb_cmd_response *resp,
+		    bool vdev_req,
+		    unsigned int vdev_id)
+{
+	struct dlb_dir_pq_pair *dir_queue;
+	struct dlb_ldb_queue *ldb_queue;
+	struct dlb_hw_domain *domain;
+	int ret;
+
+	dlb_log_start_domain(hw, domain_id, vdev_req, vdev_id);
+
+	ret = dlb_verify_start_domain_args(hw,
+					   domain_id,
+					   resp,
+					   vdev_req,
+					   vdev_id,
+					   &domain);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable load-balanced and directed queue write permissions for the
+	 * queues this domain owns. Without this, the DLB will drop all
+	 * incoming traffic to those queues.
+	 */
+	list_for_each_entry(ldb_queue, &domain->used_ldb_queues, domain_list) {
+		u32 vasqid_v = 0;
+		unsigned int offs;
+
+		BIT_SET(vasqid_v, SYS_LDB_VASQID_V_VASQID_V);
+
+		offs = domain->id.phys_id * DLB_MAX_NUM_LDB_QUEUES +
+			ldb_queue->id.phys_id;
+
+		DLB_CSR_WR(hw, SYS_LDB_VASQID_V(offs), vasqid_v);
+	}
+
+	list_for_each_entry(dir_queue, &domain->used_dir_pq_pairs, domain_list) {
+		u32 vasqid_v = 0;
+		unsigned int offs;
+
+		BIT_SET(vasqid_v, SYS_DIR_VASQID_V_VASQID_V);
+
+		offs = domain->id.phys_id * DLB_MAX_NUM_DIR_PORTS +
+			dir_queue->id.phys_id;
+
+		DLB_CSR_WR(hw, SYS_DIR_VASQID_V(offs), vasqid_v);
+	}
+
+	dlb_flush_csr(hw);
+
+	domain->started = true;
+
+	resp->status = 0;
+
+	return 0;
+}
+
 static void
 __dlb_domain_reset_dir_port_registers(struct dlb_hw *hw,
 				      struct dlb_dir_pq_pair *port)
diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
index 7a3f699b8d20..7a1798c9505b 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -50,6 +50,13 @@ int dlb_hw_create_ldb_port(struct dlb_hw *hw,
 			   bool vdev_req,
 			   unsigned int vdev_id);
 
+int dlb_hw_start_domain(struct dlb_hw *hw,
+			u32 domain_id,
+			void *unused,
+			struct dlb_cmd_response *resp,
+			bool vdev_req,
+			unsigned int vdev_id);
+
 int dlb_reset_domain(struct dlb_hw *hw,
 		     u32 domain_id,
 		     bool vdev_req,
diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
index 31fb99a463a7..fdc5fd7eb41f 100644
--- a/include/uapi/linux/dlb.h
+++ b/include/uapi/linux/dlb.h
@@ -403,6 +403,23 @@ struct dlb_get_port_fd_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB_DOMAIN_CMD_START_DOMAIN: Mark the end of the domain configuration. This
+ *	must be called before passing QEs into the device, and no configuration
+ *	ioctls can be issued once the domain has started. Sending QEs into the
+ *	device before calling this ioctl will result in undefined behavior.
+ * Input parameters:
+ * - (None)
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb_start_domain_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+};
+
 enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -414,6 +431,7 @@ enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_GET_LDB_PORT_CQ_FD,
 	DLB_DOMAIN_CMD_GET_DIR_PORT_PP_FD,
 	DLB_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,
+	DLB_DOMAIN_CMD_START_DOMAIN,
 
 	/* NUM_DLB_DOMAIN_CMD must be last */
 	NUM_DLB_DOMAIN_CMD,
@@ -488,5 +506,9 @@ enum dlb_domain_user_interface_commands {
 		_IOWR(DLB_IOC_MAGIC,				\
 		      DLB_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,	\
 		      struct dlb_get_port_fd_args)
+#define DLB_IOC_START_DOMAIN					\
+		_IOR(DLB_IOC_MAGIC,				\
+		     DLB_DOMAIN_CMD_START_DOMAIN,		\
+		     struct dlb_start_domain_args)
 
 #endif /* __DLB_H */
-- 
2.17.1

