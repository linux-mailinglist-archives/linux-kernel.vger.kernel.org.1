Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D62129F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGBQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 12:45:01 -0400
Received: from foss.arm.com ([217.140.110.172]:42530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGBQo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7921FB;
        Thu,  2 Jul 2020 09:44:55 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 363973F71E;
        Thu,  2 Jul 2020 09:44:54 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] arm, sched/topology: Remove SD_SHARE_POWERDOMAIN
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-5-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ef77cdb1-d3b9-c77f-2bbe-e3dd9883e5d8@arm.com>
Date:   Thu, 2 Jul 2020 18:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701190656.10126-5-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 21:06, Valentin Schneider wrote:
> This flag was introduced in 2014 by commit
> 
>   d77b3ed5c9f8 ("sched: Add a new SD_SHARE_POWERDOMAIN for sched_domain")
> 
> but AFAIA it was never leveraged by the scheduler. The closest thing I can
> think of is EAS caring about frequency domains, and it does that by
> leveraging performance domains.

... and even this was purely out of tree (SD_SHARE_CAP_STATES).

> Remove the flag.
> 
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  arch/arm/kernel/topology.c     |  2 +-
>  include/linux/sched/sd_flags.h | 20 ++++++--------------
>  kernel/sched/topology.c        | 10 +++-------
>  3 files changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index b5adaf744630..353f3ee660e4 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -243,7 +243,7 @@ void store_cpu_topology(unsigned int cpuid)
>  
>  static inline int cpu_corepower_flags(void)
>  {
> -	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
> +	return SD_SHARE_PKG_RESOURCES;
>  }
>  
>  static struct sched_domain_topology_level arm_topology[] = {

I guess with SD_SHARE_POWERDOMAIN gone, arch arm can even use the default_topology[]:

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index b5adaf744630..87dd193165cc 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -241,20 +241,6 @@ void store_cpu_topology(unsigned int cpuid)
        update_siblings_masks(cpuid);
 }
 
-static inline int cpu_corepower_flags(void)
-{
-       return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
-}
-
-static struct sched_domain_topology_level arm_topology[] = {
-#ifdef CONFIG_SCHED_MC
-       { cpu_corepower_mask, cpu_corepower_flags, SD_INIT_NAME(GMC) },
-       { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-#endif
-       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
-       { NULL, },
-};
-
 /*
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
@@ -265,7 +251,4 @@ void __init init_cpu_topology(void)
        smp_wmb();
 
        parse_dt_topology();
-
-       /* Set scheduler topology descriptor */
-       set_sched_topology(arm_topology);
 }
