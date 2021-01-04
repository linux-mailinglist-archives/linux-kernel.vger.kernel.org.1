Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3742E984D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbhADPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:19:46 -0500
Received: from foss.arm.com ([217.140.110.172]:38176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbhADPTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:19:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282BE101E;
        Mon,  4 Jan 2021 07:18:59 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6A8D3F719;
        Mon,  4 Jan 2021 07:18:57 -0800 (PST)
Date:   Mon, 4 Jan 2021 15:18:55 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     peterz@infradead.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20210104151855.cx4w4ptkpzi3k6ld@e107158-lin>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
 <20200907111320.GP2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907111320.GP2674@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 13:13, peterz@infradead.org wrote:
> On Mon, Sep 07, 2020 at 11:48:45AM +0100, Qais Yousef wrote:
> > IMHO the above is a hack. Out-of-tree modules should rely on public headers and
> > exported functions only. What you propose means that people who want to use
> > these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
> > maybe true for us who work in the embedded world. But users who run normal
> > distro kernels (desktop/servers) will fail to build against
> 
> But this isn't really aimed at regular users. We're aiming this at
> developers (IIUC) so I dont really see this as a problem.
> 
> > FWIW, I did raise this concern with Peter in 2019 OSPM and he was okay with the
> > exports as it's still not a contract and they can disappear anytime we want.
> > Migrating to using BTF is the right way forward IMO. I don't think what we have
> > here is out-of-control yet. Though I agree they're annoying.
> 
> Right, we're hiding behind the explicit lack of ABI for modules.
> 
> Anyway, CTF/BTF/random other crap that isn't DWARFs should work fine to
> replace all this muck. Just no idea what the state of any of that is.

So I have updated my reference module to remove the dependency on those
functions:

	https://github.com/qais-yousef/tracepoints-helpers/tree/pelt-tps-v3-create-events/sched_tp

When building against a prebuilt kernel tree, I use pahole + vmlinux to generate
vmlinux.h with all the internal struct we depend on. The kernel must be
compiled with CONFIG_DEBUG_INFO for pahole to work.

When building against a running kernel (ie: exported headers only available),
we try to use /sys/kernel/btf/vmlinux to generate vmlinux.h.

One outstanding issue is that pahole + BTF don't generate alignment info so
while the module compiles but I get a crash when I load the module and enable
one of the tracepoints. bpftool generates alignment info with BTF, but it dumps
everything which leads to another set of problems.

Barring fixing the BTF issue which I'm talking with Arnaldo about, I think we
should be in good position to remove these exported functions soon.

In the module we have to maintain helper functions (see sched_tp_helpers.h) but
I think that's much easier than maintaining out of tree copy of the structs.

It also enabled me to add uclamp trace events which had dependency on internal
details that I wasn't keen on exporting in mainline.

Is this a good/better compromise?

Thanks

--
Qais Yousef
