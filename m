Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403FE2B9678
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKSPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:43:26 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51538 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgKSPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800605; x=1637336605;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HPhDzt0MMGUh03C9iz8ZPA1mDE/B4co092DdSZBLSf0=;
  b=gJ83pag0NwFYlCbqVW6nd94BcHdzTqONAFKE1/sFemSOpasL7Lgk/maj
   TJao8ghmOzGkMBybi1YnHTAj8zF1X/U8xf4oj+5pGAnwlk9ZpsQjFIdQl
   y96Dt/Wu+OOHtqxSRKmK5rp3BXIBZLiZobyLaSs5biaKoxe1spg6zR2y5
   zynt5MwZaHOHLPRTAfsGi30fONn62BTdaKYTLujzsY12f1Kn5/kdQhlgM
   xbjw748N7VtdhZqQnLSfZ9CpIP9If7VtV85xsdHBpo+cZxwZRXrRuPyVP
   rirrv7muRDXUtt6qGl50NbkKPlO3HAtKYtJRlNv/913Lsmg83Oc1noZyJ
   g==;
IronPort-SDR: 8PHcsgbI0SaTHh3ZFbbOtsVW33UTZa6o6zfARDvqWDP2lBBhMF0OwwyHOQ2x4pZJIqQRCSKD0G
 MWSy6l1I2B1bnYT2PDIdCNx7P/htcq7Q5R01qiNBgBo5XK2Q2H+OH59D4UgG9inZUEnfG2zUgo
 SbBxYXuDTzQ/ToFUA2yAkS4hHVv9KfMyG4XfnBwKsKrHxQnk0xGclIE2/APFCsvQIMoR11uJcy
 zy8v63AjMeXYxxcSRJ5ROoRAXfS06/8k1E3gs5MbOCzemUCysilX9YVEZcChYOljV/m0t8znkm
 Y08=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="96941953"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:43:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:43:24 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:43:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 00/11] clk: at91: clk-master: re-factor master clock
Date:   Thu, 19 Nov 2020 17:43:06 +0200
Message-ID: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
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
the IPs which are not MCK0 glitch aware (patch 7/11).

This series adapt AT91 clocks (mostly sam9x60-pll and master clock drivers)
so that runtime changes of these clocks to be allowed.

The CPU clock was registered from prescaller clock (see above diagram)
and no software control has been added for divider1 because the frequencies
supported by SAMA7G5's CPU could be directly obtained from CPU PLL +
prescaller.

On top of this series I also added a fix for sama7g5.c code (patch 1/11).
Please let me know if you would like me to send this one separtely (it
would be nice if this fix could be integrated in 5.10).

Changes were tested on SAMA5D2, SAMA5D3, SAM9X60 and SAMA7G5.

Thank you,
Claudiu Beznea

Changes in v6:
- remove if (clk_hw_get_flags(hw) & CLK_SET_RATE_GATE) in patch 10/11 as
  we use different clock ops now for pres, div supporting run-time changes
  
Changes in v5:
- use separate clk_ops for PLLs and master clock div, pres supporting
  run-time changes (patches 6/11, 10/11)
- use unsigned long type for f member of struct typeof(sama7g5_plls)
- document the usage of CLK_IS_CRITICAL

Changes in v4:
- added Reviewed-by, Tested-by tags forgoten in v3

Changes in v3:
- collected Reviewed-by, Tested-by tags
- add patches 4/11, 5/11, 9/11
- in patch 10/11 use CLK_SET_RATE_GATE on MCK div and MCK pres for all
  the platforms except sama7g5

Changes in v2:
- s/at91rm9200_mck_lock/at91sam9260_mck_lock in patch 7/8

Claudiu Beznea (7):
  clk: at91: sama7g5: fix compilation error
  clk: at91: clk-sam9x60-pll: allow runtime changes for pll
  clk: at91: sama7g5: remove mck0 from parent list of other clocks
  clk: at91: sama7g5: decrease lower limit for MCK0 rate
  clk: at91: sama7g5: do not allow cpu pll to go higher than 1GHz
  clk: at91: clk-master: re-factor master clock
  clk: at91: sama7g5: register cpu clock

Eugen Hristev (4):
  dt-bindings: clock: at91: add sama7g5 pll defines
  clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and
    referenced in DT
  clk: at91: clk-master: add 5th divisor for mck master
  clk: at91: sama7g5: add 5th divisor for mck0 layout and
    characteristics

 drivers/clk/at91/at91rm9200.c      |  21 ++-
 drivers/clk/at91/at91sam9260.c     |  26 ++-
 drivers/clk/at91/at91sam9g45.c     |  32 +++-
 drivers/clk/at91/at91sam9n12.c     |  36 ++--
 drivers/clk/at91/at91sam9rl.c      |  23 ++-
 drivers/clk/at91/at91sam9x5.c      |  28 ++-
 drivers/clk/at91/clk-master.c      | 337 ++++++++++++++++++++++++++++++++-----
 drivers/clk/at91/clk-sam9x60-pll.c | 145 ++++++++++++++--
 drivers/clk/at91/dt-compat.c       |  15 +-
 drivers/clk/at91/pmc.h             |  22 ++-
 drivers/clk/at91/sam9x60.c         |  45 +++--
 drivers/clk/at91/sama5d2.c         |  42 +++--
 drivers/clk/at91/sama5d3.c         |  38 +++--
 drivers/clk/at91/sama5d4.c         |  40 +++--
 drivers/clk/at91/sama7g5.c         | 223 ++++++++++++++++--------
 include/dt-bindings/clock/at91.h   |  11 ++
 16 files changed, 840 insertions(+), 244 deletions(-)

-- 
2.7.4

