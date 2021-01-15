Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F782F6F91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbhAOAds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbhAOAdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:33:46 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7ADC061575;
        Thu, 14 Jan 2021 16:33:06 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n25so4922559pgb.0;
        Thu, 14 Jan 2021 16:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SCnQ1+aOhtuEtW+MTDlHvjEGWFVpNMZLVq5aeaBymAQ=;
        b=Og1D23NkHTNY2bXSSMHkjbb4tcGJNXKnPZTQODkbYzoCjPYqnDHK67W31fXy5kM2aG
         A+KSSCPL0bWBfoAi+WJqOccetoQAN9mH6KAoOYMvM3m9lF+TGcZsT4Kzx3BVmMmyPwxn
         bX3xU6DAoYX56RUBtX5TRRoWOYnwo+5nc7BaitM7QScu7rYlu9EIXtgJHWqfXue6c03Q
         tExKve3JX0U6QQpQ/GNjebLJTTZOY16mDKaXu0Nbe7Hg22A7jQgXntuIo58vibfSc2Kw
         7qlYHySaQUENUXIMn6oe1QzbhGh7MTKmD9KyPvtJaU4mcbykxsy6N5xYKTCbkp9eRiqr
         JcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCnQ1+aOhtuEtW+MTDlHvjEGWFVpNMZLVq5aeaBymAQ=;
        b=Yh1KPz/brDrMKSy819l4I9viyeMuMXGJ7gIhQjRl6Mk5HfPEcgsWvoXZOYhH9dBAUX
         W71ij/YP88Pt1v7RHWAg3BkxAXvLhYqHOClfTXX/4ah6YDvKN6HfABxNKm6awajHkjKd
         MOMLE7vHKzPN2p+Hxziq1q2CeaO1eObqLNGSjNpruNgK6cLDNZnmYJ7S16xAxd7fIuf5
         ZXNbNABAE4dMNMcnLeVq4KfAfOb/3ubfaAyb4YdbtBu40m9e4Vvjt/fmbgqKyySR9qZG
         b+ue3TnJt5m95BjM1N/Pyn1aBulfQNpli7vGbE2Eq7KyOmVMfJgrfavCB5NXzcyVZJVP
         V47g==
X-Gm-Message-State: AOAM530NYFCnd8E1j7XpEu1Js/c4Hl0vMRBL3kmHhjWKka4v/bPR+Ib3
        rsm3SmflCw17L+IGoYVV2nezadFrKhgXZw==
X-Google-Smtp-Source: ABdhPJzMwRhupsGWd80NAW1EnVGbg2nzZBlGFxFaGR1yEuNLM2waMBOy7SzqtWpXE61k+jZQDaUR2A==
X-Received: by 2002:a62:7858:0:b029:19d:c011:1cfe with SMTP id t85-20020a6278580000b029019dc0111cfemr9807227pfc.47.1610670785807;
        Thu, 14 Jan 2021 16:33:05 -0800 (PST)
Received: from b29397-desktop ([194.5.48.251])
        by smtp.gmail.com with ESMTPSA id z11sm6539118pjn.5.2021.01.14.16.32.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jan 2021 16:33:04 -0800 (PST)
Date:   Fri, 15 Jan 2021 08:32:51 +0800
From:   Peter Chen <hzpeterchen@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Daewoong Kim <daewoong00.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        allen.lkml@gmail.com, gustavoars@kernel.org,
        a.darwish@linutronix.de, romain.perier@gmail.com,
        dvyukov@google.com, andreyknvl@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] usb: xhci: setup packets don't need DMA mapping
Message-ID: <20210115003251.GA3443@b29397-desktop>
References: <1610593147-12511-1-git-send-email-daewoong00.kim@lge.com>
 <20210114050402.GA18650@b29397-desktop>
 <20210114180021.GA1935@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114180021.GA1935@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-14 13:00:21, Alan Stern wrote:
> On Thu, Jan 14, 2021 at 01:04:02PM +0800, Peter Chen wrote:
> > On 21-01-14 11:59:07, Daewoong Kim wrote:
> > > DMA mapping of urb->setup_packet is not necessary for xHCI host
> > > controllers. The xHCI specification says that Setup Stage TRB includes
> > > whole Setup Data; therefore, urb->setup_dma will not be used in the xhci
> > > HCD code.
> > > 
> > 
> > How about bypass map/unmap operation for xHCI control transfer directly?
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 91ab81c3fc79..0a0ab14b7638 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1374,7 +1374,8 @@ static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> >  
> >  	xhci = hcd_to_xhci(hcd);
> >  
> > -	if (xhci_urb_suitable_for_idt(urb))
> > +	if (xhci_urb_suitable_for_idt(urb) ||
> > +		(usb_endpoint_xfer_control(&urb->ep->desc)))
> >  		return 0;
> 
> Would this affect the map/unmap operations for the DATA packets in a 
> control transfer, along with the SETUP packet?
> 

Oh, you are right, Alan. We do need map/unmap operation for DATA
packet in control transfer.

-- 

Thanks,
Peter Chen

