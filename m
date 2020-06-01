Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0B41EA046
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgFAIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 04:44:57 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52427 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgFAIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:44:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-ClVgA_1591001088;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-ClVgA_1591001088)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 16:44:48 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/4] workqueue: use BUILD_BUG_ON() for compile time test instead of WARN_ON()
Date:   Mon,  1 Jun 2020 08:44:40 +0000
Message-Id: <20200601084442.8284-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601084442.8284-1-laijs@linux.alibaba.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any runtime WARN_ON() has to be fixed, and BUILD_BUG_ON() can
help you nitice it earlier.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7a1fc9fe6314..35120b909234 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5905,7 +5905,7 @@ void __init workqueue_init_early(void)
 	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	int i, cpu;
 
-	WARN_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
+	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
-- 
2.20.1

