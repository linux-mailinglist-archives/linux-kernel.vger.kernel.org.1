Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC32D1DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgLGW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgLGW4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:56:22 -0500
Date:   Mon, 7 Dec 2020 14:55:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607381742;
        bh=MTovbSNum3TKJoGnhB5Nq3ImaKuoaau0JkrY19YWFUc=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HzKGZEMulkSmll0/GZq/AdfLDIFFXu0jWuGNZFuyPNxYs1R//yvVMnKlO/5mwZKjs
         /ZAbDlwKvwO/wiiB4Ul4qbKWGpOSm1pXf8YuzkYl33ng+3l34VseCKXHdxV1jMmFsH
         HLgYil+3DkGusl593ZglXIa53KUF2SSFBBC6pTT0tx0bTjgIGy+PSMnKTCCOqXcExz
         7Enr7HlVZDTCrOR46Pzvd7VNv6Y8vupv2Y7AKAbdVoiP1BYwRAKkirVH91HhBR11TV
         DPjHTdMgAXAHVKWWYJVj3fcC23WefrjIoP1RPCIPi6xFjIThc5AWpF5anO/tL30xwU
         4Vki12++ZYnFw==
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
Message-ID: <20201207225542.GM2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <87blf547d2.fsf@nanos.tec.linutronix.de>
 <20201207223853.GL2657@paulmck-ThinkPad-P72>
 <878sa944kn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sa944kn.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:46:48PM +0100, Thomas Gleixner wrote:
> On Mon, Dec 07 2020 at 14:38, Paul E. McKenney wrote:
> 
> > On Mon, Dec 07, 2020 at 10:46:33PM +0100, Thomas Gleixner wrote:
> >> On Mon, Dec 07 2020 at 11:44, Paul E. McKenney wrote:
> >> > On Mon, Dec 07, 2020 at 07:19:51PM +0100, Marco Elver wrote:
> >> >> On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >> I currently don't know what the rule for Peter's preferred variant
> >> >> would be, without running the risk of some accidentally data_race()'d
> >> >> accesses.
> >> >> 
> >> >> Thoughts?
> >> >
> >> > I am also concerned about inadvertently covering code with data_race().
> >> >
> >> > Also, in this particular case, why data_race() rather than READ_ONCE()?
> >> > Do we really expect the compiler to be able to optimize this case
> >> > significantly without READ_ONCE()?
> >> 
> >> That was your suggestion a week or so ago :)
> >
> > You expected my suggestion to change?  ;-)
> 
> Your suggestion was data_race() IIRC but I might have lost track in that
> conversation.

OK, I am inconsistent after all.  I would have suggested READ_ONCE() given
no difference between them, so it is probably best to assume that there is
(or at least was) a good reason for data_race() instead of READ_ONCE().
Couldn't tell you what it might be, though.  :-/

							Thanx, Paul
