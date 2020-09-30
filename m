Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6127E4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgI3JQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgI3JQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:16:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57813C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M6aSBYvGHo03lIPgNtm+kwvXZmpfk2pg59CPFNzwty0=; b=icH7K6VMYF8vH0gXWgUsJCKLBp
        ReBrW3MdQyvFtCIJ2sKmgaqRvE7vhLwcx953JndM4hh7maATNfVZWCcSe4QNpU1bmFA8bvrR7Qtbg
        gnWTxHpQ1xEjkclWjdGCPsmFUmzKpko87A3YI93R8IxMeu25cvEoKsAahS3e9V6tprV5oXcdu13tc
        zdfTgOsZRmmlqgJ4WZVRNPiEjHjoawaLLYbnQOto7XsYxUm1/dTM2sLPwJzsesx0DXgCwplhgNEuF
        F7yPRH6FTGtJhr7tPXZi0tmJY9TPnXAoddTOkQCTBXT6yw2Ufp72OwSnJgg9mGMLKAXs1khU3KyXe
        7NYb97lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNYDc-0005XO-Cc; Wed, 30 Sep 2020 09:16:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1850A3077B1;
        Wed, 30 Sep 2020 11:16:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 052E52022B66B; Wed, 30 Sep 2020 11:16:11 +0200 (CEST)
Date:   Wed, 30 Sep 2020 11:16:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>,
        g@hirez.programming.kicks-ass.net
Cc:     Qian Cai <cai@redhat.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20200930091610.GV2628@hirez.programming.kicks-ass.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:08:23AM +0800, Boqun Feng wrote:
> I think there are two problems here:
> 
> 1) the "(null)" means we don't have the "usage_str" for a usage bit,
> which I think is the LOCK_USED_READ bit introduced by Peter at
> 23870f122768 ('locking/lockdep: Fix "USED" <- "IN-NMI" inversions').
> 
> 2) the next null-ptr-deref, and I think this is also caused by
> LOCK_USED_READ bit, because in the loop inside
> print_lock_class_header(), we iterate from 0 to LOCK_USAGE_STATES (which
> is 4*2 + 3), however the class->usage_traces[] only has
> XXX_LOCK_USAGE_STATES (which is 4*2 + 1) elements, so if we have
> LOCK_USED_READ bit set in ->usage_mask, we will try to access an element
> out of the ->usage_traces[] array.
> 
> Probably the following helps? And another possible fix is to enlarge the
> ->usage_trace[] array and record the call trace of LOCK_READ_USED.

Urgh.. yeah, I wanted to avoid saving that trace; it's pretty useless :/
The existing USED trace is already mostly pointless, the consistent
thing would be to remove both but that might be too radical.

But you're right in that I made a right mess of it. Not sure what's
best here.

Let me have a play.
