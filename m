Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368821F8C02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 03:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgFOBID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 21:08:03 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:59834 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgFOBID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:08:03 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jun 2020 21:08:02 EDT
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id AFC8AC4066;
        Mon, 15 Jun 2020 09:01:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P7894T140607611721472S1592182885179202_;
        Mon, 15 Jun 2020 09:01:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6e5d4ca0e9834636d81f3592b3db92c0>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: akpm@linux-foundation.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH] mm/cma: fix NULL pointer dereference when cma could not be activated
Date:   Mon, 15 Jun 2020 09:01:23 +0800
Message-Id: <20200615010123.15596-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case the cma area could not be activated, but the cma_alloc be
used under this case, then the kernel will crash caused by NULL pointer
dereference.

Add bitmap valid check in cma_alloc to avoid this issue.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 0463ad2ce06b..488496fa2972 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -425,7 +425,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	struct page *page = NULL;
 	int ret = -ENOMEM;
 
-	if (!cma || !cma->count)
+	if (!cma || !cma->count || !cma->bitmap)
 		return NULL;
 
 	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
-- 
2.17.1



