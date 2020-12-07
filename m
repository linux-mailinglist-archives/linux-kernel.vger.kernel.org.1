Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696392D1022
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgLGMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLGMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:10:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83273C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BbTSzr0ekrkrwUMtMIVfByGKajgzqxX+9tYinOrH+wI=; b=Ob9akebTGAMG8y7oW+eJRc4sl1
        93P/BxcpZ/dtnKpq6iJQenFcW1a+fDFFbcG10H+UHcU0KUpWdYf+Qw6cPnCYqdNSS/kzkCgodzt1m
        nFIF7xYvbpKcWyL0Wp1agANSbPP9r/K593EJ2vLMHamXRBBNeGSBvKHKpmzyDl0Wdm4Ha7M01TYNJ
        SJ8+gzTIBHORQkgm7RGfC0eY6HcM9YCPn9ONonBmFaN2qXXdzGG/zglHnNTyxzbsxRhBQi3ZybeY7
        tCK727rrldmksbFIi/zn8hSCGXtwO9KREMm+hKZ3jC7ud2c3KjpuJkqW++HDA1qltFY8DBmcdXshq
        zpTtRTCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmFKs-0001ZN-8N; Mon, 07 Dec 2020 12:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4703304D28;
        Mon,  7 Dec 2020 13:09:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8A1020812B4B; Mon,  7 Dec 2020 13:09:43 +0100 (CET)
Date:   Mon, 7 Dec 2020 13:09:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20201207120943.GS3021@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206212002.876987748@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 10:12:56PM +0100, Thomas Gleixner wrote:
> +		if (data_race(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {

I prefer the form:

	if (data_race(tick_do_timer_cpu == TICK_DO_TIMER_BOOT)) {

But there doesn't yet seem to be sufficient data_race() usage in the
kernel to see which of the forms is preferred. Do we want to bike-shed
this now and document the outcome somewhere?
