Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB46295A64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507884AbgJVIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444301AbgJVIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:33:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE142C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:32:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so681184pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dOSJpkMx7Vw1Efdt5qcFIg0wz4UulTvGF8jI2wMMWMk=;
        b=xqyUfHEdK+PqMP8MpGk5GNlDkOqIanfh3I2GsopRdIVCseztUdJaFtjittYnBkPR93
         iwRG/feJHGsBlx+Jy9xPCifuK/KDkRDNZ5/YxwISk7j/F/1EhxhiQHI7CdU8dLMo5Smi
         udLVzjCYV4TiOJgzotOug3nwkx4ttXLA/z+KvGPCKeSrEolrsbnvKlFfyGfZs9IgTUOJ
         AeRY20c7cRmIXKa+bijTZbyiQUxYmmhjpw8KMLgJb7qP1mAuJ/F6VH4vHmSHbwObf03S
         +CoQYSHfe6zEgaN7pMIrUYbx+oXSpyYC+C+swWewstmbECkrLKiEooAXQYT1gJCHbWr3
         SM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOSJpkMx7Vw1Efdt5qcFIg0wz4UulTvGF8jI2wMMWMk=;
        b=rwVIMlJmoS1EfHcj3EOefo7J1UFv7xvnHsgO98NVrC5Nt7VfjEme6QO4xh3YVdzKmN
         Eow4ieKPCkrskFBZUT3a0ePD7+Me4WRvqm/iWasu/wETK9uaoUp3BbApjpjcxgm7kTCG
         eAlIbIYD4KYUxdg749CB5bKHVm7IGIHdfdtd0wJbVVi8TeBNEoir+hjVK+mY4Wket0jy
         t0+1Pu9B+xtVlkB2oo70kB8/WNiXWQmue6F5w7pIT3UZxg8p/JXF0OKz6x8D7z/UVslT
         7qtweXyiTi62G0o2NNYo+fEOPEjuuoNcTY7eoM/QSKNqwkUQR3mcajqe71NW0RhtKaQv
         vYwg==
X-Gm-Message-State: AOAM530tPm/jW0s3/kUh7xSlHLUmMb7RYbKQ5IrMxB4zs5t4umIfj+Lm
        E5W5yRMoV0jxjXmbCzanWJQ3ig==
X-Google-Smtp-Source: ABdhPJw1WVNKgcuj67uqzrau1OuYobFRotv4PJBRcrBtTXkJs7oR1qbWVklWmxif4Drv6Z6FPc6SXQ==
X-Received: by 2002:a63:c55:: with SMTP id 21mr1273631pgm.392.1603355579060;
        Thu, 22 Oct 2020 01:32:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x12sm1237329pfr.156.2020.10.22.01.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 01:32:58 -0700 (PDT)
Date:   Thu, 22 Oct 2020 14:02:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716115605.GR10769@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Since Lukasz asked me to hold on to this stuff so he can propose
something in its place, I stayed away from discussing this patchset
for sometime. But now that he agrees [1] that we may take this forward
and he can work on top of it as and when he can, I am looking to find
the way out to get this stuff merged in some form.

On 16-07-20, 13:56, Peter Zijlstra wrote:
> So there's a number of things... let me recap a bunch of things that
> got mentioned on IRC earlier this week and then continue from there..
> 
> So IPA* (or any other thermal governor) needs energy estimates for the
> various managed devices, cpufreq_cooling, being the driver for the CPU
> device, needs to provide that and in return receives feedback on how
> much energy it is allowed to consume, cpufreq_cooling then dynamically
> enables/disables OPP states.
> 
> There are actually two methods the thermal governor will use:
> get_real_power() and get_requested_power().
> 
> The first isn't used anywhere in mainline, but could be implemented on
> hardware that has energy counters (like say x86 RAPL).
> 
> The second attempts to guesstimate power, and is the subject of this
> patch.
> 
> Currently cpufreq_cooling appears to estimate the CPU energy usage by
> calculating the percentage of idle time using the per-cpu cpustat stuff,
> which is pretty horrific.
> 
> This patch then attempts to improve upon that by using the scheduler's
> cpu_util(ENERGY_UTIL) estimate, which is also used to select OPP state
> and improves upon avg idle. This should be a big improvement as higher
> frequency consumes more energy

Exactly and that's the motivation behind this change.

> , but should we not also consider that:
> 
> 	E = C V^2 f
> 
> The EAS energy model has tables for the OPPs that contain this, but in
> this case we seem to be assuming a linear enery/frequency curve, which
> is just not the case.
> 
> I suppose we could do something like **:
> 
> 	100 * util^3 / max^3
> 
> which assumes V~f.
> 
> Another point is that cpu_util() vs turbo is a bit iffy, and to that,
> things like x86-APERF/MPERF and ARM-AMU got mentioned. Those might also
> have the benefit of giving you values that match your own sampling
> interval (100ms), where the sched stuff is PELT (64,32.. based).

I believe the above stuff is more around additional improvements that
we can do over this change, and probably Lukasz was looking to do
that.

> So what I've been thinking is that cpufreq drivers ought to be able to
> supply this method, and only when they lack, can the cpufreq-governor
> (schedutil) install a fallback.

One of the issues I see with this is that schedutil may not be
available in all configurations and it is still absolutely fine to
using the suggested helper to get the energy numbers in such cases, so
we shouldn't really make it scheutil dependent.

> And then cpufreq-cooling can use
> whatever is provided (through the cpufreq interfaces).
> 
> That way, we:
> 
>  1) don't have to export anything

Yeah, I understand that the exports are annoying and specially this
line :)

+#include "../../kernel/sched/sched.h"

But this is the best I could think of then as we don't want to export
them for anyone else to use sched specific stuff. And there was other
core kernel stuff that was already doing it :)

>  2) get arch drivers to provide something 'better'
> 
> 
> Does that sounds like something sensible?

-- 
viresh

[1] http://lore.kernel.org/lkml/d2a75b18-1eae-f396-4dc5-af41b539e581@arm.com
