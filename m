Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294A92A2AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgKBMdH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 07:33:07 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:55581 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgKBMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:33:07 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A125E240008;
        Mon,  2 Nov 2020 12:33:03 +0000 (UTC)
Date:   Mon, 2 Nov 2020 13:33:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <ext-adrian.hunter@nokia.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 03/23] mtd: nand: onenand: onenand_base: Fix expected
 kernel-doc formatting
Message-ID: <20201102133302.788e42ac@xps13>
In-Reply-To: <20201102115406.1074327-4-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
        <20201102115406.1074327-4-lee.jones@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Mon,  2 Nov 2020 11:53:46
+0000:

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
> ---
>  drivers/mtd/nand/onenand/onenand_base.c | 438 ++++++++++++------------
>  1 file changed, 219 insertions(+), 219 deletions(-)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 188b8061e1f79..35f851bf90a3c 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -192,7 +192,7 @@ static const unsigned char ffchars[] = {
>  

[...]

>  /**
>   * onenand_buffer_address - [DEFAULT] Get buffer address
> - * @param dataram1	DataRAM index
> - * @param sectors	the sector address
> - * @param count		the number of sectors
> + * @dataram:1	DataRAM index

Seems that the one is on the wrong side of the colon?

> + * @sectors:	the sector address
> + * @count:		the number of sectors
>   * @return		the start buffer value
>   *
>   * Setup Start Buffer Register (F200h)

The rest lgtm.

Thanks,
Miquèl
