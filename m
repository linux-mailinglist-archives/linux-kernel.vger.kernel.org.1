Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54192B0526
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgKLMuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:50:11 -0500
Received: from foss.arm.com ([217.140.110.172]:49422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLMuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:50:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFA89101E;
        Thu, 12 Nov 2020 04:50:08 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A911B3F718;
        Thu, 12 Nov 2020 04:50:07 -0800 (PST)
References: <20201112113441.27008-1-song.bao.hua@hisilicon.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Adrian Freund <adrian@freund.io>
Subject: Re: [PATCH] Documentation: scheduler: fix outdated information on arch SD flags and sched_domain
In-reply-to: <20201112113441.27008-1-song.bao.hua@hisilicon.com>
Date:   Thu, 12 Nov 2020 12:50:05 +0000
Message-ID: <jhjft5eyc1u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 12/11/20 11:34, Barry Song wrote:
> This document seems to be out of date for many, many years. Even it has
> misspelled from the first day.
> ARCH_HASH_SCHED_TUNE should be ARCH_HAS_SCHED_TUNE
> ARCH_HASH_SCHED_DOMAIN should be ARCH_HAS_SCHED_DOMAIN
>
> But since v2.6.14, kernel completely deleted the relevant code and even
> arch_init_sched_domains() was deleted.
>
> Right now, kernel is asking architectures to call set_sched_topology() to
> override the default sched domains.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Adrian Freund <adrian@freund.io>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/scheduler/sched-domains.rst | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
> index 5c4b7f4f0062..434d4e7e86c5 100644
> --- a/Documentation/scheduler/sched-domains.rst
> +++ b/Documentation/scheduler/sched-domains.rst
> @@ -69,15 +69,9 @@ The implementor should read comments in include/linux/sched.h:
>  struct sched_domain fields, SD_FLAG_*, SD_*_INIT to get an idea of
>  the specifics and what to tune.
>
> -Architectures may retain the regular override the default SD_*_INIT flags
> -while using the generic domain builder in kernel/sched/core.c if they wish to
> -retain the traditional SMT->SMP->NUMA topology (or some subset of that). This
> -can be done by #define'ing ARCH_HASH_SCHED_TUNE.
> -
> -Alternatively, the architecture may completely override the generic domain
> -builder by #define'ing ARCH_HASH_SCHED_DOMAIN, and exporting your
> -arch_init_sched_domains function. This function will attach domains to all
> -CPUs using cpu_attach_domain.
> +Architectures may override the generic domain builder and the default
> +SD_*_INIT flags by define'ing an array of sched_domain_topology_level and

That's way before my time, but IIRC those macros are also gone since

  143e1e28cb40 ("sched: Rework sched_domain topology definition")

The only way to override flags for a given topology level is to create a
new topology_level array and pass it through set_sched_topology() - reason
being you can't redefine cpu_{smt, core, *}_flags().

> +calling set_sched_topology() with this array as the parameter.
>

>  The sched-domains debugging infrastructure can be enabled by enabling
>  CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched domains

This part about debug bits is also somewhat dusty. Mind adding the
following to your patch?

@Peter: would you object to getting rid of that sched_debug thing and
always do the sched_domain_debug() faff whenever we have
CONFIG_SCHED_DEBUG? Maybe keep sched_debug for the NUMA sort, but even then
that already requires having CONFIG_SCHED_DEBUG...

---
diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 434d4e7e86c5..0ebf8afb24ae 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -74,6 +74,8 @@ SD_*_INIT flags by define'ing an array of sched_domain_topology_level and
 calling set_sched_topology() with this array as the parameter.

 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched domains
-which should catch most possible errors (described above). It also prints out
-the domain structure in a visual format.
+CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you forgot to
+tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
+knob. This enables an error checking parse of the sched domains which should
+catch most possible errors (described above). It also prints out the domain
+structure in a visual format.
