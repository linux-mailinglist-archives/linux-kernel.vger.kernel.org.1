Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309DB2EC744
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 01:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbhAGASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 19:18:35 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:37180 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAGASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:18:35 -0500
Received: by mail-io1-f44.google.com with SMTP id p187so4499647iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 16:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgrYw6CEb+ECs/AKbPpiobOC3t4eF7B8rST9fAhMs0c=;
        b=FV33cYp6yZN0iCfNf72e7BpJO/rKlQ+wbdflJ2wqvcvHAJ+39KTnRMnO7oa4WN6CeQ
         c74BzBkmkGl8ywyrJZpFZmNIU2KsABQvqBfPupehi8ja5DD0iqveng1qp7ucg6KIHyUO
         jPQavHUGJzASRuw6svBjV/kp2oyvkUPoTndKk7tedriKt1LWMGOrfGZ87m1LglaPxZEg
         yxHv2e1bG2EN1bzTtZvS2HcuBWkoueW9k9Gn8wQPFjr6wkj64V0VM0GDYnZ5MIRIPcXn
         SqcRKoHVBD4hk+EKF5MIXOzQswoMcWE4FDo2DL6TOqTsUQ9CdSKqDZIhjpJnRzfV+ALM
         ehXw==
X-Gm-Message-State: AOAM531zMIXoB7Se2oL/yywpGwznC6vXbXi83T2Ssv17JOHpcytw/8Eq
        YIlvruxLVC9U8oyx1zQAzyhgKVdaMQ==
X-Google-Smtp-Source: ABdhPJxSur2zxumivzuWwijJd/lRHpCe+8V1iSy3qb8ch5Av6rofjze2u3I3BfbAV5wiNhxM6zF5NQ==
X-Received: by 2002:a02:5148:: with SMTP id s69mr5874646jaa.8.1609978673944;
        Wed, 06 Jan 2021 16:17:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y3sm3201908ilc.2.2021.01.06.16.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 16:17:52 -0800 (PST)
Received: (nullmailer pid 3617650 invoked by uid 1000);
        Thu, 07 Jan 2021 00:17:50 -0000
Date:   Wed, 6 Jan 2021 17:17:50 -0700
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v4 2/9] arm64: perf: Enable pmu counter direct access for
 perf event on armv8
Message-ID: <20210107001750.GA2204700@robh.at.kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-3-robh@kernel.org>
 <20201113180633.GE44988@C02TD0UTHF1T.local>
 <20201119191515.GA4906@willie-the-truck>
 <20201120200345.GA1194400@robh.at.kernel.org>
 <20201202145747.GA2381290@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145747.GA2381290@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:57:47AM -0700, Rob Herring wrote:
> On Fri, Nov 20, 2020 at 02:03:45PM -0600, Rob Herring wrote:
> > On Thu, Nov 19, 2020 at 07:15:15PM +0000, Will Deacon wrote:
> > > On Fri, Nov 13, 2020 at 06:06:33PM +0000, Mark Rutland wrote:
> > > > On Thu, Oct 01, 2020 at 09:01:09AM -0500, Rob Herring wrote:
> > > > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > > > +{
> > > > > +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > > > +		return;
> > > > > +
> > > > > +	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > > > > +		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
> > > > > +}

Bump on this again... :)

> > > > 
> > > > I didn't think we kept our mm_cpumask() up-to-date in all cases on
> > > > arm64, so I'm not sure we can use it like this.
> > > > 
> > > > Will, can you confirm either way?
> > > 
> > > We don't update mm_cpumask() as the cost of the atomic showed up in some
> > > benchmarks I did years ago and we've never had any need for the thing anyway
> > > because out TLB invalidation is one or all.
> > 
> > That's good because we're also passing NULL instead of mm which would 
> > crash. So it must be more than it's not up to date, but it's always 0. 
> > It looks like event_mapped on x86 uses mm_cpumask(mm) which I guess was 
> > dropped when copying this code as it didn't work... For reference, the 
> > x86 version of this originated in commit 7911d3f7af14a6.
> > 
> > I'm not clear on why we need to update pmuserenr_el0 here anyways. To 
> > get here userspace has to mmap the event and then unmmap it. If we did 
> > nothing, then counter accesses would not fault until the next context 
> > switch.

Okay, I've come up with a test case where I can trigger this. It's a bit 
convoluted IMO where the thread doing the mmap is different thread from 
reading the counter. Seems like it would be better if we just disabled 
user access if we're not doing calling thread monitoring. We could 
always loosen that restriction later. x86 OTOH was wide open with access 
globally enabled and this hunk of code was part of restricting it some.

> > 
> > If you all have any ideas, I'm all ears. I'm not a scheduler nor perf 
> > hacker. ;)
> 
> Mark, Will, any thoughts on this?

Any reason, this would not work:

static void refresh_pmuserenr(void *mm)
{
	if (mm == current->active_mm)
		perf_switch_user_access(mm);
}

The downside is we'd be doing an IPI on *all* cores for a PMU, not just 
the ones in mm_cpumask() (if that was accurate). But this isn't a fast 
path.

Rob
