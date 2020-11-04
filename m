Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9892A6BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgKDRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:45:38 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55816 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbgKDRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604511937; x=1636047937;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ZmimzAcfmhamS/+M4yrvoHe76P5sEggPdECJfrNqkVM=;
  b=kCy/j8LcmlVMenmuQHS/CvWm3qLXi5FStFbyqbDaj81UmpAxjGHIjtUm
   c6SLEmKYgzPy+k63uocvbae1kkwPlm2UNbDXGj1RiJBd73f5yBFaskhxP
   Md9/oJtsH9WoPpmJqH9rbF25NFoeVP4eqpwgadIsbYUEha3gTsaF3GfmJ
   a97M14KISAisPrRofCpTZA/y9hc+3UaYmphlwjlz2GnX/MpwVJCfViGG7
   L0BNx49TFN2klF7NR2EZP/kkEzQGG23ZIltVsw3kKqET3LzlbrOUBmztW
   UoSW4tU+a8jdBRlQGHvGu8LqTlW9PW0LWrDgF7JVvluCQWcR6kpT+GT+n
   w==;
IronPort-SDR: p2pV9b5ZSXIJ9a3BCyo3pxiqGdMkqiR78sJeOJhH1HlkXdI/h5+hYgCvyVXOj30djzfiJiY3EQ
 FYcVVVUmA25qWXeAwyfDlcxthQ5d5eDDijYxDdwjxscBzUciH6f5+B54/G+FKG2FSROVPqjhCq
 tttMc7V9VZ1DPWMloxYXyduIF8v4oS1oRUQN1kBEbAVrI6cfU3rMUqtr+r3xPaqWMobiXQB7mS
 NXuL0C6TKw3/BXeiBuY5JmUVVCXKAMKMX6aGi0ot/264dDzJckztgSIi4D+FyNLqTnNOjgs1Jd
 RIc=
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="97768114"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 10:45:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 10:45:36 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 10:45:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/8] clk: at91: adapt for dvfs
Date:   Wed, 4 Nov 2020 19:45:18 +0200
Message-ID: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes in v2:
- s/at91rm9200_mck_lock/at91sam9260_mck_lock in patch 7/8

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

