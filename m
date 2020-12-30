Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC282E765F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 06:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgL3Ff5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 00:35:57 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:36730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgL3Ff4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 00:35:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 17FD6100E7B40;
        Wed, 30 Dec 2020 05:35:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2903:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:4321:4605:5007:7652:7875:8603:10004:10400:10450:10455:11026:11232:11473:11658:11783:11914:12043:12295:12296:12297:12438:12740:12895:13101:13439:13894:14181:14659:14721:19904:19999:21080:21324:21451:21627:21660:30029:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: stone76_4003d5f274a2
X-Filterd-Recvd-Size: 3640
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Dec 2020 05:35:14 +0000 (UTC)
Message-ID: <5ca6c2d28f6cf091a676f8e7d8f14a933da0b267.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore warning designated initializers
 using NR_CPUS
From:   Joe Perches <joe@perches.com>
To:     Peng Wang <rocking@linux.alibaba.com>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 29 Dec 2020 21:35:13 -0800
In-Reply-To: <2eba2ec8531f440410ee8164aaf2ab754bd5a0d1.1609301434.git.rocking@linux.alibaba.com>
References: <2eba2ec8531f440410ee8164aaf2ab754bd5a0d1.1609301434.git.rocking@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-30 at 12:13 +0800, Peng Wang wrote:
> Some max_length wants to hold as large room as possible to
> ensure enough size to tackle with the biggest NR_CPUS. As
> an example below:
> 
> kernel/cgroup/cpuset.c:
> static struct cftype legacy_files[] = {
>         {
>                 .name = "cpus",
>                 .seq_show = cpuset_common_seq_show,
>                 .write = cpuset_write_resmask,
>                 .max_write_len = (100U + 6 * NR_CPUS),
>                 .private = FILE_CPULIST,
>         },
> 	...
> }
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7022,12 +7022,15 @@ sub process {
>  
> 
>  # use of NR_CPUS is usually wrong
>  # ignore definitions of NR_CPUS and usage to define arrays as likely right
> +# ignore designated initializers using NR_CPUS
> +
>  		if ($line =~ /\bNR_CPUS\b/ &&
>  		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
>  		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
>  		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
>  		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
> -		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
> +		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/ &&
> +		    $line !~ /\s*\..*=.*\bNR_CPUS\b.*,$/)
>  		{
>  			WARN("NR_CPUS",
>  			     "usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);

I wonder if it's worth it as there just aren't many of these: (6 total)

$ git grep -P '\..*=.*\bNR_CPUS\b.*,\s*$'
drivers/firmware/efi/efi.c:     .cpu_bitmap             = { [BITS_TO_LONGS(NR__CPUS)] = 0},
drivers/infiniband/hw/hfi1/sdma.c:      .max_size = NR_CPUS,
init/init_task.c:       .nr_cpus_allowed= NR_CPUS,
kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
kernel/sysctl.c:                .maxlen         = NR_CPUS,

It also seems it might be more sensible as:

	$line !~ /^.\s*\.\w+\s*=\s*.*\bNR_CPUS\b/

Which finds a couple more:

$ git grep -P '^\s*\.\w+\s*=\s*.*\bNR_CPUS\b'
arch/arm64/include/asm/processor.h:     .fpsimd_cpu = NR_CPUS,                  \
arch/powerpc/kernel/prom_init.c:                .max_cpus = cpu_to_be32(NR_CPUS),       /* number of cores supported */
drivers/firmware/efi/efi.c:     .cpu_bitmap             = { [BITS_TO_LONGS(NR_CPUS)] = 0},
drivers/infiniband/hw/hfi1/sdma.c:      .max_size = NR_CPUS,
init/init_task.c:       .nr_cpus_allowed= NR_CPUS,
kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
kernel/sysctl.c:                .maxlen         = NR_CPUS,


