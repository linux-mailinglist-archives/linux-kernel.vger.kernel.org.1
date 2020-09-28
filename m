Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957D327ADB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1MZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgI1MZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:25:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8638C207E8;
        Mon, 28 Sep 2020 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601295955;
        bh=wVrs+3kytjBZohn7BTL2U88iwkha6UbOsn4DCBgdtK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EB+Oa95iV1npMb0/iwRazczbrwezIYljsx+rtwNmKiGkdgkovVWks8EaIIA4E47NT
         3SUEdo7tmd/utx0m3zdlztaHKbGlZvBBK9H/iWj/5Q9Ev08hGMAnpkZ0o/FAsTVgpw
         IHXoBZtGXWQkv6l0/Kv12svaLSlasuMxnuPH5dq8=
Date:   Mon, 28 Sep 2020 14:26:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200928122602.GB682772@kroah.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-7-shuo.a.liu@intel.com>
 <20200927104702.GE88650@kroah.com>
 <20200928035030.GD1057@shuo-intel.sh.intel.com>
 <20200928052516.GD767987@kroah.com>
 <20200928062934.GF1057@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928062934.GF1057@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 02:29:34PM +0800, Shuo A Liu wrote:
> On Mon 28.Sep'20 at  7:25:16 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 28, 2020 at 11:50:30AM +0800, Shuo A Liu wrote:
> > > > > +	write_lock_bh(&acrn_vm_list_lock);
> > > > > +	list_add(&vm->list, &acrn_vm_list);
> > > > > +	write_unlock_bh(&acrn_vm_list_lock);
> > > >
> > > > Why are the _bh() variants being used here?
> > > >
> > > > You are only accessing this list from userspace context in this patch.
> > > >
> > > > Heck, you aren't even reading from the list, only writing to it...
> > > 
> > > acrn_vm_list is read in a tasklet which dispatch I/O requests and is wrote
> > > in VM creation ioctl. Use the rwlock mechanism to protect it.
> > > The reading operation is introduced in the following patches of this
> > > series. So i keep the lock type at the moment of introduction.
> > 
> > Ok, but think about someone trying to review this code.  Does this lock
> > actually make sense here?  No, it does not.  How am I supposed to know
> > to look at future patches to determine that it changes location and
> > usage to require this?
> 
> OK. May i know how to handle such kind of code submission? Or which way
> following do you prefer?
>  1) Use a mutex lock here, then change it to rwlock in a later patch
>     of this series.

Wouldn't this make more sense if you had to read these one after
another?

>  2) Add more comments in changelog about the lock. (Now, there is
>     comment around the acrn_vm_list_lock)

It's hard to verify a comment's statement without digging through other
patches in the series, right?  You want the reviewer to just trust you?
:)

Again, what would _YOU_ want to see if you had to review this?

> > That's just not fair, would you want to review something like this?
> > 
> > And a HUGE meta-comment, again, why am I the only one reviewing this
> > stuff?  Why do you have a ton of Intel people on the Cc: yet it is, once
> > again, my job to do this?
> 
> The patchset has been reviewed in Intel's internal mailist several
> rounds and got Reviewed-by: before send out. That's why i Cced many
> Intel people as well.

Then why didn't any of those intel people on the cc: actually review it
after you have sent it out?  Why is it only me?  Do I need to wait
longer for them to get to this?  I'll gladly do so next time...

> This patchset is all about a common driver for the ACRN hypervisor
> support. I put the code in drivers/virt/ and found you are one of the
> maintainer of vboxguest driver which is in the same subdirectory. I
> thought you should be the right person to be Cced when i submitted this
> series.

I am, I'm not complaining about that.  I'm complaining that it seems to
be _only_ me reviewing this here, and not any of the people you are cc:ing
from intel.  Most of those people should be giving you this same type of
review comments and not forcing an external person to do so, right?

> Certainly, any comments are welcome. And really appreciate your review
> and help. I have little experience to submit a new driver to the
> community, my apologies if thing goes wrong.

You didn't do anything wrong, I'm arguing about the larger meta-issue I
have right now with Intel and the lack of reviews that seems to happen
from other Intel people on their co-workers patches.

Anyway, you are doing fine, it's an iterative process, hopefully you can
also review other people's patches in this area that are being posted as
well.

thanks,

greg k-h
