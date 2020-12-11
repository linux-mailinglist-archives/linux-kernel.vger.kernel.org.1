Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742AA2D7B01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406782AbgLKQdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406738AbgLKQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607704265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIrMGB49Y+IuGsgowDuFSCvTmCjpxYfmCd/REiXjRZc=;
        b=ZtWDGfs8rNDtaY7du8F9EpaBzsj7SpIFzkiQYWAkm6d9t4kXXoHuSxVxekoTcXgLw/sqR0
        h4qe6NJUTR5PEdkSOdl2BgxBXrC6he4dv4VJ1osooHbFx7B7w/PRI0ghrsiCrQi7qHrH/F
        xecgaoKzA52nkqF8CtiEFffKa8kctt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-DcNLE8KpMqWaEhks8lAUgg-1; Fri, 11 Dec 2020 11:31:01 -0500
X-MC-Unique: DcNLE8KpMqWaEhks8lAUgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D45800D53;
        Fri, 11 Dec 2020 16:30:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94D925D6A8;
        Fri, 11 Dec 2020 16:30:50 +0000 (UTC)
Date:   Fri, 11 Dec 2020 11:30:49 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
Message-ID: <20201211163049.GC16168@redhat.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com>
 <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210163222.GB10239@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10 2020 at 11:32am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Dec 10 2020 at  9:58am -0500,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> 
> > The 12/09/2020 16:51, Mike Snitzer wrote:
> > > On Wed, Dec 09 2020 at  8:01am -0500,
> > > Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> > > 
> > > > Hi all.
> > > > 
> > > > I try to suggest the Block Layer Interposer (blk_interposer) again.
> > > > It`s allows to intercept bio requests, remap bio to another devices
> > > > or add new bios.
> > > > 
> > > > Initially, blk_interposer was designed to be compatible with
> > > > device mapper. Our (my and Hannes) previous attempt to offer
> > > > blk_interposer integrated with device mapper did not receive
> > > > any comments from the dm-devel team, and without their help
> > > > I will not be able to make a full implementation. I hope later
> > > > they will have time to support blk_interposer in device mapper.
> > > 
> > > Excuse me?  I gave you quite a bit of early feedback!  I then went on
> > > PTO for ~10 days, when I returned last week I had to deal with fixing
> > > some 5.10 dm/block bio splitting regressions that only got resolved this
> > > past Saturday in time for 5.10-rc7.
> > 
> > Mike,
> > 
> > I would like to clarify some points that I've made, and also try 
> > to repair the damage from the misunderstandings that I think have occured.
> > 
> > First of all, I actually meant the feedback on Hannes's patch which was
> > sent on the 19th of November:
> > https://lore.kernel.org/linux-block/20201119164924.74401-1-hare@suse.de/
> > 
> > Your feedback from the 18th of November ("[PATCH 4/4] dm_interposer - 
> > Try to use blk_interpose in dm") is very valuable, but I am not sure that
> > I am currently capable of implementing the proposed DM changes.
> > The overall architecture of DM is still not clear to me, and I am studying
> > it right now.
> > 
> > This new patch (the one that Hannes sent on the 19th of November) is also
> > compatibile with DM and should not pose any problems - the architecture is
> > the same. There are some changes that make blk_interposer simpler and better,
> > plus the sample is added.
> > 
> > > 
> > > blk_interposer was/is on my short list to review closer (Hannes' version
> > > that refined yours a bit more).. primarily to see if I could avoid the
> > > extra clone and endio hooking.
> > 
> > Glad to hear that! In order to avoid the additional copying one can only
> > change an intercepted bio, which might be dangerous.
> > 
> > > 
> > > The development window for 5.11 is past, so you pushing this without
> > > using the approach discussed (in terms of DM) doesn't help your cause.
> > > 
> > > > And my blk-snap module requires an architecture change to
> > > > support blk_interposer.
> > > > 
> > > > This time I offer it along with a sample.
> > > > Despite the fact that blk_interposer is quite simple,
> > > > there are a few non-obvious points that I would like to clarify.
> > > > 
> > > > However, I suggest the blk_interposer now so that people
> > > > could discuss it and use it in their projects as soon as possible.
> > > 
> > > So you weren't willing to put the work in on something DM oriented
> > > because you expected me to do the work for you?  And now you're looking
> > > to side-step the consensus that was built because I didn't contribute
> > > quick enough?  That's pretty messed up.
> > 
> > I just think that no one can implement integration of DM with
> > blk_interposer better than dm-devel team. I will certainly try my best,
> > but I am afraid that such efforts will only produce incongruous
> > DM patches that will be a waste of time (yours and mine).
> > 
> > > 
> > > In the time-scale that is Linux kernel development.. you've really
> > > jumped the gun and undercut my enthusiasm to work through the details.
> > > I'd rather not read into your actions more than I already have here, but
> > > I'm not liking what you've done here.  Kind of left in dismay with how
> > > you decided to go down this path without a followup note to me or others
> > > (that I'm aware of).
> > 
> > I am very sorry that I undercut your enthusiasm, but, as you rightly
> > pointed out, another development windows is closing, and my product
> > is still not able to work on newer Linux versions starting from 5.8.
> > That fact makes me particularly sad and forces me to search for different
> > means to draw some attention to blk_interposer. I've seen an RHEL 8.4
> > alpha recently, all looks very cool there but made me even more sad ...
> 
> Made you more sad because you don't have a working solution for upstream
> or RHEL 8.4?
> 
> I may have missed it in your past emails but how were you able to
> provide blk-snap support for kernels prior to 5.8?

I now clearly understand that the 5.8 block changes to do away with
->make_request_fn in favor of a more optimized ->submit_bio (that isn't
applicable for all devices) is why you're pursuing a "fix" so urgently.

> > > But I'm still willing to make blk_interposer work as we all discussed
> > > (in terms of DM).
> > 
> > I want it too. However, there is a certain difficulty with usage of DM
> > for backup copying. For instance, there is no changed block tracking (CBT)
> > and right now I don't have any clue how it could be implemented
> > considering the existing architecture. I still hope that sometime
> > in future I could be offer my blk-snap module which was specifically
> > created for backup copying purposes.
> > 
> > I apologize for causing all that confusion and mess and making you upset.
> > I hope that all of the above makes sense to you and you will not think
> > that I was slacking and tried to offload all the work to your team.
> 
> My primary concern is that blk_interposer be correct from the start.  To
> validate its correctness it needs to be fully implemented and vetted in
> terms on upstream Linux kernel code.  DM can easily serve as the primary
> upstream consumer until if/when your blk-snap module is proposed for
> upstream inclusion.
> 
> But short of having an actual upstream consumer of blk_interposer (not
> just samples/ code) it cannot go upstream.  Otherwise there are too many
> risks of misuse and problems in the longrun.  That and it'd be baggage
> block core would need to carry for no upstream Linux benefit.

As I shared in private: I have some urgent Red Hat business critical
work I need to do and unfortunately cannot put my near-term focus to
implementing a fully baked blk_interposer for DM.  But I can come back
to it (sadly unlikely to do so until the new year though).

While I still think there needs to be a proper _upstream_ consumer of
blk_interposer as a condition of it going in.. I'll let others make the
call.

As such, I'll defer to Jens, Christoph and others on whether your
minimalist blk_interposer hook is acceptable in the near-term.

Mike

