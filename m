Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4315A3017F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbhAWTA3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 23 Jan 2021 14:00:29 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42909 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 14:00:29 -0500
X-Originating-IP: 86.201.233.230
Received: from xps13 (lfbn-tou-1-151-230.w86-201.abo.wanadoo.fr [86.201.233.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0D4B640002;
        Sat, 23 Jan 2021 18:59:41 +0000 (UTC)
Date:   Sat, 23 Jan 2021 19:59:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.11-rc5
Message-ID: <20210123195940.2c76e738@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is a fixes MTD PR for the next -rc.

Thanks,
Miquèl


The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes

for you to fetch changes up to b135b3358d73aa2a8b2be35d08e422421d1c609e:

  mtd: rawnand: omap: Use BCH private fields in the specific OOB layout (2021-01-20 23:38:00 +0100)

----------------------------------------------------------------
Martin Blumenstingl (1):
      mtd: rawnand: intel: check the mtd name only after setting the variable

Miquel Raynal (3):
      mtd: rawnand: nandsim: Fix the logic when selecting Hamming soft ECC engine
      mtd: spinand: Fix MTD_OPS_AUTO_OOB requests
      mtd: rawnand: omap: Use BCH private fields in the specific OOB layout

Sean Nyekjaer (1):
      mtd: rawnand: gpmi: fix dst bit offset when extracting raw payload

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c   |  2 +-
 drivers/mtd/nand/raw/intel-nand-controller.c |  5 +++--
 drivers/mtd/nand/raw/nandsim.c               |  7 +++----
 drivers/mtd/nand/raw/omap2.c                 | 15 +++++++++------
 drivers/mtd/nand/spi/core.c                  | 14 +++++++++++---
 5 files changed, 27 insertions(+), 16 deletions(-)
