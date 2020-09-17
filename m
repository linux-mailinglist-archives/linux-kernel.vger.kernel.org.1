Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8005426E9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIRAIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:08:25 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55293 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgIRAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:08:23 -0400
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 20:08:21 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 08HNiMqK008721;
        Fri, 18 Sep 2020 02:44:22 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 6EE6A639D6; Fri, 18 Sep 2020 02:44:22 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, tmaimon77@gmail.com
Subject: [PATCH v6 0/3] arm: dts: add and modify device node in NPCM7xx device tree
Date:   Fri, 18 Sep 2020 02:44:17 +0300
Message-Id: <20200917234420.86137-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds and modify device tree nodes in the NPCM7xx
Baseboard Management Controller (BMC) device tree.

The following device node add:
        - NPCM7xx Pin controller and GPIO
        - NPCM7xx PWM and FAN.
        - NPCM7xx EHCI USB.
        - NPCM7xx KCS.
        - NPCM Reset.
        - NPCM Peripheral SPI.
        - NPCM FIU SPI.
        - NPCM HWRNG.
        - NPCM I2C.
        - STMicro STMMAC.

The following device node modified:
        - NPCM7xx timer.
        - NPCM7xx clock constants parameters.

NPCM7xx device tree tested on NPCM750 evaluation board.

Changes since version 5:
Address comments from Joel Stanely: https://lkml.org/lkml/2020/9/16/994
 
Changes since version 4:
 - Tested patches in Linux kernel 5.9.

Changes since version 3:
 - Tested patches in Linux kernel 5.6.

Changes since version 2:
 - Remove unnecessary output-enable flags.

Changes since version 1:
 - Add NPCM reset device node.
 - Add reset parameters to NPCM driver device nodes.

Tomer Maimon (3):
  arm: dts: modify NPCM7xx device tree clock parameter
  arm: dts: modify NPCM7xx device tree timer register size
  arm: dts: add new device nodes to NPCM750 device tree

 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 968 +++++++++++++++++-
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     | 404 +++++++-
 .../boot/dts/nuvoton-npcm750-pincfg-evb.dtsi  | 157 +++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  24 +-
 4 files changed, 1516 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi

-- 
2.22.0

