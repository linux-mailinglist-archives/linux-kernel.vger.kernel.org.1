Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB5B2BB8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgKTWIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:08:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44968 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKTWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:08:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id f16so10164029otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X7EStfrrK3A2LLJguUTC1OBIwTFPm9D6KESSud0Y9MM=;
        b=NtiQvuiCZ2CCx/7gr6dgZAEcWSno2wYU/SUT5vanzFE6EfuxT+R/eFnqKiwnyLndaF
         LbwcFqNifUZ/5U3u/iHzR6vFlx8LeXef46g9DnWy6t+oMR2l3uK+s7lOR0CG0PhP9GgR
         LaSd6ECEdO0/SIy+N+r/7qrn3YrXqEiWlRAyby4YQl54LVHxAW1PI1xnzJWtIJNWINTg
         3rIreaQUF2KxGIt542oVHnNW4DHXjO0qZ0vcHfl2DbHS5pgFgONNRFZMCFfB+/DFHeCA
         SDLwoDSMmsN+PkftbmL2ZuOUpfVNfJ3pKK+FS3uP6Bb3I7H6oD1+fxhYKetZrynY/tIh
         vo1w==
X-Gm-Message-State: AOAM5319ghXxHQt/kt2KJmO9HQVG1UmzYnWpHhf7jyRVo73X5ueUCfsw
        bRuX5YfAL0JAf9Yvhw/CbQ==
X-Google-Smtp-Source: ABdhPJyHnoMKLYi4UUwlAfdkc5Vt3sQNBQ+SX5K4vzocY+HphsHPI/I1G6RVqmFT1rcfyFEgC6dBrQ==
X-Received: by 2002:a9d:b96:: with SMTP id 22mr6468525oth.295.1605910102349;
        Fri, 20 Nov 2020 14:08:22 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm2384607oif.55.2020.11.20.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 14:08:21 -0800 (PST)
Received: (nullmailer pid 1840593 invoked by uid 1000);
        Fri, 20 Nov 2020 22:08:20 -0000
Date:   Fri, 20 Nov 2020 16:08:20 -0600
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
Message-ID: <20201120220820.GA1802040@robh.at.kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-3-robh@kernel.org>
 <20201113180633.GE44988@C02TD0UTHF1T.local>
 <20201119191515.GA4906@willie-the-truck>
 <20201120200345.GA1194400@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120200345.GA1194400@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:03:45PM -0600, Rob Herring wrote:
> On Thu, Nov 19, 2020 at 07:15:15PM +0000, Will Deacon wrote:
> > On Fri, Nov 13, 2020 at 06:06:33PM +0000, Mark Rutland wrote:
> > > On Thu, Oct 01, 2020 at 09:01:09AM -0500, Rob Herring wrote:
> > > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > > +{
> > > > +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > > +		return;
> > > > +
> > > > +	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > > > +		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
> > > > +}
> > > 
> > > I didn't think we kept our mm_cpumask() up-to-date in all cases on
> > > arm64, so I'm not sure we can use it like this.
> > > 
> > > Will, can you confirm either way?
> > 
> > We don't update mm_cpumask() as the cost of the atomic showed up in some
> > benchmarks I did years ago and we've never had any need for the thing anyway
> > because out TLB invalidation is one or all.
> 
> That's good because we're also passing NULL instead of mm which would 
> crash. So it must be more than it's not up to date, but it's always 0. 
> It looks like event_mapped on x86 uses mm_cpumask(mm) which I guess was 
> dropped when copying this code as it didn't work... For reference, the 
> x86 version of this originated in commit 7911d3f7af14a6.
> 
> I'm not clear on why we need to update pmuserenr_el0 here anyways. To 
> get here userspace has to mmap the event and then unmmap it. If we did 
> nothing, then counter accesses would not fault until the next context 
> switch.
> 
> If you all have any ideas, I'm all ears. I'm not a scheduler nor perf 
> hacker. ;)

Here's another issue that needs addressing:

https://lore.kernel.org/lkml/20200821195754.20159-3-kan.liang@linux.intel.com/

Rob
