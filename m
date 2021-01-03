Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D82E8DB4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 19:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhACSOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 13:14:04 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:20278 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727712AbhACSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 13:14:00 -0500
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 103ICuH6013681
        for <linux-kernel@vger.kernel.org>; Sun, 3 Jan 2021 13:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=p1JDwNjo4kW+Onlqx41wby/8vL/xJp1erYMmcX8soa4=;
 b=cFFsfDCfl7GQiyccoTsHcnD+jsJpDsKbnK7eHCO9BLdiaWz6E7apDmUebdndd0GkO8pZ
 +2jdrwlOs+LmqZQNCyv3wNBblj7hRURRgv5mBY0pHX5CnnpcMKEOYYkSzEQfj4nB7un3
 roW+zMd59/jNR6N/RIsRckVTYkRvdj+URSsuS4s1pS3KOZXfEMzSg/a8rpjf1V01+O8Y
 5d5FM05MSQ71j2siiWU7feJqnPI50R+UEOmrlklx59QkVm3vDDv2noBV80EMbcHRjNQq
 g2sVNOFNviE19nA0C2REFFI7UoG8RPf9crHwV5VZJuayCkY96eNAk2V14Go/IbP8E79A aQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 35tm9a2ej8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 13:13:17 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 103I5Men120821
        for <linux-kernel@vger.kernel.org>; Sun, 3 Jan 2021 13:13:17 -0500
Received: from esaploutdur04.us.dell.com ([128.221.233.10])
        by mx0a-00154901.pphosted.com with ESMTP id 35u79g4jsm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 13:13:16 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.226.146
Received: from unknown (HELO vd-leonidr.xiolab.lab.emc.com) ([10.55.226.146])
  by esaploutdur04.us.dell.com with ESMTP; 03 Jan 2021 12:13:15 -0600
From:   leonid.ravich@dell.com
To:     james.smart@broadcom.com
Cc:     lravich@gmail.com, Leonid Ravich <Leonid.Ravich@dell.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmet-fc: associations list protected by rcu, instead of spinlock_irq where possible.
Date:   Sun,  3 Jan 2021 20:12:54 +0200
Message-Id: <1609697575-103348-2-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1609697575-103348-1-git-send-email-leonid.ravich@dell.com>
References: <20201224110542.22219-1-leonid.ravich@dell.com>
 <1609697575-103348-1-git-send-email-leonid.ravich@dell.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-03_11:2020-12-31,2021-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=992 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030117
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

searching assoc_list protected by rcu_read_lock if list not changed inline.
and according to the rcu list rules.

queue array embedded into nvmet_fc_tgt_assoc protected by rcu_read_lock
according to rcu dereference/assign rules.

queue and assoc object freed after grace period by call_rcu.

tgtport lock taken for changing assoc_list.

Reviewed-by: Eldad Zinger <Eldad.Zinger@dell.com>
Reviewed-by: Elad Grupi <Elad.Grupi@dell.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
1) fixed sytle issus 
2) queues array protects by rcu as well

 drivers/nvme/target/fc.c | 81 +++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index cd4e73a..c14c60b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -145,6 +145,7 @@ struct nvmet_fc_tgt_queue {
 	struct list_head		avail_defer_list;
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
+	struct rcu_head			rcu;
 	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
 } __aligned(sizeof(unsigned long long));
 
@@ -167,6 +168,7 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
+	struct rcu_head			rcu;
 };
 
 
@@ -790,7 +792,6 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 			u16 qid, u16 sqsize)
 {
 	struct nvmet_fc_tgt_queue *queue;
-	unsigned long flags;
 	int ret;
 
 	if (qid > NVMET_NR_QUEUES)
@@ -829,9 +830,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 		goto out_fail_iodlist;
 
 	WARN_ON(assoc->queues[qid]);
-	spin_lock_irqsave(&assoc->tgtport->lock, flags);
-	assoc->queues[qid] = queue;
-	spin_unlock_irqrestore(&assoc->tgtport->lock, flags);
+	rcu_assign_pointer(assoc->queues[qid], queue);
 
 	return queue;
 
@@ -851,11 +850,8 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	struct nvmet_fc_tgt_queue *queue =
 		container_of(ref, struct nvmet_fc_tgt_queue, ref);
-	unsigned long flags;
 
-	spin_lock_irqsave(&queue->assoc->tgtport->lock, flags);
-	queue->assoc->queues[queue->qid] = NULL;
-	spin_unlock_irqrestore(&queue->assoc->tgtport->lock, flags);
+	rcu_assign_pointer(queue->assoc->queues[queue->qid], NULL);
 
 	nvmet_fc_destroy_fcp_iodlist(queue->assoc->tgtport, queue);
 
@@ -863,7 +859,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 
 	destroy_workqueue(queue->work_q);
 
-	kfree(queue);
+	kfree_rcu(queue, rcu);
 }
 
 static void
@@ -965,24 +961,23 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	struct nvmet_fc_tgt_queue *queue;
 	u64 association_id = nvmet_fc_getassociationid(connection_id);
 	u16 qid = nvmet_fc_getqueueid(connection_id);
-	unsigned long flags;
 
 	if (qid > NVMET_NR_QUEUES)
 		return NULL;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
-			queue = assoc->queues[qid];
+			queue = rcu_dereference(assoc->queues[qid]);
 			if (queue &&
 			    (!atomic_read(&queue->connected) ||
 			     !nvmet_fc_tgt_q_get(queue)))
 				queue = NULL;
-			spin_unlock_irqrestore(&tgtport->lock, flags);
+			rcu_read_unlock();
 			return queue;
 		}
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -1137,7 +1132,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 		}
 		if (!needrandom) {
 			assoc->association_id = ran;
-			list_add_tail(&assoc->a_list, &tgtport->assoc_list);
+			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 		}
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	}
@@ -1167,7 +1162,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 
 	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_del(&assoc->a_list);
+	list_del_rcu(&assoc->a_list);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	/* if pending Rcv Disconnect Association LS, send rsp now */
@@ -1177,7 +1172,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	kfree(assoc);
+	kfree_rcu(assoc, rcu);
 	nvmet_fc_tgtport_put(tgtport);
 }
 
@@ -1198,7 +1193,6 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	struct nvmet_fc_tgt_queue *queue;
-	unsigned long flags;
 	int i, terminating;
 
 	terminating = atomic_xchg(&assoc->terminating, 1);
@@ -1207,19 +1201,23 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	if (terminating)
 		return;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
+
 	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
-		queue = assoc->queues[i];
-		if (queue) {
-			if (!nvmet_fc_tgt_q_get(queue))
-				continue;
-			spin_unlock_irqrestore(&tgtport->lock, flags);
-			nvmet_fc_delete_target_queue(queue);
-			nvmet_fc_tgt_q_put(queue);
-			spin_lock_irqsave(&tgtport->lock, flags);
+		rcu_read_lock();
+		queue = rcu_dereference(assoc->queues[i]);
+		if (!queue) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		if (!nvmet_fc_tgt_q_get(queue)) {
+			rcu_read_unlock();
+			continue;
 		}
+		rcu_read_unlock();
+		nvmet_fc_delete_target_queue(queue);
+		nvmet_fc_tgt_q_put(queue);
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
 
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
@@ -1234,10 +1232,9 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	struct nvmet_fc_tgt_assoc *assoc;
 	struct nvmet_fc_tgt_assoc *ret = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
 			ret = assoc;
 			if (!nvmet_fc_tgt_a_get(assoc))
@@ -1245,7 +1242,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1473,19 +1470,17 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 static void
 __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 {
-	struct nvmet_fc_tgt_assoc *assoc, *next;
-	unsigned long flags;
+	struct nvmet_fc_tgt_assoc *assoc;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry_safe(assoc, next,
-				&tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
 		if (!schedule_work(&assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
+	rcu_read_unlock();
 }
 
 /**
@@ -1568,16 +1563,16 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 			continue;
 		spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
-		spin_lock_irqsave(&tgtport->lock, flags);
-		list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
-			queue = assoc->queues[0];
+		rcu_read_lock();
+		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
+			queue = rcu_dereference(assoc->queues[0]);
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
 				if (nvmet_fc_tgt_a_get(assoc))
 					found_ctrl = true;
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&tgtport->lock, flags);
+		rcu_read_unlock();
 
 		nvmet_fc_tgtport_put(tgtport);
 
-- 
1.9.3

