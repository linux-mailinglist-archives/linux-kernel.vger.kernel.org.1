Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6432B947B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKSOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgKSOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:19:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA55C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zZWyWl1+zmoCv1Ae56Cx4RYi58BAR13Y55z0FyDLujQ=; b=ws0YQEfnxRiHbTg5j913Kc/nSg
        eKkku1LGMqNJrqPceLV4dC2eDvujOMr91xGkMLKRL6J3ZYcEpJVMi5U3+jsBBJ/peYtnhFNVgoiVQ
        uPA3pql374GaGqfr6K1pQf+mI5lzxtXphT2grewwDCbE1Hm2T0/yRmLSxLEOzHRhikDW+/J9Y8mx1
        oHeSwYwTq3NND++5/oppw4r4xp+fOvk4EoY9bO2c0336b7neDrk/r+li460QWTDiboi+gyiETjwRX
        P34LElmwgniZrKBe2AXABZH37KxnoLPlPmAw8J/TgvVrkGpX7Z5ydNWJCjV+ct5VNcltfbKOdUVK1
        GwtiD6jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfkmL-0003Vr-9n; Thu, 19 Nov 2020 14:19:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDCE53011C6;
        Thu, 19 Nov 2020 15:19:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A441D200E0A35; Thu, 19 Nov 2020 15:19:14 +0100 (CET)
Date:   Thu, 19 Nov 2020 15:19:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Deadlock cpuctx_mutex / pmus_lock / &mm->mmap_lock#2
Message-ID: <20201119141914.GO3121392@hirez.programming.kicks-ass.net>
References: <1185a97a-3780-3bce-d97d-ff9c2830e35d@gmail.com>
 <20201119130244.GN3121392@hirez.programming.kicks-ass.net>
 <160579231162.30679.12645532537616868812@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160579231162.30679.12645532537616868812@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:25:11PM +0000, Chris Wilson wrote:
> Quoting Peter Zijlstra (2020-11-19 13:02:44)
> > 
> > Chris, I suspect this is due to i915 calling stop machine with all sorts
> > of locks held. Is there anything to be done about this? stop_machine()
> > is really nasty to begin with.
> > 
> > What problem is it typing to solve?
> 
> If there is any concurrent access through a PCI bar (that is exported to
> userspace via mmap) as the GTT is updated, results in undefined HW
> behaviour (where that is not limited to users writing to other system
> pages).
> 
> stop_machine() is the most foolproof method we know that works.

Sorry, I don't understand. It tries to do what? And why does it need to
do that holding locks.

Really, this is very bad form.

> This particular cycle is easy to break by moving the copy_to_user to
> after releasing perf_event_ctx_unlock in perf_read().

The splat in question is about the ioctl()s, but yeah that too. Not sure
how easy that is. I'm also not sure that'll solve your problem,
cpu_hotplug_lock is a big lock, there's tons of stuff inside.
