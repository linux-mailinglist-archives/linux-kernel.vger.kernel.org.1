Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8AE1DFDD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEXJPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 05:15:17 -0400
Received: from mail5.windriver.com ([192.103.53.11]:47312 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgEXJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:15:16 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 04O9EL1x030031
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 24 May 2020 02:14:32 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Sun, 24 May 2020 02:13:58 -0700
From:   <qiang.zhang@windriver.com>
To:     <tj@kernel.org>
CC:     <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] workqueue: Fix double kfree(rescuer) in destroy_workqueue()
Date:   Sun, 24 May 2020 17:22:43 +0800
Message-ID: <20200524092243.19083-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

When destroy_workqueue if rescuer worker exist,wq->rescuer pointer be
kfree. if sanity checks passed. the func call_rcu(&wq->rcu, rcu_free_wq)
will be called if the wq->flags & WQ_UNBOUND is false,in rcu_free_wq
func wq->rescuer pointer was kfree again.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..a2451cdcd503 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3491,7 +3491,6 @@ static void rcu_free_wq(struct rcu_head *rcu)
 	else
 		free_workqueue_attrs(wq->unbound_attrs);
 
-	kfree(wq->rescuer);
 	kfree(wq);
 }
 
-- 
2.17.0

