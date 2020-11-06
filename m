Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D72A9EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgKFVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:22:41 -0500
Received: from foss.arm.com ([217.140.110.172]:44918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgKFVWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:22:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A99A106F;
        Fri,  6 Nov 2020 13:22:40 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DF213F718;
        Fri,  6 Nov 2020 13:22:38 -0800 (PST)
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com> <jhjimamz1dv.mognet@arm.com> <27f88d6a-302e-2c28-c936-22ac233fe175@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Li\, Aubrey" <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for task wakeup
In-reply-to: <27f88d6a-302e-2c28-c936-22ac233fe175@linux.intel.com>
Date:   Fri, 06 Nov 2020 21:22:36 +0000
Message-ID: <jhjy2jexjs3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/20 11:52, Li, Aubrey wrote:
> On 2020/11/4 3:27, Valentin Schneider wrote:
>>> +static DEFINE_PER_CPU(bool, cpu_idle_state);
>>
>> I would've expected this to be far less compact than a cpumask, but that's
>> not the story readelf is telling me. Objdump tells me this is recouping
>> some of the padding in .data..percpu, at least with the arm64 defconfig.
>>
>> In any case this ought to be better wrt cacheline bouncing, which I suppose
>> is what we ultimately want here.
>
> Yes, every CPU has a byte, so it may not be less than a cpumask. Probably I can
> put it into struct rq, do you have any better suggestions?
>

Not really, I'm afraid.
