Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82CA27A8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgI1Hke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgI1Hke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:40:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402CFC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PZx4mQcS16vVBWxb5ZhL8PMWQ24KIE04pGNtD7lHIlQ=; b=jKn7dUyU7AqferYYGCoxzFQtDw
        aeLWdIefxPxmcEw31FGzz8fo+q5LLeNm8IhuMgQfR5UwUK3H8KJ6HpP5byeBLAGeQd+rdagb01H7X
        i9i4l4mySKPwiiZyDwQHwnu/Oqi6E5U0pDzN8taUHnhKiFViSijNsVIZtTzAD/MoLWy4mMYCJjJBa
        OKBukZCn1Fyu/cb8M32cT1AaFyKiyPBv04La3ZHP+WmpyyTbG2w7as3agWSHH5AHxLCJsan0PD+49
        CDBd5uzyC5VJ0oTAoEcQrSmGVY+9ABUaAR13r4Dx0XW/iL8xNKLmRhtJo4PLJs91I7PdwENoYQP/x
        6V0ivbXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMnln-0000Kq-IA; Mon, 28 Sep 2020 07:40:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB45B305C16;
        Mon, 28 Sep 2020 09:40:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD2B5200D90B3; Mon, 28 Sep 2020 09:40:20 +0200 (CEST)
Date:   Mon, 28 Sep 2020 09:40:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     psodagud@codeaurora.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        qais.yousef@arm.com, mingo@kernel.org, cai@lca.pw,
        tyhicks@canonical.com, arnd@arndb.de, rameezmustafa@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] measure latency of cpu hotplug path
Message-ID: <20200928074020.GB2611@hirez.programming.kicks-ass.net>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
 <20200924083414.GB1362448@hirez.programming.kicks-ass.net>
 <20200924105823.0e11f2e4@oasis.local.home>
 <75eca1a41e49a199d7aa72be8c5221b3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75eca1a41e49a199d7aa72be8c5221b3@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 07:41:45PM -0700, psodagud@codeaurora.org wrote:
> On 2020-09-24 07:58, Steven Rostedt wrote:
> > On Thu, 24 Sep 2020 10:34:14 +0200
> > peterz@infradead.org wrote:
> > 
> > > On Wed, Sep 23, 2020 at 04:37:44PM -0700, Prasad Sodagudi wrote:
> > > > There are all changes related to cpu hotplug path and would like to seek
> > > > upstream review. These are all patches in Qualcomm downstream kernel
> > > > for a quite long time. First patch sets the rt prioity to hotplug
> > > > task and second patch adds cpuhp trace events.
> > > >
> > > > 1) cpu-hotplug: Always use real time scheduling when hotplugging a CPU
> > > > 2) cpu/hotplug: Add cpuhp_latency trace event
> > > 
> > > Why? Hotplug is a known super slow path. If you care about hotplug
> > > latency you're doing it wrong.
> Hi Peter,
> 
> [PATCH 1/2] cpu/hotplug: Add cpuhp_latency trace event -
> 1)	Tracing of the cpuhp operation is important to find whether upstream
> changes or out of tree modules(or firmware changes) caused latency
> regression or not.

This is a contradiction in terms, it is impossible to have a latency
regression is you don't care about the latency in this super slow path
to begin with.

> 2)	Secondary cpus are hotplug out during the device suspend and hotplug in
> during the resume.

Indeed they are.

> 3)	firmware(psci calls handling from firmware) changes impact need to be
> tested right?

Firmware is firmware, it's broken by design and we can't fix it if it's
broken. The only sane solution is not having firmware :-)

> 4)	cpu hotplug framework(CPUHP_AP_ONLINE_DYN) dynamic callbacks may impact
> the hotplug latency.

Again, nobody cares.

> [PATCH 2/2] cpu-hotplug: Always use real time scheduling when  hotplugging a
> CPU –
> 
> CPU hotplug operation is stressed and while stress testing with full load on
> the system following problem is observed.
> CPU hotplug operations take place in preemptible context. This leaves the
> hotplugging thread at the mercy of overall system load and CPU
> availability. If the hotplugging thread does not get an opportunity to
> execute after it has already begun a hotplug operation, CPUs can
> end up being stuck in a quasi online state. In the worst case a CPU can be
> stuck in a state where the migration thread is parked while
> another task is executing and changing affinity in a loop. This combination
> can result in unbounded execution time for the running
> task until the hot plugging thread gets the chance to run to complete the
> hotplug operation.

How is that not an administration problem?

Also, you shouldn't be able to change your affinity _to_ a CPU that's
going down. One of the very first steps in hotplug ensures that.
