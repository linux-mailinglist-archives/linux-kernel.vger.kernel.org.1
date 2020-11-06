Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BAD2A9E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgKFTnR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Nov 2020 14:43:17 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56719 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgKFTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:43:17 -0500
X-Originating-IP: 109.220.208.103
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C3A3C20003;
        Fri,  6 Nov 2020 19:43:12 +0000 (UTC)
Date:   Fri, 6 Nov 2020 20:43:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.10-rc3
Message-ID: <20201106204311.795d6016@xps13>
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

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes

for you to fetch changes up to 9efac6ce7f621c405d49a091e3e367be4250a27a:

  mtd: rawnand: stm32_fmc2: fix broken ECC (2020-10-30 18:24:51 +0100)

----------------------------------------------------------------
Alexander Sverdlin (1):
      mtd: spi-nor: Don't copy self-pointing struct around

Bert Vermeulen (1):
      mtd: spi-nor: Fix address width on flash chips > 16MB

Christophe Kerello (1):
      mtd: rawnand: stm32_fmc2: fix broken ECC

Fabio Estevam (2):
      mtd: rawnand: mxc: Move the ECC engine initialization to the right place
      mtd: rawnand: ifc: Move the ECC engine initialization to the right place

 drivers/mtd/nand/raw/fsl_ifc_nand.c    | 43 +++++++++++++++++++++++------------------
 drivers/mtd/nand/raw/mxc_nand.c        | 17 +++++-----------
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 15 +++++++-------
 drivers/mtd/spi-nor/core.c             | 13 +++++++------
 4 files changed, 44 insertions(+), 44 deletions(-)
