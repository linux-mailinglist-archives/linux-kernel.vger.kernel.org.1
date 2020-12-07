Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A051D2D0EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLGLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:16:43 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:40647 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgLGLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:16:43 -0500
Received: from localhost.localdomain (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BDDB7200010;
        Mon,  7 Dec 2020 11:15:59 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kernel test robot <lkp@intel.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Subject: Re: [PATCH v2] mtd: physmap: physmap-bt1-rom: Fix __iomem addrspace removal warning
Date:   Mon,  7 Dec 2020 12:15:58 +0100
Message-Id: <20201207111558.9012-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201125072640.23516-1-Sergey.Semin@baikalelectronics.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 18b9c9403758ff68d93ee2f593096778d58e6f76
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-25 at 07:26:40 UTC, Serge Semin wrote:
> sparse is unhappy with us casting the __iomem address space pointer to
> a type with no address space attribute specified:
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast removes address space '__iomem' of expression
> 
> Indeed we perform the __iomem-less type casting but to an integer
> variable. The integer variable isn't dereferenced then, so the casting is
> safe and won't cause any problem. But in order to make sparse happy and
> keep the code coherent let's fix the warning by converting the local
> "shift" and "chunk" variables to the "unsigned int" type (since their
> value won't ever exceed three) and cast the __iomem-pointers to uintptr_t.
> Add the same fix to the bt1_rom_map_read() method for unification.
> 
> Fixes: b3e79e7682e0 ("mtd: physmap: Add Baikal-T1 physically mapped ROM support")
> Link: https://lore.kernel.org/lkml/202011021254.XC70BaQT-lkp@intel.com/
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
