Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05C22E95C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhADNUU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 08:20:20 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51687 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbhADNUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:20:19 -0500
Received: from xps13 (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D0640240003;
        Mon,  4 Jan 2021 13:19:33 +0000 (UTC)
Date:   Mon, 4 Jan 2021 14:19:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: intel: remove broken code
Message-ID: <20210104141932.1037f8e3@xps13>
In-Reply-To: <CAFBinCDw_Zwwww88Vd2yU5sMZxYg-NQWHhLiuV7A5rhApeNroA@mail.gmail.com>
References: <20201217221148.2877318-1-martin.blumenstingl@googlemail.com>
        <20210104094849.1850c993@xps13>
        <CAFBinCDw_Zwwww88Vd2yU5sMZxYg-NQWHhLiuV7A5rhApeNroA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Mon,
4 Jan 2021 14:13:04 +0100:

> Hi Miquel,
> 
> thank you for looking into this
> 
> On Mon, Jan 4, 2021 at 9:48 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> [...]
> > >       nand_set_flash_node(&ebu_host->chip, dev->of_node);
> > > -     if (!mtd->name) {
> > > -             dev_err(ebu_host->dev, "NAND label property is mandatory\n");
> > > -             return -EINVAL;
> > > -     }  
> >
> > This is valid code, it's best to use a label = "my-storage"; property
> > in your NAND DT node. Then mtd->name will be updated by
> > nand_set_flash_node().  
> so you suggest moving the check instead?
> the original code flow was:
>   mtd = NULL;
>   if (!mtd->name)
>      return -EINVAL;
>   mtd = nand_to_mtd(&ebu_host->chip);
>   ...
> 
> by saying that the code itself is valid you're asking me to update the
> flow to the following:
>   mtd = nand_to_mtd(&ebu_host->chip);
>   if (!mtd->name)
>      return -EINVAL;

I actually missed the fact that mtd was used initialized, but yes that
is exactly what I meant!

Thanks,
Miquèl
