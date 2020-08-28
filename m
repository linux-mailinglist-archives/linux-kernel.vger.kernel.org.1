Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E49255640
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgH1ITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1ITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:19:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF79C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NxdbOY70mCwnzqfUQdLkryP0Ss6jF6+w5CM4jdheeU0=; b=Q5d0a9VUPUoK43jNXOUDekTcKH
        MdEsb/8mz6VjEdKeCu+tuxC3ETTCAM7uDRSTGQrNMQDWs0YrbtayBF+mAsE1cJooM0NxWwCXaZqua
        GflmHqyP6Ik/ff2cU2UK3u6s8oz0LjYBsKz9t/B1gJVrfz8oJGncO4qtAJVSOEDuGzSunjqPaMUQt
        6yJ4A5Bw6Eg46pCcDsiJDldNsVBK32R5b0nL5llc4NgAhze9iTpxMStLP/jBMRL0WDbalpGGu7WWy
        Vbc+kHqahKj3BJx6QREoax6nqknEOz0yxXxNCQRy5mLyhjPSvfjtOcQbI0iOAxaysUdaa7BYn6bvP
        0nyf5pJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBZay-0003E0-F2; Fri, 28 Aug 2020 08:18:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2997D305C10;
        Fri, 28 Aug 2020 10:18:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D25552C49BBC1; Fri, 28 Aug 2020 10:18:44 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:18:44 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] seqlock: seqcount_LOCKTYPE_t: Standardize naming
 convention
Message-ID: <20200828081844.GM1362448@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-2-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828010710.5407-2-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:07:06AM +0200, Ahmed S. Darwish wrote:
> At seqlock.h, sequence counters with associated locks are either called
> seqcount_LOCKNAME_t, seqcount_LOCKTYPE_t, or seqcount_locktype_t.
> 
> Standardize on "seqcount_LOCKTYPE_t" for all instances in comments,
> kernel-doc, and SEQCOUNT_LOCKTYPE() generative macro paramters.

> +#define SEQCOUNT_LOCKTYPE(locktype, locktype_t, preemptible, lockmember)	\
> +typedef struct seqcount_##locktype {					\
> +	__SEQ_LOCK(locktype_t	*lock);					\
> +} seqcount_##locktype##_t;						\

Hurmph, so my thinking was that the above 'locktype' is not actually a
type and therefore a misnomer.

But I see your point about it being a bit of a mess.

Would:

 s/LOCKTYPE/LOCKNAME/g
 s/seqcount_locktype_t/seqcount_LOCKNAME_t/g

help? Then we're consistently at: seqcount_LOCKNAME_t, which is a type.

