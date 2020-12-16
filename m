Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00522DBC87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgLPIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:20:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53FEC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tvyQmXVAfz/2Lo0TusD+HjU56ZhaWL40OiopO9KNh5E=; b=bJZuXljBeUOrUVDuXapuedCsWh
        zEcQdPTTbqJfErYR6TjMoTW+obBa/GOqhSjrYQQVpRANcqrzhd9DwaPQ10ZihOypr3Auci0Vl06Wr
        PiXfLVkFmMiM5R2k20KvnjLR/D09v+zqTU9Fl//p5BTCMJONb73gZkC3i1HkYb6FopgwnE0EepV1I
        0wpwiYuZlKTL0NlNGWtWW+Puf2oXlimaItx/Z83/yDLfSjZxZjmfUwQaAu61bPABnQguV8atODOj9
        lQx6rtRilr+uaAPOvWm6CmujRU+n2FtruMnjUhLE70dSsE+AQPUeN2xK3epjumPm0DogPCybUwY0O
        v0t6909Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpS1c-000410-Os; Wed, 16 Dec 2020 08:19:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A17304D58;
        Wed, 16 Dec 2020 09:19:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC8B2203C64AC; Wed, 16 Dec 2020 09:19:04 +0100 (CET)
Date:   Wed, 16 Dec 2020 09:19:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
Message-ID: <20201216081904.GK3040@hirez.programming.kicks-ass.net>
References: <20201215104400.9435-1-anna-maria@linutronix.de>
 <20201215111806.GF3040@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.2012151449260.1448@somnus>
 <20201215093415.5b2898ef@gandalf.local.home>
 <20201215150529.GI3040@hirez.programming.kicks-ass.net>
 <87mtyft0r2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtyft0r2.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 06:52:49PM +0100, Thomas Gleixner wrote:
> I might be missing something, but how is the CPU which runs the pinned
> kernel thread, i.e. the hotplug thread, supposed to go idle between the
> two calls?

Take a mutex or something other daft. My disabling preemption around it
we basically assert the two functions are non-blocking and none of that
cruft matters.
