Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF502D0246
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgLFJgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 04:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgLFJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 04:36:51 -0500
Date:   Sun, 6 Dec 2020 10:37:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607247364;
        bh=71WbWYLmUr3JX6mYgxcp8Sep0aYV7sGlX32gjtgaLJg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=2EH8lAMG5mtLP7wlfrkgeAdUOrSlbgcWd1s9ehnRML8CVpdPxxjkNKG730Di3cGRt
         52M/xRCJ+ejAEneTbhXVGzdIdAGdHEE/oulq72x6n8ZBXBN0Hb/ieHbdessqXe7JBC
         b3qxtxjDULtvfTwZlVFLs3esPcwrxiTVrtiBGbiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Yu1" <yu1.wang@intel.com>,
        "Liu, Shuo A" <shuo.a.liu@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Message-ID: <X8ymTRQDlykxfU6T@kroah.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
 <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
 <20201203164859-mutt-send-email-mst@kernel.org>
 <X8lgSb9vB6UoJbVB@kroah.com>
 <20201205143909-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205143909-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 02:40:10PM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 03, 2020 at 11:01:45PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 03, 2020 at 04:51:10PM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Nov 25, 2020 at 09:18:04PM +0000, Winkler, Tomas wrote:
> > > > > 
> > > > > On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > > > > > +#ifndef VIRTIO_ID_MEI
> > > > > > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> > > > > 
> > > > > Just noticed now that this driver landed upstream.  Can I ask that you guys
> > > > > please register IDs with the virtio TC and not just pick a number at random?
> > > > > In particular this is way outside allowed range.
> > > > > 
> > > > > IDs should also be listed in include/uapi/linux/virtio_ids.h
> > > > > 
> > > > > If people just pick random numbers like this collistions are unavoidable.
> > > > > 
> > > > > List of IDs is part of virtio spec, chapter "Device Types".
> > > > > 
> > > > > Please do this change now before this goes out to production!
> > > > Okay,  this was assigned by ACRN, my impression was it's already registered.
> > > > Will take care of.
> > > > Thanks
> > > > Tomas
> > > 
> > > Well nothing happened yet.
> > > 
> > > I think at this point we really should revert this patch before Linux is
> > > released so in the next version the correct ID can be used instead of a reserved one.
> > > Otherwise Linux will be stuck supporting this forever and will conflict
> > > with hypervisors using this for what this range is for which is
> > > experimental use.
> > > 
> > > Greg, any opinion on that?
> > 
> > I will be glad to revert it, what's the git commit id?
> 
> commit d162219c655c8cf8003128a13840d6c1e183fb80
> Author: Tomas Winkler <tomas.winkler@intel.com>
> Date:   Tue Aug 18 14:51:47 2020 +0300
> 
>     mei: virtio: virtualization frontend driver
>     
> 
> I sent a revert on list in case it makes things easier,
> but it's just a result of a plain git revert,
> build-tested.

Thanks, that made it even easier for me, now queued up.

greg k-h
