Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7A257F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHaRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 13:11:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39217 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgHaRLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:11:40 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 814B560004;
        Mon, 31 Aug 2020 17:11:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] ARM: dts: at91: fix dtbs_check warnings
Date:   Mon, 31 Aug 2020 19:11:22 +0200
Message-Id: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series fixes some of the dtbs_check warnings. The remaining ones
are mainly missing documentation or the documentation has not been
converted to yaml.

Alexandre Belloni (5):
  ARM: dts: at91: fix cpu node
  ARM: dts: at91: fix sram nodes
  ARM: dts: at91: move mmc pinctrl-names property to board dts
  ARM: dts: at91: add unit-address to memory node
  ARM: dts: at91: sama5d2: add missing flexcom spi node properties

 arch/arm/boot/dts/animeo_ip.dts               |  3 ++-
 arch/arm/boot/dts/at91-ariag25.dts            |  3 ++-
 arch/arm/boot/dts/at91-ariettag25.dts         |  3 ++-
 arch/arm/boot/dts/at91-cosino.dtsi            |  3 ++-
 arch/arm/boot/dts/at91-cosino_mega2560.dts    |  1 +
 arch/arm/boot/dts/at91-foxg20.dts             |  3 ++-
 arch/arm/boot/dts/at91-kizbox.dts             |  2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi    |  2 +-
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi |  2 +-
 arch/arm/boot/dts/at91-linea.dtsi             |  2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts          |  3 ++-
 arch/arm/boot/dts/at91-sam9_l9260.dts         |  3 ++-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   |  2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi     |  2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts   |  2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts          |  2 +-
 arch/arm/boot/dts/at91-som60.dtsi             |  2 +-
 arch/arm/boot/dts/at91-vinco.dts              |  2 +-
 arch/arm/boot/dts/at91-wb45n.dtsi             |  3 ++-
 arch/arm/boot/dts/at91-wb50n.dtsi             |  2 +-
 arch/arm/boot/dts/at91rm9200.dtsi             | 11 +++++++----
 arch/arm/boot/dts/at91rm9200ek.dts            |  2 +-
 arch/arm/boot/dts/at91sam9260.dtsi            | 11 +++++++----
 arch/arm/boot/dts/at91sam9260ek.dts           |  3 ++-
 arch/arm/boot/dts/at91sam9261.dtsi            | 10 +++++++---
 arch/arm/boot/dts/at91sam9261ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            | 15 ++++++++++-----
 arch/arm/boot/dts/at91sam9263ek.dts           |  3 ++-
 arch/arm/boot/dts/at91sam9g20.dtsi            |  5 ++++-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi   |  3 ++-
 arch/arm/boot/dts/at91sam9g45.dtsi            | 12 +++++++-----
 arch/arm/boot/dts/at91sam9m10g45ek.dts        |  4 +++-
 arch/arm/boot/dts/at91sam9n12.dtsi            | 10 +++++++---
 arch/arm/boot/dts/at91sam9n12ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi             | 10 +++++++---
 arch/arm/boot/dts/at91sam9rlek.dts            |  2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi             | 12 +++++++-----
 arch/arm/boot/dts/at91sam9x5cm.dtsi           |  2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi           |  2 ++
 arch/arm/boot/dts/at91sam9xe.dtsi             |  3 +++
 arch/arm/boot/dts/ethernut5.dts               |  2 +-
 arch/arm/boot/dts/mpa1600.dts                 |  2 +-
 arch/arm/boot/dts/pm9g45.dts                  |  3 ++-
 arch/arm/boot/dts/sam9x60.dtsi                | 10 +++++++---
 arch/arm/boot/dts/sama5d2.dtsi                | 19 ++++++++++++++++++-
 arch/arm/boot/dts/sama5d3.dtsi                |  8 +++++++-
 arch/arm/boot/dts/sama5d3xcm.dtsi             |  2 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi         |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi                |  8 +++++++-
 arch/arm/boot/dts/tny_a9260_common.dtsi       |  2 +-
 arch/arm/boot/dts/tny_a9263.dts               |  2 +-
 arch/arm/boot/dts/usb_a9260.dts               |  2 +-
 arch/arm/boot/dts/usb_a9263.dts               |  2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi       |  2 +-
 54 files changed, 160 insertions(+), 77 deletions(-)

-- 
2.26.2

