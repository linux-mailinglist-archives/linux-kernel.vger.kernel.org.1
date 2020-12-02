Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651022CC2EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgLBQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbgLBQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ICIwPScTyOPZq1IRDrxDK6jQadAjeRRdxNuGb4ptO54=; b=hEra2LQkMd7pHsBhc94ZlRee+N
        r+MbLw+7AOyVtZRHp1hllkiEmuTAXk44X3AR8e06WG//oBn9OiI7Pv17og3jl/RMDrnO4RbKK4PK0
        J4TzmMbpnFgpZeExrgRzmpd8YMgmpFwC8ehkHhmEdS1rY5uE9yS3z0PSh2r8iPlrKwSI9nE5tR44Q
        xxUAedGKzoyE/4VFObMrMjFSjmUmYWpgnsWKcDQr0hRVzq3LU2BPLqlFLQ894jf9YIgudG20ET4PA
        pLMawVi0FwaKfgMAiPRejOcDIxfFRN085PhzLXOAZqio9EaR0H2lkQjHeC0JVLMf/HaPIUaJb6vtY
        L5GlGLvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkVSY-0005Kk-F9; Wed, 02 Dec 2020 16:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D637305E21;
        Wed,  2 Dec 2020 17:58:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2A59201BAA71; Wed,  2 Dec 2020 17:58:28 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:58:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com,
        qperret@google.com, viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201202165828.GC2414@hirez.programming.kicks-ass.net>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201202141835.GY3306@suse.de>
 <20201202155452.GK3021@hirez.programming.kicks-ass.net>
 <20201202164531.GA3306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202164531.GA3306@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:45:31PM +0000, Mel Gorman wrote:

> > > It's less obvious what the consequence is unless the reader manages to
> > > tie the IO-wait comment in "Schedutil / DVFS" to this section.
> > 
> > I'm not entirely sure I follow. The purpose of UTIL_EST is to avoid
> > ramp-up issues and isn't related to IO-wait boosting.
> > 
> 
> I mixed up the example. Historically io-wait boosting was one way of
> avoiding DVFS ramp-up issues but now that I reread it, it's best to leave
> it general like you already have in your current version.

So IO-wait boosting is an interesting case; as it captures something not
present in the rest of the model, namely interaction.

There's also that series of patches that does the cpu/gpu interaction
thing.

It would be worth expanding on it, but I didn't have it in me to dig
through the archives to get a coherent description of the current state
of things. Something left todo later...
