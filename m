Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24C2D9CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501943AbgLNQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgLNQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:44:24 -0500
Date:   Mon, 14 Dec 2020 17:44:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607964224;
        bh=Pk+XCiHHVxje/Yvvinw5lMgWaIoh+grgFYLPBUgmLS8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ys6xF+UdmqbY9sKd5jlITCx41WKhmsDGfwo1u2ZAqdjvxz2+vK06lBw6JDKYv8dID
         pCa73Zpns+fMvckLlyF3zkMgxtkuf5aNm2sVds/sbHWSe1JsRp/99k6Lvr+yyuHcss
         6udE7lxFPn+zAN1VZR7mSNdTxTkz4eeGSZU/Bof4=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.10
Message-ID: <X9eWf0eGHonxQk5H@kroah.com>
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk>
 <X9b9ujh5T6U5+aBY@kroah.com>
 <20201214160247.GA2090@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214160247.GA2090@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:02:47AM -0500, Mike Snitzer wrote:
> On Mon, Dec 14 2020 at 12:52am -0500,
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Dec 14, 2020 at 12:31:47AM -0500, Dave Jones wrote:
> > > On Sun, Dec 13, 2020 at 03:03:29PM -0800, Linus Torvalds wrote:
> > >  > Ok, here it is - 5.10 is tagged and pushed out.
> > >  > 
> > >  > I pretty much always wish that the last week was even calmer than it
> > >  > was, and that's true here too. There's a fair amount of fixes in here,
> > >  > including a few last-minute reverts for things that didn't get fixed,
> > >  > but nothing makes me go "we need another week".
> > > 
> > > ...
> > > 
> > >  > Mike Snitzer (1):
> > >  >       md: change mddev 'chunk_sectors' from int to unsigned
> > > 
> > > Seems to be broken.  This breaks mounting my raid6 partition:
> > > 
> > > [   87.290698] attempt to access beyond end of device
> > >                md0: rw=4096, want=13996467328, limit=6261202944
> > > [   87.293371] attempt to access beyond end of device
> > >                md0: rw=4096, want=13998564480, limit=6261202944
> > > [   87.296045] BTRFS warning (device md0): couldn't read tree root
> > > [   87.300056] BTRFS error (device md0): open_ctree failed
> > > 
> > > Reverting it goes back to the -rc7 behaviour where it mounts fine.
> > 
> > If the developer/maintainer(s) agree, I can revert this and push out a
> > 5.10.1, just let me know.
> 
> Yes, these should be reverted from 5.10 via 5.10.1:
> 
> e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10
> f075cfb1dc59 md: change mddev 'chunk_sectors' from int to unsigned
> 
> They were also both marked for stable@, and I just got email stating
> that you've staged them both for 5.4 and 5.9, but they shouldn't go to
> stable@.  We need to reassess and fix during 5.11.

Ok, will go push out a 5.10.1 with those reverted, but please, get the
reverts into Linus as soon as possible as well.

thanks,

greg k-h
