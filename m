Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081023B931
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 13:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHDLDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 07:03:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgHDLDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:03:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C8430E;
        Tue,  4 Aug 2020 04:03:04 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5FBC3F6CF;
        Tue,  4 Aug 2020 04:03:02 -0700 (PDT)
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com> <20200804033307.76111-2-srikar@linux.vnet.ibm.com> <20200804104642.GC2657@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/topology: Override cpu_smt_mask
In-reply-to: <20200804104642.GC2657@hirez.programming.kicks-ass.net>
Date:   Tue, 04 Aug 2020 12:02:49 +0100
Message-ID: <jhjeeomish2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/08/20 11:46, peterz@infradead.org wrote:
> On Tue, Aug 04, 2020 at 09:03:07AM +0530, Srikar Dronamraju wrote:
>> On Power9 a pair of cores can be presented by the firmware as a big-core
>> for backward compatibility reasons, with 4 threads per (small) core and 8
>> threads per big-core. cpu_smt_mask() should generally point to the cpu mask
>> of the (small)core.
>>
>> In order to maintain userspace backward compatibility (with Power8 chips in
>> case of Power9) in enterprise Linux systems, the topology_sibling_cpumask
>> has to be set to big-core. Hence override the default cpu_smt_mask() to be
>> powerpc specific allowing for better scheduling behaviour on Power.
>
> Why does Linux userspace care about this?

Ditto; from [1], a core contains CPUs that all share the same L1 (and capacity,
as per SD_SHARE_CPUCAPACITY). So IMO it makes perfect sense to have a first
domain spanning L1, and its parent spanning L2 - that means
topology_sibling_cpumask *itself* should span a single core rather than a
pair.

[1]: https://lkml.kernel.org/r/jhjr1sviswg.mognet@arm.com
