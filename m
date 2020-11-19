Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932582B9C98
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgKSVHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:07:31 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:47885 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKSVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:07:30 -0500
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id DA763200002;
        Thu, 19 Nov 2020 21:07:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 22/23] mtd: onenand: Fix some kernel-doc misdemeanours
Date:   Thu, 19 Nov 2020 22:07:26 +0100
Message-Id: <20201119210726.25150-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-23-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 59d61489c4450eb8782f1eca93833f4b18ead69f
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:22:05 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'mtd' not described in 'onenand_ooblayout_32_64_ecc'
>  drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'section' not described in 'onenand_ooblayout_32_64_ecc'
>  drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'oobregion' not described in 'onenand_ooblayout_32_64_ecc'
>  drivers/mtd/nand/onenand/onenand_base.c:1436: warning: bad line:
>  drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Function parameter or member 'ops' not described in 'onenand_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'len' description in 'onenand_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'retlen' description in 'onenand_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'buf' description in 'onenand_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'mode' description in 'onenand_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:2156: warning: Function parameter or member 'block_size' not described in 'onenand_multiblock_erase'
>  drivers/mtd/nand/onenand/onenand_base.c:2156: warning: Excess function parameter 'region' description in 'onenand_multiblock_erase'
>  drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Function parameter or member 'ops' not described in 'onenand_otp_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Excess function parameter 'len' description in 'onenand_otp_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Excess function parameter 'retlen' description in 'onenand_otp_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Excess function parameter 'buf' description in 'onenand_otp_write_oob_nolock'
>  drivers/mtd/nand/onenand/onenand_base.c:3387: warning: Function parameter or member 'mtd' not described in 'flexonenand_get_boundary'
>  drivers/mtd/nand/onenand/onenand_base.c:3387: warning: Excess function parameter 'onenand_info' description in 'flexonenand_get_boundary'
>  drivers/mtd/nand/onenand/onenand_base.c:3509: warning: Function parameter or member 'mtd' not described in 'flexonenand_check_blocks_erased'
>  drivers/mtd/nand/onenand/onenand_base.c:3509: warning: Excess function parameter 'mtd_info' description in 'flexonenand_check_blocks_erased'
>  drivers/mtd/nand/onenand/onenand_base.c:3557: warning: Function parameter or member 'die' not described in 'flexonenand_set_boundary'
>  drivers/mtd/nand/onenand/onenand_base.c:3557: warning: Function parameter or member 'boundary' not described in 'flexonenand_set_boundary'
>  drivers/mtd/nand/onenand/onenand_base.c:3557: warning: Function parameter or member 'lock' not described in 'flexonenand_set_boundary'
> 
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
