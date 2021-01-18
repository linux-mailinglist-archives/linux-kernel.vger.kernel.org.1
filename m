Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7E2F9CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389860AbhARKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389365AbhARJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:55:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB71C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:53:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v184so8983961wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6jQxvrdg4qy2EZL9N8xtit/ocZhA3/uVnMS0C547Vs=;
        b=bWs/iuftHz+PV+7azX+PPueBRNaKcm8Aswspr7cdp6br161cqyo1C3q0AZ6KRLiz5G
         +H+or0jMkO+QMHs9om3G6i/tq/3KotYssKySfHSuglxD8TzkkJJSsMrBs6IWxnJ0cWKk
         eZ+ZaXooYnj6U/NSv2cwee2gBg/F2TgUtchRWdKcQ8WGR9zRQTG+3fQ3zxH1jhnJpFih
         gV+j3huAbMfbXI6hzxt+7y9BHo79RhyhZyyKwlt8yc65jazDFJapmY4bVEduUfieBg9g
         Fh1TtWlLbWgESVKCtfOG1mRSEzmoKre3omZtsz9cuhRMzqhSq3h51RMNpiThwOLhNnnk
         AGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6jQxvrdg4qy2EZL9N8xtit/ocZhA3/uVnMS0C547Vs=;
        b=Hl1lD21VkBUD7EtFdz+gT32efxbNU+6zO50il5iQ+bb08/noiyys+crY7A9BoLlnQd
         n/+0/+Qu5bRpYayUiftl/GwxWxqG9gHG35rcQzED05hAJ83RGcPttc2nI6MX6oyZDPMn
         aAqKAqvdlZ3mjJwJDAoAhVmNZTzDH9KR2E+sGeq92mQ/yFNIudR2F47R4uibyIsDVQgM
         zBsPo4P9l4pwCYyWdI2e7plvRrtxyTzfZSVJUtXdsJbF4aGhv3JdV6qanGqYfzXdDoy0
         3Kmrr8/DE5c986NbOwAP0PPJVtb+pPSw6SdnQZBElgi2aW3LpXc3a71xqjRanJF5H43+
         X7eA==
X-Gm-Message-State: AOAM53226GYQL1vgramRZydSfbyA9Voxvs/XkFZ+7Pb22Q8VOE0pVQGP
        YV1zFLYu+7KCkJo1tV9lA+OF9w==
X-Google-Smtp-Source: ABdhPJzhvh9f1x5ilf1AmvBGKQ2Mc38ag05TWKgHPLr2/mNrAIPJWbDg+1F5AUFIqTqv+z6yQt/nqQ==
X-Received: by 2002:a1c:6283:: with SMTP id w125mr19819076wmb.155.1610963632505;
        Mon, 18 Jan 2021 01:53:52 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id f68sm15081928wmf.6.2021.01.18.01.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 01:53:51 -0800 (PST)
Date:   Mon, 18 Jan 2021 09:53:50 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Elena Petrova <lenaptr@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        George-Aurelian Popescu <georgepope@google.com>,
        Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        George Popescu <george.apopescu97@gmail.com>
Subject: Re: [PATCH v3 1/9] KVM: arm64: Enable UBSan instrumentation in nVHE
 hyp code
Message-ID: <20210118095350.j5dy7om6dfn276cj@google.com>
References: <20210115171830.3602110-1-lenaptr@google.com>
 <20210115171830.3602110-2-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115171830.3602110-2-lenaptr@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:18:22PM +0000, Elena Petrova wrote:
> From: George-Aurelian Popescu <georgepope@google.com>
> 
> Implement UBSan handlers inside nVHe hyp code, as empty functions for the
> moment, so the undefined behaviours, that are triggered there, will be
> linked to them, not to the ones defined in kernel-proper lib/ubsan.c.
> 
> In this way, enabling UBSAN_MISC won't cause a link error.

The commit message needs to be updated - UBSAN_MISC does not exist any longer.
Also "nVHe" is a typo.

Other than that:
Acked-by: David Brazdil <dbrazdil@google.com>

> 
> Signed-off-by: Elena Petrova <lenaptr@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/Makefile |  3 ++-
>  arch/arm64/kvm/hyp/nvhe/ubsan.c  | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan.c
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 1f1e351c5fe2..2a683e7c6c5b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -10,6 +10,8 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
>  	 hyp-main.o hyp-smp.o psci-relay.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>  	 ../fpsimd.o ../hyp-entry.o ../exception.o
> +obj-$(CONFIG_UBSAN) += ubsan.o
> +CFLAGS_ubsan.nvhe.o += -I $(srctree)/lib/
>  
>  ##
>  ## Build rules for compiling nVHE hyp code
> @@ -61,7 +63,6 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAG
>  # cause crashes. Just disable it.
>  GCOV_PROFILE	:= n
>  KASAN_SANITIZE	:= n
> -UBSAN_SANITIZE	:= n
>  KCOV_INSTRUMENT	:= n
>  
>  # Skip objtool checking for this directory because nVHE code is compiled with
> diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
> new file mode 100644
> index 000000000000..a5db6b61ceb2
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Google LLC
> + * Author: George Popescu <georgepope@google.com>
> + */
> +#include <linux/ctype.h>
> +#include <linux/types.h>
> +#include <ubsan.h>
> +
> +void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs) {}
> +
> +void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs) {}
> +
> +void __ubsan_handle_mul_overflow(void *_data, void *lhs, void *rhs) {}
> +
> +void __ubsan_handle_negate_overflow(void *_data, void *old_val) {}
> +
> +void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs) {}
> +
> +void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr) {}
> +
> +void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr) {}
> +
> +void __ubsan_handle_out_of_bounds(void *_data, void *index) {}
> +
> +void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs) {}
> +
> +void __ubsan_handle_builtin_unreachable(void *_data) {}
> +
> +void __ubsan_handle_load_invalid_value(void *_data, void *val) {}
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
