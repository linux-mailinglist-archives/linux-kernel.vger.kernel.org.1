Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31C02EF575
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbhAHQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAHQF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:05:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0F1E23A03;
        Fri,  8 Jan 2021 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610121918;
        bh=T71b0NrTSD0U1OUuRL9Xy7ztlZRyqZ9ouP02YGOs214=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knZsnjTYf+Dv6l52BBfnOkK8IgNeHXCWDHxUXSF27IxEV7SPu5esSZ60HlOehEU8E
         B8cGDEyu/AkE1tAOdicVGOdZ1eKIiJtxD9wF8slY9RoBNbljvb41bqnKNrpu+SHjq5
         itdffdXz6V97kEkoCBYwsVUgVzowNtHzH28QeIYU=
Date:   Fri, 8 Jan 2021 17:06:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, rafael@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] Driver core: platform: Add extra error check in
 devm_platform_get_irqs_affinity()
Message-ID: <X/iDC9T1LYgcB3LM@kroah.com>
References: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
 <X/h9vy/1h0E1hyN0@kroah.com>
 <e10af177-583b-636a-be14-6f781baaa61a@huawei.com>
 <68e22d9cd4cc631201f06300205bafb6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e22d9cd4cc631201f06300205bafb6@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 03:48:24PM +0000, Marc Zyngier wrote:
> On 2021-01-08 15:43, John Garry wrote:
> > On 08/01/2021 15:43, Greg KH wrote:
> > > On Mon, Dec 21, 2020 at 10:30:55PM +0800, John Garry wrote:
> > > > The current check of nvec < minvec for nvec returned from
> > > > platform_irq_count() will not detect a negative error code in nvec.
> > > > 
> > > > This is because minvec is unsigned, and, as such, nvec is promoted to
> > > > unsigned in that check, which will make it a huge number (if it
> > > > contained
> > > > -EPROBE_DEFER).
> > > > 
> > > > In practice, an error should not occur in nvec for the only in-tree
> > > > user, but add a check anyway.
> > > > 
> > > > Fixes: e15f2fa959f2 ("driver core: platform: Add
> > > > devm_platform_get_irqs_affinity()")
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: John Garry <john.garry@huawei.com>
> > > > ---
> > > > I hope that this can go through either irqchip or driver/core
> > > > trees, thanks!
> > > 
> > > I'll take it, thanks.
> > > 
> > 
> > Hi Greg,
> > 
> > I think that Marc already has taken it:
> > 
> > https://lore.kernel.org/lkml/X%2Fh9vy%2F1h0E1hyN0@kroah.com/T/#m95ef1736dbbd801cd85a4144c8f13c2afe33bc2c
> > 
> > I hope it doesn't cause hassle.
> 
> I was about to send tglx a pull request.
> 
> Greg, let me know if you want me to drop it.

Nope, no worries, git will handle this coming in multiple places :)

thanks,

greg k-h
