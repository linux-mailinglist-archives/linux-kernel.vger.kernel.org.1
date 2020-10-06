Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7540284CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJFNum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:50:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWSicsUkOLd+NrAhxw/4TTPErnmmPc99/9X07B2SMTc=; b=OnsvslPRyYU8NFZbHXgNmUgXKL
        odLPfnAdz6bGAJi/f1h3twz3m+ASB22bNaLvEva9i0G7CnQDoyx1pScZ86BIUnFL5ItGsE/kljy7E
        yDTRIEIqHbw+/3NdjqUXm6AgKSQDDh7yejmvhDbg18tuZ9ZeLhylnKGpI7NgoTOLs8/BznlJeVZOR
        UOkuAtsFY/TCb1/tddGL3viKvO2AHwD+4CZ7e8Ou+1mFp3clh2PyCtEARGMCTNzekJhOePkWeqlcG
        uMHnOpmoAKJgdhO1E8vyO9PFQvX1E57WcwxYJPsymjg91OOVNcjwO5SWUu41V2ymumc67Hn1jUvBF
        CCZsOyrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPnMI-00039k-Nf; Tue, 06 Oct 2020 13:50:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4F673011C6;
        Tue,  6 Oct 2020 15:50:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6F732B82AF21; Tue,  6 Oct 2020 15:50:25 +0200 (CEST)
Date:   Tue, 6 Oct 2020 15:50:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201006135025.GW2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <20201006075939.GL2628@hirez.programming.kicks-ass.net>
 <20201006094445.09c8b3b9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006094445.09c8b3b9@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:44:45AM -0400, Steven Rostedt wrote:
> As I've always said. When dealing with real-time systems, you need to be
> careful about how you organize your tasks. Ideally, any RT task that is
> pinned to a CPU shouldn't be sharing that CPU with anything else that may
> be critical.

Due to locks we're always sharing.. :-)
