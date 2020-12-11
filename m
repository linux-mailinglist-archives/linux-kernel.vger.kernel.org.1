Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C795F2D7F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgLKTPG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Dec 2020 14:15:06 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44835 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbgLKTOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:14:41 -0500
X-Originating-IP: 109.220.208.103
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 111C220002;
        Fri, 11 Dec 2020 19:13:56 +0000 (UTC)
Date:   Fri, 11 Dec 2020 20:13:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.10 final
Message-ID: <20201211201356.62c54b3f@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the last fixes MTD PR for 5.10 final.

Thanks,
Miquèl

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.10-rc8

for you to fetch changes up to 33d974e76e21e9da8a36b14d2dce6394c36c3e30:

  mtd: rawnand: xway: Do not force a particular software ECC engine (2020-12-11 20:10:02 +0100)

----------------------------------------------------------------
Raw NAND:
* Second fixes series initiated because of a rework of the ECC engine
  subsystem. The location of the DT parsing logic got moved, breaking
  several drivers which in fact were not doing the ECC engine
  initialization at the right place. These drivers have been fixed by
  enforcing a particular ECC engine type and algorithm, software
  Hamming, while the algorithm may be overwritten by a DT
  property. This merge request fixes this in the xway, socrates,
  plat_nand, pasemi, orion, mpc5121, gpio, au1550 and ams-delta
  controller drivers.

----------------------------------------------------------------
Miquel Raynal (9):
      mtd: rawnand: ams-delta: Do not force a particular software ECC engine
      mtd: rawnand: au1550: Do not force a particular software ECC engine
      mtd: rawnand: gpio: Do not force a particular software ECC engine
      mtd: rawnand: mpc5121: Do not force a particular software ECC engine
      mtd: rawnand: orion: Do not force a particular software ECC engine
      mtd: rawnand: pasemi: Do not force a particular software ECC engine
      mtd: rawnand: plat_nand: Do not force a particular software ECC engine
      mtd: rawnand: socrates: Do not force a particular software ECC engine
      mtd: rawnand: xway: Do not force a particular software ECC engine

 drivers/mtd/nand/raw/ams-delta.c     | 4 +++-
 drivers/mtd/nand/raw/au1550nd.c      | 4 +++-
 drivers/mtd/nand/raw/gpio.c          | 4 +++-
 drivers/mtd/nand/raw/mpc5121_nfc.c   | 4 +++-
 drivers/mtd/nand/raw/orion_nand.c    | 4 +++-
 drivers/mtd/nand/raw/pasemi_nand.c   | 4 +++-
 drivers/mtd/nand/raw/plat_nand.c     | 4 +++-
 drivers/mtd/nand/raw/socrates_nand.c | 4 +++-
 drivers/mtd/nand/raw/xway_nand.c     | 4 +++-
 9 files changed, 27 insertions(+), 9 deletions(-)
