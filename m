Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1F2A60AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKDJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:40:15 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:50096 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgKDJkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604482813; x=1636018813;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0DHraKbRH3590M9sevmtaecbtEISot1V5c4yDS9ajbc=;
  b=DVhYCJ/kKKJzCeG8uYR5m71DWAg7JggJCG6YIYN0ke2eliYqhIkCDDSr
   gN4LipezbzQQo8OBKRrDd+kcRuE5A7TP61iXbCh76N8B8qVkxF0BdM+nQ
   MCNyYowWDFYxMh0pemk4sSUavYisSFXExSHR3Od7/oOAaetGRnRelTPww
   MoFgSa4wv9Z7pk8Ph/TjHhX0jPtHk46OvxWDJNuhLdkcMHY/u5BdwjDsa
   bJ8QR8s9LI7aEeb/1zb1hcVlC8E5BpKueMOXc8zxpVLI/G6wUUH5nL895
   dCFXzxqigTdwWBszrWDkGeAUckHO025laiaAW9IYQTk0qXW0eryfqJTFv
   A==;
IronPort-SDR: eYEtuCBPhdWoPt4qxB5MtpKkKNRsISIky3i8nKXY7MNHLRQ6jLaILeTTiiPJihRsvbRycaui+W
 D+10vosEmQjuD3szIPlEH39PUmlMPa2O1VTgUiUl5l3cBISn8QIQyCLNU/PGwmUqYurH4UZKjN
 r56oYiI0a7dJLNJv3EjZa9wVdo/9lnbZj2Uy38Sy9p+AfhhEv4Olmf54A0YXgxV4IORTcU7mcB
 IAx2AusWY2tb/aSSfXtpRRlYUZXXnphgVsaInKt20srrVykZEsLdZX0P6kGvEM1FcBDrTSItRd
 Nc8=
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="32375204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 02:40:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 02:40:10 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 02:40:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/8]clk: at91: adapt for dvfs
Date:   Wed, 4 Nov 2020 11:39:54 +0200
Message-ID: <1604482802-1647-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

SAMA7G5 is capable of DVFS. The supported CPU clock frequencies could be
obtained from CPU PLL. The hardware block diagram for clock feeding the
CPU is as follows:

                               +--------+
                           +-->|divider1|--> CPU clock
                           |   +--------+
+--------+   +----------+  |   +--------+
|CPU PLL |-->|prescaller|--+-->|divider0|--> MCK0 clock
+--------+   +----------+      +--------+

When switching CPU clock frequencies the MCK0 is also changed by DVFS
driver to avoid its over/under clocking (depending on CPU clock frequency
requested by DVFS algorithms). Some of IPs feed by MCK0 are MCK0 glich
aware, some are not. For this MCK0 was removed from the parents list of
the IPs which are not MCK0 glitch aware (patch 5/8).

This series adapt AT91 clocks (mostly sam9x60-pll and master clock drivers)
so that runtime changes of these clocks to be allowed.

The CPU clock was registered from prescaller clock (see above diagram)
and no software control has been added for divider1 because the frequencies
supported by SAMA7G5's CPU could be directly obtained from CPU PLL +
prescaller.

On top of this series I also added a fix for sama7g5.c code (patch 1/8).
Please let me know if you would like me to send this one separtely (it
would be nice if this fix could be integrated in 5.10).

Thank you,
Claudiu Beznea

Claudiu Beznea (6):
  clk: at91: sama7g5: fix compilation error
  clk: at91: clk-sam9x60-pll: allow runtime changes for pll
  clk: at91: sama7g5: remove mck0 from parent list of other clocks
  clk: at91: sama7g5: decrease lower limit for MCK0 rate
  clk: at91: clk-master: re-factor master clock
  clk: at91: sama7g5: register cpu clock

Eugen Hristev (2):
  dt-bindings: clock: at91: add sama7g5 pll defines
  clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and
    referenced in DT

 drivers/clk/at91/at91rm9200.c      |  20 ++-
 drivers/clk/at91/at91sam9260.c     |  24 ++-
 drivers/clk/at91/at91sam9g45.c     |  30 ++--
 drivers/clk/at91/at91sam9n12.c     |  34 ++--
 drivers/clk/at91/at91sam9rl.c      |  22 ++-
 drivers/clk/at91/at91sam9x5.c      |  27 +++-
 drivers/clk/at91/clk-master.c      | 323 +++++++++++++++++++++++++++++++------
 drivers/clk/at91/clk-sam9x60-pll.c | 102 ++++++++++--
 drivers/clk/at91/dt-compat.c       |  15 +-
 drivers/clk/at91/pmc.h             |  20 ++-
 drivers/clk/at91/sam9x60.c         |  35 ++--
 drivers/clk/at91/sama5d2.c         |  41 +++--
 drivers/clk/at91/sama5d3.c         |  37 +++--
 drivers/clk/at91/sama5d4.c         |  39 +++--
 drivers/clk/at91/sama7g5.c         | 139 +++++++++-------
 include/dt-bindings/clock/at91.h   |  11 ++
 16 files changed, 692 insertions(+), 227 deletions(-)

-- 
2.7.4

