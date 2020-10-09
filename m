Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458A12889AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbgJINWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgJINWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:22:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BEC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PYKYqLB0Wzf3RykMPh7P82enY7iDUz5TB2tQwrLLoHM=; b=dEDUYlR22NXXj1Ju3qdkDwuNLQ
        NPxXI3vllUR9qF05tkD42RBsnKOWxOU++pHrG0KGZUx3W0Uogidl/4YoJQZK7QOuzpdShCcrm/TdP
        txa2eZ553x3np9c8IwG43wyvpmygGLy6i1O1OWYmv6SSbgXwRxsRn2cMR9fpbuJ1OGFcGkjjqt7hA
        RpDpBOSdKdQ57/XNtxjsq4m4vn6gf7urZvMIz188o1FD6V25d2O3IKaD+uMlZlHQqldTpNpesh4K8
        rMnLHC4s6YpD9HW2e72cZ62CgvMJWzuAHxDEOongQ3rXfZPHDKtNVpLWPPPePoxOGH90jTugkqTcw
        xcpGkDiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQsM4-0001uM-SB; Fri, 09 Oct 2020 13:22:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B992E301A42;
        Fri,  9 Oct 2020 15:22:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90CF22B774830; Fri,  9 Oct 2020 15:22:39 +0200 (CEST)
Date:   Fri, 9 Oct 2020 15:22:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/5] allow overriding default preempt mode from
 command line
Message-ID: <20201009132239.GP2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
 <20201009125056.GN2628@hirez.programming.kicks-ass.net>
 <20201009130344.GN4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009130344.GN4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:03:44PM +0200, Michal Hocko wrote:
> On Fri 09-10-20 14:50:56, Peter Zijlstra wrote:
> > 
> > Can you please not thread the new series onto the old one? That's some
> > seriously annoying behaviour that I see more and more... It makes me
> > loose whole patch-sets.
> 
> Sure, no problem. This is not really unusual in mm and I personally
> prefer to have discussion in a single thread rather than separated in
> two or more. But I definitely do not insist of course. It is surprising
> that you are losing the whole patchset as the threading seems to be done
> properly. Mutt doesn't seem to have problems with that.

I often sort by thread and date and look at the recent most threads.
Mutt sorts threads by first post, not most recent post, hence the thread
is 'lost'.

> Anyway, let me know if I should repost.

I've already broken the thread (#), no need to repost.
