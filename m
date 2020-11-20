Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC302BA7C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgKTKvP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Nov 2020 05:51:15 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50245 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgKTKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:51:15 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 73236E0029;
        Fri, 20 Nov 2020 10:51:11 +0000 (UTC)
Date:   Fri, 20 Nov 2020 11:51:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Juergen Borleis <jbe@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, kernel@pengutronix.de,
        Han Xu <han.xu@nxp.com>
Subject: Re: mtd: rawnand: gpmi: regression since
 e5e5631cc88987a6f3cd8304660bd9190da95916
Message-ID: <20201120115109.198d0e5d@xps13>
In-Reply-To: <20201117123001.GE29830@pengutronix.de>
References: <315838324eb25d3a1ab37ee90fa28fa1cdc48cae.camel@pengutronix.de>
        <20201117123001.GE29830@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sascha Hauer <s.hauer@pengutronix.de> wrote on Tue, 17 Nov 2020
13:30:01 +0100:

> On Tue, Nov 17, 2020 at 11:16:26AM +0100, Juergen Borleis wrote:
> > Hi,
> > 
> > reading a NAND page in raw mode is required to check the consistence of the so-
> > called FCBs (used to boot the SoC from NAND content).
> > 
> > Before e5e5631cc88987a6f3cd8304660bd9190da95916 ("mtd: rawnand: gpmi: Use
> > nand_extract_bits()") it reads the first page of the NAND correctly as:
> > 
> > 00000000  00 00 88 fb ff ff 46 43  42 20 00 00 00 01 50 3c  |......FCB ....P<|
> > 00000010  19 06 00 00 00 00 00 08  00 00 80 08 00 00 40 00  |..............@.|
> > 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 09 00  |................|
> > 00000030  00 00 00 02 00 00 00 02  00 00 09 00 00 00 0a 00  |................|
> > 00000040  00 00 03 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000060  00 00 00 00 00 00 00 00  00 00 00 01 00 00 80 10  |................|
> > 00000070  00 00 55 01 00 00 55 01  00 00 01 00 00 00 9e 07  |..U...U.........|
> > 00000080  00 00 02 00 00 00 00 08  00 00 00 00 00 00 00 00  |................|
> > 00000090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 00000200  40 05 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |@...............|
> > 00000210  40 01 00 00 00 80 05 00  00 80 05 00 40 01 00 00  |@...........@...|
> > 00000220  c0 03 00 00 80 02 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000230  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000240  00 00 00 00 00 00 00 00  00 00 00 00 00 00 07 00  |................|
> > 00000250  80 83 06 00 00 00 07 00  00 00 07 00 00 07 00 00  |................|
> > 00000260  00 42 06 00 80 05 00 00  00 40 06 00 00 00 00 00  |.B.......@......|
> > 00000270  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 00000790  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fc  |................|
> > 000007a0  03 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > 000007b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 00000800  ff 00 00 00 00 00 00 00  00 00 00 00 17 15 06 06  |................|
> > 00000810  10 1f 03 07 00 00 00 1c  0f 17 1f 05 00 00 00 00  |................|
> > 00000820  00 19 00 00 0e 19 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000830  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 00000880
> > 
> > After applying e5e5631cc88987a6f3cd8304660bd9190da95916 reading the same page
> > the reported content is broken (the NAND page still contains correct data):
> > 
> > 00000000  00 00 88 fb ff ff 46 43  42 20 00 00 00 01 50 3c  |......FCB ....P<|
> > 00000010  19 06 00 00 00 00 00 08  00 00 80 08 00 00 40 00  |..............@.|
> > 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 09 00  |................|
> > 00000030  00 00 00 02 00 00 00 02  00 00 09 00 00 00 0a 00  |................|
> > 00000040  40 05 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |@...............|
> > 00000050  40 01 00 00 00 80 05 00  00 80 05 00 40 01 00 00  |@...........@...|
> > 00000060  c0 03 00 00 80 02 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 00000250  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fc  |................|
> > 00000260  03 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > 00000270  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 000002c0  06 70 c0 a8 00 00 00 00  00 00 00 00 40 00 00 00  |.p..........@...|  
> 
> Note beginning from offset 0x2c0 we get some uninitialized data. Among
> other things we saw systemd unit files there.

Indeed, this unitialized data makes me thing that it is not fully
related to this patch. Honestly this is super weird.

Juergen would you have the time to debug it further? I don't have the
necessary hardware to investigate this right now.

Thanks,
Miquèl
