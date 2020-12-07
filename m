Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1D2D17C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgLGRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:47:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgLGRr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:47:29 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607363208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afDC03InAXZsSNwfef2vWGfi5DTW9+sgf5g7C6+1NsA=;
        b=OVGEyYBnrdqJ3N9sFPwlQrVzeJHhVqcqrNQs0QQcb/zYkPL75uFBdNWMvCSf0aHat5BQ+2
        WS+sgSAbDcFNFRDd2QVF73wORuMfErYzzzNR2qpn388m7r3qHzYrQAePHAjA4tDMz/Q1rV
        Hr6NZmQQnXcroCax9DkDjOH1SjBcWD3N4rOxDMy/oGzGE9C+eWVcHcXIxeC6Z1k3dZptYA
        D3Moctk8j+C1ecigV1sM46jO9+I7cJvRb4G8gaoAIZMyNRG34jzSmQCKMWuK91vM4KxIV4
        G/k4jubAGTeT6OZGV6AzwZL17w+Om50zQ33bu7ckB+W6FLW22Ge/9QfySJ57xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607363208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afDC03InAXZsSNwfef2vWGfi5DTW9+sgf5g7C6+1NsA=;
        b=LVuezxMdPq/58zrhUDFJlNPYpS7Q4X5cB8etMiMenYAdqOJyFmfYqCSr3bd39bQzH1pEBa
        iLbmIai15q1357CQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
In-Reply-To: <20201207120943.GS3021@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de> <20201206212002.876987748@linutronix.de> <20201207120943.GS3021@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 18:46:47 +0100
Message-ID: <87y2i94igo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 13:09, Peter Zijlstra wrote:
> On Sun, Dec 06, 2020 at 10:12:56PM +0100, Thomas Gleixner wrote:
>> +		if (data_race(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
>
> I prefer the form:
>
> 	if (data_race(tick_do_timer_cpu == TICK_DO_TIMER_BOOT)) {
>
> But there doesn't yet seem to be sufficient data_race() usage in the
> kernel to see which of the forms is preferred. Do we want to bike-shed
> this now and document the outcome somewhere?

Yes please before we get a gazillion of patches changing half of them
half a year from now.

Thanks,

        tglx
