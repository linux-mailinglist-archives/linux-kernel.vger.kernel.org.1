Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED25E2CC02B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgLBO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:58:37 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38022 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgLBO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:58:36 -0500
Received: by mail-il1-f194.google.com with SMTP id v3so1785480ilo.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWCyPfwicznRbw1YhSQojjI4Bw6LCPb3+EKGblCRP2E=;
        b=AxkyTxAUjyFakz1Bk+NuXWfl5esOUxPEuc0P58PD2Pi8nv7o4LaA0NowaGcsQGc1cg
         a3Q5xjj3LTpdpnECHvzsUb/SQJo+K3NiOCHs2im2OJ9drcwR0QfwERxM9ALg2rsu75Jp
         gxuDeBG5wtFraxUNz6bEqgt9rXnBH1WfIJd68mw1I3PG9hZnBzBf4UPkJK/JXzbVYbfL
         mSdXLWkLarTIel0WpGqieoffG6vQ4hCyYVwtvAplo4uUpiDULOTp0mI2BaLVOREd0Whx
         MVOQZI1vtI9HtWTtgg7fkmJ7Udvlw9v/QdxzQRDoeByNURg10HLxLOwK6txljvysX0pM
         W2GA==
X-Gm-Message-State: AOAM532bIxyHaXm5hefqIzY3VJmYuMFq89e17qOS7CEKxvRSnwyvgo2L
        UpSRQckLyrYLenzADCwUHA==
X-Google-Smtp-Source: ABdhPJyaVakqp6n6WLV5ZLOiORIiXy4Mr87J72aPw6EB/hrivYjbbVXscTCoOATaWyMySZ9qRuUZ7A==
X-Received: by 2002:a92:2e0f:: with SMTP id v15mr2620478ile.110.1606921069917;
        Wed, 02 Dec 2020 06:57:49 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 10sm1280376ill.75.2020.12.02.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:57:48 -0800 (PST)
Received: (nullmailer pid 2608258 invoked by uid 1000);
        Wed, 02 Dec 2020 14:57:47 -0000
Date:   Wed, 2 Dec 2020 07:57:47 -0700
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
Message-ID: <20201202145747.GA2381290@robh.at.kernel.org>
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

Mark, Will, any thoughts on this?

Rob
