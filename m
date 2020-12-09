Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56F02D4399
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgLINxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732594AbgLINxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607521918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEvOjmhB1i5PXoaqnNt7r2jS1AVWUu3gyXThIQN4+ZA=;
        b=ZeIPJEQIlE3mOn3eJ4lEbP4zZccMmn4Ol0bEHGWhLh47wcnF0j9QIvewFF0iTwZRAWwQxX
        8+VuTpYCP79Jn9LpU2WODlXgPKDZOJuN/2Qyz71WAbpflt/fPdwbhYngkuyc6PGKNkx3QU
        hA9nG6Om0R9fHK7O3Houb5yHw+Xq8Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-p3lncGqXNNSZ7cDqvAsfeQ-1; Wed, 09 Dec 2020 08:51:56 -0500
X-MC-Unique: p3lncGqXNNSZ7cDqvAsfeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 965CB809DC3;
        Wed,  9 Dec 2020 13:51:53 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 764EB10074E0;
        Wed,  9 Dec 2020 13:51:49 +0000 (UTC)
Date:   Wed, 9 Dec 2020 08:51:48 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, koct9i@gmail.com,
        ming.lei@redhat.com, hare@suse.de, josef@toxicpanda.com,
        steve@sk2.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
Message-ID: <20201209135148.GA32720@redhat.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09 2020 at  8:01am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> Hi all.
> 
> I try to suggest the Block Layer Interposer (blk_interposer) again.
> It`s allows to intercept bio requests, remap bio to another devices
> or add new bios.
> 
> Initially, blk_interposer was designed to be compatible with
> device mapper. Our (my and Hannes) previous attempt to offer
> blk_interposer integrated with device mapper did not receive
> any comments from the dm-devel team, and without their help
> I will not be able to make a full implementation. I hope later
> they will have time to support blk_interposer in device mapper.

Excuse me?  I gave you quite a bit of early feedback!  I then went on
PTO for ~10 days, when I returned last week I had to deal with fixing
some 5.10 dm/block bio splitting regressions that only got resolved this
past Saturday in time for 5.10-rc7.

blk_interposer was/is on my short list to review closer (Hannes' version
that refined yours a bit more).. primarily to see if I could avoid the
extra clone and endio hooking.

The development window for 5.11 is past, so you pushing this without
using the approach discussed (in terms of DM) doesn't help your cause.

> And my blk-snap module requires an architecture change to
> support blk_interposer.
> 
> This time I offer it along with a sample.
> Despite the fact that blk_interposer is quite simple,
> there are a few non-obvious points that I would like to clarify.
> 
> However, I suggest the blk_interposer now so that people
> could discuss it and use it in their projects as soon as possible.

So you weren't willing to put the work in on something DM oriented
because you expected me to do the work for you?  And now you're looking
to side-step the consensus that was built because I didn't contribute
quick enough?  That's pretty messed up.

In the time-scale that is Linux kernel development.. you've really
jumped the gun and undercut my enthusiasm to work through the details.
I'd rather not read into your actions more than I already have here, but
I'm not liking what you've done here.  Kind of left in dismay with how
you decided to go down this path without a followup note to me or others
(that I'm aware of).

But I'm still willing to make blk_interposer work as we all discussed
(in terms of DM).

Mike

> Sergei Shtepa (3):
>   block: blk_interposer - Block Layer Interposer
>   block: blk_interposer - sample
>   block: blk_interposer - sample config
> 
>  block/blk-core.c                        |  32 +++
>  include/linux/blk_types.h               |   6 +-
>  include/linux/genhd.h                   |  12 +-
>  samples/Kconfig                         |   7 +
>  samples/Makefile                        |   1 +
>  samples/blk_interposer/Makefile         |   2 +
>  samples/blk_interposer/blk-interposer.c | 276 ++++++++++++++++++++++++
>  7 files changed, 333 insertions(+), 3 deletions(-)
>  create mode 100644 samples/blk_interposer/Makefile
>  create mode 100644 samples/blk_interposer/blk-interposer.c
> 
> --
> 2.20.1
> 

