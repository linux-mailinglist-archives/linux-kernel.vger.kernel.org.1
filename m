Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD72A0026
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJ3Ig0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 04:36:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35259 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3Ig0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:36:26 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 071C21C0005;
        Fri, 30 Oct 2020 08:36:22 +0000 (UTC)
Date:   Fri, 30 Oct 2020 09:36:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: fix broken ECC
Message-ID: <20201030093621.6315ea1a@xps13>
In-Reply-To: <d3073938-e714-6b5d-1dc9-36887b11de46@st.com>
References: <1603989492-6670-1-git-send-email-christophe.kerello@st.com>
        <20201030091905.111aa7a4@xps13>
        <d3073938-e714-6b5d-1dc9-36887b11de46@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 30 Oct
2020 09:31:25 +0100:

> Hi Miquel,
> 
> On 10/30/20 9:19 AM, Miquel Raynal wrote:
> > Hi Christophe,
> > 
> > Christophe Kerello <christophe.kerello@st.com> wrote on Thu, 29 Oct
> > 2020 17:38:12 +0100:
> >   
> >> Since commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user
> >> input parsing bits"), ECC are broken in FMC2 driver in case of
> >> nand-ecc-step-size and nand-ecc-strength are not set in the device tree.
> >> The default user configuration set in FMC2 driver is lost when
> >> rawnand_dt_init function is called. To avoid to lose the default user
> >> configuration, it is needed to move it in the new user_conf structure.
> >>
> >> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >> Fixes: d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing bits")
> >> ---
> >>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 +++++---
> >>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >> index b31a581..dc86ac9 100644
> >> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >> @@ -1846,6 +1846,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
> >>   	struct resource *res;
> >>   	struct mtd_info *mtd;
> >>   	struct nand_chip *chip;
> >> +	struct nand_device *nanddev;
> >>   	struct resource cres;
> >>   	int chip_cs, mem_region, ret, irq;
> >>   	int start_region = 0;
> >> @@ -1952,10 +1953,11 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
> >>   	chip->options |= NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE |
> >>   			 NAND_USES_DMA;  
> >>   >> -	/* Default ECC settings */  
> >> +	/* Default ECC user settings */
> >>   	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
> >> -	chip->ecc.size = FMC2_ECC_STEP_SIZE;
> >> -	chip->ecc.strength = FMC2_ECC_BCH8;
> >> +	nanddev = mtd_to_nanddev(mtd);
> >> +	nanddev->ecc.user_conf.step_size = FMC2_ECC_STEP_SIZE;
> >> +	nanddev->ecc.user_conf.strength = FMC2_ECC_BCH8;  
> >>   >>   	/* Scan to find existence of the device */  
> >>   	ret = nand_scan(chip, nand->ncs);  
> > 
> > Sorry for breaking the driver with this change, but now I think we
> > should have all ECC related bits in ->attach() instead of ->probe().
> > The ->attach() hook is called during the nand_scan() operation and at
> > this point the chip's requirements/layout are known (not before). I
> > know that certain controllers don't really care about that, here your
> > simply hardcode these two fields and you don't need to know anything
> > about the chip's properties. But as a bid to harmonize all drivers with
> > the target of a generic ECC engine in mind, I think it's now time to
> > move these three lines (chip->ecc.* = ...) at the top of ->attach().
> > Also, these fields should have been populated by the core so perhaps
> > the best approach is to check if the user requirements are synced with
> > the controller's capabilities and error out otherwise?
> > 
> > We plan to send a fixes PR for -rc2, if the v2 arrives today I'll
> > integrate it.  
> 
> Ok. Issue is that the controller is initialized when stm32_fmc2_nfc_select_chip is called. This function will be called before the ->attach() hook, when the first command will be sent to the NAND device (reset command). So, moving the default ECC initialization
> needs probably more modifications in the driver.
> I will try to send a v2 today.

The ECC engine is not supposed to be used before nand_scan() and its
default state should be disabled. Maybe this driver needs an update
about that, but then -hopefully- it will be pretty straightforward.

No hurry though, if the fix is not ready we'll wait an additional week
(it will be in next as soon as it is ready anyway).

Thanks,
Miquèl
