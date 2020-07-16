Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CB221E98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGPIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:39:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgGPIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:39:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88FF275C51A9C3B9AFA4;
        Thu, 16 Jul 2020 16:39:20 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:39:12 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] genirq/irqdomain: Remove redundant NULL pointer check on fwnode
Date:   Thu, 16 Jul 2020 16:39:05 +0800
Message-ID: <20200716083905.287-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_fwnode_irqchip() helper will check if the fwnode_handle is empty.
There is no need to perform a redundant check outside of it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a4c2c915511d..155460fc0147 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -142,7 +142,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	if (!domain)
 		return NULL;
 
-	if (fwnode && is_fwnode_irqchip(fwnode)) {
+	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
 
 		switch (fwid->type) {
-- 
2.19.1

