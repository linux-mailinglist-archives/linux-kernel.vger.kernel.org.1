Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B860D2C06CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgKWMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgKWMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:34:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE5C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:34:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so17719843wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ZjO/kg/ZyQBzHgAo7+6n9tS4H4jKirnAxxmVXvH/yc=;
        b=M992dxd2tit7xNFnltCm7IKEDMdlnmQGCe8L5HxLpyARAZse097Av2j/VAIWecNH3m
         bJD+3EDrsh/k+G08pWWz5IJCJd1iwyLpBdfnINWsvXgBH0tfbK2u04BrazZWO+Jo49zy
         yh3iWmzRhuMtjd2JI7q+Gb5w9cjBK3HqqCmSre9UFgSOna7kNL626foIzmVYCIrYe/93
         Qp5+sKy4TAindANud2ZsE1u/VMhU0+QZZ4fy+VOQ5k8mbFKCyHOL4BGH/49geVbGKALP
         aed65X9OM2QRaPt6uBOY49PSxEmgZcC/XdnzywKBaD0U8jyA3urZlDqlFsWzPdOkG0nh
         VjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZjO/kg/ZyQBzHgAo7+6n9tS4H4jKirnAxxmVXvH/yc=;
        b=kYQD5pCz7ZS27FOY0ObdSwK8EQp+V/t52r0R3aTl7ZAdbWmRtJ2RH/Zf6vE8FOtInU
         83rQY28mlwjUg/NW+Hbi7IZT+YMZekST42GX4wbeFB/8AjCqEl9ECLY1gnuZ1fZhS7qi
         P51u2AcdYqLzlKX5TwO3FWzIt8EVaxgWBm7RxEPzZtQgJuKjLYaqi87EvKlzGiDADeZO
         btGKHftTgP+ux1pr6P1PmfzRSDtU8B0CUbAJSHTo8bidx8adsH+/EmfTdBnZypIDKRhv
         tyDHMzn3zpWjUtUqlFMUVj/tpoDXfgxqnbKXo35ydsxiWvFAvdP7AKV6tRGmxhaXifyc
         spkA==
X-Gm-Message-State: AOAM5326TYU4Nv3/oht0mzhYrKSuM0NJvtsPj/efXcbpfhlg+81j7eYX
        yIgbCv/D7SkYYW7o4+hds/S47g==
X-Google-Smtp-Source: ABdhPJwSjPl1MftPJmQUSt0CDAQ26Ikg4YZNe+FEtt3uYPrzCayTOdXmpbrYKg2gwpnbE1eL73qqnQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr23400394wmc.176.1606134867262;
        Mon, 23 Nov 2020 04:34:27 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:acac:b2ef:c7d:fd8a])
        by smtp.gmail.com with ESMTPSA id j71sm16889889wmj.10.2020.11.23.04.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 04:34:26 -0800 (PST)
Date:   Mon, 23 Nov 2020 12:34:25 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Subject: Re: [RFC PATCH 02/27] KVM: arm64: Link position-independent string
 routines into .hyp.text
Message-ID: <20201123123425.uzfuk3pmwgzuijwn@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117181607.1761516-3-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:15:42PM +0000, 'Quentin Perret' via kernel-team wrote:
> From: Will Deacon <will@kernel.org>
> 
> Pull clear_page(), copy_page(), memcpy() and memset() into the nVHE hyp
> code and ensure that we always execute the '__pi_' entry point on the
> offchance that it changes in future.
> 
> [ qperret: Commit title nits ]
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kernel/image-vars.h   | 11 +++++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 8539f34d7538..dd8ccc9efb6a 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -105,6 +105,17 @@ KVM_NVHE_ALIAS(__stop___kvm_ex_table);
>  /* Array containing bases of nVHE per-CPU memory regions. */
>  KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
>  
> +/* Position-independent library routines */
> +__kvm_nvhe_clear_page			= __kvm_nvhe___pi_clear_page;
> +__kvm_nvhe_copy_page			= __kvm_nvhe___pi_copy_page;
> +__kvm_nvhe_memcpy			= __kvm_nvhe___pi_memcpy;
> +__kvm_nvhe_memset			= __kvm_nvhe___pi_memset;
> +
> +#ifdef CONFIG_KASAN
> +__kvm_nvhe___memcpy			= __kvm_nvhe___pi_memcpy;
> +__kvm_nvhe___memset			= __kvm_nvhe___pi_memset;
> +#endif
> +
>  #endif /* CONFIG_KVM */

Nit: Would be good to use the kvm_nvhe_sym() helper for the namespacing.
And feel free to define something like KVM_NVHE_ALIAS for PI in hyp-image.h.

>  
>  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 1f1e351c5fe2..590fdefb42dd 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -6,10 +6,14 @@
>  asflags-y := -D__KVM_NVHE_HYPERVISOR__
>  ccflags-y := -D__KVM_NVHE_HYPERVISOR__
>  
> +lib-objs := clear_page.o copy_page.o memcpy.o memset.o
> +lib-objs := $(addprefix ../../../lib/, $(lib-objs))
> +
>  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
>  	 hyp-main.o hyp-smp.o psci-relay.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>  	 ../fpsimd.o ../hyp-entry.o ../exception.o
> +obj-y += $(lib-objs)
>  
>  ##
>  ## Build rules for compiling nVHE hyp code
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
