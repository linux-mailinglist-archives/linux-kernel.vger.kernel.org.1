Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C41EA047
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFAIpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 04:45:03 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:23098 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgFAIpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:45:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-ClVg0_1591001087;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-ClVg0_1591001087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 16:44:48 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/4] workqueue: fix a piece of comment about reserved bits for work flags
Date:   Mon,  1 Jun 2020 08:44:39 +0000
Message-Id: <20200601084442.8284-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601084442.8284-1-laijs@linux.alibaba.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8a2e8e5dec7e("workqueue: fix cwq->nr_active underflow")
allocated one more bit from the work flags, and it updated
partial of the comments (128 bytes -> 256 bytes), but it
failed to update the info about the number of reserved bits.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8b505d22fc0e..26de0cae2a0a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -62,7 +62,7 @@ enum {
 	WORK_CPU_UNBOUND	= NR_CPUS,
 
 	/*
-	 * Reserve 7 bits off of pwq pointer w/ debugobjects turned off.
+	 * Reserve 8 bits off of pwq pointer w/ debugobjects turned off.
 	 * This makes pwqs aligned to 256 bytes and allows 15 workqueue
 	 * flush colors.
 	 */
-- 
2.20.1

