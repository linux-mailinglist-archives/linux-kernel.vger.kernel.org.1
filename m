Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAA2861A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgJGO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:58:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59523 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728737AbgJGO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:58:11 -0400
Received: (qmail 456826 invoked by uid 1000); 7 Oct 2020 10:58:09 -0400
Date:   Wed, 7 Oct 2020 10:58:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Subject: Re: [PATCH 2/3] usb: host: add uhci compatible support for
 ast2600-uhci
Message-ID: <20201007145809.GA456169@rowland.harvard.edu>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-3-ryan_chen@aspeedtech.com>
 <CACPK8Xc2Y1njgtrtjO1bdmkcQR7jDu+oaOBc3R+CWtn+UrEOhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xc2Y1njgtrtjO1bdmkcQR7jDu+oaOBc3R+CWtn+UrEOhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:25:04AM +0000, Joel Stanley wrote:
> On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
> >
> > Add support for AST2600 SOC UHCI driver.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> USB maintainers, can you please take this patch (2/3)? I will take the
> others in this series through the aspeed tree.
> 
> Cheers,
> 
> Joel
> 
> 
> > ---
> >  drivers/usb/host/uhci-platform.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> > index 70dbd95c3f06..fa40fe125c2a 100644
> > --- a/drivers/usb/host/uhci-platform.c
> > +++ b/drivers/usb/host/uhci-platform.c
> > @@ -113,7 +113,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
> >                                 num_ports);
> >                 }
> >                 if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
> > -                   of_device_is_compatible(np, "aspeed,ast2500-uhci")) {
> > +                       of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
> > +                       of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
> >                         uhci->is_aspeed = 1;
> >                         dev_info(&pdev->dev,
> >                                  "Enabled Aspeed implementation workarounds\n");
> > --
> > 2.17.1
> >

The indentation of the continuation lines isn't good, because the 
continued parts are aligned with the lines in the conditional block.  
They should be visually distinct.  Either align with the "of_device..." 
at the start or indent by two extra tab stops.

Once this is fixed, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
