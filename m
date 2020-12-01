Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098FF2CA0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgLALDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLALDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:03:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1DC0613CF;
        Tue,  1 Dec 2020 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2SCn4JlSamV69DOhuHkaaHHDkWdEHLNroHw+GqxnhKA=; b=IxI289gjll//VzkPWqs5LPvNE7
        ME07sDg+BNtzea65e0vyN3kdjectclnL4YJH1mPUBQRHoeQH8IR9azDTK+QsJye0iP1xfdhnlIYEs
        utLBzHWcyFJhsnsrLrHGKDsOREGA/8U7YUsHEYTNS3iHk1CMof/8B/PK85vp1Geu2Q7IZI+XB6yT4
        MOkhducVVGX4cyO5vSROAyB6hVQnWnjNKYim8nLvfYVbDv2Vta+6uViXo6SFYERJjel5ihTu1Sfse
        h+1nhSUAcNBfmm73Mp6WwCWd2pXZN43hrW6IAvkQiQa6tWKRSfvOMayn53+x/9jS1enhlAOrOprjH
        QF/QbveA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk3QB-0007Cn-Vn; Tue, 01 Dec 2020 11:02:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57DC13059DD;
        Tue,  1 Dec 2020 12:02:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38E122BE3991C; Tue,  1 Dec 2020 12:02:09 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:02:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org,
        x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
 <20201130210003.GA40619@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130210003.GA40619@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> > We call arch_cpu_idle() with RCU disabled, but then use
> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > 
> > Switch all arch_cpu_idle() implementations to use
> > raw_local_irq_{en,dis}able() and carefully manage the
> > lockdep,rcu,tracing state like we do in entry.
> > 
> > (XXX: we really should change arch_cpu_idle() to not return with
> > interrupts enabled)
> > 
> 
> Has this patch been tested on s390 ? Reason for asking is that it causes
> all my s390 emulations to crash. Reverting it fixes the problem.

My understanding is that it changes the error on s390. Previously it
would complain about the local_irq_enable() in arch_cpu_idle(), now it
complains when taking an interrupt during idle.

