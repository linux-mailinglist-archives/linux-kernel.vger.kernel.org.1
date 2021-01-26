Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE4303D15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbhAZMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:36:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391623AbhAZK12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:27:28 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l4LYL-000112-S9; Tue, 26 Jan 2021 10:26:29 +0000
Date:   Tue, 26 Jan 2021 11:26:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Dealing with complex patch series in linux-next
Message-ID: <20210126102629.cde4k436hvz3cibg@wittgenstein>
References: <20210125094323.gz7g5p6xeifolf5v@wittgenstein>
 <20210126190030.109f24d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126190030.109f24d7@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:00:30PM +1100, Stephen Rothwell wrote:
> Hi Christian,
> 
> On Mon, 25 Jan 2021 10:43:23 +0100 Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >
> > After having received another round of acks on the idmapped mounts
> > series and other fses about to move forward with porting I moved forward
> > with merging [1] into my for-next branch which is tracked by sfr in
> > linux-next.
> > Given the nature of the series I expected there to be a good chunk of
> > merge conflicts including some non-trivial ones. But there proved to be
> > too many conflicts or at least a few ones that sfr couldn't handle
> > without more insight into the series. So after talking to sfr this
> > morning we decided to drop the tree for today.
> 
> OK, so tomorrow, I will try merging your tree really early.  This will,
> at least, spread the conflict pain out for me (yesterday it hit all at
> once at 4pm and added an hour to my day before I gave up).  Lets see
> how that goes.
> 
> Unless someone comes up with a better suggestion, of course :-)

I'm happy to help you if you want me to apply it to somewhere specific,
rebase or whatever. I have no problem doing it on a daily basis if that
makes it easier for you.

(Btw, I'm not sure this mail has made it to everyone here. It's
definitely not on lkml (as of now) seemingly because vger is having some
issues.)

Christian
