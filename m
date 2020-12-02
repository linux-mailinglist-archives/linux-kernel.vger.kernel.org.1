Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1E2CB9F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbgLBJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:58:25 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:15346 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbgLBJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606903104; x=1638439104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=37AH/eE7ah8M+AAHKPVe04uSJk40NY7/cY6zhOg1Bck=;
  b=Hbt8gWEc3RMYPac1pvyhkYqSX8/ddh9rCDCaTfZ0yPwDWVwjYLNFjipO
   Q4TXJ91sAKG87dCcPmuDJL0BqQ0o77eAVpE3QH15IpLsS51HtkicOiL+t
   JFe9g9S/6p56b8EwPfBpFp/7f/mUu2PprttQgEo5QIuBTLoesXIKRcsL9
   0RZ9Ri/a58JMbS2hZsu7osY72IM041Ivh3v8MieRi1N2A8c5wt2e6cymQ
   KRnx/RuGK3MpbDdk8Uo0uUBO6sdvUT1601ABW6x/P66kntCNIO57JTk3N
   PFSqj3W1mHLqAgyZNKVeB+Fcrg6OJt2wwnB6vjPAt8FQgStXYekUkWNTa
   Q==;
IronPort-SDR: RyaCZZVFCsSwAGrS/9XonAvjQOQg7au2ubI9frfBpinZWJniiC7bHmcgQoEOK/jlJ305drA+nV
 T/8izPZDV88O6Eke0uD0urXTjMDuPmuNix7mNu3lKGr/NsHsCq/IqHcGrSa3arWc77cpZshM8x
 59j9aladEX+mXERkDYMhHlXdxZxuHpIIHZU14ERAfNY8WI/Q2h+07DiEquOaUZrfQHmbMibq96
 cIiZ7+HHp1PADQcgZhAwm5OjYkbmcckMB7VyEb50hrBEQFC/zV8ePcl1WkHWz7o1kbzkFVFTeq
 GzQ=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101099220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 02:57:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 02:57:18 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 02:57:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2: map securam as device
Date:   Wed, 2 Dec 2020 11:57:05 +0200
Message-ID: <1606903025-14197-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
References: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to strobe signal not being propagated from CPU to securam
the securam needs to be mapped as device or strongly ordered memory
to work properly. Otherwise, updating to one offset may affect
the adjacent locations in securam.

Fixes: d4ce5f44d4409 ("ARM: dts: at91: sama5d2: Add securam node")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2ddc85dff8ce..6d399ac0385d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -656,6 +656,7 @@
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 51>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				no-memory-wc;
 				ranges = <0 0xf8044000 0x1420>;
 			};
 
-- 
2.7.4

