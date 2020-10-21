Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48744294C74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411679AbgJUMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411613AbgJUMUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:20:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B947EC0613CE;
        Wed, 21 Oct 2020 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hsnXQecX6kCtiiedXylMT/pwt2lPiF3DvQvxAo7NxUc=; b=YJBEdH4RgUxynHiucqfi042ohU
        j1kbmQoa2VWVFpmFYjz0BUM+jddWyWvrqLI+6RcuQUaMPpKpQ3iRfmPdFpEoKat2POKpv7FrE88tL
        fXEDv1lqBOn3goaqX3G7ACKU3Ix3u3nUbCvvpgWQXPghmbocxPRvJKbd9Ow38sFQpfSZ64kzHUPyf
        kyvY3mf7gcjeyXPb/gOkYd5TW+gwUKE+flKHJAof2T4JlnsWdGVPcMGuloJOdtiHGD/jdu8WfyU1C
        LGX/1p6V9ryaNgHkeQkNmMptTwEexVFar17/E72fbIgqrlz+9t67D1/Vh3uUSwn72cydob7cl50UU
        vdS3Ybqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVD5u-0002d0-TD; Wed, 21 Oct 2020 12:19:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7BC1304BAE;
        Wed, 21 Oct 2020 14:19:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 718E2203CC49D; Wed, 21 Oct 2020 14:19:50 +0200 (CEST)
Date:   Wed, 21 Oct 2020 14:19:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021121950.GF2628@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <alpine.DEB.2.22.394.2010211336410.8475@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2010211336410.8475@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> Prior to 5.8, my machine was using intel_pstate and had few background
> tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> the kernel decided that intel_cpufreq would be more appropriate, which
> introduced kworkers every 0.004 seconds on all cores.

That still doesn't make any sense. Are you running the legacy on-demand
thing or something?

Rafael, Srinivas, Viresh, how come it defaults to that?
