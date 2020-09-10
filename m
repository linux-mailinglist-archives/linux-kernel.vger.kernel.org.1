Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393372647D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgIJORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbgIJOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C4C061348
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:07:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so191608wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QJ5xEB2z11c85j6v+J4UJJ6T/KCHaYAOj5sVJT9cY58=;
        b=cYL3QKW0nMiKASGS3CJTqYRW4EJhwjV95TkNT0tAhERyHlIVcKujnsUZ992Tgt805x
         3uuPEFEzZ6VgoEVJunPO22PvL1THHkv0rx45qgLJ5V4frgzv84ZS4X4awVwGcqp6sl2v
         zR1Fglj6zs5XzvZseqGJun2dk9bpkq3nUYWLNEEqA+T0eMTr23JSl7M9K0Ok+jnduwEj
         /eZHnRWGDiVRXE8KK+upeUUGtW6Y/g7j8relgaZTHwu0oIF4TJHUCIUCUAvmS6x/EDXI
         nevfOC1kp/P7s7F8psEC35HXkrbOLNy0uO6x8SSD50eVqa4iYCMPePAxogexL4gtbNlP
         ESIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJ5xEB2z11c85j6v+J4UJJ6T/KCHaYAOj5sVJT9cY58=;
        b=EWosRrIyXjO/SNdws0qXpIU2sXrlDGl2CA6LXJ6bL+sdLP81jJzz4L/DOgFPv8nQqH
         jCV+Hleuj+cysSFJ1AmHGsM1wWzZpi4jG4B5C4QkjwaNSgNE0mr29tmnX2ozFWVg4BTE
         OEKwnp2yXsw+H/YiAtWzspZwhEIsiijWgSPUvHZIq3OaZbTNAgNq7FC9ehX/gIpxaRhb
         x7X0EQszWmV0ntRz/xpnOp/rwlvrPks3/NkIzGHzIhyqLLTzpOF/wzwUPhneeHRafRnQ
         2sE8J8/uXl6opsRm8BKStKKBOBz1iOooS6K16yaOApmFvKpOoOAwucnyF/0tz9CO8HUW
         /+NA==
X-Gm-Message-State: AOAM533KSIWWY/TzcBcFrCow1bEMKNvUzn6E25FGN82QuOTQUrDgfl9Z
        Tm5jY4Rm9ZAjBCugliu3nGNCOg==
X-Google-Smtp-Source: ABdhPJxlhCOonhA/QUW6OuXk1EjfpUKr/GIkLwPXiWKB30qBaOqPGDH5pFin00r8M+FnE6NxmcHIbg==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr149856wmj.107.1599746864225;
        Thu, 10 Sep 2020 07:07:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
        by smtp.gmail.com with ESMTPSA id v128sm3801248wme.2.2020.09.10.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 07:07:43 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:07:38 +0100
From:   Andrew Scull <ascull@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 10/10] kvm: arm64: Remove unnecessary hyp mappings
Message-ID: <20200910140738.GE93664@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-11-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-11-dbrazdil@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 11:17:12AM +0200, 'David Brazdil' via kernel-team wrote:
> With all nVHE per-CPU variables being part of the hyp per-CPU region,
> mapping them individual is not necessary any longer. They are mapped to hyp
> as part of the overall per-CPU region.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Acked-by: Andrew Scull<ascull@google.com>

> ---
>  arch/arm64/include/asm/kvm_mmu.h | 25 +++++++------------------
>  arch/arm64/kvm/arm.c             | 17 +----------------
>  2 files changed, 8 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 9db93da35606..bbe9df76ff42 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -531,28 +531,17 @@ static inline int kvm_map_vectors(void)
>  DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>  DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
>  
> -static inline int hyp_init_aux_data(void)
> +static inline void hyp_init_aux_data(void)
>  {
> -	int cpu, err;
> +	int cpu;
>  
> -	for_each_possible_cpu(cpu) {
> -		u64 *ptr;
> -
> -		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
> -		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
> -		if (err)
> -			return err;
> -
> -		/* Copy value from kernel to hyp. */
> -		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
> -	}
> -	return 0;
> +	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
> +	for_each_possible_cpu(cpu)
> +		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
> +			per_cpu(arm64_ssbd_callback_required, cpu);

Careful with breaking allocations across lines, that seems to be taboo
in this subsystem.

>  }
>  #else
> -static inline int hyp_init_aux_data(void)
> -{
> -	return 0;
> -}
> +static inline void hyp_init_aux_data(void) {}
>  #endif
>  
>  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index df7d133056ce..dfe1baa5bbb7 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1631,22 +1631,7 @@ static int init_hyp_mode(void)
>  		}
>  	}
>  
> -	for_each_possible_cpu(cpu) {
> -		kvm_host_data_t *cpu_data;
> -
> -		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
> -		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
> -
> -		if (err) {
> -			kvm_err("Cannot map host CPU state: %d\n", err);
> -			goto out_err;
> -		}
> -	}
> -
> -	err = hyp_init_aux_data();
> -	if (err)
> -		kvm_err("Cannot map host auxiliary data: %d\n", err);
> -
> +	hyp_init_aux_data();
>  	return 0;
>  
>  out_err:
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
