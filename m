Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB012D69FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394095AbgLJVen convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 16:34:43 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45261 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394086AbgLJVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:34:24 -0500
X-Originating-IP: 109.220.208.103
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6D735240002;
        Thu, 10 Dec 2020 21:33:34 +0000 (UTC)
Date:   Thu, 10 Dec 2020 22:33:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>
Cc:     vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: nand: ecc-bch: Fix the size of
 calc_buf/code_buf of the BCH
Message-ID: <20201210223333.204062b1@xps13>
In-Reply-To: <1607570529-22341-2-git-send-email-ycllin@mxic.com.tw>
References: <1607570529-22341-1-git-send-email-ycllin@mxic.com.tw>
        <1607570529-22341-2-git-send-email-ycllin@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YouChing,

YouChing Lin <ycllin@mxic.com.tw> wrote on Thu, 10 Dec 2020 11:22:08
+0800:

> If eccbyte exceeds 64 bytes, the read operation will get wrong results.
> For example: Flash with a page size of 4096 bytes (eccbyte: 104 bytes).
> During the read operation, after executing nand_ecc_sw_bch_calculate(),
> since the calc_buf/code_buf ranges overlap each other, the last three
> steps of ecc_code (read from oob) will be changed.
> 
> The root cause is that the size of calc_buf/code_buf is limited to 64
> bytes, although sizeof(mtd->oobsize) returns 4, kzalloc() will allocate
> 64 bytes (cache size alignment).
> 
> So we correct the size of calc_buf/code_buf to mtd->oobsize.
> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
> ---
>  drivers/mtd/nand/ecc-sw-bch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ecc-sw-bch.c b/drivers/mtd/nand/ecc-sw-bch.c
> index 4d8a979..0a0ac11 100644
> --- a/drivers/mtd/nand/ecc-sw-bch.c
> +++ b/drivers/mtd/nand/ecc-sw-bch.c
> @@ -237,8 +237,8 @@ int nand_ecc_sw_bch_init_ctx(struct nand_device *nand)
>  
>  	engine_conf->code_size = code_size;
>  	engine_conf->nsteps = nsteps;
> -	engine_conf->calc_buf = kzalloc(sizeof(mtd->oobsize), GFP_KERNEL);
> -	engine_conf->code_buf = kzalloc(sizeof(mtd->oobsize), GFP_KERNEL);
> +	engine_conf->calc_buf = kzalloc(mtd->oobsize, GFP_KERNEL);
> +	engine_conf->code_buf = kzalloc(mtd->oobsize, GFP_KERNEL);

Very nice catch! If you don't mind I will merge this fix with the
faulty commit (still in next) and I will also bring the fix to Hamming
which will suffer from the same error.

Then I will apply the second patch.

>  	if (!engine_conf->calc_buf || !engine_conf->code_buf) {
>  		ret = -ENOMEM;
>  		goto free_bufs;

Thanks,
Miquèl
