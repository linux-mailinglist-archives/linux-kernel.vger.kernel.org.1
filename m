Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0D2B939D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKSNZc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 08:25:32 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:51519 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726474AbgKSNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:25:31 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23042097-1500050 
        for multiple; Thu, 19 Nov 2020 13:25:13 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201119130244.GN3121392@hirez.programming.kicks-ass.net>
References: <1185a97a-3780-3bce-d97d-ff9c2830e35d@gmail.com> <20201119130244.GN3121392@hirez.programming.kicks-ass.net>
Subject: Re: Deadlock cpuctx_mutex / pmus_lock / &mm->mmap_lock#2
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 19 Nov 2020 13:25:11 +0000
Message-ID: <160579231162.30679.12645532537616868812@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Zijlstra (2020-11-19 13:02:44)
> 
> Chris, I suspect this is due to i915 calling stop machine with all sorts
> of locks held. Is there anything to be done about this? stop_machine()
> is really nasty to begin with.
> 
> What problem is it typing to solve?

If there is any concurrent access through a PCI bar (that is exported to
userspace via mmap) as the GTT is updated, results in undefined HW
behaviour (where that is not limited to users writing to other system
pages).

stop_machine() is the most foolproof method we know that works.

This particular cycle is easy to break by moving the copy_to_user to
after releasing perf_event_ctx_unlock in perf_read().
-Chris
