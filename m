Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1350D2A2C50
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKBOL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:11:58 -0500
Received: from m12-12.163.com ([220.181.12.12]:45178 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKBOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=X9akP
        RF2DkcKO4cG0CcTnYlS18rDofVKLD9yne71XRY=; b=V+QIwIXdXK489rR8nr4ol
        CLNie5Y3DQhPksFIgiHAK9qsBw4UFBzW0vfOg3+UtMCUs+oZx7n6CGF11APsdIqG
        trG7JbMaf8pIjpVd9/jjWCvRWsPzfgU9FNKYzousYYhb+GSDbxjuso84OJ6zuWJT
        D7gDSZlfC5S4x6rywft7IE=
Received: from localhost (unknown [101.228.30.230])
        by smtp8 (Coremail) with SMTP id DMCowABXXr5mE6BfgATWUg--.8283S2;
        Mon, 02 Nov 2020 22:10:47 +0800 (CST)
Date:   Mon, 2 Nov 2020 22:10:46 +0800
From:   Hui Su <sh_def@163.com>
To:     Phil Auld <pauld@redhat.com>, David.Laight@aculab.com,
        linux-kernel@vger.kernel.org, bsegall@google.com, mingo@redhat.com
Subject: Re: [PATCH] sched/fair: remove the spin_lock operations
Message-ID: <20201102141046.GA184102@rlk>
References: <20201030144621.GA96974@rlk>
 <xm26mu0335zz.fsf@google.com>
 <22f99ee1d9b245c2a356d4d555b54e6a@AcuMS.aculab.com>
 <20201102135341.GA154641@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102135341.GA154641@lorien.usersys.redhat.com>
X-CM-TRANSID: DMCowABXXr5mE6BfgATWUg--.8283S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr15Zw1UXr4fCFWxKr1UGFg_yoW8WF1DpF
        ZrKay5KF4DXr97XrnF93WYgF4kK3yIyr15Zr1rWF1fZws8uw13KrW7GrZIkF4avr1SyF4v
        gF48J3s3Xrs0yw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDMa5UUUUU=
X-Originating-IP: [101.228.30.230]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMRzQX1UMWNDOagAAsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 08:53:41AM -0500, Phil Auld wrote:
> On Fri, Oct 30, 2020 at 10:16:29PM +0000 David Laight wrote:
> > From: Benjamin Segall
> > > Sent: 30 October 2020 18:48
> > > 
> > > Hui Su <sh_def@163.com> writes:
> > > 
> > > > Since 'ab93a4bc955b ("sched/fair: Remove
> > > > distribute_running fromCFS bandwidth")',there is
> > > > nothing to protect between raw_spin_lock_irqsave/store()
> > > > in do_sched_cfs_slack_timer().
> > > >
> > > > So remove it.
> > > 
> > > Reviewed-by: Ben Segall <bsegall@google.com>
> > > 
> > > (I might nitpick the subject to be clear that it should be trivial
> > > because the lock area is empty, or call them dead or something, but it's
> > > not all that important)
> > 
> > I don't know about this case, but a lock+unlock can be used
> > to ensure that nothing else holds the lock when acquiring
> > the lock requires another lock be held.
> > 
> > So if the normal sequence is:
> > 	lock(table)
> > 	# lookup item
> > 	lock(item)
> > 	unlock(table)
> > 	....
> > 	unlock(item)
> > 
> > Then it can make sense to do:
> > 	lock(table)
> > 	lock(item)
> > 	unlock(item)
> > 	....
> > 	unlock(table)
> > 
> > although that ought to deserve a comment.
> >
> 
> Nah, this one used to be like this :
> 
>         raw_spin_lock_irqsave(&cfs_b->lock, flags);
>         lsub_positive(&cfs_b->runtime, runtime);
>         cfs_b->distribute_running = 0;
>         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> 
> It's just a leftover. I agree that if it was there for some other
> purpose that it would really need a comment. In this case, it's an
> artifact of patch-based development I think.
> 
> 
> Cheers,
> Phil
> 

Yeah, thanks for your explanation, Phil.

It is just a leftover.

