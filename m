Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AFB273FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgIVKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:33:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39641 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIVKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:33:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U9liOx3_1600770811;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U9liOx3_1600770811)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 18:33:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: PCI: Validate the node before setting node id for root bus
Date:   Tue, 22 Sep 2020 18:33:24 +0800
Message-Id: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the BIOS disabled the NUMA configuration, but did not change the
proximity domain description in the SRAT table, so the PCI root bus
device may get a incorrect node id by acpi_get_node().

Thus better to add a numa node validation before setting numa node
for the PCI root bus, like pci_acpi_root_get_node() does for X86
architecture.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/kernel/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2..24fe2bd 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -86,9 +86,13 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 		struct pci_config_window *cfg = bridge->bus->sysdata;
 		struct acpi_device *adev = to_acpi_device(cfg->parent);
 		struct device *bus_dev = &bridge->bus->dev;
+		int node = acpi_get_node(acpi_device_handle(adev));
+
+		if (node != NUMA_NO_NODE && !node_online(node))
+			node = NUMA_NO_NODE;
 
 		ACPI_COMPANION_SET(&bridge->dev, adev);
-		set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+		set_dev_node(bus_dev, node);
 	}
 
 	return 0;
-- 
1.8.3.1

