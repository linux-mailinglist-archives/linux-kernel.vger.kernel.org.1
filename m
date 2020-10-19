Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD37C292D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgJSSeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgJSSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:34:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE2BC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=awaro1Pgqhj5bDOkMFLxC0bLfUUjl96PTd5xBeWJe60=; b=JLwjjZQuhZO2sh1bgH8zFvyOL/
        ZbjfyzkXG1XGWEAgqXry+JCr3q2NMbiWtMkGe2ujsyaMIQLDMDCHs3AZS9xYKtrqkrey4sZ8JGNoW
        purkenZqklrEF/qIXnJ3GnNU1WLKs4qsQjzv8sk5vHlwdbwgCgSpUIZKhPgZoPLS35FdSMVilo86V
        lAngJdImitanG4EpI1dXzyEfggEhKVQOo7SIQlXogY4vM+vT9Sr6Z3k4bgM12P/j2OCt2BnVo9wPd
        8HCrpZ0R2y/xrmqJK2FsaiPT8r+wMwD8EfB6H56Z+4rhCRKTwIlT6H2Ioyq1D3re2IHTdHvMRgZT6
        dfJVRgTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUZyq-0003KF-GW; Mon, 19 Oct 2020 18:34:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE28B300DAE;
        Mon, 19 Oct 2020 20:33:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2FE320414E59; Mon, 19 Oct 2020 20:33:55 +0200 (CEST)
Date:   Mon, 19 Oct 2020 20:33:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, philip.li@intel.com
Subject: Re: 4d004099a6 ("lockdep: Fix lockdep recursion"):  BUG: using
 __this_cpu_read() in preemptible [00000000] code: trinity-c6/526
Message-ID: <20201019183355.GS2611@hirez.programming.kicks-ass.net>
References: <5f8dc512.pzfR1ahTGDOChwCh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8dc512.pzfR1ahTGDOChwCh%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:55:46AM +0800, kernel test robot wrote:
> [   92.898145] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c6/526

> [   92.903305] Call Trace:
> [   92.905182]  __this_cpu_preempt_check+0xf/0x11
> [   92.905968]  lockdep_hardirqs_on_prepare+0x2c/0x18f
> [   92.906853]  trace_hardirqs_on+0x49/0x53
> [   92.907578]  __bad_area_nosemaphore+0x3a/0x134

Hurph, that's a spurious local_irq_enable(). I suppose this'll fix it.

---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfef8408..9f818145ef7d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4057,9 +4057,6 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
-		return;
-
 	if (unlikely(lockdep_hardirqs_enabled())) {
 		/*
 		 * Neither irq nor preemption are disabled here
@@ -4070,6 +4067,9 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 		return;
 	}
 
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
+		return;
+
 	/*
 	 * We're enabling irqs and according to our state above irqs weren't
 	 * already enabled, yet we find the hardware thinks they are in fact
@@ -4126,9 +4126,6 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
-		return;
-
 	if (lockdep_hardirqs_enabled()) {
 		/*
 		 * Neither irq nor preemption are disabled here
@@ -4139,6 +4136,9 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		return;
 	}
 
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
+		return;
+
 	/*
 	 * We're enabling irqs and according to our state above irqs weren't
 	 * already enabled, yet we find the hardware thinks they are in fact
