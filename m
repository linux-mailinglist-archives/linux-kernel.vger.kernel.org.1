Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257AE2CD565
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbgLCMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgLCMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:21:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDEC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9zUFKXJHVhzH96g7NGAMXYc3BeOdBcaev2tbX+KB8xI=; b=p1A0qtoGwppA7hWqxk6zCAqS3B
        T+wfwCgYISmVnf262FjCDRsHKJNrqiygpHpZcr/a2TLJ8KOsGqgYhBotigDnPlIIdk4wC/9x7I8FO
        KnF6mp+L65rIDbvAvSB0D5rVgUa/y1msESPBtnohJgIELeuC5hQXltL5Q451x8z/mQdc5RZcIjQoC
        6MU8K7gDpzLckYfGn8FReUiwnUpZbLMwWV/hRVN1VoLGtP8BbXOyhAiWpmvwt+kDXcwcmNrdPh0I4
        UR97WFDNYwW/CdoBzJN5hNUfHC+mor17yt8SftEjRINksVHGdk+uJgXz2SmKCAHqB0NBsqGBiqloX
        lBLjbPHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kknbG-0006e1-6M; Thu, 03 Dec 2020 12:20:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99C783059DD;
        Thu,  3 Dec 2020 13:20:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A9EB235F86BC; Thu,  3 Dec 2020 13:20:40 +0100 (CET)
Date:   Thu, 3 Dec 2020 13:20:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Message-ID: <20201203122040.GO3021@hirez.programming.kicks-ass.net>
References: <20201202150205.35750-1-namhyung@kernel.org>
 <20201202192828.GG1363814@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202192828.GG1363814@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:28:28AM -0800, Andi Kleen wrote:
> > +	prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > +	next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > +
> > +	if (prev_cgrp != next_cgrp)
> > +		perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> 
> Seems to be the perf cgroup only, not all cgroups.
> That's a big difference and needs to be documented properly.

With cgroup-v2 that's all the same, no?
