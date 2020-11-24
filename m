Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB92C2940
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbgKXOTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgKXOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:19:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9EBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l8pZFbiEFpxPq1yQcg1bSYzCbo66wT2t3iINfeAQesk=; b=SJCrPpWUUyKm9dIXarGTf7mlvF
        4a6hQiQ79QjZ/AFqAzD2NUK49sf9CU7pRsnLh4g5u/etlfoFVjvXVOVNVUek4sySrjgj7gY9mNMqd
        fx4f07hl5R+Ev5gE4Ry2yvRQK7AYANeT8H4dqfAdlDKYdBJ81SSIUZawwiP8Y4k7kej4HJOlVTszr
        9ADUalDq1moioRmvaL0Soc+h0BL/jEn5wZuAFUu4ziQcASoM5oo5OZeuuFK64jsl/JHC3PRDMWPKk
        pcw5MN0pkg2fzQZP2nRSezKTkJFdEcm1Y9a53D8JaGuS4s3sXZGM9GIktMyxY/u3k2yPWKVSdb9P7
        3vml/ZwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khZ9i-0002uB-AJ; Tue, 24 Nov 2020 14:18:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 476313062EA;
        Tue, 24 Nov 2020 15:18:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 287D7209BAB75; Tue, 24 Nov 2020 15:18:53 +0100 (CET)
Date:   Tue, 24 Nov 2020 15:18:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org,
        x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] More RCU vs idle fixes
Message-ID: <20201124141853.GG2414@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <yt9dv9du7tow.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dv9du7tow.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:47:27PM +0100, Sven Schnelle wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Both arm64 and s390 are tripping over arch_cpu_idle() RCU,tracing,lockdep
> > interaction. While looking at that I also found fail in inte_idle.
> >
> > Please consider for this cycle.
> 
> Is anyone taking this patchset?

I think I'll stuff it in x86/urgent for lack of a better place.

> For s390, we also need to change the
> local_irq_safe/restore to the raw variants in enabled_wait() in
> arch/s390/kernel/idle.c.

Duh, I'll add that.



