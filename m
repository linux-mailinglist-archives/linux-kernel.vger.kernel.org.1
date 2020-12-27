Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50FF2E31C0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL0QDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgL0QDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:03:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7203122512;
        Sun, 27 Dec 2020 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609084940;
        bh=0vg7M7y/o+3nZ+KECAO25hYa8OZo8S9gmKnQKy+rQgQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l7CHi1d9H3wJjUMl620CzmmYVVm4e9EiZsR4nSdzppWa3b0hZN45aCyo3bzVk77Rc
         bJORCoqNAdk2W6q5u1NhQ3/VS65eRT+svItR9NqtsnarWS79F7jAKjljQFNihBAhFZ
         VbBmshpNTHpuNk1YniBqPo4UnLy9iVyB7+rmiVinf5c2I/sCz6LJZxXjazrp06gjBR
         XFOngjcPKHFn3BF6jeUF4uBbxroee0rKK2+391YQypknuUliXNWR+15kl0RAPQDTiG
         01n4eWI7RBeAVqbVQyZEKTXEHGGDjB/65VedMGcxRmx21uPIcXtXmB7Vm4PjXCnUF1
         K+J5nhLRzsgWw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 34DBE35226B3; Sun, 27 Dec 2020 08:02:20 -0800 (PST)
Date:   Sun, 27 Dec 2020 08:02:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Message-ID: <20201227160220.GK2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
 <20201226103421.6616-1-hdanton@sina.com>
 <20201226145239.GJ2657@paulmck-ThinkPad-P72>
 <CAJhGHyBGb_fBqp7-XCD0bkZOt5E_aPKwkViY3PUN1MVZuBE3KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBGb_fBqp7-XCD0bkZOt5E_aPKwkViY3PUN1MVZuBE3KA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:08:51PM +0800, Lai Jiangshan wrote:
> On Sat, Dec 26, 2020 at 10:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > >
> > > Can you please specify a bit what you encountered in rcutorture
> > > before this patchset? You know we cant have a correct estimation
> > > of the fix diameter without your help.
> 
> >
> > It triggers the following in sched_cpu_dying() in kernel/sched/core.c,
> > exactly the same as for Lai Jiangshan:
> >
> >         BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq))
> >
> > Which is in fact the "this" in my earlier "rcutorture hits this".  ;-)
> >
> >                                                         Thanx, Paul
> >
> 
> Hi, Hillf
> 
> https://lkml.org/lkml/2020/12/22/141
> 
> >From the email, I think rcutorture encountered the same problem.
> 
> Hi, Paul
> 
> I'm sorry to forget to add your Tested-by.

No need to apologize, especially given that I didn't get around to
testing it until after it was pulled into -tip.  ;-)

Thank you for the patch series!

							Thanx, Paul
