Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17E2D9D43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502169AbgLNRJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502111AbgLNRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607965618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIiBUY90rUlzHYBsmvY+zwRQ2Zyr2oZBp7AXhfXLY/o=;
        b=ecoIkV1y9OvrwwUg7A5gom6wck2yb6k61HwD/4bU7mdU2kIjhNT1v9P8vivppVCmeVeOlc
        nQao9MfDmkIQJ+7Lw8RcDGSmct6BzJWU3CG12UnfgMnQpg3/o4z/RjWbgjr1TqlVLbQBI8
        ISgpKOiNTpDS2oKgwI4OY2UBBjHsi/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-tj0YQucoNYOE2dLpAksM5A-1; Mon, 14 Dec 2020 12:06:56 -0500
X-MC-Unique: tj0YQucoNYOE2dLpAksM5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37DF980402D;
        Mon, 14 Dec 2020 17:06:55 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 015616085A;
        Mon, 14 Dec 2020 17:06:54 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:06:54 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.10
Message-ID: <20201214170653.GB2290@redhat.com>
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk>
 <X9b9ujh5T6U5+aBY@kroah.com>
 <20201214160247.GA2090@redhat.com>
 <X9eWf0eGHonxQk5H@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9eWf0eGHonxQk5H@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14 2020 at 11:44am -0500,
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Dec 14, 2020 at 11:02:47AM -0500, Mike Snitzer wrote:
> > On Mon, Dec 14 2020 at 12:52am -0500,
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Mon, Dec 14, 2020 at 12:31:47AM -0500, Dave Jones wrote:
> > > > On Sun, Dec 13, 2020 at 03:03:29PM -0800, Linus Torvalds wrote:
> > > >  > Ok, here it is - 5.10 is tagged and pushed out.
> > > >  > 
> > > >  > I pretty much always wish that the last week was even calmer than it
> > > >  > was, and that's true here too. There's a fair amount of fixes in here,
> > > >  > including a few last-minute reverts for things that didn't get fixed,
> > > >  > but nothing makes me go "we need another week".
> > > > 
> > > > ...
> > > > 
> > > >  > Mike Snitzer (1):
> > > >  >       md: change mddev 'chunk_sectors' from int to unsigned
> > > > 
> > > > Seems to be broken.  This breaks mounting my raid6 partition:
> > > > 
> > > > [   87.290698] attempt to access beyond end of device
> > > >                md0: rw=4096, want=13996467328, limit=6261202944
> > > > [   87.293371] attempt to access beyond end of device
> > > >                md0: rw=4096, want=13998564480, limit=6261202944
> > > > [   87.296045] BTRFS warning (device md0): couldn't read tree root
> > > > [   87.300056] BTRFS error (device md0): open_ctree failed
> > > > 
> > > > Reverting it goes back to the -rc7 behaviour where it mounts fine.
> > > 
> > > If the developer/maintainer(s) agree, I can revert this and push out a
> > > 5.10.1, just let me know.
> > 
> > Yes, these should be reverted from 5.10 via 5.10.1:
> > 
> > e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10
> > f075cfb1dc59 md: change mddev 'chunk_sectors' from int to unsigned
> > 
> > They were also both marked for stable@, and I just got email stating
> > that you've staged them both for 5.4 and 5.9, but they shouldn't go to
> > stable@.  We need to reassess and fix during 5.11.
> 
> Ok, will go push out a 5.10.1 with those reverted, but please, get the
> reverts into Linus as soon as possible as well.

Yes, will do, working on it now!

Thanks,
Mike

