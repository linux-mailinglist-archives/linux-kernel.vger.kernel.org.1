Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C912FF781
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbhAUVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbhAUVjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:39:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C28A206BE;
        Thu, 21 Jan 2021 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611265153;
        bh=aLuf1i9OQEMa2qBpCs/Nu07vuKtAWu6kZISwL4/LvOw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p4KSYU373sYoPwYkPjI/RoAXpn44Un2Dfhs5PP8/rYka97g6UN6v7q2ilehqFDUfq
         rJdgMZPx4ZxXALWhLNcOx2ymd7DXvwKcPNLIsttHJJaBDWrXen8e0Dh66ARS5OLyi2
         VUjq6cFhrXFeZ1icra2T6Bz1Cu2baUOUlHF5LUtcbSj5BuuWPy3CmykYheIkP/2u9W
         SO7z3lE3BUc7g4d1l4HAL//gSdeiK6l7gt6JnSgvgexEmgh9+BORxTtVHlJ/0KeAMp
         FmYlD21fe2jVC9neX0/JtGZqHk2/i9ZBNsj3QUmMRWqf3yzF3QaoExYEpNXmp8g0mA
         BX6GYAjzvWdVQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4840F35226D8; Thu, 21 Jan 2021 13:39:13 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:39:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC cpumask] Allow "all", "none", and "last" in cpumask
 strings
Message-ID: <20210121213913.GA19646@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <CAAH8bW95nyx6PEnPiBPoHMLoduvgU9KO7N=K7mhLORkA+zzhDw@mail.gmail.com>
 <CAAH8bW8-q-2LaTC5DE0PnUBqs3V_69EAefLvwdZoeFSow8NYZA@mail.gmail.com>
 <20210121165725.GP2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210121165725.GP2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:57:25AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 20, 2021 at 11:11:48PM -0800, Yury Norov wrote:
> > On Wed, Jan 6, 2021 at 12:49 AM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > On Tue, Jan 5, 2021 at 4:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > This series allows "all", "none", and "last" to be used in cpumask
> > > > strings.  This allows these strings to be less dependent on the underlying
> > > > system.  For example, currently a string specifying all but the first
> > > > CPU must be "1-7" on an eight-CPU system and "1-15" on a 16-CPU system.
> > > > With this series, the single string "1-last" can be used regardless of the
> > > > number of CPUs (at least assuming that each system has at least one CPU).
> > >
> > > 'none' may be implemented as an empty string or string with separators only,
> > > but I have nothing against explicit 'none'. See other comments inline.
> > >
> > > Thanks,
> > > Yury.
> > >
> > > > 1.      Un-inline cpulist_parse for SMP; prepare for ascii helpers,
> > > >         courtesy of Paul Gortmaker.
> > > >
> > > > 2.      Make "all" alias global and not just RCU, courtesy of Paul
> > > >         Gortmaker.
> > > >
> > > > 3.      Add a "none" alias to complement "all", courtesy of Paul
> > > >         Gortmaker.
> > > >
> > > > 4.      Add "last" alias for cpu list specifications, courtesy of Paul
> > > >         Gortmaker.
> > > >
> > > > 5.      Use "all" and "last" in "nohz_full" and "rcu_nocbs".
> > > >
> > > >                                                 Thanx, Paul
> > 
> > Hi Paul,
> > 
> > Today I found this series in linux-next despite downsides discovered during
> > the review. This series introduces absolutely unneeded cap on the number of
> > cpus in the system (9999), and also adds unsafe and non-optimal code.
> > 
> > In addition to that, I observe this warning on powerpc:
> >   CC      lib/cpumask.o
> > lib/cpumask.c: In function ‘cpulist_parse’:
> > lib/cpumask.c:222:17: warning: cast from pointer to integer of
> > different size [-Wpointer-to-int-cast]
> >   222 |   memblock_free((phys_addr_t)cpulist, len);
> >       |                 ^
> > 
> > Can you please revert this series unless all the problems will be fixed?
> 
> Thank you for your further review and comments!
> 
> I had been keeping the old series as a placeholder for its anticipated
> replacement, but given the compiler warning you note above and given
> that it is getting uncomfortably close to the time when I send my pull
> request, I will remove it from the -rcu rcu/next branch sourced by -next.

Except that the resulting rebasing and testing took too long, so there will
be one more -next with these commits.

								Thanx, Paul
