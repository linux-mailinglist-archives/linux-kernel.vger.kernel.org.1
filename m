Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682582CB9F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgLBJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:58:21 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:15340 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbgLBJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606903100; x=1638439100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OdCpF73TbaLabmoC1RVF4yiDtMF6ipG7iEY58ar58x8=;
  b=vMvQFHAb/8zNSgC9bR/WIu9ozm8xTXPW9tQ1YDbYDIbIC4x+5ORV0NFc
   oB0+rsn3To8Iq+IABLbeBusagsu8hzUAOjKBUI745CMNcGzS86ryPlmgw
   zxaVVnU9CwNXS19gls907Ii9/wT7aWZowqSyS1bnQbGXVG4XZEx2BNqmq
   WYOvjcO68SGxWB/S8lgIVyTa/S6OmUfCg4mhvKnJWyC78LkfBE7eDsAPa
   3bX4Kz9G57zhGvh28kfyKKhi8wIl3c/6HwNd3X/j5nkqV3Ki8Mvc60dvy
   NCthF2bIueLynYvwoclHmWzYtUfXROneR3gNXTL2ZQtXMp3GHHIdtFgJp
   A==;
IronPort-SDR: +3KW5gWdJyWenbnbDcy7glcD+2K/owO4WupDOqLzVABEDvT3c6S2HqisyIObGSy0Ceb2qR4iFg
 1l1QkgQQMhqtsgBrGnk7LWkY+NBhhqYai+PBdtqYQN5M1IA4liFIa2Z+Mod4+yjvpyeUL3oa4p
 r1YqceHJOmM6J2oZdiC/TNVGWC/PvbbDOezbWVAL4neNiKq6am7TssbxGf9B+cOkVKcpASm9z0
 3H79OzQiEyx3AjSFR9MmxXj8XGaPjcZPXMktRncRqeqCGvSp6lqyVQwp6bcyx1gf09T+KbxTl8
 Hpk=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101099214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 02:57:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 02:57:15 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 02:57:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marco Cardellini <marco.cardellini@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sam9x60ek: remove bypass property
Date:   Wed, 2 Dec 2020 11:57:04 +0200
Message-ID: <1606903025-14197-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
References: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel,osc-bypass property sets the bit 1 at main oscillator register.
On SAM9X60 this bit is not valid according to datasheet (chapter
28.16.9 PMC Clock Generator Main Oscillator Register).

Fixes: 720329e86a463 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Cc: Marco Cardellini <marco.cardellini@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 0e3b6147069f..73b6b1f89de9 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -578,10 +578,6 @@
 	};
 }; /* pinctrl */
 
-&pmc {
-	atmel,osc-bypass;
-};
-
 &pwm0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0_0 &pinctrl_pwm0_1 &pinctrl_pwm0_2 &pinctrl_pwm0_3>;
-- 
2.7.4

