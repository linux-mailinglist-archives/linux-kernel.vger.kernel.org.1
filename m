Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AF2EA114
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbhADXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbhADXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:47:09 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6B7C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:46:53 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z9so19781688qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Titf8x1fnSDltA5xxQs29GH+bpNslU3vFYKElIQuG6w=;
        b=UhUadZD8lOMwa+Sed5RMf2DZTdRKBT+RmtE1cnmlb62Mriz/FGKLSKYErHQpwAxFQJ
         mnI2RuV6HLKzuDk+m1Xxw+zALXui1RupcIKAK5XxwPzelwxyCo4eqp2H3wfaKXM5Kr58
         V+LcSQ7vmCT+YPyKo4v3f7lxolxxs4TrCR+Y59fdeBcb4KPJ0iqiRmN1Sf/JMJqg+0Gy
         6YlGzw0zLQhnHSfFdMx/NGqE/RNHpI0GkYmzk9qX11ELglQmITltuVAqMRZVSTtad7za
         wXsAgfO5H9GrYeH8MtUP/RZOGGVA8fpYBYxz7FuyBrUR5rxIjakjeewLdNx9k4Dh8GPe
         GW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Titf8x1fnSDltA5xxQs29GH+bpNslU3vFYKElIQuG6w=;
        b=Top1aF9L72+Ua7C9TttUXVxhACLIHb95E1204zy0L8ip0BtA3FNlm2zYM+A4dj3dN2
         TcSqEBtEWc1ZHMW6iFwakuau6I2f2R64cWnl4DGU4FBXMvB+jr0TdpXwmBsaRQ/jdGkA
         QeO2UaNCPI/7ugF7SAhm8r440yhcxbdD5S+c7Fh1ofY5WqJoyAv3P4ZYpbKzQUngUfuv
         62fR/Ew9bScHLs1WGFzYCfxvNERhz70uk4mgms+0zONrqoaQdTwVcNJCER747NO0R0sN
         xv7w52lY0XM3sZB2AOh6l4rOTtQXCshBFNRqmmGoTIUxJbLlYPBbfP6iRrPToz1BVESw
         acYA==
X-Gm-Message-State: AOAM531/QgcbXJMveTIpLjswqUZzbxDqBz67zCVcpTkS7DOfBgNFiDut
        N6Sp+nvFrQBdWkaizpJos0Y891S3kyonRA==
X-Google-Smtp-Source: ABdhPJx12uFWI2THN0aVECziLp2DMRNGSOgWv6NMPBIpeCirGPZXBzkoXxqOekXbRwkLEp1YgiE+Vw==
X-Received: by 2002:aed:2e47:: with SMTP id j65mr74442331qtd.231.1609804012936;
        Mon, 04 Jan 2021 15:46:52 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 195sm38380739qke.108.2021.01.04.15.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:46:52 -0800 (PST)
Date:   Mon, 4 Jan 2021 16:46:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] percpu: fix clang modpost warning in
 pcpu_build_alloc_info()
Message-ID: <20210104234651.GA3548546@ubuntu-m3-large-x86>
References: <20201231212852.3175381-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231212852.3175381-1-dennis@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 09:28:52PM +0000, Dennis Zhou wrote:
> This is an unusual situation so I thought it best to explain it in a
> separate patch.
> 
> "percpu: reduce the number of cpu distance comparisons" introduces a
> dependency on cpumask helper functions in __init code. This code
> references a struct cpumask annotated __initdata. When the function is
> inlined (gcc), everything is fine, but clang decides not to inline these
> function calls. This causes modpost to warn about an __initdata access
> by a function not annotated with __init [1].
> 
> Ways I thought about fixing it:
> 1. figure out why clang thinks this inlining is too costly.
> 2. create a wrapper function annotated __init (this).
> 3. annotate cpumask with __refdata.
> 
> Ultimately it comes down to if it's worth saving the cpumask memory and
> allowing it to be freed. IIUC, __refdata won't be freed, so option 3 is
> just a little wasteful. 1 is out of my depth, leaving 2. I don't feel
> great about this behavior being dependent on inlining semantics, but
> cpumask helpers are small and probably should be inlined.
> 
> modpost complaint:
>   WARNING: modpost: vmlinux.o(.text+0x735425): Section mismatch in reference from the function cpumask_clear_cpu() to the variable .init.data:pcpu_build_alloc_info.mask
>   The function cpumask_clear_cpu() references
>   the variable __initdata pcpu_build_alloc_info.mask.
>   This is often because cpumask_clear_cpu lacks a __initdata
>   annotation or the annotation of pcpu_build_alloc_info.mask is wrong.
> 
> clang output:
>   mm/percpu.c:2724:5: remark: cpumask_clear_cpu not inlined into pcpu_build_alloc_info because too costly to inline (cost=725, threshold=325) [-Rpass-missed=inline]
> 
> [1] https://lore.kernel.org/linux-mm/202012220454.9F6Bkz9q-lkp@intel.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
> This is on top of percpu#for-5.12.
> 
>  mm/percpu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 80f8f885a990..357977c4cb00 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2642,6 +2642,18 @@ early_param("percpu_alloc", percpu_alloc_setup);
>  
>  /* pcpu_build_alloc_info() is used by both embed and page first chunk */
>  #if defined(BUILD_EMBED_FIRST_CHUNK) || defined(BUILD_PAGE_FIRST_CHUNK)
> +
> +/*
> + * This wrapper is to avoid a warning where cpumask_clear_cpu() is not inlined
> + * when compiling with clang causing modpost to warn about accessing __initdata
> + * from a non __init function.  By doing this, we allow the struct cpumask to be
> + * freed instead of it taking space by annotating with __refdata.
> + */
> +static void __init pcpu_cpumask_clear_cpu(int cpu, struct cpumask *mask)
> +{
> +	cpumask_clear_cpu(cpu, mask);
> +}
> +
>  /**
>   * pcpu_build_alloc_info - build alloc_info considering distances between CPUs
>   * @reserved_size: the size of reserved percpu area in bytes
> @@ -2713,7 +2725,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
>  		cpu = cpumask_first(&mask);
>  		group_map[cpu] = group;
>  		group_cnt[group]++;
> -		cpumask_clear_cpu(cpu, &mask);
> +		pcpu_cpumask_clear_cpu(cpu, &mask);
>  
>  		for_each_cpu(tcpu, &mask) {
>  			if (!cpu_distance_fn ||
> @@ -2721,7 +2733,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
>  			     cpu_distance_fn(tcpu, cpu) == LOCAL_DISTANCE)) {
>  				group_map[tcpu] = group;
>  				group_cnt[group]++;
> -				cpumask_clear_cpu(tcpu, &mask);
> +				pcpu_cpumask_clear_cpu(tcpu, &mask);
>  			}
>  		}
>  	}
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

Hi Dennis,

I did a bisect of the problematic config against defconfig and it points
out that CONFIG_GCOV_PROFILE_ALL is in the bad config but not the good
config, which makes some sense as that will mess with clang's inlining
heuristics. It does not appear to be the single config that makes a
difference but it gives some clarity.

I do not personally have any strong opinions around the patch but is it
really that much wasted memory to just annotate mask with __refdata?

Cheers,
Nathan
