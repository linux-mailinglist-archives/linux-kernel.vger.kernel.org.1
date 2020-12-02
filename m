Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1D2CB9EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbgLBJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:58:18 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7617 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgLBJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606903096; x=1638439096;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NHp049afLRmE48Nw3kYNwUJM3WDj7TQljOlxEv4P8Q0=;
  b=KUq+pUAP38/LrB6hE3qAyV0znMGJVcPfyDj355aXz3+WABPWzLOP2+dm
   +h1FJ3MgWod3qKub+ur/g1Aemg6JTJTY1idfVTky0JLb99/qDsllJIbFE
   +Ath6QjI6VKJmXb/x2WLNspb+Ex6AXha0GqqJqUSUN0JgBw+QhnT8iMkC
   72QOBnjZVsk7dpdSACDWYShCyaRgLZxC7vxD8MdSitzT7HpheCkPbcKz2
   nTEnGSNs52UP8ns2fDsmV1oHWakYsz+FXLkb/YyM+yvWp9fMj+zwil7ON
   /6oMc9XeKzJL0vIS1aSLsF0HePufYZhwY72Qon9c0qitJ+oUpztPunE6m
   g==;
IronPort-SDR: 4my0U638L12qHMmTGl/b9nXEdtehzd+/j0x0SAGKv0M1SkZ1xCribntavn/8QG6l+KSbW/Yyzk
 agurXK0vsTBKntVwMXid33gHnoN1Nbfn5HZ3d8PSjCvyL5Ri6sP+o57o0GwQ+VsHhq8vM/ZoRY
 MoFJsLn/aU3WYDft09miGbykhQgnP4BNUkGy14Waep9UkVwnEcjcuJ7w9pAPx8TXpzxmANjJNX
 EQt4sGKIH7Kr/3Yf2gEw4YlKQSkKMDbFXFb67d3MH2XqQbw7Obl6NLUQcRG0IjeR5SWlYSisUN
 Ahw=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="35770452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 02:57:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 02:57:10 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 02:57:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] fixes for at91 devices
Date:   Wed, 2 Dec 2020 11:57:03 +0200
Message-ID: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I added here 2 fixes for AT91 devices.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  ARM: dts: at91: sam9x60ek: remove bypass property
  ARM: dts: at91: sama5d2: map securam as device

 arch/arm/boot/dts/at91-sam9x60ek.dts | 4 ----
 arch/arm/boot/dts/sama5d2.dtsi       | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.7.4

