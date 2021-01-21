Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198AD2FE984
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbhAUL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:59:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29463 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbhAULUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611228041; x=1642764041;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=q4ZsdJTJ4dixLEzGTbbVdW+QogbIEeXzO/QvdmgiWYc=;
  b=O3uwtf4v/pFYS5oxU1RpLd/SR0rT5PrEpxbb0+AB4YVh/uoFwNeCbmGX
   lWVFxeGAsFBkpWiaAzQDu8zEu1xLTzmx+vBZO6svDKWHst7F6Ik3td8x2
   FILUePUZUI4cOf1yIoB5Z/QrABpK+LToUdoS1N3JNJG8KrD0lAy7VQLWC
   4ebCyUT5iC7JjXjtcWhSK9WikWuvBeD+JLQ6aPgBSq7/3pRpgsQjGVNEf
   li03p79SR3kQyPjcawPd3OTC/1+m3UO+p+l7YUF1EwOKQ6XormGR2FO0z
   cOQw/xkYVFp10FI9UjUt0tHRAjA4gGAJLWAqsHWw3cnRDwJb1JldUntwn
   g==;
IronPort-SDR: +t0APLGnIHjfYPowpTVdQRdw3kaWi8iOv/SRjwjUXXhIOGn/siHsxsyddTuGTLSDrZtrOMWFO7
 Y1cQVtL4JMNxC/dszoqbz4jWkNGG+Q2Rmz3sTF9EaHkp4YzvcwmdcsBoRVWbMpG+B3z7YGyE2u
 nmkXUodlJbpW/rXEXp6hBj2UqAK3M+GtuoyFZk+q52enpj8+ut28SZ+PuHSiyOgUK3ffAZhj5F
 DMYEQTOEhuc8l9cG8D5J3SbRey9GjSi6RbJzcJFQxgPC36iJLjJf6UJNzy54iGmCtWGmqcM2SI
 OYs=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="106762264"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:19:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:19:25 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:19:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/5] clk: at91: updates for power management and dvfs
Date:   Thu, 21 Jan 2021 13:19:06 +0200
Message-ID: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series addresses the power management for SAMA7G5 and also updates
the master clock prescaller and master clock divider drivers to accomodate
the requests at [1].

The power management part is implemented by adding
save_context()/restore_context() on each clock driver (patch 1/5). Since
the PM part is necessary only for backup mode (supported on SAMA5D2 and
SAMA7G5) the pmc.c has been adapted to call the
save_context()/restore_context() only on switches to/from backup mode
(patch 2/5).

Patch 3/5 adds the securam clock on SAMA7G5. This is necessary for
backup mode of SAMA7G5.

Patch 4/5 adds registers definitions for the new master clocks (MCK1..4) of
SAMA7G5 and adapt the clk-master.c. The defines exported in
include/linux/clk/at91_pmc.h will be also used by platform specific PM
code.

Patch 5/5 adpat the master clock divider and master clock prescaller
to address the requests at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210105104426.4tmgc2l3vyicwedd@vireshk-i7/

Claudiu Beznea (5):
  clk: at91: re-factor clocks suspend/resume
  clk: at91: pmc: execute suspend/resume only for backup mode
  clk: at91: sama7g5: add securam's peripheral clock
  clk: at91: clk-master: add register definition for sama7g5's master
    clock
  clk: at91: clk-master: update for dvfs

 drivers/clk/at91/at91rm9200.c       |   2 +-
 drivers/clk/at91/at91sam9260.c      |   2 +-
 drivers/clk/at91/at91sam9g45.c      |   2 +-
 drivers/clk/at91/at91sam9n12.c      |   2 +-
 drivers/clk/at91/at91sam9rl.c       |   2 +-
 drivers/clk/at91/at91sam9x5.c       |   2 +-
 drivers/clk/at91/clk-generated.c    |  45 +++-
 drivers/clk/at91/clk-main.c         |  66 ++++++
 drivers/clk/at91/clk-master.c       | 395 +++++++++++++++++++++++++++---------
 drivers/clk/at91/clk-peripheral.c   |  38 +++-
 drivers/clk/at91/clk-pll.c          |  37 ++++
 drivers/clk/at91/clk-programmable.c |  29 ++-
 drivers/clk/at91/clk-sam9x60-pll.c  |  68 ++++++-
 drivers/clk/at91/clk-system.c       |  20 ++
 drivers/clk/at91/clk-usb.c          |  27 +++
 drivers/clk/at91/clk-utmi.c         |  47 ++++-
 drivers/clk/at91/dt-compat.c        |   2 +-
 drivers/clk/at91/pmc.c              | 175 ++++------------
 drivers/clk/at91/pmc.h              |  27 ++-
 drivers/clk/at91/sam9x60.c          |   2 +-
 drivers/clk/at91/sama5d2.c          |   2 +-
 drivers/clk/at91/sama5d3.c          |   2 +-
 drivers/clk/at91/sama5d4.c          |   2 +-
 drivers/clk/at91/sama7g5.c          |   3 +-
 include/linux/clk/at91_pmc.h        |  26 +++
 25 files changed, 750 insertions(+), 275 deletions(-)

-- 
2.7.4

