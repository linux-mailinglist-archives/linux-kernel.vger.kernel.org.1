Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1F1BD999
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgD2K1R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Apr 2020 06:27:17 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47875 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2K1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:27:15 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 91395C0002;
        Wed, 29 Apr 2020 10:27:11 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:27:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 06/12] mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS
 for timeouts
Message-ID: <20200429122710.291d54ff@xps13>
In-Reply-To: <cf4f4d00-7cfd-d0df-3004-9fd534e62bd0@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-7-git-send-email-christophe.kerello@st.com>
        <20200427202212.0235d987@xps13>
        <0e2c9a6a-aa21-7814-9af8-629de6568fab@st.com>
        <20200429113529.5ddc3ad9@xps13>
        <b6b31f36-8e8f-4042-2587-0dcad82aafc5@st.com>
        <20200429120632.7bce63e6@xps13>
        <cf4f4d00-7cfd-d0df-3004-9fd534e62bd0@st.com>
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

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 29 Apr
2020 12:13:18 +0200:

> On 4/29/20 12:06 PM, Miquel Raynal wrote:
> > Hi Christophe,
> > 
> > Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 29 Apr
> > 2020 11:41:44 +0200:
> >   
> >> On 4/29/20 11:35 AM, Miquel Raynal wrote:  
> >>> Hi Christophe,
> >>>
> >>> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 29 Apr
> >>> 2020 11:27:43 +0200:  
> >>>    >>>> Hi Miquèl,  
> >>>>
> >>>> On 4/27/20 8:22 PM, Miquel Raynal wrote:  
> >>>>> Hi Christophe,
> >>>>>
> >>>>> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
> >>>>> 2020 17:57:30 +0200:  
> >>>>>     >>>> This patch removes the constant FMC2_TIMEOUT_US.  
> >>>>>> FMC2_TIMEOUT_MS is set to 5 seconds and this constant is used
> >>>>>> each time that we need to wait (except when the timeout value
> >>>>>> is set by the framework)
> >>>>>>
> >>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >>>>>> ---
> >>>>>>     drivers/mtd/nand/raw/stm32_fmc2_nand.c | 11 +++++------
> >>>>>>     1 file changed, 5 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>>>>> index ab53314..f159c39 100644
> >>>>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>>>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>>>>> @@ -37,8 +37,7 @@
> >>>>>>     /* Max ECC buffer length */
> >>>>>>     #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)  
> >>>>>>     >> -#define FMC2_TIMEOUT_US			1000  
> >>>>>> -#define FMC2_TIMEOUT_MS			1000
> >>>>>> +#define FMC2_TIMEOUT_MS			5000  
> >>>>>>     >>   /* Timings */  
> >>>>>>     #define FMC2_THIZ			1
> >>>>>> @@ -525,9 +524,9 @@ static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
> >>>>>>     	u32 sr, heccr;
> >>>>>>     	int ret;  
> >>>>>>     >> -	ret = readl_relaxed_poll_timeout(fmc2->io_base + FMC2_SR,  
> >>>>>> -					 sr, sr & FMC2_SR_NWRF, 10,
> >>>>>> -					 FMC2_TIMEOUT_MS);
> >>>>>> +	ret = readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR,
> >>>>>> +						sr, sr & FMC2_SR_NWRF, 1,
> >>>>>> +						1000 * FMC2_TIMEOUT_MS);  
> >>>>>
> >>>>> Is the _atomic suffix needed here? If yes it would deserve a separate
> >>>>> patch with Fixes/Stable tags.  
> >>>>>     >>  
> >>>> I have currently not seen any issues. So, I will remove this modification as we will move to regmap_read_poll_timeout in patch 10.  
> >>>>   >>>>>>     	if (ret) {  
> >>>>>>     		dev_err(fmc2->dev, "ham timeout\n");
> >>>>>>     		return ret;
> >>>>>> @@ -1315,7 +1314,7 @@ static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
> >>>>>>     	/* Check if there is no pending requests to the NAND flash */
> >>>>>>     	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
> >>>>>>     					      sr & FMC2_SR_NWRF, 1,
> >>>>>> -					      FMC2_TIMEOUT_US))
> >>>>>> +					      1000 * FMC2_TIMEOUT_MS))
> >>>>>>     		dev_warn(fmc2->dev, "Waitrdy timeout\n");  
> >>>>>>     >>   	/* Wait tWB before R/B# signal is low */  
> >>>>>
> >>>>> You change the timeouts from 1ms to 5s.
> >>>>>
> >>>>> Maybe 5s is a little bit too much IMHO but we don't really care as this
> >>>>> is a timeout. However 1ms is tight. If you are changing this value
> >>>>> because it triggers error (eg. when the machine is loaded), then it is
> >>>>> a fix and should appear like it.
> >>>>>
> >>>>> Thanks,
> >>>>> Miquèl  
> >>>>>     >>  
> >>>> No errors currently happens.
> >>>> During our stress tests, in a overloaded system, we have seen that we could be close to 1 second, even if we never met this value.
> >>>> So, to be safe, I have set this timeout to 5 seconds.
> >>>> As it is just a timeout value, I have not seen any side effect.
> >>>> I am using the same timeout constant to avoid to have one timeout per cases.  
> >>>
> >>> Something is wrong in my mind:
> >>> You say you observe delays of almost up to 1 second, but the polling
> >>> currently happens on 1000 us = 1ms, either you had timeouts or I
> >>> misread something?
> >>>
> >>> Thanks,
> >>> Miquèl  
> >>>    >>  
> >> Hi Miquèl,
> >>
> >> My fault. For this polling, we never met 1 ms.
> >> The 1 second observed was on the sequencer when we read/write a page (as it the same timeout value that is used)  
> > 
> > OK I get it. So perhaps you can give these details in the commit log to
> > explain why you use 5 seconds instead of one.
> > 
> > Thanks,
> > Miquèl
> >   
> 
> Hi Miquèl,
> 
> A proposal could also be to split this patch:
>   - a first patch that is using only one timeout value.
>   - a second patch that is increasing the value to 5 seconds.
> 
> Regards,
> Christophe Kerello.


Given the situation, both are fine as long as everything is clearly
explained in the commit log :)

Thanks,
Miquèl
