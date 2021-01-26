Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EFD3040E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbhAZOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:51:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25154 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391291AbhAZJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653886; x=1643189886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IbiTl8yUYXW9POMe4jJjHlFiQ6QTbLk72ZtZMsD7Cps=;
  b=g10ZVH84KARpF2pswtIRUoXCBxbo4D0xiq4/P80ndakPmRZ5kJGGUfhN
   fLUT+ReRUrqgKhLSxIBdBqzf27TrKnLIh3pN5oOdZSzK5/t9NxgcVS6wA
   MrjPlD8W7vYhMEorfWih+ySMaRul18MWTt8w0fZ26/gJlO2575e1d8HgR
   Y3Dqcamc3M+6uz6pYBcZOJRIzKhLz/udIwMyqQo/N7V7Xm1iO5p1McLiI
   NWYbri732Ik6W3zt5RjGli8vZ783sDRhlh7sIzMzwqu+Y80SPacdcigeY
   Zh5QYzhCUo4v8V/ZAZaUn0LHafwNiDF0eYPkshOEaxe0pIsVab3DmgYtd
   A==;
IronPort-SDR: BPp9TFhauPXYHrWjQGvIkupUfKOR6Wm0a2UiCuXpRjd5+/uwJvEAZ2BeP+F79baeikuqil2cON
 ekQK71V8sZM8BzuyYFgnOBD/rwyRGh1CW0NhSgExt5zI0SGK55EBgS1PU6feJwn4j4usnaMAza
 2phJRV85vVKPguj0Ze98GpG/Wgf2GF3s4PDH7EJMo0lsR+xen0dr/1rNlnIkUMql7i36x/EeN+
 KsY01N4kLRJ7IBuURCKgb998/afr3x8i9giMzkfVLPgQv85oYJhtMpo/zOeXiFyG6Wic4wGghY
 w+w=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="104250496"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:36:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:36:50 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:36:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/7] drivers: soc: atmel: use GENMASK
Date:   Tue, 26 Jan 2021 11:29:31 +0200
Message-ID: <1611653376-24168-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GENMASK() to define CIDR match mask.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 755a82502ef4..d54ec271a15d 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -28,7 +28,7 @@
 #define AT91_CHIPID_EXID		0x04
 #define AT91_CIDR_VERSION(x)		((x) & 0x1f)
 #define AT91_CIDR_EXT			BIT(31)
-#define AT91_CIDR_MATCH_MASK		0x7fffffe0
+#define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
 
 static const struct at91_soc __initconst socs[] = {
 #ifdef CONFIG_SOC_AT91RM9200
-- 
2.7.4

