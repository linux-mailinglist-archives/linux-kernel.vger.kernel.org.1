Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A090303B98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbhAZL2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:28:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:20082 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391296AbhAZJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611653897; x=1643189897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=poKO1QLD7vI0zCPnPL2EEcKhUF8lVOuEF/XvYo+LqT8=;
  b=m/5BihmsTFBtXc8T+i9cQ4+PWYrAqxwpfNJaqni1hShxVuGybVDo1ODJ
   ik+p6IKsIINIrwV4iE2m0XOYGvoAw5Fuij5sAzb+7rPOk54q5P9QCnSvu
   BehyeMEmPXrgJSGIQ63lS9TzeSYflnf4BUXMhzFVSvcScRm1LiyxGhP+h
   2NCrnYwTUeFCuBpp29p5JdJoL7WJla6CHTonFd82vqjLog/z6R0a/3dHh
   BqNihL+i6sopiImwk+t4M7lZBCn4kLEujFArucFMEO+GgqYW2xpnE/JUm
   EXkRKEVaFvOl/JT5Jr5+DmmvgH2sDPVT7hWBPnkrSBLasEzflU9o0QsEx
   g==;
IronPort-SDR: HLmCHs28w91etPIu+P42XPDZF2YppX5vyHIDR9YjnR3qQqGQh4R3QqqzGnumJcAxSr0R0dfWi/
 fTvRQ3iEB7xNt1d4Anf3cECWF9gRKp8ygNVa9m5UClbuPvrG0bvGZtqsbpciXW3UCk+jT9sYH1
 nn1WF8V/U3o0F3llaET3ceYzLOeCz5APIfAy+pN9Rb0gHKrT+swqUgw+ca76cHH1Kid564IcJG
 9uaaKlhY030PvVdhArx7LjAS5uR6qpg67ST65LkXi5QXItIpNjq5Xbr972hfcEwae+7mZdr0iy
 fAU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="101448954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2021 02:37:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 02:37:01 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 26 Jan 2021 02:36:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sudeep.holla@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/7] dt-bindings: atmel-sysreg: add "microchip,sama7g5-chipid"
Date:   Tue, 26 Jan 2021 11:29:35 +0200
Message-ID: <1611653376-24168-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611653376-24168-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for SAMA7G5's CHIPID.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 62cd4e89817c..67719f15eb4c 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -1,7 +1,7 @@
 Atmel system registers
 
 Chipid required properties:
-- compatible: Should be "atmel,sama5d2-chipid"
+- compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
 - reg : Should contain registers location and length
 
 PIT Timer required properties:
-- 
2.7.4

