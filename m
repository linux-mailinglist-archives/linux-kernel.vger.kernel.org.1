Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887213002D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbhAVM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:26:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37463 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbhAVMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611318197; x=1642854197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4ZZbR+gfy81D0z3Xa1K28E9lwpQ/XAas5cIRZrYBinw=;
  b=W5ctgfCllYjl3uMCLnb20lNSLF9xt1uPKiIzuZboQatq2jTbt1+RMrHT
   2ZX2DHxZX3SeePKRiZLfHIUTl2ZvCrynXkc2Tv5kulvUPE+4jodHrewSk
   ZH74OoOkAaYCiRpKHZWXZh6f5z9Hj/7Etya1On8vuZTsqrnlzDd89q1tN
   4VJxwwSmXp4xMQSMKei797Z7Q7qJgowlHBt/+7f5cFIUgfcaRbvP1w5NL
   sEYExvIWjmuK/+NpXKExjpS9K2Xa/gMC2kPguV9KgnD7axK9i/9hlCVMg
   t8bJOsqOmV/4c8ZW72Sjrf4yqDseSgST/w8UiuVet6oeNq2KgD26bQSfE
   g==;
IronPort-SDR: QNmEYipg4tuHZC/6y0tjxplJX1fSHmntBZK8YcBvbu570+XeVt3BCD5po0ycYgw5ojg8X4nKTh
 Aq+Zy/vzSfg6P5NC7JWAUH5RHuUt4OO+G9zrGx7IpcSB2RzHweZJKSLLCVycer5jkJevX1qbkK
 7+7NhA0lwnP66hiK7ZCmycm3UBSH+DVLcMmMFmHs+trHg9Pn+idud/onNSLdd53suBhb5Rz8au
 OleaqT6l8AGRQB6VmFw1q0ICs330eU2vSd2871EW5ZK1R8o9RJVKPxZ/6nQUSFTUPEIVR7+qdM
 +gg=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="106393529"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 05:22:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 05:22:01 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 22 Jan 2021 05:21:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/7] drivers: soc: atmel: add null entry at the end of at91_soc_allowed_list[]
Date:   Fri, 22 Jan 2021 14:21:34 +0200
Message-ID: <1611318097-8970-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com>
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
index 9d10a526cd3c..a196e171f6cc 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -276,7 +276,8 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
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

