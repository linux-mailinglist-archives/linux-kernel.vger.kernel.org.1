Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92E29AA81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1749877AbgJ0L0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:26:44 -0400
Received: from foss.arm.com ([217.140.110.172]:38606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460314AbgJ0L0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:26:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704E730E;
        Tue, 27 Oct 2020 04:26:42 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C1723F66E;
        Tue, 27 Oct 2020 04:26:39 -0700 (PDT)
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201022071145.GM2628@hirez.programming.kicks-ass.net> <20201022104703.nw45dwor6wfn4ity@vireshk-i7> <34115486.YmRjPRKJaA@kreacher> <20201022120213.GG2611@hirez.programming.kicks-ass.net> <20201027111133.ajlxn5lbnfeocfgb@e107158-lin>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
In-reply-to: <20201027111133.ajlxn5lbnfeocfgb@e107158-lin>
Date:   Tue, 27 Oct 2020 11:26:37 +0000
Message-ID: <jhjlffrq58y.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/20 11:11, Qais Yousef wrote:
> On 10/22/20 14:02, Peter Zijlstra wrote:
>> However I do want to retire ondemand, conservative and also very much
>> intel_pstate/active mode. I also have very little sympathy for
>> userspace.
>
> Userspace is useful for testing and sanity checking. Not sure if people use it
> to measure voltage/current at each frequency to generate
> dynamic-power-coefficient for their platform. Lukasz, Dietmar?
>

It's valuable even just for cpufreq sanity checking - we have that test
that goes through increasing frequencies and asserts the work done is
monotonically increasing. This has been quite useful in the past to detect
broken bits.

That *should* still be totally doable with any other governor by using the
scaling_{min, max}_freq sysfs interface.

> Thanks
