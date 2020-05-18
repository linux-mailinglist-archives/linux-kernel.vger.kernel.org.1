Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09151D6F36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 05:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgERDCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 23:02:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbgERDCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 23:02:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5E8C9CFAF9557B9ED897;
        Mon, 18 May 2020 11:02:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 11:02:10 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] platform-msi: Fix typos in comment
Date:   Mon, 18 May 2020 11:00:59 +0800
Message-ID: <1589770859-19340-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up one typos @nev -> @nr_irqs.

Cc: Marc Zyngier <maz@kernel.org> 
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/base/platform-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8da314b81eab..c4a17e5edf8b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -387,7 +387,7 @@ void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
  *
  * @domain:	The platform-msi domain
  * @virq:	The base irq from which to perform the allocate operation
- * @nvec:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to free from @virq
  *
  * Return 0 on success, or an error code on failure. Must be called
  * with irq_domain_mutex held (which can only be done as part of a
-- 
2.7.4

