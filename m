Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB142DCFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgLQKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:49:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A98C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjyTgh1UagQyigQH76YaZvKk8RwMBB2TgkJohxIQuyM=; b=l9KCtMAy5kxRoMpWLeg9XlIe+E
        omw46H1JH2Jz//PSHgGwA4XA8O0CInyPUP5XIow6pn/Dh2EAP8ZFpaQAWmb3aZ/ugpJXumLazxycG
        qzuIQPhlZPuZuHIKzrF2Q6qpqV6Fa6O0nI8hi63/EvSL6yvg+PPl11c4/cX91lU6JfAy71vwtwRrb
        Qa205lZoSMctNZI36yCM4ksw9Vymkh/C+JhkLSmWPe2cbVipN3SUo+DEgyWvmZqh/mHw/B29awQk4
        uWw8HAWPSJopy8dFcrhMC23mmSjCKr/vNkYqFb/+zAiOS9lM52g+v7AvvznLo2QYvHzb3OFE8bi9a
        7Ic2VsZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpqpc-0003jS-TP; Thu, 17 Dec 2020 10:48:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6250B300446;
        Thu, 17 Dec 2020 11:48:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44297202395BD; Thu, 17 Dec 2020 11:48:23 +0100 (CET)
Date:   Thu, 17 Dec 2020 11:48:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
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
Message-ID: <20201217104823.GU3040@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
 <20201208150309.GP2657@paulmck-ThinkPad-P72>
 <873606tx1c.fsf@nanos.tec.linutronix.de>
 <20201216211931.GL2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216211931.GL2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 01:19:31PM -0800, Paul E. McKenney wrote:
> Given that there is no optimization potential, then the main reason to use
> data_race() instead of *_ONCE() is to prevent KCSAN from considering the
> accesses when looking for data races.  But that is mostly for debugging
> accesses, in cases when these accesses are not really part of the
> concurrent algorithm.
> 
> So if I understand the situation correctly, I would be using *ONCE().

Huh, what, why?

The code doesn't need READ_ONCE(), it merely wants to tell kasan that
the race it observes is fine and as to please shut up.

IOW data_race() is accurate and right.
