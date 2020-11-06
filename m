Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6812D2A9290
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKFJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:28:15 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42869 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604654894; x=1636190894;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=XFJniwlkNXe8JM15OXyPD5pcQfDbLM43u1ZRyw/GVgk=;
  b=GTKjchbDWcS2fm7+Qz1PKNWXWOyrSUrYG0+YLgy1ZNme3Rnq/ObRuTny
   zGCOCdPrCF5VYEZi+34zB6B7Q+69+amWIlrhZOa7fhqsU9r43bYKYM3Jr
   2PYHUjU8m5hco0R74ujQtc6nQyQHMrd2IFXkztOPniKXPQEQUB1zgUyEw
   Hy+XfEb5K7tP8GULqXuo+NaF4QgqGcXXhmLyMtwCkazxuGrLko79OnIti
   BUUlsofQl4kwP1bhIFyQCCicHtOBic+UvgTxs1+YwKXlv+XQfWO3TFuW8
   0iZsws6/ncNdLQOfHO1BNU491SuDVMvHSBrsJuoIwvCQmEOtPsutR+/2b
   A==;
IronPort-SDR: PiN57OyndIRezPrmP27QVdfP9WUeWkQxAMo9QmP1nWM1lMY8qk5l0xrCE6Wmla35kxvYLbuVRn
 /aJL4OyZmsmv+0MX6nbmlfH9/QTAaE7tmvSHt9Pb0EnGE6CjjnDs9HeNNIwa2IB2h1vQMTvEne
 sJXSmbqioY+99bdOnL5nycYigbS8X7OzcRLENgAKeKTN7LhrXXOcI7jsnyuHglQRT7j2oRiqOZ
 gmaET2pVAMJDS629U9J9aKkdG7aXkAtIJ0pqWi+2ya0mqMaOpdY1s00CaMDxLzzIaio1QMsWB3
 I90=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97423883"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:28:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:28:13 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:28:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 00/11] clk: at91: adapt for dvfs
Date:   Fri, 6 Nov 2020 11:27:53 +0200
Message-ID: <1604654884-30339-1-git-send-email-claudiu.beznea@microchip.com>
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
 drivers/clk/at91/at91sam9x5.c      |  28 +++-
 drivers/clk/at91/clk-master.c      | 328 +++++++++++++++++++++++++++++++------
 drivers/clk/at91/clk-sam9x60-pll.c | 102 ++++++++++--
 drivers/clk/at91/dt-compat.c       |  15 +-
 drivers/clk/at91/pmc.h             |  22 ++-
 drivers/clk/at91/sam9x60.c         |  36 ++--
 drivers/clk/at91/sama5d2.c         |  42 +++--
 drivers/clk/at91/sama5d3.c         |  38 +++--
 drivers/clk/at91/sama5d4.c         |  40 +++--
 drivers/clk/at91/sama7g5.c         | 204 ++++++++++++++---------
 include/dt-bindings/clock/at91.h   |  11 ++
 16 files changed, 759 insertions(+), 245 deletions(-)

-- 
2.7.4

