Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D022FFD8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbhAVHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbhAVHoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:44:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 007F322DBF;
        Fri, 22 Jan 2021 07:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611301417;
        bh=6s8dyzyoPVLbWhDYMgL1F8LoDlDPt5FF8Zj53kV3mAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfrVUnxMKWRy3l4OwAp6N6XZxPCKi4F+bj789X/Wkue+NYccwQyYR5AX1tIZBo0nq
         eZ8RVREqLWy7msLAbGnbI2DWoumRgWuSaJQNNXdZiCgOB6bIq1dEMORrm04HrENFpJ
         ANwRJ2iBG6VP7jJRscNGXz7e6jAjWkO1NOkL7HEs=
Date:   Fri, 22 Jan 2021 08:43:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-serial@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Subject: Re: [PATCH 1/6] tty: implement write_iter
Message-ID: <YAqCJr8JnpWrAZDf@kroah.com>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
 <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com>
 <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
 <4ade6b19-dc9e-ef72-dcca-1ddaa8d6c5fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ade6b19-dc9e-ef72-dcca-1ddaa8d6c5fd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 08:33:33AM +0100, Jiri Slaby wrote:
> On 21. 01. 21, 19:42, Linus Torvalds wrote:
> > On Thu, Jan 21, 2021 at 9:57 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > Incremental patches please as these are already in my public branches
> > > and I would have to revert them and add new ones but that's messy, so
> > > fixes on top is fine.
> > 
> > Ok. And since I think you put that first tty_write conversion patch in
> > a different branch from the tty_read one, I did the fixup patches for
> > the two as separate patches, even though they really just do the exact
> > same thing.
> > 
> > So here's three patches: the two fixups for the hung_up_tty case, and
> > the EOVERFLOW error case that Jiri also noted. I've also updated the
> > 'tty-splice' branch if you prefer them that way.
> > 
> > And I *should* say that I still haven't tested _any_ of the HDLC
> > changes. I have no idea how to do that, and if somebody can point to a
> > test-case (or better yet, actually has a real life situation where
> > they use it and can test this all) it would be great.
> > 
> > Jiri, any other issues, or any comment of yours I missed? I didn't do
> > the min() thing, I find the explicit conditional more legible myself,
> > but won't complain if somebody else then disagrees and wants to clean
> > it up.
> 
> I cannot find anything else.
> 
> All three:
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks for the review, I'll go apply these in a bit...

greg k-h
