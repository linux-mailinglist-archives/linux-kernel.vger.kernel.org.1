Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB92B9C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgKSVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:07:52 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46421 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKSVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:07:52 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2816EE0006;
        Thu, 19 Nov 2020 21:07:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jian Zhang <jzhang@ti.com>
Subject: Re: [PATCH v3 19/23] mtd: rawnand: omap2: Fix a bunch of kernel-doc misdemeanours
Date:   Thu, 19 Nov 2020 22:07:49 +0100
Message-Id: <20201119210749.25398-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-20-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: cd4c4f41a70354bc690c67b28e0688debd1aaaf1
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:22:02 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/omap2.c:191: warning: Function parameter or member 'info' not described in 'omap_prefetch_enable'
>  drivers/mtd/nand/raw/omap2.c:221: warning: Function parameter or member 'cs' not described in 'omap_prefetch_reset'
>  drivers/mtd/nand/raw/omap2.c:221: warning: Function parameter or member 'info' not described in 'omap_prefetch_reset'
>  drivers/mtd/nand/raw/omap2.c:946: warning: Function parameter or member 'chip' not described in 'omap_enable_hwecc'
>  drivers/mtd/nand/raw/omap2.c:946: warning: Excess function parameter 'mtd' description in 'omap_enable_hwecc'
>  drivers/mtd/nand/raw/omap2.c:1017: warning: Function parameter or member 'chip' not described in 'omap_dev_ready'
>  drivers/mtd/nand/raw/omap2.c:1017: warning: Excess function parameter 'mtd' description in 'omap_dev_ready'
>  drivers/mtd/nand/raw/omap2.c:1036: warning: Function parameter or member 'chip' not described in 'omap_enable_hwecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1036: warning: Excess function parameter 'mtd' description in 'omap_enable_hwecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1142: warning: Function parameter or member 'ecc_calc' not described in '_omap_calculate_ecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1142: warning: Excess function parameter 'ecc_code' description in '_omap_calculate_ecc_bch'
>  drivers/mtd/nand/raw/omap2.c:1270: warning: Function parameter or member 'ecc_calc' not described in 'omap_calculate_ecc_bch_sw'
>  drivers/mtd/nand/raw/omap2.c:1270: warning: Excess function parameter 'ecc_code' description in 'omap_calculate_ecc_bch_sw'
>  drivers/mtd/nand/raw/omap2.c:1284: warning: Function parameter or member 'ecc_calc' not described in 'omap_calculate_ecc_bch_multi'
>  drivers/mtd/nand/raw/omap2.c:1284: warning: Excess function parameter 'ecc_code' description in 'omap_calculate_ecc_bch_multi'
>  drivers/mtd/nand/raw/omap2.c:1681: warning: Function parameter or member 'info' not described in 'is_elm_present'
>  drivers/mtd/nand/raw/omap2.c:1681: warning: Function parameter or member 'elm_node' not described in 'is_elm_present'
>  drivers/mtd/nand/raw/omap2.c:1681: warning: Excess function parameter 'omap_nand_info' description in 'is_elm_present'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Jian Zhang <jzhang@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
