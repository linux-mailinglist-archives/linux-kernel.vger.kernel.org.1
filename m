Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0D303C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404993AbhAZL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:29:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:39062 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391345AbhAZJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653985; x=1643189985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sqpwPF9U4qG1g/0WmrtNvE4y7SqpqZVyPv6CCH+N9zY=;
  b=CzQZh9yUn/M9EOArsi9pDARGejR5vmufPPz7SwrC76TAuHc931oLJwRs
   n1QBaipWw+QsGeKWWtUQuSjQIpAFBkGmp8+Yv2105X0DqxeGxFKqbFbgI
   mvKLNhV3grF6gy1pZDISXvLpWanfM2BemZjmGoOcu8RormpvlQ0wXQGMm
   Gcm3udA4y3X1PMg5cbmUpDFSAmK8z5Ap1HnD+2humk5WfpiKxKI84kJ8F
   xP8YUaeL4XNRRIwlEh6rB/wxB6stOFwiVvJ6MlwLP4efT/A+o/eYMmowZ
   pApawVr4YZDzcSd7tNKRCIXXoXo3nh+P3Xg4ABh9DQNeKKB6MMVyreRWP
   A==;
IronPort-SDR: jC436hV2ubchyafcCOfkAkD47hEkIHJ7MjO+/9gK+NndCheCkyB2hPA4XIsJpWLz6p6uP8eQAp
 RVogrgGYv8hV4CdOTxMhjlMS0FlBECsLGN6LcEHzLylgor3sh+3wTs1WPR62k83OYuOvWuUkwN
 BYlc1vXt/sd+GBasXsP39vCUf1E639w9k5d/O991yiHn6mca/OCgCYXtLp5af5dzVJMVHKTgoq
 X0qTQKzkQsH+cgE5xONFq8iezuKZtGVtp3JZ2E+RTyDUrVviKL+yys24K6NZNkXfWB5sp7TApI
 47c=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="41780882"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:36:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:36:55 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:36:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/7] drivers: soc: atmel: add null entry at the end of at91_soc_allowed_list[]
Date:   Tue, 26 Jan 2021 11:29:33 +0200
Message-ID: <1611653376-24168-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_node() calls __of_match_node() which loops though the entries of
matches array. It stops when condition:
(matches->name[0] || matches->type[0] || matches->compatible[0]) is
false. Thus, add a null entry at the end of at91_soc_allowed_list[]
array.

Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 8d89e2426fc8..9a2c08a26ea4 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -270,7 +270,8 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 	{ .compatible = "atmel,at91rm9200", },
 	{ .compatible = "atmel,at91sam9", },
 	{ .compatible = "atmel,sama5", },
-	{ .compatible = "atmel,samv7", }
+	{ .compatible = "atmel,samv7", },
+	{ }
 };
 
 static int __init atmel_soc_device_init(void)
-- 
2.7.4

