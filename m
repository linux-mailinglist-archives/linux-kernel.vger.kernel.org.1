Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF03040E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391265AbhAZOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:50:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38840 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391316AbhAZJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653959; x=1643189959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NQ7l4oDImBnVyOc+iYZ5NgNpi62aMQ9qjS6hc354pFk=;
  b=qHqEiJ41gfTw7Uk6DMmymytchgBB53e0aKEijEsJ9YltYQc8qdMcxFRZ
   l4tZ/qFao0GofHCBq5+h1pQNU/MilDBl167h53DX+zpb24k/pC/GueZZN
   IEU4yU30rPvNdjbLs5kOs+1uxFl5dT62VoMQZp6jpHxeu2Vbk83O4x/At
   rR5tIPXn01jsACt5KeYgBUlMwyZb630vCkBKa+jsWnJmlSJqvTapfE5IG
   NJ8MbbUBMPQAPuXsHwSBjORMv6jX2rTt064Jjm79zTIoP6JU7tHN3ypmj
   IbQccv636DR2IUQeA3FTtL7OsWrZ9GmCdjTPGIXe9IpE6VfAei8fpnicx
   g==;
IronPort-SDR: 1182lLgxHhaPPboY0paWFaNT3LQ5kaBkt/nkQBkqIaWLQUL+QTQMPhUldeXLlJ48ZKgueBMMpU
 SnROm+IDPNlVTLPGau8Im4sMwFkjUyaZ6nLR0cLFJdXrRkVtpQJwmuZfGkGvPOqN91OuOyRVXM
 fhBLMNKvXevhOevyP8wwU701Yat94SXSkCGoWYzSNh7X+/Z8opAdEDPAM1SajiD8izX3zLYK+/
 OK0TIRCc8ADUbqjL4U4XFDVXm3mFnj3T8fCD64ojweJt0IJJU/0ZCRUJJkEUkLOIGTQ0dx79cF
 pok=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="41780873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:36:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:36:53 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:36:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/7] drivers: soc: atmel: fix "__initconst should be placed after socs[]" warning
Date:   Tue, 26 Jan 2021 11:29:32 +0200
Message-ID: <1611653376-24168-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning: "__initconst should be placed after socs[]".

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index d54ec271a15d..8d89e2426fc8 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -30,7 +30,7 @@
 #define AT91_CIDR_EXT			BIT(31)
 #define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
 
-static const struct at91_soc __initconst socs[] = {
+static const struct at91_soc socs[] __initconst = {
 #ifdef CONFIG_SOC_AT91RM9200
 	AT91_SOC(AT91RM9200_CIDR_MATCH, 0, "at91rm9200 BGA", "at91rm9200"),
 #endif
-- 
2.7.4

