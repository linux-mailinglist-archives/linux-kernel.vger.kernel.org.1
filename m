Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862841CE579
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgEKU2Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 May 2020 16:28:25 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40437 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKU2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:28:24 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4084D200002;
        Mon, 11 May 2020 20:28:19 +0000 (UTC)
Date:   Mon, 11 May 2020 22:28:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v4 10/10] mtd: rawnand: stm32_fmc2: get resources from
 parent node
Message-ID: <20200511222817.003f5aff@xps13>
In-Reply-To: <f09690bf-f985-d60d-7805-6dad00b19b66@st.com>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
        <1588756279-17289-11-git-send-email-christophe.kerello@st.com>
        <20200511111855.48216940@xps13>
        <3377adc6-3e5e-b9b7-12be-c7aa44bfac82@st.com>
        <20200511135926.3e5c622d@xps13>
        <0c704fea-f2a6-2cec-8741-d322acf6afd5@st.com>
        <20200511145855.35c6abfb@xps13>
        <6f822f79-18f1-5308-16cc-b31f0be80d5a@st.com>
        <20200511164524.3f94ba31@xps13>
        <f09690bf-f985-d60d-7805-6dad00b19b66@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Mon, 11 May
2020 19:02:51 +0200:

> Hi Miquel,
> 
> On 5/11/20 4:45 PM, Miquel Raynal wrote:
> > Hi Christophe,
> > 
> > Christophe Kerello <christophe.kerello@st.com> wrote on Mon, 11 May
> > 2020 16:19:47 +0200:
> >   
> >> Hi Miquel,
> >>
> >> On 5/11/20 2:58 PM, Miquel Raynal wrote:  
> >>> Hi Christophe,
> >>>
> >>> Christophe Kerello <christophe.kerello@st.com> wrote on Mon, 11 May
> >>> 2020 14:47:09 +0200:  
> >>>    >>>> Hi Miquel,  
> >>>>
> >>>> On 5/11/20 1:59 PM, Miquel Raynal wrote:  
> >>>>> Hi Christophe,
> >>>>>
> >>>>> Christophe Kerello <christophe.kerello@st.com> wrote on Mon, 11 May
> >>>>> 2020 12:21:03 +0200:  
> >>>>>     >>>> Hi Miquel,  
> >>>>>>
> >>>>>> On 5/11/20 11:18 AM, Miquel Raynal wrote:  
> >>>>>>> Hi Christophe,
> >>>>>>>
> >>>>>>> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
> >>>>>>> 11:11:19 +0200:  
> >>>>>>>      >>>> FMC2 EBI support has been added. Common resources (registers base  
> >>>>>>>> and clock) are now shared between the 2 drivers. It means that the
> >>>>>>>> common resources should now be found in the parent device when EBI
> >>>>>>>> node is available.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >>>>>>>> ---  
> >>>>>>>
> >>>>>>> [...]  
> >>>>>>>      >>>> +  
> >>>>>>>> +static bool stm32_fmc2_nfc_check_for_parent(struct platform_device *pdev)
> >>>>>>>> +{
> >>>>>>>> +	u32 i;
> >>>>>>>> +	int nb_resources = 0;
> >>>>>>>> +
> >>>>>>>> +	/* Count the number of resources in reg property */
> >>>>>>>> +	for (i = 0; i < pdev->num_resources; i++) {
> >>>>>>>> +		struct resource *res = &pdev->resource[i];
> >>>>>>>> +
> >>>>>>>> +		if (resource_type(res) == IORESOURCE_MEM)
> >>>>>>>> +			nb_resources++;
> >>>>>>>> +	}
> >>>>>>>> +
> >>>>>>>> +	/* Each CS needs 3 resources defined (data, cmd and addr) */
> >>>>>>>> +	if (nb_resources % 3)
> >>>>>>>> +		return false;
> >>>>>>>> +
> >>>>>>>> +	return true;
> >>>>>>>> +}  
> >>>>>>>
> >>>>>>> This function looks fragile. Why not just checking the compatible
> >>>>>>> string of the parent node?  
> >>>>>>>      >>  
> >>>>>> Yes, it is another way to check that we have an EBI parent node.
> >>>>>>
> >>>>>> In this implementation, I was checking the number of reg tuples.
> >>>>>> In case we have 6, it means that the register base address is defined in the parent node (EBI node).
> >>>>>> In case we have 7, it means that the register base address is defined in the current node (NFC node).  
> >>>>>
> >>>>> Yes, I understand what you are doing, but I kind of dislike the logic.
> >>>>> Relying on the number of reg tuples is something that can be done (I
> >>>>> used it myself one time), but I think this is more a hack that you do
> >>>>> when you have no other way to differentiate. I guess the proper way
> >>>>> would be to look at the parent's compatible. If it matches what you
> >>>>> expect, then you can store the dev->of_node->parent->dev somewhere in
> >>>>> your controller's structure and then use it to initialize the clock and
> >>>>> regmap. This way you don't have to move anything else in the probe path.  
> >>>>>     >>  
> >>>> OK, I will check the compatible string of the parent device using of_device_is_compatible API in v5.
> >>>> In case of the parent is found, I will add it in the structure of the controller (dev_parent).
> >>>> I will rely on this field only to get the common resources (the register base address and the clock) in the NFC node or in the EBI node.  
> >>>
> >>> I had something slightly different in mind: what about setting a
> >>> default value to this field as being the controller's device itself.
> >>> This way, once it is set to either the parent device or the device
> >>> itself, you can use it "blindly" in your devm_clk_get/regmap_init calls?  
> >>>    >>  
> >> I will try to explain what I have in mind.
> >>
> >> I will add a new field in the structure of the controller (not called dev_parent but cdev)
> >> struct device *cdev;
> >>
> >> Then, at probe time, this field will be assigned:
> >> nfc->cdev = of_device_is_compatible(dev->parent->of_node, "bla bla") : dev->parent ? dev;  
> > 
> > That's what I had in mind. Maybe you'll have to use
> > dev->of_node->parent though, I think they are not equivalent.
> >   
> >>
> >> For the clock, it will be
> >> nfc->clk = devm_clk_get(nfc->cdev, NULL);
> >>
> >> For the register base, I need to replace:
> >> res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> mmio = devm_ioremap_resource(dev, res);
> >> if (IS_ERR(mmio))
> >> 	return PTR_ERR(mmio);
> >>
> >> nfc->regmap = devm_regmap_init_mmio(dev, mmio, &stm32_fmc2_regmap_cfg);
> >> if (IS_ERR(nfc->regmap))
> >> 	return PTR_ERR(nfc->regmap);
> >>
> >> nfc->io_phys_addr = res->start;
> >>
> >> With:
> >>
> >> ret = of_address_to_resource(nfc->cdev->of_node, 0, &res);
> >> if (ret)
> >> 	return ret;
> >>
> >> nfc->io_phys_addr = res.start;
> >>
> >> nfc->regmap = device_node_to_regmap(nfc->cdev->of_node);
> >> if (IS_ERR(nfc->regmap))
> >> 	return PTR_ERR(nfc->regmap);
> >>
> >> I expect that you were thinking about something like this proposal.  
> > 
> > This means the regmap has already been initialized, can you make sure
> > it is actually the case? What if the probe of the EBI block happens
> > next, or is deferred? (maybe you'll get a -EPROBE_DEFER, which is fine
> > then). Please try booting with the EBI node but without the EBI driver
> > and see if this is handled gracefully.
> >   
> 
> In case we have an EBI node, the NFC node will be a child node of the EBI node.
> The EBI driver will first be probed, getting all its resources and then it will populate all its children node (including the NFC node if this one is enabled). If the EBI driver is deferred because of getting one of its resources has failed, none of its children will be probed. They will be probed later when the EBI driver will succeed to get all its resources and will then populate all of its children.
> 

Ok, I just reviewed it more in depth and I get it now, should be fine.

> In case we have the EBI node without its driver, none of its children will be populated, so the NFC node will not be probed.
> 
> Here is an exemple of the bindings proposal:
>      fmc: memory-controller@58002000 {
>        #address-cells = <2>;
>        #size-cells = <1>;
>        compatible = "st,stm32mp1-fmc2-ebi";
>        reg = <0x58002000 0x1000>;
>        clocks = <&rcc FMC_K>;
>        resets = <&rcc FMC_R>;
> 
>        ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
>                 <1 0 0x64000000 0x04000000>, /* EBI CS 2 */
>                 <2 0 0x68000000 0x04000000>, /* EBI CS 3 */
>                 <3 0 0x6c000000 0x04000000>, /* EBI CS 4 */
>                 <4 0 0x80000000 0x10000000>; /* NAND */
> 
>        psram@0,0 {
>          compatible = "mtd-ram";
>          reg = <0 0x00000000 0x100000>;
>          bank-width = <2>;
> 
>          st,fmc2-ebi-cs-transaction-type = <1>;
>          st,fmc2-ebi-cs-address-setup-ns = <60>;
>          st,fmc2-ebi-cs-data-setup-ns = <30>;
>          st,fmc2-ebi-cs-bus-turnaround-ns = <5>;
>        };
> 
>        nand-controller@4,0 {
>          #address-cells = <1>;
>          #size-cells = <0>;
>          compatible = "st,stm32mp15-fmc2";
>          reg = <4 0x00000000 0x1000>,
>                <4 0x08010000 0x1000>,
>                <4 0x08020000 0x1000>,
>                <4 0x01000000 0x1000>,
>                <4 0x09010000 0x1000>,
>                <4 0x09020000 0x1000>;
>          interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>          dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
>                 <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
>                 <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
>          dma-names = "tx", "rx", "ecc";
> 
>          nand@0 {
>            reg = <0>;
>            nand-on-flash-bbt;
>            #address-cells = <1>;
>            #size-cells = <1>;
>          };
>        };
>      };
> 
> Regards,
> Christophe Kerello.

Thanks,
Miquèl
