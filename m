Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3012BAC1C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKTOoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgKTOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:44:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zVm/SCH2gW0dx0JpynqROEWKXznlIIRkjjY5i7qnbLY=; b=jzP5MyELNOdaH5GRCvIj34NPLI
        mKZx9Hc3lTj2VoOl3bxQmM/kecr1Q6k+y1jKQC8r8QqW97rqrTFkRcu3As+zn7A1M+dDBRlaDPyRF
        IOJDxxc1pM+hdgX/VUrxeSws7srRH9J/YLZ6VYpAWPheSLyhwC+kY7UnR7DStttsoPcOuK7neD17N
        UTSLGZEftJNf9EhMqyGHEeYj6caIXc2b//Qb7IK3oqs7WC6KE6EEEutTRuPVrH6k35p5m8nwsutoD
        H480BGUJO40BWE+f4opPk/C5Gyrffyz39MUO4/TTu2jpSAQc41x7l2ruvidwoMhFsCXxSW/FJwz6S
        ikoN67Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg7dy-0007W0-Fi; Fri, 20 Nov 2020 14:44:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93D25300B22;
        Fri, 20 Nov 2020 15:44:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86103201B4C51; Fri, 20 Nov 2020 15:44:08 +0100 (CET)
Date:   Fri, 20 Nov 2020 15:44:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Message-ID: <20201120144408.GF3040@hirez.programming.kicks-ass.net>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:35:56PM -0800, Davidlohr Bueso wrote:
> On Tue, 17 Nov 2020, Waiman Long wrote:
> 
> > The column "CS Load" represents the number of pause instructions issued
> > in the locking critical section. A CS load of 1 is extremely short and
> > is not likey in real situations. A load of 20 (moderate) and 100 (long)
> > are more realistic.
> > 
> > It can be seen that the previous patches in this series have reduced
> > performance in general except in highly contended cases with moderate
> > or long critical sections that performance improves a bit. This change
> > is mostly caused by the "Prevent potential lock starvation" patch that
> > reduce reader optimistic spinning and hence reduce reader fragmentation.
> > 
> > The patch that further limit reader optimistic spinning doesn't seem to
> > have too much impact on overall performance as shown in the benchmark
> > data.
> > 
> > The patch that disables reader optimistic spinning shows reduced
> > performance at lightly loaded cases, but comparable or slightly better
> > performance on with heavier contention.
> 
> I'm not overly worried about the lightly loaded cases here as the users
> (mostly thinking mmap_sem) most likely won't care for real workloads,
> not, ie: will-it-scale type things.
> 
> So at SUSE we also ran into this very same problem with reader optimistic
> spinning and considering the fragmentation went with disabling it, much
> like this patch - but without the reader optimistic lock stealing bits
> you have. So far nothing has really shown to fall out in our performance
> automation. And per your data a single reader spinner does not seem to be
> worth the added complexity of keeping reader spinning vs ripping it out.

I'm fine with ripping it... It was finnicky to begin with.
