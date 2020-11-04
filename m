Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C679A2A6BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgKDRjF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Nov 2020 12:39:05 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:56221 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgKDRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:39:05 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 99DDE200008;
        Wed,  4 Nov 2020 17:39:00 +0000 (UTC)
Date:   Wed, 4 Nov 2020 18:38:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Kernel 5.10-rc1 not mounting NAND flash (Bisected to
 d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing
 bits"))
Message-ID: <20201104183859.590f0806@xps13>
In-Reply-To: <20201104183353.Horde.FyqZycHkfr5KHDjPaOEBpQ7@messagerie.c-s.fr>
References: <20201104183353.Horde.FyqZycHkfr5KHDjPaOEBpQ7@messagerie.c-s.fr>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Leroy <christophe.leroy@csgroup.eu> wrote on Wed, 04 Nov
2020 18:33:53 +0100:

> Hi Miquel,
> 
> I'm unable to boot 5.10-rc1 on my boards. I get the following error:
> 
> [    4.125811] nand: device found, Manufacturer ID: 0xad, Chip ID: 0x76
> [    4.131992] nand: Hynix NAND 64MiB 3,3V 8-bit
> [    4.136173] nand: 64 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
> [    4.143534] ------------[ cut here ]------------
> [    4.147934] Unsupported ECC algorithm!
> [    4.152142] WARNING: CPU: 0 PID: 1 at drivers/mtd/nand/raw/nand_base.c:5244 nand_scan_with_ids+0x1260/0x1640
> ...
> [    4.332052] ---[ end trace e3a36f62cae4ac56 ]---
> [    4.336882] gpio-nand: probe of c0000000.nand failed with error -22
> 
> Bisected to commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing bits")
> 
> My first impression is that with that change, the value set in chip->ecc.algo
> by gpio_nand_probe() in drivers/mtd/nand/raw/gpio.c gets overwritten in rawnand_dt_init()
> 
> The following change fixes the problem, though I'm not sure it is the right fix. Can you have a look ?
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 1f0d542d5923..aa74797cf2da 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5032,7 +5032,8 @@ static int rawnand_dt_init(struct nand_chip *chip)
>   		chip->ecc.engine_type = nand->ecc.defaults.engine_type;
> 
>   	chip->ecc.placement = nand->ecc.user_conf.placement;
> -	chip->ecc.algo = nand->ecc.user_conf.algo;
> +	if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
> +		chip->ecc.algo = nand->ecc.user_conf.algo;
>   	chip->ecc.strength = nand->ecc.user_conf.strength;
>   	chip->ecc.size = nand->ecc.user_conf.step_size;
> 
> ---
> 
> Thanks
> Christophe

Sorry for introducing this issue, I didn't had the time to send the
Fixes PR yet but I think this issue has been solved already. Could
you please try with a recent linux-next?

Thanks,
Miquèl
