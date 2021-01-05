Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507952EA396
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbhAEC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:41794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbhAEC7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:54 -0500
IronPort-SDR: gerQz/1CMC/lW4nQ5G08eJyJxJMRKl/R2DkFO9UHRCcLB/iGss6JOBeSThRbxkNcC+i3lgiJ7H
 r6JJfRqxHsPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827531"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:19 -0800
IronPort-SDR: VxZcmVwbMvq6fk0KFiNFmZb1h/jVKr/iC5AZWorYQIFXkcj7l9j8Y3jk46HaVstvby3h6xBeBg
 wjyJ5oUf6+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632180"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:19 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 16/20] dlb: add port map/unmap state machine
Date:   Mon,  4 Jan 2021 20:58:35 -0600
Message-Id: <20210105025839.23169-17-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the port map/unmap state machine. Each load-balanced port
has eight "slots", one for each queue it is linked to, and each slot can be
in one of five states:
1. Queue unmapped
2. Queue mapped
3. Queue unmap in progress
4. Queue map in progress
5. Queue unmap in progress, with a map pending when the unmap completes.

These states exist because the map and unmap operations can be asynchronous
(with respect to the ioctl command). If the domain is already started, the
map operation must (temporarily) disable the queue and wait for it to
quiesce. Similarly, the unmap operation must (temporarily) disable the port
and wait for it to quiesce. 'Quiesce' here means the user processes any
in-flight QEs.

The queue map/unmap in this commit refers to link/unlink between DLB's
load-balanced queues (internal) and consumer ports. See Documentation/
misc-devices/dlb.rst for details.

It's possible that the thread that requires the map/unmap is the same one
which is responsible for doing the processing that would quiesce the
queue/port, in which case the driver may have to complete the operation
asynchronously.

To support this asynchronous operation while also providing a reasonably
usable user-interface, the driver maintains two views of the queue map
(slot) state:
- The hardware view: the actual state in the device
- The user/software view: the state as though the operations were
  synchronous.

While a map/unmap operation is inflight, these two views are out-of-sync.
When the user requests a new map/unmap operation, the driver verifies the
request against the software view, so any errors are synchronous from the
user’s perspective, then adds the request to the queue of in-progress
operations. When possible -- for example if the user requests to map a
queue and then immediately requests to unmap it -- the driver will coalesce
or cancel outstanding operations.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_resource.c | 458 +++++++++++++++++++++++++++++++-
 1 file changed, 456 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 2e10cb249b7d..3acb9ada964e 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -1384,6 +1384,229 @@ static int dlb_verify_map_qid_args(struct dlb_hw *hw,
 	return 0;
 }
 
+static bool dlb_port_find_slot(struct dlb_ldb_port *port,
+			       enum dlb_qid_map_state state,
+			       int *slot)
+{
+	int i;
+
+	for (i = 0; i < DLB_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		if (port->qid_map[i].state == state)
+			break;
+	}
+
+	*slot = i;
+
+	return (i < DLB_MAX_NUM_QIDS_PER_LDB_CQ);
+}
+
+static bool dlb_port_find_slot_queue(struct dlb_ldb_port *port,
+				     enum dlb_qid_map_state state,
+				     struct dlb_ldb_queue *queue,
+				     int *slot)
+{
+	int i;
+
+	for (i = 0; i < DLB_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		if (port->qid_map[i].state == state &&
+		    port->qid_map[i].qid == queue->id.phys_id)
+			break;
+	}
+
+	*slot = i;
+
+	return (i < DLB_MAX_NUM_QIDS_PER_LDB_CQ);
+}
+
+static bool
+dlb_port_find_slot_with_pending_map_queue(struct dlb_ldb_port *port,
+					  struct dlb_ldb_queue *queue,
+					  int *slot)
+{
+	int i;
+
+	for (i = 0; i < DLB_MAX_NUM_QIDS_PER_LDB_CQ; i++) {
+		struct dlb_ldb_port_qid_map *map = &port->qid_map[i];
+
+		if (map->state == DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP &&
+		    map->pending_qid == queue->id.phys_id)
+			break;
+	}
+
+	*slot = i;
+
+	return (i < DLB_MAX_NUM_QIDS_PER_LDB_CQ);
+}
+
+static int dlb_port_slot_state_transition(struct dlb_hw *hw,
+					  struct dlb_ldb_port *port,
+					  struct dlb_ldb_queue *queue,
+					  int slot,
+					  enum dlb_qid_map_state new_state)
+{
+	enum dlb_qid_map_state curr_state = port->qid_map[slot].state;
+	struct dlb_hw_domain *domain;
+	int domain_id;
+
+	domain_id = port->domain_id.phys_id;
+
+	domain = dlb_get_domain_from_id(hw, domain_id, false, 0);
+	if (!domain) {
+		DLB_HW_ERR(hw,
+			   "[%s()] Internal error: unable to find domain %d\n",
+			   __func__, domain_id);
+		return -EINVAL;
+	}
+
+	switch (curr_state) {
+	case DLB_QUEUE_UNMAPPED:
+		switch (new_state) {
+		case DLB_QUEUE_MAPPED:
+			queue->num_mappings++;
+			port->num_mappings++;
+			break;
+		case DLB_QUEUE_MAP_IN_PROG:
+			queue->num_pending_additions++;
+			domain->num_pending_additions++;
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB_QUEUE_MAPPED:
+		switch (new_state) {
+		case DLB_QUEUE_UNMAPPED:
+			queue->num_mappings--;
+			port->num_mappings--;
+			break;
+		case DLB_QUEUE_UNMAP_IN_PROG:
+			port->num_pending_removals++;
+			domain->num_pending_removals++;
+			break;
+		case DLB_QUEUE_MAPPED:
+			/* Priority change, nothing to update */
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB_QUEUE_MAP_IN_PROG:
+		switch (new_state) {
+		case DLB_QUEUE_UNMAPPED:
+			queue->num_pending_additions--;
+			domain->num_pending_additions--;
+			break;
+		case DLB_QUEUE_MAPPED:
+			queue->num_mappings++;
+			port->num_mappings++;
+			queue->num_pending_additions--;
+			domain->num_pending_additions--;
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB_QUEUE_UNMAP_IN_PROG:
+		switch (new_state) {
+		case DLB_QUEUE_UNMAPPED:
+			port->num_pending_removals--;
+			domain->num_pending_removals--;
+			queue->num_mappings--;
+			port->num_mappings--;
+			break;
+		case DLB_QUEUE_MAPPED:
+			port->num_pending_removals--;
+			domain->num_pending_removals--;
+			break;
+		case DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP:
+			/* Nothing to update */
+			break;
+		default:
+			goto error;
+		}
+		break;
+	case DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP:
+		switch (new_state) {
+		case DLB_QUEUE_UNMAP_IN_PROG:
+			/* Nothing to update */
+			break;
+		case DLB_QUEUE_UNMAPPED:
+			/*
+			 * An UNMAP_IN_PROG_PENDING_MAP slot briefly
+			 * becomes UNMAPPED before it transitions to
+			 * MAP_IN_PROG.
+			 */
+			queue->num_mappings--;
+			port->num_mappings--;
+			port->num_pending_removals--;
+			domain->num_pending_removals--;
+			break;
+		default:
+			goto error;
+		}
+		break;
+	default:
+		goto error;
+	}
+
+	port->qid_map[slot].state = new_state;
+
+	DLB_HW_DBG(hw,
+		   "[%s()] queue %d -> port %d state transition (%d -> %d)\n",
+		   __func__, queue->id.phys_id, port->id.phys_id,
+		    curr_state, new_state);
+	return 0;
+
+error:
+	DLB_HW_ERR(hw,
+		   "[%s()] Internal error: invalid queue %d -> port %d state transition (%d -> %d)\n",
+		   __func__, queue->id.phys_id, port->id.phys_id,
+		    curr_state, new_state);
+	return -EFAULT;
+}
+
+static int dlb_verify_map_qid_slot_available(struct dlb_ldb_port *port,
+					     struct dlb_ldb_queue *queue,
+					     struct dlb_cmd_response *resp)
+{
+	enum dlb_qid_map_state state;
+	int i;
+
+	/* Unused slot available? */
+	if (port->num_mappings < DLB_MAX_NUM_QIDS_PER_LDB_CQ)
+		return 0;
+
+	/*
+	 * If the queue is already mapped (from the application's perspective),
+	 * this is simply a priority update.
+	 */
+	state = DLB_QUEUE_MAPPED;
+	if (dlb_port_find_slot_queue(port, state, queue, &i))
+		return 0;
+
+	state = DLB_QUEUE_MAP_IN_PROG;
+	if (dlb_port_find_slot_queue(port, state, queue, &i))
+		return 0;
+
+	if (dlb_port_find_slot_with_pending_map_queue(port, queue, &i))
+		return 0;
+
+	/*
+	 * If the slot contains an unmap in progress, it's considered
+	 * available.
+	 */
+	state = DLB_QUEUE_UNMAP_IN_PROG;
+	if (dlb_port_find_slot(port, state, &i))
+		return 0;
+
+	state = DLB_QUEUE_UNMAPPED;
+	if (dlb_port_find_slot(port, state, &i))
+		return 0;
+
+	resp->status = DLB_ST_NO_QID_SLOTS_AVAILABLE;
+	return -EINVAL;
+}
+
 static int dlb_verify_unmap_qid_args(struct dlb_hw *hw,
 				     u32 domain_id,
 				     struct dlb_unmap_qid_args *args,
@@ -1394,9 +1617,11 @@ static int dlb_verify_unmap_qid_args(struct dlb_hw *hw,
 				     struct dlb_ldb_port **out_port,
 				     struct dlb_ldb_queue **out_queue)
 {
+	enum dlb_qid_map_state state;
 	struct dlb_hw_domain *domain;
 	struct dlb_ldb_queue *queue;
 	struct dlb_ldb_port *port;
+	int slot;
 	int id;
 
 	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
@@ -1434,6 +1659,26 @@ static int dlb_verify_unmap_qid_args(struct dlb_hw *hw,
 		return -EINVAL;
 	}
 
+	/*
+	 * Verify that the port has the queue mapped. From the application's
+	 * perspective a queue is mapped if it is actually mapped, the map is
+	 * in progress, or the map is blocked pending an unmap.
+	 */
+	state = DLB_QUEUE_MAPPED;
+	if (dlb_port_find_slot_queue(port, state, queue, &slot))
+		goto done;
+
+	state = DLB_QUEUE_MAP_IN_PROG;
+	if (dlb_port_find_slot_queue(port, state, queue, &slot))
+		goto done;
+
+	if (dlb_port_find_slot_with_pending_map_queue(port, queue, &slot))
+		goto done;
+
+	resp->status = DLB_ST_INVALID_QID;
+	return -EINVAL;
+
+done:
 	*out_domain = domain;
 	*out_port = port;
 	*out_queue = queue;
@@ -1963,6 +2208,24 @@ static int dlb_configure_dir_port(struct dlb_hw *hw,
 	return 0;
 }
 
+static void dlb_ldb_port_change_qid_priority(struct dlb_hw *hw,
+					     struct dlb_ldb_port *port,
+					     int slot,
+					     struct dlb_map_qid_args *args)
+{
+	/* Placeholder */
+}
+
+static int dlb_ldb_port_map_qid(struct dlb_hw *hw,
+				struct dlb_hw_domain *domain,
+				struct dlb_ldb_port *port,
+				struct dlb_ldb_queue *queue,
+				u8 prio)
+{
+	/* Placeholder */
+	return 0;
+}
+
 static void
 dlb_log_create_sched_domain_args(struct dlb_hw *hw,
 				 struct dlb_create_sched_domain_args *args,
@@ -2478,6 +2741,14 @@ int dlb_hw_create_dir_port(struct dlb_hw *hw,
 	return 0;
 }
 
+static bool dlb_domain_finish_unmap_port(struct dlb_hw *hw,
+					 struct dlb_hw_domain *domain,
+					 struct dlb_ldb_port *port)
+{
+	/* Placeholder */
+	return true;
+}
+
 static unsigned int
 dlb_domain_finish_unmap_qid_procedures(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain)
@@ -2563,8 +2834,10 @@ int dlb_hw_map_qid(struct dlb_hw *hw,
 {
 	struct dlb_hw_domain *domain;
 	struct dlb_ldb_queue *queue;
+	enum dlb_qid_map_state st;
 	struct dlb_ldb_port *port;
-	int ret;
+	int ret, i;
+	u8 prio;
 
 	dlb_log_map_qid(hw, domain_id, args, vdev_req, vdev_id);
 
@@ -2584,6 +2857,127 @@ int dlb_hw_map_qid(struct dlb_hw *hw,
 	if (ret)
 		return ret;
 
+	prio = args->priority;
+
+	/*
+	 * If there are any outstanding detach operations for this port,
+	 * attempt to complete them. This may be necessary to free up a QID
+	 * slot for this requested mapping.
+	 */
+	if (port->num_pending_removals)
+		dlb_domain_finish_unmap_port(hw, domain, port);
+
+	ret = dlb_verify_map_qid_slot_available(port, queue, resp);
+	if (ret)
+		return ret;
+
+	/* Hardware requires disabling the CQ before mapping QIDs. */
+	if (port->enabled)
+		dlb_ldb_port_cq_disable(hw, port);
+
+	/*
+	 * If this is only a priority change, don't perform the full QID->CQ
+	 * mapping procedure
+	 */
+	st = DLB_QUEUE_MAPPED;
+	if (dlb_port_find_slot_queue(port, st, queue, &i)) {
+		if (prio != port->qid_map[i].priority) {
+			dlb_ldb_port_change_qid_priority(hw, port, i, args);
+			DLB_HW_DBG(hw, "DLB map: priority change\n");
+		}
+
+		st = DLB_QUEUE_MAPPED;
+		ret = dlb_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto map_qid_done;
+	}
+
+	st = DLB_QUEUE_UNMAP_IN_PROG;
+	if (dlb_port_find_slot_queue(port, st, queue, &i)) {
+		if (prio != port->qid_map[i].priority) {
+			dlb_ldb_port_change_qid_priority(hw, port, i, args);
+			DLB_HW_DBG(hw, "DLB map: priority change\n");
+		}
+
+		st = DLB_QUEUE_MAPPED;
+		ret = dlb_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto map_qid_done;
+	}
+
+	/*
+	 * If this is a priority change on an in-progress mapping, don't
+	 * perform the full QID->CQ mapping procedure.
+	 */
+	st = DLB_QUEUE_MAP_IN_PROG;
+	if (dlb_port_find_slot_queue(port, st, queue, &i)) {
+		port->qid_map[i].priority = prio;
+
+		DLB_HW_DBG(hw, "DLB map: priority change only\n");
+
+		goto map_qid_done;
+	}
+
+	/*
+	 * If this is a priority change on a pending mapping, update the
+	 * pending priority
+	 */
+	if (dlb_port_find_slot_with_pending_map_queue(port, queue, &i)) {
+		port->qid_map[i].pending_priority = prio;
+
+		DLB_HW_DBG(hw, "DLB map: priority change only\n");
+
+		goto map_qid_done;
+	}
+
+	/*
+	 * If all the CQ's slots are in use, then there's an unmap in progress
+	 * (guaranteed by dlb_verify_map_qid_slot_available()), so add this
+	 * mapping to pending_map and return. When the removal is completed for
+	 * the slot's current occupant, this mapping will be performed.
+	 */
+	if (!dlb_port_find_slot(port, DLB_QUEUE_UNMAPPED, &i)) {
+		if (dlb_port_find_slot(port, DLB_QUEUE_UNMAP_IN_PROG, &i)) {
+			enum dlb_qid_map_state new_st;
+
+			port->qid_map[i].pending_qid = queue->id.phys_id;
+			port->qid_map[i].pending_priority = prio;
+
+			new_st = DLB_QUEUE_UNMAP_IN_PROG_PENDING_MAP;
+
+			ret = dlb_port_slot_state_transition(hw, port, queue,
+							     i, new_st);
+			if (ret)
+				return ret;
+
+			DLB_HW_DBG(hw, "DLB map: map pending removal\n");
+
+			goto map_qid_done;
+		}
+	}
+
+	/*
+	 * If the domain has started, a special "dynamic" CQ->queue mapping
+	 * procedure is required in order to safely update the CQ<->QID tables.
+	 * The "static" procedure cannot be used when traffic is flowing,
+	 * because the CQ<->QID tables cannot be updated atomically and the
+	 * scheduler won't see the new mapping unless the queue's if_status
+	 * changes, which isn't guaranteed.
+	 */
+	ret = dlb_ldb_port_map_qid(hw, domain, port, queue, prio);
+
+	/* If ret is less than zero, it's due to an internal error */
+	if (ret < 0)
+		return ret;
+
+map_qid_done:
+	if (port->enabled)
+		dlb_ldb_port_cq_enable(hw, port);
+
 	resp->status = 0;
 
 	return 0;
@@ -2649,8 +3043,9 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw,
 {
 	struct dlb_hw_domain *domain;
 	struct dlb_ldb_queue *queue;
+	enum dlb_qid_map_state st;
 	struct dlb_ldb_port *port;
-	int ret;
+	int i, ret;
 
 	dlb_log_unmap_qid(hw, domain_id, args, vdev_req, vdev_id);
 
@@ -2670,6 +3065,65 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw,
 	if (ret)
 		return ret;
 
+	/*
+	 * If the queue hasn't been mapped yet, we need to update the slot's
+	 * state and re-enable the queue's inflights.
+	 */
+	st = DLB_QUEUE_MAP_IN_PROG;
+	if (dlb_port_find_slot_queue(port, st, queue, &i)) {
+		st = DLB_QUEUE_UNMAPPED;
+		ret = dlb_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto unmap_qid_done;
+	}
+
+	/*
+	 * If the queue mapping is on hold pending an unmap, we simply need to
+	 * update the slot's state.
+	 */
+	if (dlb_port_find_slot_with_pending_map_queue(port, queue, &i)) {
+		st = DLB_QUEUE_UNMAP_IN_PROG;
+		ret = dlb_port_slot_state_transition(hw, port, queue, i, st);
+		if (ret)
+			return ret;
+
+		goto unmap_qid_done;
+	}
+
+	st = DLB_QUEUE_MAPPED;
+	if (!dlb_port_find_slot_queue(port, st, queue, &i)) {
+		DLB_HW_ERR(hw,
+			   "[%s()] Internal error: no available CQ slots\n",
+			   __func__);
+		return -EFAULT;
+	}
+
+	/*
+	 * QID->CQ mapping removal is an asychronous procedure. It requires
+	 * stopping the DLB from scheduling this CQ, draining all inflights
+	 * from the CQ, then unmapping the queue from the CQ. This function
+	 * simply marks the port as needing the queue unmapped, and (if
+	 * necessary) starts the unmapping worker thread.
+	 */
+	dlb_ldb_port_cq_disable(hw, port);
+
+	st = DLB_QUEUE_UNMAP_IN_PROG;
+	ret = dlb_port_slot_state_transition(hw, port, queue, i, st);
+	if (ret)
+		return ret;
+
+	/*
+	 * Attempt to finish the unmapping now, in case the port has no
+	 * outstanding inflights. If that's not the case, this will fail and
+	 * the unmapping will be completed at a later time.
+	 */
+	dlb_domain_finish_unmap_port(hw, domain, port);
+
+unmap_qid_done:
+	resp->status = 0;
+
 	return 0;
 }
 
-- 
2.17.1

