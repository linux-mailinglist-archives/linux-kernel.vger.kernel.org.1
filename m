Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE462177B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGGTPf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Jul 2020 15:15:35 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51679 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:15:35 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D29FA20006;
        Tue,  7 Jul 2020 19:15:32 +0000 (UTC)
Date:   Tue, 7 Jul 2020 21:15:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.8-rc5
Message-ID: <20200707211531.7f762650@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for the next -rc.

Thanks,
Miquèl


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.8-rc5

for you to fetch changes up to 880bc529bae2257d05a767f7f5c24fd61a47b605:

  mtd: rawnand: xway: Fix build issue (2020-07-07 21:04:38 +0200)

----------------------------------------------------------------
MTD:
* Set a missing master partition panic write flag.

Raw NAND:
* Fix build issue in the xway driver.
* Fix a wrong return code.

----------------------------------------------------------------
Kamal Dasu (1):
      mtd: set master partition panic write flag

Miquel Raynal (1):
      mtd: rawnand: xway: Fix build issue

Richard Weinberger (1):
      nandsim: Fix return code testing of ns_find_operation()

 drivers/mtd/mtdcore.c            | 4 ++--
 drivers/mtd/nand/raw/nandsim.c   | 2 +-
 drivers/mtd/nand/raw/xway_nand.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
