Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AFC2A7846
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgKEHto convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Nov 2020 02:49:44 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49177 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKEHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:49:44 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9B8ADC0005;
        Thu,  5 Nov 2020 07:49:40 +0000 (UTC)
Date:   Thu, 5 Nov 2020 08:49:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Kernel 5.10-rc1 not mounting NAND flash (Bisected to
 d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing
 bits"))
Message-ID: <20201105084939.72ea6bfd@xps13>
In-Reply-To: <a04de8a0-4e3b-d9c6-139e-c25d9d5423d1@csgroup.eu>
References: <20201104183353.Horde.FyqZycHkfr5KHDjPaOEBpQ7@messagerie.c-s.fr>
        <20201104183859.590f0806@xps13>
        <a04de8a0-4e3b-d9c6-139e-c25d9d5423d1@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Leroy <christophe.leroy@csgroup.eu> wrote on Wed, 4 Nov 2020
19:37:57 +0100:

> Hi Miquel,
> 
> Le 04/11/2020 à 18:38, Miquel Raynal a écrit :
> > Hi Christophe,
> > 
> > Christophe Leroy <christophe.leroy@csgroup.eu> wrote on Wed, 04 Nov
> > 2020 18:33:53 +0100:
> >   
> >> Hi Miquel,
> >>
> >> I'm unable to boot 5.10-rc1 on my boards. I get the following error:
> >>
> >> [    4.125811] nand: device found, Manufacturer ID: 0xad, Chip ID: 0x76
> >> [    4.131992] nand: Hynix NAND 64MiB 3,3V 8-bit
> >> [    4.136173] nand: 64 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
> >> [    4.143534] ------------[ cut here ]------------
> >> [    4.147934] Unsupported ECC algorithm!
> >> [    4.152142] WARNING: CPU: 0 PID: 1 at drivers/mtd/nand/raw/nand_base.c:5244 nand_scan_with_ids+0x1260/0x1640
> >> ...
> >> [    4.332052] ---[ end trace e3a36f62cae4ac56 ]---
> >> [    4.336882] gpio-nand: probe of c0000000.nand failed with error -22
> >>
> >> Bisected to commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing bits")
> >>
> >> My first impression is that with that change, the value set in chip->ecc.algo
> >> by gpio_nand_probe() in drivers/mtd/nand/raw/gpio.c gets overwritten in rawnand_dt_init()
> >>
> >> The following change fixes the problem, though I'm not sure it is the right fix. Can you have a look ?
> >>
> >> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> >> index 1f0d542d5923..aa74797cf2da 100644
> >> --- a/drivers/mtd/nand/raw/nand_base.c
> >> +++ b/drivers/mtd/nand/raw/nand_base.c
> >> @@ -5032,7 +5032,8 @@ static int rawnand_dt_init(struct nand_chip *chip)
> >>    		chip->ecc.engine_type = nand->ecc.defaults.engine_type;
> >>
> >>    	chip->ecc.placement = nand->ecc.user_conf.placement;
> >> -	chip->ecc.algo = nand->ecc.user_conf.algo;
> >> +	if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
> >> +		chip->ecc.algo = nand->ecc.user_conf.algo;
> >>    	chip->ecc.strength = nand->ecc.user_conf.strength;
> >>    	chip->ecc.size = nand->ecc.user_conf.step_size;
> >>
> >> ---
> >>
> >> Thanks
> >> Christophe  
> > 
> > Sorry for introducing this issue, I didn't had the time to send the
> > Fixes PR yet but I think this issue has been solved already. Could
> > you please try with a recent linux-next?
> >   
> 
> Sorry, same problem with "Linux version 5.10.0-rc2-next-20201104"

Can you please give this patch a try, please?

---8<---

Author: Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Thu Nov 5 08:44:48 2020 +0100

    mtd: rawnand: gpio: Move the ECC initialization to ->attach_chip()
    
    While forcing a Hamming software ECC looks clearly wrong, let's just
    fix the situation for now and move these lines to the ->attach_chip()
    hook which gets executed after the user input parsing and NAND chip
    discovery.
    
    Fixes: d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing bits")
    Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 3bd847ccc3f3..6feab847f5e0 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -161,8 +161,15 @@ static int gpio_nand_exec_op(struct nand_chip *chip,
        return ret;
 }
 
+static int gpio_nand_attach_chip(struct nand_chip *chip)
+{
+       chip->ecc.mode = NAND_ECC_SOFT;
+       chip->ecc.algo = NAND_ECC_HAMMING;
+}
+
 static const struct nand_controller_ops gpio_nand_ops = {
        .exec_op = gpio_nand_exec_op,
+       .attach_chip = gpio_nand_attach_chip,
 };
 
 #ifdef CONFIG_OF
@@ -342,8 +349,6 @@ static int gpio_nand_probe(struct platform_device *pdev)
        gpiomtd->base.ops = &gpio_nand_ops;
 
        nand_set_flash_node(chip, pdev->dev.of_node);
-       chip->ecc.mode          = NAND_ECC_SOFT;
-       chip->ecc.algo          = NAND_ECC_HAMMING;
        chip->options           = gpiomtd->plat.options;
        chip->controller        = &gpiomtd->base;
 
