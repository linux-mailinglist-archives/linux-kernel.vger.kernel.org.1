Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E12C6BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgK0SiK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Nov 2020 13:38:10 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47687 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgK0SiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:38:09 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 15E961BF206;
        Fri, 27 Nov 2020 18:38:04 +0000 (UTC)
Date:   Fri, 27 Nov 2020 19:38:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.10-rc6
Message-ID: <20201127193803.324e1f83@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is an MTD fixes PR for the next -rc.

Thanks,
Miquèl

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.10-rc6

for you to fetch changes up to b36bf0a0fe5d18561dd98eb774ef61dd396edc42:

  mtd: rawnand: socrates: Move the ECC initialization to ->attach_chip() (2020-11-20 12:31:26 +0100)

----------------------------------------------------------------
Raw NAND changes:
* Because of a recent change in the core, NAND controller drivers
  initializing the ECC engine too early in the probe path are
  broken. Drivers should wait for the NAND device to be discovered and
  its memory layout known before doing any ECC related initialization,
  so instead of reverting the faulty change which is actually moving
  in the right direction, let's fix the drivers directly: socrates,
  sharpsl, r852, plat_nand, pasemi, tmio, txx9ndfmc, orion, mpc5121,
  lpc32xx_slc, lpc32xx_mlc, fsmc, diskonchip, davinci, cs553x, au1550,
  ams-delta, xway and gpio.

----------------------------------------------------------------
Miquel Raynal (19):
      mtd: rawnand: gpio: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: xway: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: ams-delta: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: au1550: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: cs553x: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: davinci: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: diskonchip: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: fsmc: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: lpc32xx_mlc: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: lpc32xx_slc: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: mpc5121: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: orion: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: txx9ndfmc: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: tmio: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: pasemi: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: plat_nand: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: r852: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: sharpsl: Move the ECC initialization to ->attach_chip()
      mtd: rawnand: socrates: Move the ECC initialization to ->attach_chip()

 drivers/mtd/nand/raw/ams-delta.c     | 12 +++++++++---
 drivers/mtd/nand/raw/au1550nd.c      | 11 +++++++++--
 drivers/mtd/nand/raw/cs553x_nand.c   | 24 ++++++++++++++++--------
 drivers/mtd/nand/raw/davinci_nand.c  |  8 ++++----
 drivers/mtd/nand/raw/diskonchip.c    | 29 +++++++++++++++++++----------
 drivers/mtd/nand/raw/fsmc_nand.c     | 30 +++++++++++++++---------------
 drivers/mtd/nand/raw/gpio.c          | 11 +++++++++--
 drivers/mtd/nand/raw/lpc32xx_mlc.c   | 23 +++++++++++++----------
 drivers/mtd/nand/raw/lpc32xx_slc.c   | 26 ++++++++++++++------------
 drivers/mtd/nand/raw/mpc5121_nfc.c   | 19 +++++++++++++++++--
 drivers/mtd/nand/raw/orion_nand.c    | 19 +++++++++++++++++--
 drivers/mtd/nand/raw/pasemi_nand.c   | 19 +++++++++++++++++--
 drivers/mtd/nand/raw/plat_nand.c     | 20 +++++++++++++++++---
 drivers/mtd/nand/raw/r852.c          | 40 +++++++++++++++++++++++++++-------------
 drivers/mtd/nand/raw/r852.h          |  1 +
 drivers/mtd/nand/raw/sharpsl.c       | 32 ++++++++++++++++++++++++--------
 drivers/mtd/nand/raw/socrates_nand.c | 21 +++++++++++++++++----
 drivers/mtd/nand/raw/tmio_nand.c     | 33 ++++++++++++++++++++++++---------
 drivers/mtd/nand/raw/txx9ndfmc.c     | 14 +++++++++-----
 drivers/mtd/nand/raw/xway_nand.c     | 18 ++++++++++++++++--
 20 files changed, 294 insertions(+), 116 deletions(-)
