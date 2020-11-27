Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35312C6D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgK0WGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:06:35 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:35509 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgK0WEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:04:05 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A4EB4240002;
        Fri, 27 Nov 2020 22:04:03 +0000 (UTC)
Date:   Fri, 27 Nov 2020 23:04:03 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.11
Message-ID: <20201127220403.GA1735041@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here are the DT changes for 5.11 which contains non urgent fixes.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-dt-5.11

for you to fetch changes up to e1062fa7292f1e3744db0a487c4ac0109e09b03d:

  ARM: dts: at91: sama5d3_xplained: add pincontrol for USB Host (2020-11-24 12:11:27 +0100)

----------------------------------------------------------------
AT91 DT for 5.11:

 - fix USB host pinctrl
 - fix DT schema warnings

----------------------------------------------------------------
Alexander Dahl (2):
      ARM: dts: at91: smartkiz: Reference led node directly
      ARM: dts: at91: Fix schema warnings for pwm-leds

Bartosz Golaszewski (1):
      ARM: dts: at91: at91-sama5d27_som1: fix EEPROM compatible

Cristian Birsan (3):
      ARM: dts: at91: sam9x60: add pincontrol for USB Host
      ARM: dts: at91: sama5d4_xplained: add pincontrol for USB Host
      ARM: dts: at91: sama5d3_xplained: add pincontrol for USB Host

 arch/arm/boot/dts/at91-kizbox.dts             | 10 +++++-----
 arch/arm/boot/dts/at91-kizbox2-common.dtsi    |  8 ++++----
 arch/arm/boot/dts/at91-kizbox3-hs.dts         | 16 ++++++++--------
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 10 +++++-----
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi |  8 ++++----
 arch/arm/boot/dts/at91-sam9x60ek.dts          |  9 +++++++++
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi     |  2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   |  7 +++++++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts   |  7 +++++++
 arch/arm/boot/dts/at91-smartkiz.dts           |  6 ++----
 arch/arm/boot/dts/at91sam9m10g45ek.dts        | 10 +++++-----
 arch/arm/boot/dts/at91sam9rlek.dts            | 10 +++++-----
 12 files changed, 62 insertions(+), 41 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
