Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20542C9E50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgLAJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387466AbgLAJri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:47:38 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D10206C0;
        Tue,  1 Dec 2020 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606816017;
        bh=w3kwOokByEnA8Ps2WHcCoXlwpesQvmrePz9i2AHTGMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFhBUOqf+6W7jt8MjlUYx5iOfaUyfRU3ijEHBmqXxtNKXtr2KozSOuYlV6h9k4FGz
         IukiyBuEaXrcHaz3UVoPD9/bqb+xoa9CiuH1DYbntVau3Da8o9QZO59Yz190GOuKow
         l/hv5CbXUNrx5xrtmhNEdKk6Tj3EUwc8FEud9v8M=
Received: by pali.im (Postfix)
        id AE07C11CF; Tue,  1 Dec 2020 10:46:54 +0100 (CET)
Date:   Tue, 1 Dec 2020 10:46:54 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Terry Zhou <bjzhou@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH] clk: mvebu: a3700: fix the XTAL MODE pin to MPP1_9
Message-ID: <20201201094654.n3w632cmtnsg2irh@pali>
References: <20201106100039.11385-1-pali@kernel.org>
 <20201106115118.43eab492@kernel.org>
 <20201113101919.wega756egs7dinth@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113101919.wega756egs7dinth@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING! I would like to remind this patch.

On Friday 13 November 2020 11:19:19 Pali Rohár wrote:
> Michael, Stephen: Could you take this clk patch?
> 
> On Friday 06 November 2020 11:51:18 Marek Behún wrote:
> > Also, this is how A3720 WTMI code and ATF determines XTAL clock rate.
> > No reason for kernel to do it differently.
> > 
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > 
> > On Fri,  6 Nov 2020 11:00:39 +0100
> > Pali Rohár <pali@kernel.org> wrote:
> > 
> > > From: Terry Zhou <bjzhou@marvell.com>
> > > 
> > > There is an error in the current code that the XTAL MODE
> > > pin was set to NB MPP1_31 which should be NB MPP1_9.
> > > The latch register of NB MPP1_9 has different offset of 0x8.
> > > 
> > > Signed-off-by: Terry Zhou <bjzhou@marvell.com>
> > > [pali: Fix pin name in commit message]
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Fixes: 7ea8250406a6 ("clk: mvebu: Add the xtal clock for Armada 3700 SoC")
> > > Cc: stable@vger.kernel.org
> > > 
> > > ---
> > > This patch is present in Marvell SDK and also in Marvell's kernel fork:
> > > https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/80d4cec4cef8282e5ac3aaf98ce3e68fb299a134
> > > 
> > > Konstantin Porotchkin wrote on Github that Gregory Clement was notified
> > > about this patch, but as this patch is still not in mainline kernel I'm
> > > sending it again for review.
> > > 
> > > In original commit message (only in commit message, not code) was
> > > specified MPP9 pin on South Bridge, but correct is North Bridge.
> > > ---
> > >  drivers/clk/mvebu/armada-37xx-xtal.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
> > > index e9e306d4e9af..41271351cf1f 100644
> > > --- a/drivers/clk/mvebu/armada-37xx-xtal.c
> > > +++ b/drivers/clk/mvebu/armada-37xx-xtal.c
> > > @@ -13,8 +13,8 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > >  
> > > -#define NB_GPIO1_LATCH	0xC
> > > -#define XTAL_MODE	    BIT(31)
> > > +#define NB_GPIO1_LATCH	0x8
> > > +#define XTAL_MODE	    BIT(9)
> > >  
> > >  static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
> > >  {
> > 
