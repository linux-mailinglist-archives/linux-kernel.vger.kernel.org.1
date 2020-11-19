Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA332B9CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgKSVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:11:13 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45505 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgKSVLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:11:12 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0362C1BF206;
        Thu, 19 Nov 2020 21:11:08 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH v3 03/23] mtd: onenand: onenand_base: Fix expected kernel-doc formatting
Date:   Thu, 19 Nov 2020 22:11:07 +0100
Message-Id: <20201119211107.27287-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109182206.3037326-4-lee.jones@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 7abc17b3ab63d44a96e281617aff61e1424304d8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-09 at 18:21:46 UTC, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'mtd' not described in 'onenand_ooblayout_32_64_ecc'
>  drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'section' not described in 'onenand_ooblayout_32_64_ecc'
>  drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'oobregion' not described in 'onenand_ooblayout_32_64_ecc'
>  drivers/mtd/nand/onenand/onenand_base.c:200: warning: Function parameter or member 'addr' not described in 'onenand_readw'
>  drivers/mtd/nand/onenand/onenand_base.c:212: warning: Function parameter or member 'value' not described in 'onenand_writew'
>  drivers/mtd/nand/onenand/onenand_base.c:212: warning: Function parameter or member 'addr' not described in 'onenand_writew'
>  drivers/mtd/nand/onenand/onenand_base.c:225: warning: Function parameter or member 'this' not described in 'onenand_block_address'
>  drivers/mtd/nand/onenand/onenand_base.c:225: warning: Function parameter or member 'block' not described in 'onenand_block_address'
>  drivers/mtd/nand/onenand/onenand_base.c:242: warning: Function parameter or member 'this' not described in 'onenand_bufferram_address'
>  drivers/mtd/nand/onenand/onenand_base.c:242: warning: Function parameter or member 'block' not described in 'onenand_bufferram_address'
> 
>  NB: Snipped 200 lines for brevity.
> 
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
