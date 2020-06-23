Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF4205354
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgFWNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:24:48 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48973 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732580AbgFWNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:24:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0WDs5q_1592918684;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0WDs5q_1592918684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 21:24:45 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvme: Use USEC_PER_SEC instead of magic numbers
Date:   Tue, 23 Jun 2020 21:24:34 +0800
Message-Id: <a64d35465b8d91ab11f37d814ac10003da7804b8.1592916850.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use USEC_PER_SEC instead of magic numbers to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3a60d8..0eca820 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2963,7 +2963,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	if (id->rtd3e) {
 		/* us -> s */
-		u32 transition_time = le32_to_cpu(id->rtd3e) / 1000000;
+		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
 
 		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
 						 shutdown_timeout, 60);
-- 
1.8.3.1

