Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD31B48CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDVPgI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Apr 2020 11:36:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37099 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgDVPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:36:08 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2C69C20016;
        Wed, 22 Apr 2020 15:36:02 +0000 (UTC)
Date:   Wed, 22 Apr 2020 17:36:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: denali: add more delays before
 latching incoming data
Message-ID: <20200422173600.304c7cf2@xps13>
In-Reply-To: <6093dfab-1e9e-824a-b639-33d340b377f9@denx.de>
References: <20200317071821.9916-1-yamada.masahiro@socionext.com>
        <6093dfab-1e9e-824a-b639-33d340b377f9@denx.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Marek Vasut <marex@denx.de> wrote on Wed, 22 Apr 2020 17:29:53 +0200:

> On 3/17/20 8:18 AM, Masahiro Yamada wrote:
> > The Denali IP have several registers to specify how many clock cycles
> > should be waited between falling/rising signals. You can improve the
> > NAND access performance by programming these registers with optimized
> > values.
> > 
> > Because struct nand_sdr_timings represents the device requirement
> > in pico seconds, denali_setup_data_interface() computes the register
> > values by dividing the device timings with the clock period.
> > 
> > Marek Vasut reported this driver in the latest kernel does not work
> > on his SOCFPGA board. (The on-board NAND chip is mode 5)
> > 
> > The suspicious parameter is acc_clks, so this commit relaxes it.
> > 
> > The Denali NAND Flash Memory Controller User's Guide describes this
> > register as follows:
> > 
> >   acc_clks
> >     signifies the number of bus interface clk_x clock cycles,
> >     controller should wait from read enable going low to sending
> >     out a strobe of clk_x for capturing of incoming data.
> > 
> > Currently, acc_clks is calculated only based on tREA, the delay on the
> > chip side. This does not include additional delays that come from the
> > data path on the PCB and in the SoC, load capacity of the pins, etc.
> > 
> > This relatively becomes a big factor on faster timing modes like mode 5.
> > 
> > Before supporting the ->setup_data_interface() hook (e.g. Linux 4.12),
> > the Denali driver hacks acc_clks in a couple of ways [1] [2] to support
> > the timing mode 5.
> > 
> > We would not go back to the hard-coded acc_clks, but we need to include
> > this factor into the delay somehow. Let's say the amount of the additional
> > delay is 10000 pico sec.
> > 
> > In the new calculation, acc_clks is determined by timings->tREA_max +
> > data_setup_on_host.
> > 
> > Also, prolong the RE# low period to make sure the data hold is met.
> > 
> > Finally, re-center the data latch timing for extra safety.
> > 
> > [1] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L276
> > [2] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L282
> > 
> > Reported-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>  
> 
> I tested it on the AV SoCFPGA, this seems to work, so feel free to apply.


Great! Thanks a lot for testing, would you mind sending your Tested-by?

Thanks,
Miquèl
