Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6442B9C96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKSVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:07:06 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37573 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgKSVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:07:06 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6AB42E0006;
        Thu, 19 Nov 2020 21:07:02 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Subject: Re: [PATCH] mtd: physmap: physmap-bt1-rom: Fix __iomem addrspace removal warning
Date:   Thu, 19 Nov 2020 22:07:01 +0100
Message-Id: <20201119210701.24856-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201112180037.6754-1-Sergey.Semin@baikalelectronics.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 0bf23a17d54fb09bea4dd3ecaee6c2d81d7dd965
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-12 at 18:00:37 UTC, Serge Semin wrote:
> sparse is unhappy with us casting the __iomem address space pointer to
> a type with no address space attribute specified:
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast removes address space '__iomem' of expression
> 
> Indeed we perform the __iomem-less type casting but to an integer
> variable. The integer variable isn't dereferenced then, so the casting is
> safe and won't cause any problem. But in order to make sparse happy let's
> fix the warning just by converting the local "shift" and "chunk" variables
> to the "unsigned int" type. Add the same fix to the bt1_rom_map_read()
> method for unification.
> 
> Fixes: b3e79e7682e0 ("mtd: physmap: Add Baikal-T1 physically mapped ROM support")
> Link: https://lore.kernel.org/lkml/202011021254.XC70BaQT-lkp@intel.com/
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
