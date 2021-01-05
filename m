Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0312EA38F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbhAEC71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:41795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbhAEC7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:25 -0500
IronPort-SDR: 41x+XZL6ND0e9WkcUxVudsjj50Mhh6DnrYu+PJbp1SLA6EUr+DTz6vmQ/xXoXEy++GUo1ZHOaw
 QyOPyduwEtag==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827521"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:16 -0800
IronPort-SDR: 0voIA5XW43OVnCfWo4Pp7EGcaPsU8EtoHdVUxCN0/fTCHKUoxJn1nud29G63G54Jc9M+Q5fr3w
 qWz3kC6sK9ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632146"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:16 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 09/20] dlb: add queue create, reset, get-depth ioctls
Date:   Mon,  4 Jan 2021 20:58:28 -0600
Message-Id: <20210105025839.23169-10-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctl commands to create DLB queues and query their depth, and the
corresponding scheduling domain reset code to drain the queues when they
are no longer in use.

When a CPU enqueues a queue entry (QE) to DLB, the QE entry is sent to
a DLB queue. These queues hold queue entries (QEs) that have not yet
been scheduled to a destination port. The queue's depth is the number of
QEs residing in a queue.

Each queue supports multiple priority levels, and while a directed queue
has a 1:1 mapping with a directed port, load-balanced queues can be
configured with a set of load-balanced ports that software desires the
queue's QEs to be scheduled to.

For ease of review, this commit is limited to higher-level code including
the ioctl commands, request verification, and debug log messages. All
register access/configuration code will be included in a subsequent commit.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_hw_types.h |  27 ++
 drivers/misc/dlb/dlb_ioctl.c    |  93 +++++
 drivers/misc/dlb/dlb_ioctl.h    |   2 +
 drivers/misc/dlb/dlb_main.c     |   2 +
 drivers/misc/dlb/dlb_main.h     |  16 +
 drivers/misc/dlb/dlb_pf_ops.c   |  40 ++
 drivers/misc/dlb/dlb_resource.c | 716 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_resource.h |  28 ++
 include/uapi/linux/dlb.h        | 147 +++++++
 9 files changed, 1071 insertions(+)

diff --git a/drivers/misc/dlb/dlb_hw_types.h b/drivers/misc/dlb/dlb_hw_types.h
index 766e471dbcb7..5dde91e22de7 100644
--- a/drivers/misc/dlb/dlb_hw_types.h
+++ b/drivers/misc/dlb/dlb_hw_types.h
@@ -152,6 +152,33 @@ struct dlb_sn_group {
 	u32 id;
 };
 
+static inline bool dlb_sn_group_full(struct dlb_sn_group *group)
+{
+	const u32 mask[] = {
+		0x0000ffff,  /* 64 SNs per queue */
+		0x000000ff,  /* 128 SNs per queue */
+		0x0000000f,  /* 256 SNs per queue */
+		0x00000003,  /* 512 SNs per queue */
+		0x00000001}; /* 1024 SNs per queue */
+
+	return group->slot_use_bitmap == mask[group->mode];
+}
+
+static inline int dlb_sn_group_alloc_slot(struct dlb_sn_group *group)
+{
+	const u32 bound[] = {16, 8, 4, 2, 1};
+	u32 i;
+
+	for (i = 0; i < bound[group->mode]; i++) {
+		if (!(group->slot_use_bitmap & BIT(i))) {
+			group->slot_use_bitmap |= BIT(i);
+			return i;
+		}
+	}
+
+	return -1;
+}
+
 static inline void
 dlb_sn_group_free_slot(struct dlb_sn_group *group, int slot)
 {
diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
index 674c352b50ec..b875221a16c6 100644
--- a/drivers/misc/dlb/dlb_ioctl.c
+++ b/drivers/misc/dlb/dlb_ioctl.c
@@ -10,6 +10,99 @@
 #include "dlb_ioctl.h"
 #include "dlb_main.h"
 
+/*
+ * The DLB domain ioctl callback template minimizes replication of boilerplate
+ * code to copy arguments, acquire and release the resource lock, and execute
+ * the command.  The arguments and response structure name should have the
+ * format dlb_<lower_name>_args.
+ */
+#define DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(lower_name)			   \
+static int dlb_domain_ioctl_##lower_name(struct dlb *dlb,		   \
+					 struct dlb_domain *domain,	   \
+					 void *karg)			   \
+{									   \
+	struct dlb_cmd_response *resp;					   \
+	struct dlb_##lower_name##_args *arg = karg;			   \
+	int ret;							   \
+									   \
+	mutex_lock(&dlb->resource_mutex);				   \
+									   \
+	BUILD_BUG_ON(offsetof(typeof(*arg), response) != 0);		   \
+	resp = &arg->response;						   \
+	ret = dlb->ops->lower_name(&dlb->hw,				   \
+				   domain->id,				   \
+				   arg,					   \
+				   resp);				   \
+									   \
+	mutex_unlock(&dlb->resource_mutex);				   \
+									   \
+	return ret;							   \
+}
+
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_ldb_queue)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(create_dir_queue)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_ldb_queue_depth)
+DLB_DOMAIN_IOCTL_CALLBACK_TEMPLATE(get_dir_queue_depth)
+
+typedef int (*dlb_domain_ioctl_fn_t)(struct dlb *dlb,
+				     struct dlb_domain *domain,
+				     void *karg);
+
+static dlb_domain_ioctl_fn_t dlb_domain_ioctl_fns[NUM_DLB_DOMAIN_CMD] = {
+	dlb_domain_ioctl_create_ldb_queue,
+	dlb_domain_ioctl_create_dir_queue,
+	dlb_domain_ioctl_get_ldb_queue_depth,
+	dlb_domain_ioctl_get_dir_queue_depth
+};
+
+static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
+	sizeof(struct dlb_create_ldb_queue_args),
+	sizeof(struct dlb_create_dir_queue_args),
+	sizeof(struct dlb_get_ldb_queue_depth_args),
+	sizeof(struct dlb_get_dir_queue_depth_args)
+};
+
+long
+dlb_domain_ioctl(struct file *f,
+		 unsigned int cmd,
+		 unsigned long user_arg)
+{
+	struct dlb_domain *dom = f->private_data;
+	struct dlb *dlb = dom->dlb;
+	dlb_domain_ioctl_fn_t fn;
+	u32 cmd_nr;
+	void *karg;
+	int size;
+	int ret;
+
+	if (_IOC_NR(cmd) >= NUM_DLB_DOMAIN_CMD) {
+		dev_err(dlb->dev, "[%s()] Unexpected DLB command %d\n",
+			__func__, _IOC_NR(cmd));
+		return -EINVAL;
+	}
+
+	/* Block potential speculation on invalid command numbers.
+	 */
+	cmd_nr = array_index_nospec(_IOC_NR(cmd), NUM_DLB_DOMAIN_CMD);
+
+	size = dlb_domain_ioctl_arg_size[cmd_nr];
+	fn = dlb_domain_ioctl_fns[cmd_nr];
+
+	karg = kzalloc(size, GFP_KERNEL);
+	if (!karg)
+		return -ENOMEM;
+
+	if (copy_from_user(karg, (void __user *)user_arg, size))
+		return -EFAULT;
+
+	ret = fn(dlb, dom, karg);
+
+	if (copy_to_user((void __user *)user_arg, karg, size))
+		return -EFAULT;
+
+	return ret;
+}
+
 /* [7:0]: device revision, [15:8]: device version */
 #define DLB_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
 
diff --git a/drivers/misc/dlb/dlb_ioctl.h b/drivers/misc/dlb/dlb_ioctl.h
index 0737676f4208..597021b6dc78 100644
--- a/drivers/misc/dlb/dlb_ioctl.h
+++ b/drivers/misc/dlb/dlb_ioctl.h
@@ -8,4 +8,6 @@
 
 long dlb_ioctl(struct file *f, unsigned int cmd, unsigned long user_arg);
 
+long dlb_domain_ioctl(struct file *f, unsigned int cmd, unsigned long user_arg);
+
 #endif /* __DLB_IOCTL_H */
diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index 67dc4d0319b0..b5aef228c6db 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -198,6 +198,8 @@ static int dlb_domain_close(struct inode *i, struct file *f)
 const struct file_operations dlb_domain_fops = {
 	.owner   = THIS_MODULE,
 	.release = dlb_domain_close,
+	.unlocked_ioctl = dlb_domain_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 /**********************************/
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 5f3c671e466f..6f913ec3e84d 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -42,9 +42,25 @@ struct dlb_device_ops {
 	int (*create_sched_domain)(struct dlb_hw *hw,
 				   struct dlb_create_sched_domain_args *args,
 				   struct dlb_cmd_response *resp);
+	int (*create_ldb_queue)(struct dlb_hw *hw,
+				u32 domain_id,
+				struct dlb_create_ldb_queue_args *args,
+				struct dlb_cmd_response *resp);
+	int (*create_dir_queue)(struct dlb_hw *hw,
+				u32 domain_id,
+				struct dlb_create_dir_queue_args *args,
+				struct dlb_cmd_response *resp);
 	int (*get_num_resources)(struct dlb_hw *hw,
 				 struct dlb_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb_hw *hw, u32 domain_id);
+	int (*get_ldb_queue_depth)(struct dlb_hw *hw,
+				   u32 domain_id,
+				   struct dlb_get_ldb_queue_depth_args *args,
+				   struct dlb_cmd_response *resp);
+	int (*get_dir_queue_depth)(struct dlb_hw *hw,
+				   u32 domain_id,
+				   struct dlb_get_dir_queue_depth_args *args,
+				   struct dlb_cmd_response *resp);
 };
 
 extern struct dlb_device_ops dlb_pf_ops;
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
index e989bc8f2c97..5f8e2bc2ece9 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -120,6 +120,24 @@ dlb_pf_create_sched_domain(struct dlb_hw *hw,
 	return dlb_hw_create_sched_domain(hw, args, resp, false, 0);
 }
 
+static int
+dlb_pf_create_ldb_queue(struct dlb_hw *hw,
+			u32 id,
+			struct dlb_create_ldb_queue_args *args,
+			struct dlb_cmd_response *resp)
+{
+	return dlb_hw_create_ldb_queue(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb_pf_create_dir_queue(struct dlb_hw *hw,
+			u32 id,
+			struct dlb_create_dir_queue_args *args,
+			struct dlb_cmd_response *resp)
+{
+	return dlb_hw_create_dir_queue(hw, id, args, resp, false, 0);
+}
+
 static int
 dlb_pf_get_num_resources(struct dlb_hw *hw,
 			 struct dlb_get_num_resources_args *args)
@@ -133,6 +151,24 @@ dlb_pf_reset_domain(struct dlb_hw *hw, u32 id)
 	return dlb_reset_domain(hw, id, false, 0);
 }
 
+static int
+dlb_pf_get_ldb_queue_depth(struct dlb_hw *hw,
+			   u32 id,
+			   struct dlb_get_ldb_queue_depth_args *args,
+			   struct dlb_cmd_response *resp)
+{
+	return dlb_hw_get_ldb_queue_depth(hw, id, args, resp, false, 0);
+}
+
+static int
+dlb_pf_get_dir_queue_depth(struct dlb_hw *hw,
+			   u32 id,
+			   struct dlb_get_dir_queue_depth_args *args,
+			   struct dlb_cmd_response *resp)
+{
+	return dlb_hw_get_dir_queue_depth(hw, id, args, resp, false, 0);
+}
+
 /********************************/
 /****** DLB PF Device Ops ******/
 /********************************/
@@ -144,6 +180,10 @@ struct dlb_device_ops dlb_pf_ops = {
 	.enable_pm = dlb_pf_enable_pm,
 	.wait_for_device_ready = dlb_pf_wait_for_device_ready,
 	.create_sched_domain = dlb_pf_create_sched_domain,
+	.create_ldb_queue = dlb_pf_create_ldb_queue,
+	.create_dir_queue = dlb_pf_create_dir_queue,
 	.get_num_resources = dlb_pf_get_num_resources,
 	.reset_domain = dlb_pf_reset_domain,
+	.get_ldb_queue_depth = dlb_pf_get_ldb_queue_depth,
+	.get_dir_queue_depth = dlb_pf_get_dir_queue_depth,
 };
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 3790d7d01d46..e1f2cb581cf9 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -225,6 +225,44 @@ static struct dlb_hw_domain *dlb_get_domain_from_id(struct dlb_hw *hw,
 	return NULL;
 }
 
+static struct dlb_dir_pq_pair *
+dlb_get_domain_used_dir_pq(u32 id,
+			   bool vdev_req,
+			   struct dlb_hw_domain *domain)
+{
+	struct dlb_dir_pq_pair *port;
+
+	if (id >= DLB_MAX_NUM_DIR_PORTS)
+		return NULL;
+
+	list_for_each_entry(port, &domain->used_dir_pq_pairs, domain_list) {
+		if ((!vdev_req && port->id.phys_id == id) ||
+		    (vdev_req && port->id.virt_id == id))
+			return port;
+	}
+
+	return NULL;
+}
+
+static struct dlb_ldb_queue *
+dlb_get_domain_ldb_queue(u32 id,
+			 bool vdev_req,
+			 struct dlb_hw_domain *domain)
+{
+	struct dlb_ldb_queue *queue;
+
+	if (id >= DLB_MAX_NUM_LDB_QUEUES)
+		return NULL;
+
+	list_for_each_entry(queue, &domain->used_ldb_queues, domain_list) {
+		if ((!vdev_req && queue->id.phys_id == id) ||
+		    (vdev_req && queue->id.virt_id == id))
+			return queue;
+	}
+
+	return NULL;
+}
+
 static int dlb_attach_ldb_queues(struct dlb_hw *hw,
 				 struct dlb_function_resources *rsrcs,
 				 struct dlb_hw_domain *domain,
@@ -684,6 +722,180 @@ dlb_verify_create_sched_dom_args(struct dlb_function_resources *rsrcs,
 	return 0;
 }
 
+static int
+dlb_verify_create_ldb_queue_args(struct dlb_hw *hw,
+				 u32 domain_id,
+				 struct dlb_create_ldb_queue_args *args,
+				 struct dlb_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id,
+				 struct dlb_hw_domain **out_domain,
+				 struct dlb_ldb_queue **out_queue)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+	int i;
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
+	queue = list_first_entry_or_null(&domain->avail_ldb_queues,
+					 typeof(*queue), domain_list);
+	if (!queue) {
+		resp->status = DLB_ST_LDB_QUEUES_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (args->num_sequence_numbers) {
+		for (i = 0; i < DLB_MAX_NUM_SEQUENCE_NUMBER_GROUPS; i++) {
+			struct dlb_sn_group *group = &hw->rsrcs.sn_groups[i];
+
+			if (group->sequence_numbers_per_queue ==
+			    args->num_sequence_numbers &&
+			    !dlb_sn_group_full(group))
+				break;
+		}
+
+		if (i == DLB_MAX_NUM_SEQUENCE_NUMBER_GROUPS) {
+			resp->status = DLB_ST_SEQUENCE_NUMBERS_UNAVAILABLE;
+			return -EINVAL;
+		}
+	}
+
+	if (args->num_qid_inflights > 4096) {
+		resp->status = DLB_ST_INVALID_QID_INFLIGHT_ALLOCATION;
+		return -EINVAL;
+	}
+
+	/* Inflights must be <= number of sequence numbers if ordered */
+	if (args->num_sequence_numbers != 0 &&
+	    args->num_qid_inflights > args->num_sequence_numbers) {
+		resp->status = DLB_ST_INVALID_QID_INFLIGHT_ALLOCATION;
+		return -EINVAL;
+	}
+
+	if (domain->num_avail_aqed_entries < args->num_atomic_inflights) {
+		resp->status = DLB_ST_ATOMIC_INFLIGHTS_UNAVAILABLE;
+		return -EINVAL;
+	}
+
+	if (args->num_atomic_inflights &&
+	    args->lock_id_comp_level != 0 &&
+	    args->lock_id_comp_level != 64 &&
+	    args->lock_id_comp_level != 128 &&
+	    args->lock_id_comp_level != 256 &&
+	    args->lock_id_comp_level != 512 &&
+	    args->lock_id_comp_level != 1024 &&
+	    args->lock_id_comp_level != 2048 &&
+	    args->lock_id_comp_level != 4096 &&
+	    args->lock_id_comp_level != 65536) {
+		resp->status = DLB_ST_INVALID_LOCK_ID_COMP_LEVEL;
+		return -EINVAL;
+	}
+
+	*out_domain = domain;
+	*out_queue = queue;
+
+	return 0;
+}
+
+static int
+dlb_verify_create_dir_queue_args(struct dlb_hw *hw,
+				 u32 domain_id,
+				 struct dlb_create_dir_queue_args *args,
+				 struct dlb_cmd_response *resp,
+				 bool vdev_req,
+				 unsigned int vdev_id,
+				 struct dlb_hw_domain **out_domain,
+				 struct dlb_dir_pq_pair **out_queue)
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
+	/*
+	 * If the user claims the port is already configured, validate the port
+	 * ID, its domain, and whether the port is configured.
+	 */
+	if (args->port_id != -1) {
+		pq = dlb_get_domain_used_dir_pq(args->port_id,
+						vdev_req,
+						domain);
+
+		if (!pq || pq->domain_id.phys_id != domain->id.phys_id ||
+		    !pq->port_configured) {
+			resp->status = DLB_ST_INVALID_PORT_ID;
+			return -EINVAL;
+		}
+	} else {
+		/*
+		 * If the queue's port is not configured, validate that a free
+		 * port-queue pair is available.
+		 */
+		pq = list_first_entry_or_null(&domain->avail_dir_pq_pairs,
+					      typeof(*pq), domain_list);
+		if (!pq) {
+			resp->status = DLB_ST_DIR_QUEUES_UNAVAILABLE;
+			return -EINVAL;
+		}
+	}
+
+	*out_domain = domain;
+	*out_queue = pq;
+
+	return 0;
+}
+
+static void dlb_configure_ldb_queue(struct dlb_hw *hw,
+				    struct dlb_hw_domain *domain,
+				    struct dlb_ldb_queue *queue,
+				    struct dlb_create_ldb_queue_args *args,
+				    bool vdev_req,
+				    unsigned int vdev_id)
+{
+	/* Placeholder */
+}
+
+static void dlb_configure_dir_queue(struct dlb_hw *hw,
+				    struct dlb_hw_domain *domain,
+				    struct dlb_dir_pq_pair *queue,
+				    struct dlb_create_dir_queue_args *args,
+				    bool vdev_req,
+				    unsigned int vdev_id)
+{
+	/* Placeholder */
+}
+
 static void dlb_configure_domain_credits(struct dlb_hw *hw,
 					 struct dlb_hw_domain *domain)
 {
@@ -769,6 +981,68 @@ dlb_domain_attach_resources(struct dlb_hw *hw,
 	return 0;
 }
 
+static int
+dlb_ldb_queue_attach_to_sn_group(struct dlb_hw *hw,
+				 struct dlb_ldb_queue *queue,
+				 struct dlb_create_ldb_queue_args *args)
+{
+	int slot = -1;
+	int i;
+
+	queue->sn_cfg_valid = false;
+
+	if (args->num_sequence_numbers == 0)
+		return 0;
+
+	for (i = 0; i < DLB_MAX_NUM_SEQUENCE_NUMBER_GROUPS; i++) {
+		struct dlb_sn_group *group = &hw->rsrcs.sn_groups[i];
+
+		if (group->sequence_numbers_per_queue ==
+		    args->num_sequence_numbers &&
+		    !dlb_sn_group_full(group)) {
+			slot = dlb_sn_group_alloc_slot(group);
+			if (slot >= 0)
+				break;
+		}
+	}
+
+	if (slot == -1) {
+		DLB_HW_ERR(hw,
+			   "[%s():%d] Internal error: no sequence number slots available\n",
+			   __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	queue->sn_cfg_valid = true;
+	queue->sn_group = i;
+	queue->sn_slot = slot;
+	return 0;
+}
+
+static int
+dlb_ldb_queue_attach_resources(struct dlb_hw *hw,
+			       struct dlb_hw_domain *domain,
+			       struct dlb_ldb_queue *queue,
+			       struct dlb_create_ldb_queue_args *args)
+{
+	int ret;
+
+	ret = dlb_ldb_queue_attach_to_sn_group(hw, queue, args);
+	if (ret)
+		return ret;
+
+	/* Attach QID inflights */
+	queue->num_qid_inflights = args->num_qid_inflights;
+
+	/* Attach atomic inflights */
+	queue->aqed_limit = args->num_atomic_inflights;
+
+	domain->num_avail_aqed_entries -= args->num_atomic_inflights;
+	domain->num_used_aqed_entries += args->num_atomic_inflights;
+
+	return 0;
+}
+
 static void
 dlb_log_create_sched_domain_args(struct dlb_hw *hw,
 				 struct dlb_create_sched_domain_args *args,
@@ -874,6 +1148,196 @@ int dlb_hw_create_sched_domain(struct dlb_hw *hw,
 	return 0;
 }
 
+static void
+dlb_log_create_ldb_queue_args(struct dlb_hw *hw,
+			      u32 domain_id,
+			      struct dlb_create_ldb_queue_args *args,
+			      bool vdev_req,
+			      unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB create load-balanced queue arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID:                  %d\n",
+		   domain_id);
+	DLB_HW_DBG(hw, "\tNumber of sequence numbers: %d\n",
+		   args->num_sequence_numbers);
+	DLB_HW_DBG(hw, "\tNumber of QID inflights:    %d\n",
+		   args->num_qid_inflights);
+	DLB_HW_DBG(hw, "\tNumber of ATM inflights:    %d\n",
+		   args->num_atomic_inflights);
+}
+
+/**
+ * dlb_hw_create_ldb_queue() - create a load-balanced queue
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue creation arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function creates a load-balanced queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the queue ID.
+ *
+ * resp->id contains a virtual ID if vdev_req is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, the domain is not configured,
+ *	    the domain has already been started, or the requested queue name is
+ *	    already in use.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb_hw_create_ldb_queue(struct dlb_hw *hw,
+			    u32 domain_id,
+			    struct dlb_create_ldb_queue_args *args,
+			    struct dlb_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+	int ret;
+
+	dlb_log_create_ldb_queue_args(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb_verify_create_ldb_queue_args(hw,
+					       domain_id,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id,
+					       &domain,
+					       &queue);
+	if (ret)
+		return ret;
+
+	ret = dlb_ldb_queue_attach_resources(hw, domain, queue, args);
+	if (ret) {
+		DLB_HW_ERR(hw,
+			   "[%s():%d] Internal error: failed to attach the ldb queue resources\n",
+			   __func__, __LINE__);
+		return ret;
+	}
+
+	dlb_configure_ldb_queue(hw, domain, queue, args, vdev_req, vdev_id);
+
+	queue->num_mappings = 0;
+
+	queue->configured = true;
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list.
+	 */
+	list_del(&queue->domain_list);
+
+	list_add(&queue->domain_list, &domain->used_ldb_queues);
+
+	resp->status = 0;
+	resp->id = (vdev_req) ? queue->id.virt_id : queue->id.phys_id;
+
+	return 0;
+}
+
+static void
+dlb_log_create_dir_queue_args(struct dlb_hw *hw,
+			      u32 domain_id,
+			      struct dlb_create_dir_queue_args *args,
+			      bool vdev_req,
+			      unsigned int vdev_id)
+{
+	DLB_HW_DBG(hw, "DLB create directed queue arguments:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from vdev %d)\n", vdev_id);
+	DLB_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+	DLB_HW_DBG(hw, "\tPort ID:   %d\n", args->port_id);
+}
+
+/**
+ * dlb_hw_create_dir_queue() - create a directed queue
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue creation arguments.
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function creates a directed queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the queue ID.
+ *
+ * resp->id contains a virtual ID if vdev_req is true.
+ *
+ * Errors:
+ * EINVAL - A requested resource is unavailable, the domain is not configured,
+ *	    or the domain has already been started.
+ * EFAULT - Internal error (resp->status not set).
+ */
+int dlb_hw_create_dir_queue(struct dlb_hw *hw,
+			    u32 domain_id,
+			    struct dlb_create_dir_queue_args *args,
+			    struct dlb_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id)
+{
+	struct dlb_dir_pq_pair *queue;
+	struct dlb_hw_domain *domain;
+	int ret;
+
+	dlb_log_create_dir_queue_args(hw, domain_id, args, vdev_req, vdev_id);
+
+	/*
+	 * Verify that hardware resources are available before attempting to
+	 * satisfy the request. This simplifies the error unwinding code.
+	 */
+	ret = dlb_verify_create_dir_queue_args(hw,
+					       domain_id,
+					       args,
+					       resp,
+					       vdev_req,
+					       vdev_id,
+					       &domain,
+					       &queue);
+	if (ret)
+		return ret;
+
+	dlb_configure_dir_queue(hw, domain, queue, args, vdev_req, vdev_id);
+
+	/*
+	 * Configuration succeeded, so move the resource from the 'avail' to
+	 * the 'used' list (if it's not already there).
+	 */
+	if (args->port_id == -1) {
+		list_del(&queue->domain_list);
+
+		list_add(&queue->domain_list, &domain->used_dir_pq_pairs);
+	}
+
+	resp->status = 0;
+
+	resp->id = (vdev_req) ? queue->id.virt_id : queue->id.phys_id;
+
+	return 0;
+}
+
 static int dlb_domain_reset_software_state(struct dlb_hw *hw,
 					   struct dlb_hw_domain *domain)
 {
@@ -1019,6 +1483,162 @@ static int dlb_domain_reset_software_state(struct dlb_hw *hw,
 	return 0;
 }
 
+static u32 dlb_dir_queue_depth(struct dlb_hw *hw,
+			       struct dlb_dir_pq_pair *queue)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static void dlb_log_get_dir_queue_depth(struct dlb_hw *hw,
+					u32 domain_id,
+					u32 queue_id,
+					bool vdev_req,
+					unsigned int vf_id)
+{
+	DLB_HW_DBG(hw, "DLB get directed queue depth:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from VF %d)\n", vf_id);
+	DLB_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+	DLB_HW_DBG(hw, "\tQueue ID: %d\n", queue_id);
+}
+
+/**
+ * dlb_hw_get_dir_queue_depth() - returns the depth of a directed queue
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue depth args
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function returns the depth of a directed queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the depth.
+ *
+ * Errors:
+ * EINVAL - Invalid domain ID or queue ID.
+ */
+int dlb_hw_get_dir_queue_depth(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_get_dir_queue_depth_args *args,
+			       struct dlb_cmd_response *resp,
+			       bool vdev_req,
+			       unsigned int vdev_id)
+{
+	struct dlb_dir_pq_pair *queue;
+	struct dlb_hw_domain *domain;
+	int id;
+
+	id = domain_id;
+
+	dlb_log_get_dir_queue_depth(hw, domain_id, args->queue_id,
+				    vdev_req, vdev_id);
+
+	domain = dlb_get_domain_from_id(hw, id, vdev_req, vdev_id);
+	if (!domain) {
+		resp->status = DLB_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	id = args->queue_id;
+
+	queue = dlb_get_domain_used_dir_pq(id, vdev_req, domain);
+	if (!queue) {
+		resp->status = DLB_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	resp->id = dlb_dir_queue_depth(hw, queue);
+
+	return 0;
+}
+
+static u32 dlb_ldb_queue_depth(struct dlb_hw *hw,
+			       struct dlb_ldb_queue *queue)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static bool dlb_ldb_queue_is_empty(struct dlb_hw *hw,
+				   struct dlb_ldb_queue *queue)
+{
+	/* Placeholder */
+	return true;
+}
+
+static void dlb_log_get_ldb_queue_depth(struct dlb_hw *hw,
+					u32 domain_id,
+					u32 queue_id,
+					bool vdev_req,
+					unsigned int vf_id)
+{
+	DLB_HW_DBG(hw, "DLB get load-balanced queue depth:\n");
+	if (vdev_req)
+		DLB_HW_DBG(hw, "(Request from VF %d)\n", vf_id);
+	DLB_HW_DBG(hw, "\tDomain ID: %d\n", domain_id);
+	DLB_HW_DBG(hw, "\tQueue ID: %d\n", queue_id);
+}
+
+/**
+ * dlb_hw_get_ldb_queue_depth() - returns the depth of a load-balanced queue
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @args: queue depth args
+ * @resp: response structure.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function returns the depth of a load-balanced queue.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise. If an error occurs, resp->status is
+ * assigned a detailed error code from enum dlb_error. If successful, resp->id
+ * contains the depth.
+ *
+ * Errors:
+ * EINVAL - Invalid domain ID or queue ID.
+ */
+int dlb_hw_get_ldb_queue_depth(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_get_ldb_queue_depth_args *args,
+			       struct dlb_cmd_response *resp,
+			       bool vdev_req,
+			       unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_queue *queue;
+
+	dlb_log_get_ldb_queue_depth(hw, domain_id, args->queue_id,
+				    vdev_req, vdev_id);
+
+	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+	if (!domain) {
+		resp->status = DLB_ST_INVALID_DOMAIN_ID;
+		return -EINVAL;
+	}
+
+	queue = dlb_get_domain_ldb_queue(args->queue_id, vdev_req, domain);
+	if (!queue) {
+		resp->status = DLB_ST_INVALID_QID;
+		return -EINVAL;
+	}
+
+	resp->id = dlb_ldb_queue_depth(hw, queue);
+
+	return 0;
+}
+
 static void __dlb_domain_reset_ldb_port_registers(struct dlb_hw *hw,
 						  struct dlb_ldb_port *port)
 {
@@ -1383,6 +2003,27 @@ static void dlb_domain_reset_dir_queue_registers(struct dlb_hw *hw,
 	}
 }
 
+static int dlb_domain_verify_reset_success(struct dlb_hw *hw,
+					   struct dlb_hw_domain *domain)
+{
+	struct dlb_ldb_queue *queue;
+
+	/*
+	 * Confirm that all the domain's queue's inflight counts and AQED
+	 * active counts are 0.
+	 */
+	list_for_each_entry(queue, &domain->used_ldb_queues, domain_list) {
+		if (!dlb_ldb_queue_is_empty(hw, queue)) {
+			DLB_HW_ERR(hw,
+				   "[%s()] Internal error: failed to empty ldb queue %d\n",
+				   __func__, queue->id.phys_id);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
 static void dlb_domain_reset_registers(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain)
 {
@@ -1403,6 +2044,52 @@ static void dlb_domain_reset_registers(struct dlb_hw *hw,
 		   CHP_CFG_DIR_VAS_CRD_RST);
 }
 
+static int dlb_domain_drain_mapped_queues(struct dlb_hw *hw,
+					  struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static int dlb_domain_drain_dir_queues(struct dlb_hw *hw,
+				       struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+	return 0;
+}
+
+static void
+dlb_domain_disable_ldb_queue_write_perms(struct dlb_hw *hw,
+					 struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
+static void
+dlb_domain_disable_dir_queue_write_perms(struct dlb_hw *hw,
+					 struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
+static void dlb_domain_disable_dir_cqs(struct dlb_hw *hw,
+				       struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
+static void dlb_domain_disable_ldb_cqs(struct dlb_hw *hw,
+				       struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
+static void dlb_domain_enable_ldb_cqs(struct dlb_hw *hw,
+				      struct dlb_hw_domain *domain)
+{
+	/* Placeholder */
+}
+
 static void dlb_log_reset_domain(struct dlb_hw *hw,
 				 u32 domain_id,
 				 bool vdev_req,
@@ -1445,6 +2132,7 @@ int dlb_reset_domain(struct dlb_hw *hw,
 		     unsigned int vdev_id)
 {
 	struct dlb_hw_domain *domain;
+	int ret;
 
 	dlb_log_reset_domain(hw, domain_id, vdev_req, vdev_id);
 
@@ -1453,6 +2141,34 @@ int dlb_reset_domain(struct dlb_hw *hw,
 	if (!domain || !domain->configured)
 		return -EINVAL;
 
+	/*
+	 * For each queue owned by this domain, disable its write permissions to
+	 * cause any traffic sent to it to be dropped. Well-behaved software
+	 * should not be sending QEs at this point.
+	 */
+	dlb_domain_disable_dir_queue_write_perms(hw, domain);
+
+	dlb_domain_disable_ldb_queue_write_perms(hw, domain);
+
+	/* Re-enable the CQs in order to drain the mapped queues. */
+	dlb_domain_enable_ldb_cqs(hw, domain);
+
+	ret = dlb_domain_drain_mapped_queues(hw, domain);
+	if (ret)
+		return ret;
+
+	/* Done draining LDB QEs, so disable the CQs. */
+	dlb_domain_disable_ldb_cqs(hw, domain);
+
+	dlb_domain_drain_dir_queues(hw, domain);
+
+	/* Done draining DIR QEs, so disable the CQs. */
+	dlb_domain_disable_dir_cqs(hw, domain);
+
+	ret = dlb_domain_verify_reset_success(hw, domain);
+	if (ret)
+		return ret;
+
 	/* Reset the QID and port state. */
 	dlb_domain_reset_registers(hw, domain);
 
diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
index 1b916b8a6f08..d11b8c062e90 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -20,6 +20,20 @@ int dlb_hw_create_sched_domain(struct dlb_hw *hw,
 			       bool vdev_req,
 			       unsigned int vdev_id);
 
+int dlb_hw_create_ldb_queue(struct dlb_hw *hw,
+			    u32 domain_id,
+			    struct dlb_create_ldb_queue_args *args,
+			    struct dlb_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id);
+
+int dlb_hw_create_dir_queue(struct dlb_hw *hw,
+			    u32 domain_id,
+			    struct dlb_create_dir_queue_args *args,
+			    struct dlb_cmd_response *resp,
+			    bool vdev_req,
+			    unsigned int vdev_id);
+
 int dlb_reset_domain(struct dlb_hw *hw,
 		     u32 domain_id,
 		     bool vdev_req,
@@ -32,4 +46,18 @@ int dlb_hw_get_num_resources(struct dlb_hw *hw,
 
 void dlb_clr_pmcsr_disable(struct dlb_hw *hw);
 
+int dlb_hw_get_ldb_queue_depth(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_get_ldb_queue_depth_args *args,
+			       struct dlb_cmd_response *resp,
+			       bool vdev_req,
+			       unsigned int vdev_id);
+
+int dlb_hw_get_dir_queue_depth(struct dlb_hw *hw,
+			       u32 domain_id,
+			       struct dlb_get_dir_queue_depth_args *args,
+			       struct dlb_cmd_response *resp,
+			       bool vdev_req,
+			       unsigned int vdev_id);
+
 #endif /* __DLB_RESOURCE_H */
diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
index 83dba8daf6e7..d3bf6e01b4ed 100644
--- a/include/uapi/linux/dlb.h
+++ b/include/uapi/linux/dlb.h
@@ -20,6 +20,15 @@ enum dlb_error {
 	DLB_ST_HIST_LIST_ENTRIES_UNAVAILABLE,
 	DLB_ST_LDB_PORT_REQUIRED_FOR_LDB_QUEUES,
 	DLB_ST_DOMAIN_RESET_FAILED,
+	DLB_ST_INVALID_DOMAIN_ID,
+	DLB_ST_INVALID_QID_INFLIGHT_ALLOCATION,
+	DLB_ST_INVALID_LDB_QUEUE_ID,
+	DLB_ST_DOMAIN_NOT_CONFIGURED,
+	DLB_ST_INVALID_QID,
+	DLB_ST_DOMAIN_STARTED,
+	DLB_ST_DIR_QUEUES_UNAVAILABLE,
+	DLB_ST_INVALID_PORT_ID,
+	DLB_ST_INVALID_LOCK_ID_COMP_LEVEL,
 };
 
 struct dlb_cmd_response {
@@ -159,6 +168,128 @@ enum dlb_user_interface_commands {
 	NUM_DLB_CMD,
 };
 
+/*********************************/
+/* 'domain' device file commands */
+/*********************************/
+
+/*
+ * DLB_DOMAIN_CMD_CREATE_LDB_QUEUE: Configure a load-balanced queue.
+ * Input parameters:
+ * - num_atomic_inflights: This specifies the amount of temporary atomic QE
+ *	storage for this queue. If zero, the queue will not support atomic
+ *	scheduling.
+ * - num_sequence_numbers: This specifies the number of sequence numbers used
+ *	by this queue. If zero, the queue will not support ordered scheduling.
+ *	If non-zero, the queue will not support unordered scheduling.
+ * - num_qid_inflights: The maximum number of QEs that can be inflight
+ *	(scheduled to a CQ but not completed) at any time. If
+ *	num_sequence_numbers is non-zero, num_qid_inflights must be set equal
+ *	to num_sequence_numbers.
+ * - lock_id_comp_level: Lock ID compression level. Specifies the number of
+ *	unique lock IDs the queue should compress down to. Valid compression
+ *	levels: 0, 64, 128, 256, 512, 1k, 2k, 4k, 64k. If lock_id_comp_level is
+ *	0, the queue won't compress its lock IDs.
+ * - depth_threshold: DLB sets two bits in the received QE to indicate the
+ *	depth of the queue relative to the threshold before scheduling the
+ *	QE to a CQ:
+ *	- 2’b11: depth > threshold
+ *	- 2’b10: threshold >= depth > 0.75 * threshold
+ *	- 2’b01: 0.75 * threshold >= depth > 0.5 * threshold
+ *	- 2’b00: depth <= 0.5 * threshold
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Queue ID.
+ */
+struct dlb_create_ldb_queue_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 num_sequence_numbers;
+	__u32 num_qid_inflights;
+	__u32 num_atomic_inflights;
+	__u32 lock_id_comp_level;
+	__u32 depth_threshold;
+	__u32 padding0;
+};
+
+/*
+ * DLB_DOMAIN_CMD_CREATE_DIR_QUEUE: Configure a directed queue.
+ * Input parameters:
+ * - port_id: Port ID. If the corresponding directed port is already created,
+ *	specify its ID here. Else this argument must be 0xFFFFFFFF to indicate
+ *	that the queue is being created before the port.
+ * - depth_threshold: DLB sets two bits in the received QE to indicate the
+ *	depth of the queue relative to the threshold before scheduling the
+ *	QE to a CQ:
+ *	- 2’b11: depth > threshold
+ *	- 2’b10: threshold >= depth > 0.75 * threshold
+ *	- 2’b01: 0.75 * threshold >= depth > 0.5 * threshold
+ *	- 2’b00: depth <= 0.5 * threshold
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: Queue ID.
+ */
+struct dlb_create_dir_queue_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__s32 port_id;
+	__u32 depth_threshold;
+};
+
+/*
+ * DLB_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH: Get a load-balanced queue's depth.
+ * Input parameters:
+ * - queue_id: The load-balanced queue ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: queue depth.
+ */
+struct dlb_get_ldb_queue_depth_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 queue_id;
+	__u32 padding0;
+};
+
+/*
+ * DLB_DOMAIN_CMD_DIR_QUEUE_DEPTH: Get a directed queue's depth.
+ * Input parameters:
+ * - queue_id: The directed queue ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: queue depth.
+ */
+struct dlb_get_dir_queue_depth_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 queue_id;
+	__u32 padding0;
+};
+
+enum dlb_domain_user_interface_commands {
+	DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,
+	DLB_DOMAIN_CMD_CREATE_DIR_QUEUE,
+	DLB_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,
+	DLB_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
+
+	/* NUM_DLB_DOMAIN_CMD must be last */
+	NUM_DLB_DOMAIN_CMD,
+};
+
 /********************/
 /* dlb ioctl codes */
 /********************/
@@ -177,5 +308,21 @@ enum dlb_user_interface_commands {
 		_IOR(DLB_IOC_MAGIC,				\
 		     DLB_CMD_GET_NUM_RESOURCES,			\
 		     struct dlb_get_num_resources_args)
+#define DLB_IOC_CREATE_LDB_QUEUE				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,		\
+		      struct dlb_create_ldb_queue_args)
+#define DLB_IOC_CREATE_DIR_QUEUE				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_CREATE_DIR_QUEUE,		\
+		      struct dlb_create_dir_queue_args)
+#define DLB_IOC_GET_LDB_QUEUE_DEPTH				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_GET_LDB_QUEUE_DEPTH,	\
+		      struct dlb_get_ldb_queue_depth_args)
+#define DLB_IOC_GET_DIR_QUEUE_DEPTH				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,	\
+		      struct dlb_get_dir_queue_depth_args)
 
 #endif /* __DLB_H */
-- 
2.17.1

