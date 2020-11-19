Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9C2B9B58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgKSTPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgKSTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:15:22 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A9822267;
        Thu, 19 Nov 2020 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813322;
        bh=xBOcBxca72bKqLRS+dLuVtZoFEY5roI4F6617wVfhho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZ5/cADunQa/pilv7aE73K7zgv2+enzkoL08MCGDGb6j5swSxLGdq08YG06KdJuPK
         F/Ikk9M3BO+W6pQYpeE/JmygTm0RN0pRAPnoMK2QjUNJnJpeHu0ssTTO+1HQ/VdAOR
         2ESa5UIG1hRMaNHOu8Ry2U3PUEMpev0OY6/lEXqU=
Date:   Thu, 19 Nov 2020 19:15:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <20201119191515.GA4906@willie-the-truck>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-3-robh@kernel.org>
 <20201113180633.GE44988@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113180633.GE44988@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:06:33PM +0000, Mark Rutland wrote:
> On Thu, Oct 01, 2020 at 09:01:09AM -0500, Rob Herring wrote:
> > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > +{
> > +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > +		return;
> > +
> > +	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > +		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
> > +}
> 
> I didn't think we kept our mm_cpumask() up-to-date in all cases on
> arm64, so I'm not sure we can use it like this.
> 
> Will, can you confirm either way?

We don't update mm_cpumask() as the cost of the atomic showed up in some
benchmarks I did years ago and we've never had any need for the thing anyway
because out TLB invalidation is one or all.

Will
