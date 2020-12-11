Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBB2D7745
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395011AbgLKOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:00:24 -0500
Received: from foss.arm.com ([217.140.110.172]:58832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394306AbgLKN7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:59:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E50D41FB;
        Fri, 11 Dec 2020 05:58:59 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B4343F68F;
        Fri, 11 Dec 2020 05:58:58 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2] drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs
Date:   Fri, 11 Dec 2020 13:58:46 +0000
Message-Id: <20201211135846.1334322-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since at91_soc_init is called unconditionally from atmel_soc_device_init,
we get the following warning on all non AT91 SoCs:
	" AT91: Could not find identification node"

Fix the same by filtering with allowed AT91 SoC list.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/atmel/soc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

v1->v2:
	- Updated the allowed list as suggested by Alexandre

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 55a1f57a4d8c..2dc86728b132 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -265,8 +265,20 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
 	return soc_dev;
 }

+static const struct of_device_id at91_soc_allowed_list[] __initconst = {
+	{ .compatible = "atmel,at91rm9200", },
+	{ .compatible = "atmel,at91sam9", },
+	{ .compatible = "atmel,sama5", },
+	{ .compatible = "atmel,samv7", }
+};
+
 static int __init atmel_soc_device_init(void)
 {
+	struct device_node *np = of_find_node_by_path("/");
+
+	if (!of_match_node(at91_soc_allowed_list, np))
+		return 0;
+
 	at91_soc_init(socs);

 	return 0;
--
2.25.1

