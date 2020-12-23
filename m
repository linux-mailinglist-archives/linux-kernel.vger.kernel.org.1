Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7102E224F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLWWA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:00:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:4211 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgLWWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:00:55 -0500
IronPort-SDR: Jh6X9WtI3fPv9J/1VwHMiyXgE+HeQHcsqYOsUJ7kZSiAIAl+E9CJXf8eWACrXZOsclibCKWw9J
 nDxBb7+6QoFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="176227051"
X-IronPort-AV: E=Sophos;i="5.78,442,1599548400"; 
   d="scan'208";a="176227051"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 14:00:13 -0800
IronPort-SDR: ZE9vjT+jio/b1tX/7pX6GuRO1MMz0A/r592uY2dF3aio3SMMoiiIkjBp9UmgFnM3q33hFK7d/E
 VHy+ZG29weww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,442,1599548400"; 
   d="scan'208";a="398209958"
Received: from sbensaid-test1.sc.intel.com ([172.25.206.207])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2020 14:00:12 -0800
From:   lalithambika.krishnakumar@intel.com
To:     kbusch@kernel.org, hch@lst.de, axboe@fb.com, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, lalithambika.krishnakumar@intel.com
Subject: [PATCH] nvme: avoid possible double fetch in handling CQE
Date:   Wed, 23 Dec 2020 14:09:00 -0800
Message-Id: <20201223220900.11234-1-lalithambika.krishnakumar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>

While handling the completion queue, keep a local copy of the command id
from the DMA-accessible completion entry. This silences a time-of-check
to time-of-use (TOCTOU) warning from KF/x[1], with respect to a
Thunderclap[2] vulnerability analysis. The double-read impact appears
benign.

There may be a theoretical window for @command_id to be used as an
adversary-controlled array-index-value for mounting a speculative
execution attack, but that mitigation is saved for a potential follow-on.
A man-in-the-middle attack on the data payload is out of scope for this
analysis and is hopefully mitigated by filesystem integrity mechanisms.

[1] https://github.com/intel/kernel-fuzzer-for-xen-project
[2] http://thunderclap.io/thunderclap-paper-ndss2019.pdf
Signed-off-by: Lalithambika Krishna Kumar <lalithambika.krishnakumar@intel.com>
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b4385cb0ff60..88a7cb3fe2a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -967,6 +967,7 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
+	__u16 command_id = READ_ONCE(cqe->command_id);
 	struct request *req;
 
 	/*
@@ -975,17 +976,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_is_aen_req(nvmeq->qid, cqe->command_id))) {
+	if (unlikely(nvme_is_aen_req(nvmeq->qid, command_id))) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
 	if (unlikely(!req)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
-			cqe->command_id, le16_to_cpu(cqe->sq_id));
+			command_id, le16_to_cpu(cqe->sq_id));
 		return;
 	}
 
-- 
2.29.2

