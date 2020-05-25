Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2B1E0830
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 09:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbgEYHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 03:51:32 -0400
Received: from mail5.windriver.com ([192.103.53.11]:37948 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbgEYHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:51:32 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 04P7oSSN009368
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 25 May 2020 00:50:39 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Mon, 25 May 2020 00:50:18 -0700
From:   <qiang.zhang@windriver.com>
To:     <tj@kernel.org>
CC:     <jiangshanlai@gmail.com>, <markus.elfring@web.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] workqueue: Fix double kfree for rescuer
Date:   Mon, 25 May 2020 15:59:01 +0800
Message-ID: <20200525075901.12699-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

The duplicate memory release should be deleted from the implementation
of the callback function "rcu_free_wq".

Fixes: 6ba94429c8e7 ("workqueue: Reorder sysfs code")
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
2.24.1

