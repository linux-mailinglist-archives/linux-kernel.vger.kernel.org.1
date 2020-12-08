Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A12D256E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLHIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgLHIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:12:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEDC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8wGUeauYQffXI8deK/t5tpiJqZQbKQ3feyEVhMUeoio=; b=UEP2qNx2yuGrgBZuyUqqIknCDM
        bunAcbBJmvpuvxgrv4RaBxQlYji19+2pO7V9vqrV+lyA236b34edtdd6ev/43ZJXnoGUS7KQcOxXI
        gGhCIDw/DJISC2r0k64rbr6bRG8asqyKv5TkCjLdpj5VYhCaUUBZLO+pK3NUrNqHrEVmx7cadj9Fw
        rvQKg/4WxlRRcSOCOd6nDH5ABfvEMEQnJc+82eWYaBWtIE4IDMFpQ53RyAoQagdd/QzQM9FFIPy4b
        mILUSeiWH6r3TlM6yCx58S7T/hVU+p8cHuhUbPOTewoTF65iXUfawV8B8ErVXrecd4iVmSV932Dp8
        gI0CeVKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmY5r-0004Vv-5b; Tue, 08 Dec 2020 08:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6347304B92;
        Tue,  8 Dec 2020 09:11:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA68B200AABB6; Tue,  8 Dec 2020 09:11:29 +0100 (CET)
Date:   Tue, 8 Dec 2020 09:11:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207194406.GK2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:44:06AM -0800, Paul E. McKenney wrote:

> Also, in this particular case, why data_race() rather than READ_ONCE()?
> Do we really expect the compiler to be able to optimize this case
> significantly without READ_ONCE()?

It's about intent and how the code reads. READ_ONCE() is something
completely different from data_race(). data_race() is correct here.


