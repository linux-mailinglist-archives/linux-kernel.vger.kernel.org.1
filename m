Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A626BCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIPGVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:21:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgIPGU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:20:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F87EB1388928149EAE6;
        Wed, 16 Sep 2020 14:20:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:43 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] irqchip/gic-v3: use for_each_matching_node() macro
Date:   Wed, 16 Sep 2020 14:21:24 +0800
Message-ID: <20200916062124.190682-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_matching_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   | 3 +--
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 3 +--
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 634263dfd..b4eec9f51 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -147,8 +147,7 @@ static void __init its_fsl_mc_of_msi_init(void)
 {
 	struct device_node *np;
 
-	for (np = of_find_matching_node(NULL, its_device_id); np;
-	     np = of_find_matching_node(np, its_device_id)) {
+	for_each_matching_node(np, its_device_id) {
 		if (!of_device_is_available(np))
 			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 87711e0f8..fdc596c87 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -130,8 +130,7 @@ static int __init its_pci_of_msi_init(void)
 {
 	struct device_node *np;
 
-	for (np = of_find_matching_node(NULL, its_device_id); np;
-	     np = of_find_matching_node(np, its_device_id)) {
+	for_each_matching_node(np, its_device_id) {
 		if (!of_device_is_available(np))
 			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index daa6d5053..5ce2c2ff2 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -143,8 +143,7 @@ static void __init its_pmsi_of_init(void)
 {
 	struct device_node *np;
 
-	for (np = of_find_matching_node(NULL, its_device_id); np;
-	     np = of_find_matching_node(np, its_device_id)) {
+	for_each_matching_node(np, its_device_id) {
 		if (!of_device_is_available(np))
 			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
-- 
2.23.0

