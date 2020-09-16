Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9226CF13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIPWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:47:41 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54924 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIPWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 18:47:39 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0C5913AA941
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 21:14:11 +0000 (UTC)
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1D582C0002;
        Wed, 16 Sep 2020 21:13:49 +0000 (UTC)
Date:   Wed, 16 Sep 2020 23:13:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.10
Message-ID: <20200916211348.GA275895@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

The bulk of the changes are fixes for issues found by dtbs_check. A new
board is also introduced.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-dt-5.10

for you to fetch changes up to 860b6d803f3d5feab4b67d500b060168a77f9a04:

  ARM: dts: at91: sama5d2: add missing flexcom spi node properties (2020-09-16 10:45:32 +0200)

----------------------------------------------------------------
AT91 DT for 5.10

 - New board: GARDENA smart Gateway (Art. 19000)
 - dtbs_check warnings fixes

----------------------------------------------------------------
Alexandre Belloni (5):
      ARM: dts: at91: fix cpu node
      ARM: dts: at91: fix sram nodes
      ARM: dts: at91: move mmc pinctrl-names property to board dts
      ARM: dts: at91: add unit-address to memory node
      ARM: dts: at91: sama5d2: add missing flexcom spi node properties

Reto Schneider (2):
      dt-bindings: arm: at91: Add GARDENA smart Gateway (Art. 19000) board
      ARM: at91: Add GARDENA smart Gateway (Art. 19000) support

 .../devicetree/bindings/arm/atmel-at91.yaml        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/animeo_ip.dts                    |   3 +-
 arch/arm/boot/dts/at91-ariag25.dts                 |   3 +-
 arch/arm/boot/dts/at91-ariettag25.dts              |   3 +-
 arch/arm/boot/dts/at91-cosino.dtsi                 |   3 +-
 arch/arm/boot/dts/at91-cosino_mega2560.dts         |   1 +
 arch/arm/boot/dts/at91-foxg20.dts                  |   3 +-
 arch/arm/boot/dts/at91-kizbox.dts                  |   2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi         |   2 +-
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi      |   2 +-
 arch/arm/boot/dts/at91-linea.dtsi                  |   2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts               |   3 +-
 arch/arm/boot/dts/at91-sam9_l9260.dts              |   3 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |   2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |   2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |   2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts               |   2 +-
 arch/arm/boot/dts/at91-som60.dtsi                  |   2 +-
 arch/arm/boot/dts/at91-vinco.dts                   |   2 +-
 arch/arm/boot/dts/at91-wb45n.dtsi                  |   3 +-
 arch/arm/boot/dts/at91-wb50n.dtsi                  |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |  11 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |  11 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |   3 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |  10 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  15 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |   3 +-
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   5 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   3 +-
 .../boot/dts/at91sam9g25-gardena-smart-gateway.dts | 158 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  12 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  10 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  10 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  12 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi                |   2 +
 arch/arm/boot/dts/at91sam9xe.dtsi                  |   3 +
 arch/arm/boot/dts/ethernut5.dts                    |   2 +-
 arch/arm/boot/dts/mpa1600.dts                      |   2 +-
 arch/arm/boot/dts/pm9g45.dts                       |   3 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |  10 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  19 ++-
 arch/arm/boot/dts/sama5d3.dtsi                     |   8 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |   2 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   8 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi            |   2 +-
 arch/arm/boot/dts/tny_a9263.dts                    |   2 +-
 arch/arm/boot/dts/usb_a9260.dts                    |   2 +-
 arch/arm/boot/dts/usb_a9263.dts                    |   2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi            |   2 +-
 57 files changed, 320 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
