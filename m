Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124B92D1D88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgLGWje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgLGWje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:39:34 -0500
Date:   Mon, 7 Dec 2020 14:38:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607380733;
        bh=0FDK3sfRhL+zaCimlzL6gWXaPTiTkLgCI5cm5rzO33I=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HG3baAYgR5MpiaDHZfbjKVVCuFNnEXlCqIiwsb4qyS7jISjL/9zwELeEdbseQt+lS
         rw40lySCD0RSluP3xdnF5DeGImS0VASeWOHEHKCH9zPIFbxUk3C3gpzqLDu4onN+Co
         0H2vkWNVhvgcLcWXvXEeHW/HOYVbAMEXplM2OrUQO8FoOcHi7G6Dn0xG2U2VHuLhy1
         Ild+FW59BZHtMoG58aphwCqNAMuoS5UA9nn4AENNcUkz25Ew3r3TTQ9t4k0tWuzx59
         aw6OtZdyH1cxEx5sUyxsi2sz/D35O2aVtHKy8zAwKdnw4EAD46oeV+uVOGIq3oMesS
         j2JZatbvViCLQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
Message-ID: <20201207223853.GL2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <87blf547d2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blf547d2.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:46:33PM +0100, Thomas Gleixner wrote:
> On Mon, Dec 07 2020 at 11:44, Paul E. McKenney wrote:
> > On Mon, Dec 07, 2020 at 07:19:51PM +0100, Marco Elver wrote:
> >> On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> I currently don't know what the rule for Peter's preferred variant
> >> would be, without running the risk of some accidentally data_race()'d
> >> accesses.
> >> 
> >> Thoughts?
> >
> > I am also concerned about inadvertently covering code with data_race().
> >
> > Also, in this particular case, why data_race() rather than READ_ONCE()?
> > Do we really expect the compiler to be able to optimize this case
> > significantly without READ_ONCE()?
> 
> That was your suggestion a week or so ago :)

You expected my suggestion to change?  ;-)

							Thanx, Paul
