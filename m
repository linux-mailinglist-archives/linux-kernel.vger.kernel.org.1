Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D827F2D1DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgLGWrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:47:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLGWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:47:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607381209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DF7s5pk4Zw7F4Z2nppe0ZuFvyidXGsr6pkOHRZYg040=;
        b=z6h2Skd6Npw6+UOW47F4wiFBtAPxZNXBfKkjPDYXIY+em1Iu2EMMtdlgJLp7nq3MeQzG8h
        oFy82ZG6DqhcJ0rM6YSXZhSdU9a71vzi2Ure7bmyfXdSTcjVKxczPBqNAkwpA7LzUfuIYj
        Xk+SzGF56zatuASCFWXgzX/MShBS3Gcykho5iu91a+Z6A5hAIF70N6VsPW15PCY5xSMh20
        r67/fp2pdSG0ZXaGCniMWypCTCsCB92q+003FtxmjZsVwa4/DbdJMAC7EaAXsN6rj9zUmG
        XkCEeTlCLiGhO9Xf8uf4I9v1TlZ5RAbFzjExcVQDasbU+HMt/4qlw0W1beTuEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607381209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DF7s5pk4Zw7F4Z2nppe0ZuFvyidXGsr6pkOHRZYg040=;
        b=CeWqBvqQZSg4eFg2hQfpVHwHizWRr6ZhqODicAjGwNBL3A0aqsxbjIyBNu8+zte/q6gaBW
        frVmiJRylI/MBICA==
To:     paulmck@kernel.org
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
In-Reply-To: <20201207223853.GL2657@paulmck-ThinkPad-P72>
References: <20201206211253.919834182@linutronix.de> <20201206212002.876987748@linutronix.de> <20201207120943.GS3021@hirez.programming.kicks-ass.net> <87y2i94igo.fsf@nanos.tec.linutronix.de> <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com> <20201207194406.GK2657@paulmck-ThinkPad-P72> <87blf547d2.fsf@nanos.tec.linutronix.de> <20201207223853.GL2657@paulmck-ThinkPad-P72>
Date:   Mon, 07 Dec 2020 23:46:48 +0100
Message-ID: <878sa944kn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 14:38, Paul E. McKenney wrote:

> On Mon, Dec 07, 2020 at 10:46:33PM +0100, Thomas Gleixner wrote:
>> On Mon, Dec 07 2020 at 11:44, Paul E. McKenney wrote:
>> > On Mon, Dec 07, 2020 at 07:19:51PM +0100, Marco Elver wrote:
>> >> On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> I currently don't know what the rule for Peter's preferred variant
>> >> would be, without running the risk of some accidentally data_race()'d
>> >> accesses.
>> >> 
>> >> Thoughts?
>> >
>> > I am also concerned about inadvertently covering code with data_race().
>> >
>> > Also, in this particular case, why data_race() rather than READ_ONCE()?
>> > Do we really expect the compiler to be able to optimize this case
>> > significantly without READ_ONCE()?
>> 
>> That was your suggestion a week or so ago :)
>
> You expected my suggestion to change?  ;-)

Your suggestion was data_race() IIRC but I might have lost track in that
conversation.
