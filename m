Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55164274835
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIVSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:34:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D73C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:34:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so2781639wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ig3mZwlM5VgOYpaLezhg7vQFxV24lXeVdfnz5xWj0rM=;
        b=j74lrtCwlnu6fqYOp87AYQKgh20vY4HWutnBUDTD/MqKbmkWvoiV1gzSZV1V651W6t
         0EKrZbRNvxSaOS5XQN/3rRjYUWD+Ybjv7r9BGve2BX11HJKB1svj+6D+/qfyXmfvs5PX
         +uTe4FmQnZePv8i6hoTB84tksthKi2ioxGQFqtqwFVhQQsPsEIsaZHKXIpuaML4TRitw
         C99CuqPCX6sqXqJwRmpmlW0UUiuKt8OkI4se3513BsxjHTyOHyDzrjDiH2IAT20a8hxQ
         syrZurWX6+zVVt9bSCPXFUuRjAYKQbteOrwVjfILeDBIkZQWQziXt/ZnAD2Waf7SR4a8
         vZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ig3mZwlM5VgOYpaLezhg7vQFxV24lXeVdfnz5xWj0rM=;
        b=lVK9okyblYMarb2Gc6JLzmzENAPn9Wrs1VawwC2rrGvR3JNyBpLl4M/KGbxAaI5iFx
         485vAaAo7665sS4ko5PsLGyKZwdpc7fcWu2Pelm3Rs6F5cjRFe3mkc7rfU8N+Jd48YHc
         7fXSk4ZWSNikdQ0I8/dJenIWttLTgZx3snZK9xq1BQ801ufWzrMQ/7d1yDrVYelJmhgu
         d0/Cx8U3214JIf/hbyqvS6usQu/Cm37KJLTk7pr/b9kGoy54bbPZ4IgEZzivEibTzw7Q
         jKLc+j6gJScDq7P2VD+iJswJ6vANd3AFG/CR7j4Pno5v1K+jHwyBWcPPHu2xSpHd/pu9
         A4Pg==
X-Gm-Message-State: AOAM532LsudEGDaytiv6WVZTInTvCqvDRddxBvvE+vgS3XL12xBHymZc
        HvqS5OBjz8DoPew/8ml6ecXv3A==
X-Google-Smtp-Source: ABdhPJxj0h/V08O5vb8gOXVPpqliJJY+kmMZI4zN+kzRDjl+BRuapEiHWcZOA9NImhQeqmN/2EE34w==
X-Received: by 2002:a1c:40a:: with SMTP id 10mr1283670wme.61.1600799694728;
        Tue, 22 Sep 2020 11:34:54 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:55c2:2cdf:ff31:96a3])
        by smtp.gmail.com with ESMTPSA id 63sm29411016wrh.71.2020.09.22.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:34:53 -0700 (PDT)
Date:   Tue, 22 Sep 2020 19:34:52 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 10/11] kvm: arm64: Set up hyp percpu data for nVHE
Message-ID: <20200922183452.xalwog2ojsc5ogpe@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-11-dbrazdil@google.com>
 <20200918122219.GD31096@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918122219.GD31096@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
> > -#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
> > +/* Array of percpu base addresses. Length of the array is nr_cpu_ids. */
> > +extern unsigned long *kvm_arm_hyp_percpu_base;
> > +
> > +/*
> > + * Compute pointer to a symbol defined in nVHE percpu region.
> > + * Returns NULL if percpu memory has not been allocated yet.
> > + */
> > +#define this_cpu_ptr_nvhe(sym)	per_cpu_ptr_nvhe(sym, smp_processor_id())
> 
> Don't you run into similar problems here with the pcpu accessors when
> CONFIG_DEBUG_PREEMPT=y? I'm worried we can end up with an unresolved
> reference to debug_smp_processor_id().

Fortunately not. This now doesn't use the generic macros at all.

> >  /* The VMID used in the VTTBR */
> >  static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
> > @@ -1258,6 +1259,15 @@ long kvm_arch_vm_ioctl(struct file *filp,
> >  	}
> >  }
> >  
> > +#define kvm_hyp_percpu_base(cpu)	((unsigned long)per_cpu_ptr_nvhe(__per_cpu_start, cpu))
> 
> Having both kvm_arm_hyp_percpu_base and kvm_hyp_percpu_base be so
> completely different is a recipe for disaster! Please can you rename
> one/both of them to make it clearer what they represent?

I am heavily simplifying this code in v4. Got rid of this macro completely, so
hopefully there will be no confusion.

> > -	if (!kvm_pmu_switch_needed(attr))
> > +	if (!ctx || !kvm_pmu_switch_needed(attr))
> >  		return;
> >  
> >  	if (!attr->exclude_host)
> > @@ -49,6 +49,9 @@ void kvm_clr_pmu_events(u32 clr)
> >  {
> >  	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
> >  
> > +	if (!ctx)
> > +		return;
> 
> I guess this should only happen if KVM failed to initialise or something,
> right? (e.g. if we were booted at EL1). If so, I'm wondering whether it
> would be better to do something like:
> 
> 	if (!is_hyp_mode_available())
> 		return;
> 
> 	WARN_ON_ONCE(!ctx);
> 
> so that any unexpected NULL pointer there screams loudly, rather than causes
> the register switch to be silently ignored. What do you think?

Unfortunately, this happens on every boot. I don't fully understand how the
boot order is determined, so please correct me if this makes no sense, but 
kvm_clr_pmu_events is called as part of CPUHP_AP_PERF_ARM_STARTING. The first
time that happens is before KVM initialized (tested from inserting
BUG_ON(!ctx)). That's not a problem, the per-CPU memory is there and it's all
zeroes. It becomes a problem with this patch because the per-CPU memory is not
there *yet*.

