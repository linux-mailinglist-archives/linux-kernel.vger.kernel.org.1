Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7D2D73F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgLKKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:33:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgLKKci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:32:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ADB330E;
        Fri, 11 Dec 2020 02:31:53 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18ECF3F68F;
        Fri, 11 Dec 2020 02:31:51 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs
Date:   Fri, 11 Dec 2020 10:31:43 +0000
Message-Id: <20201211103143.1332302-1-sudeep.holla@arm.com>
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
 drivers/soc/atmel/soc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index c4472b68b7c2..ba9fc07cd91c 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -271,8 +271,19 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
 	return soc_dev;
 }
 
+static const struct of_device_id at91_soc_allowed_list[] __initconst = {
+	{ .compatible = "atmel,at91rm9200", },
+	{ .compatible = "atmel,at91sam9260", },
+	{ .compatible = "atmel,sama5d2", },
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

