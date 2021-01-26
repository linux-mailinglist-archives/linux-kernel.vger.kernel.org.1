Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E35303CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392611AbhAZMVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392571AbhAZMVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:21:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD4F62255F;
        Tue, 26 Jan 2021 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611663636;
        bh=SyEIFgGM/H0MBFGrTB8Qc18ZSnruxlWKVtgwOC9+6sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chSCMuaE2kMnB2pkwkzoLdIj6rfJPIa1NEcx5j0zOisZbWMlOO2UQNgVbFRNz/46H
         HWaQ3hG+gKRRWT7imZL6f8NQF+YK01rLP4RxNKbrD3+7qSvWMhA56SsKT/R2vfdiE/
         ew4D8GP2Fi6MCtJ6cjWjd2dwrafk3lJcjMhdO4z8=
Date:   Tue, 26 Jan 2021 13:20:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH] usb: dwc3: add EXPORT_SYMBOL_GPL for role init functions
Message-ID: <YBAJERMWh8V7qbiH@kroah.com>
References: <20210126094913.180945-1-raychi@google.com>
 <YA/ogYkHrbmd1Eyo@kroah.com>
 <CAPBYUsAc25n2kFD2VQVkx7oeFXU888MWKGCQeusT4HgV1JKY3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsAc25n2kFD2VQVkx7oeFXU888MWKGCQeusT4HgV1JKY3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 08:14:02PM +0800, Ray Chi wrote:
> On Tue, Jan 26, 2021 at 6:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jan 26, 2021 at 05:49:13PM +0800, Ray Chi wrote:
> > > Currently, role init functions are used in dwc3 driver but
> > > can't be called from kernel modules.
> > >   dwc3_host_init
> > >   dwc3_host_exit
> > >   dwc3_gadget_init
> > >   dwc3_gadget_exit
> > >   dwc3_event_buffers_setup
> > >   dwc3_event_buffers_cleanup
> > >
> > > If other kernel modules want to use these functions, it needs
> > > EXPORT_SYMBOL_GPL() to get compile pass.
> > >
> > > Signed-off-by: Ray Chi <raychi@google.com>
> >
> > What current kernel configuration fails without this patch applied?  I
> > don't see any in-tree users of this as a module that would break, or am
> > I missing something?
> >
> > thanks,
> >
> > greg k-h
> 
> There is no failure for current status. This patch is just used for
> any kernel modules
> which want to call these functions. I think it is an expandability of
> dwc3 core driver.

We will gladly take exports for in-kernel users, but as you well know,
we can not export symbols that no one in the kernel tree needs, that
would be foolish of us to do so.

Please submit the code that uses these symbols and include this patch as
part of that patch series and all will be good!

thanks,

greg k-h
