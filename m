Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDB2F9D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbhARLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbhARLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:07:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0145C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:06:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so16052559wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NnBFT8EP9V7MmU84deKSaC5Ci7/3yuRujoqea2uYBqU=;
        b=S0v70/XeJSnyzyiifqGs12j42+wMyVfdZmFp9vAYkXCvNspcgkhHm/aAnQRXxVKwXn
         xMc//0tppKYCReKyia6kMXMXxqRWsrWfKSwZ+LPj8fybmUm1d6i1vYA87dayQ08MyOUc
         0p6Akb3D1OU7oM6tdHFfjG3TkuwOE22g9Eqvgr8tCeZ9J9ESNatB5rJHEaL49J/XzUYf
         qe/5UI+KoiKw5ugbwxf6Dph+sNadI0zgVCRMqckEhTL5F2NEWen6hNvI4IiTIZ5yzVvT
         ko0skt3XiUtvAqGdh6+/oV51WMeZ7c1SEhK/K0YPo731oBI195bJhJXW106wUlun6yJy
         2TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NnBFT8EP9V7MmU84deKSaC5Ci7/3yuRujoqea2uYBqU=;
        b=gmJskgvS8F1NVBzF9Pwxq/GD1J3XueHvOgyrDwXAiuHWIafdtX5i4Dt9vGqTjeRk3r
         InW6uQko0nAQLhriu/NF2Dw4DLJXyy0trqsBifNmwn/VcQzEUnhMkiel5rT+A1ARaCDi
         27pup06V4t/pVRQEL4WkjBSJGV5ULV+IPp8O69xJ5TaQ2PKxnnMWU3sXUbb+ysj5pTNX
         ENIsosESdmTWEST4P9NRJBTlp0n54ELuwdXwUm9gERDXDIiBIdbpUWxVOfpkiUcIs3hC
         Ij92/wRs9TwOttYOYOyMlHE/RlpGv8NwwKSY6jKTEl5Nu0To2KNZEySG2TtskNojl/rF
         godg==
X-Gm-Message-State: AOAM530DGdMW9z3goZ+CvHRJ12zzfo1lv4f0+//S8SoeiGoVE62DQbCd
        5M12/q0c/XwVnvgiLAeKqYNNYw==
X-Google-Smtp-Source: ABdhPJwWGXCEWcvWmyWLYTOB7DQ3+9c+Y1HcC/heAJVGshcFFa64ZS5RxK5AbQjre5wgJBvYLRmsBQ==
X-Received: by 2002:a5d:40ce:: with SMTP id b14mr24876133wrq.350.1610968003510;
        Mon, 18 Jan 2021 03:06:43 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id g1sm29961893wrq.30.2021.01.18.03.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:06:42 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:06:41 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Elena Petrova <lenaptr@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        George Popescu <georgepope@google.com>,
        Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        George Popescu <george.apopescu97@gmail.com>
Subject: Re: [PATCH v3 3/9] KVM: arm64: Enable UBSAN_BOUNDS for the both the
 kernel and hyp/nVHE
Message-ID: <20210118110641.ak4jlzu34lxzluzy@google.com>
References: <20210115171830.3602110-1-lenaptr@google.com>
 <20210115171830.3602110-4-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115171830.3602110-4-lenaptr@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:18:24PM +0000, Elena Petrova wrote:
> From: George Popescu <georgepope@google.com>
> 
> If an out of bounds happens inside the hyp/nVHE code, the ubsan_out_of_bounds
> handler stores the logging data inside the kvm_ubsan_buffer. The one responsible
> for printing is the kernel ubsan_out_of_bounds handler. The process of
> decapsulating the data from the buffer is straightforward.
> 
> Signed-off-by: George Popescu <georgepope@google.com>
> Signed-off-by: Elena Petrova <lenaptr@google.com>
> ---
>  arch/arm64/include/asm/kvm_ubsan.h | 19 ++++++++++++++++++-
>  arch/arm64/kvm/hyp/nvhe/ubsan.c    | 14 ++++++++++++--
>  arch/arm64/kvm/kvm_ubsan_buffer.c  | 10 ++++++++++
>  3 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
> index fb32c7fd65d4..4f471acb88b0 100644
> --- a/arch/arm64/include/asm/kvm_ubsan.h
> +++ b/arch/arm64/include/asm/kvm_ubsan.h
> @@ -9,6 +9,23 @@
>  #define UBSAN_MAX_TYPE 6
>  #define KVM_UBSAN_BUFFER_SIZE 1000
>  
> +
> +struct ubsan_values {
> +	void *lval;
> +	void *rval;
> +	char op;
> +};
> +
>  struct kvm_ubsan_info {
> -	int type;
> +	enum {
> +		UBSAN_OUT_OF_BOUNDS,
> +	} type;
> +	union {
> +		struct out_of_bounds_data out_of_bounds_data;
> +	};
> +	union {
> +		struct ubsan_values u_val;
> +	};

I don't see this second union having more members later in the series.
Remove it? Even the 'struct ubsan_values' seems redundant and we could just
have those three fields directly here.

>  };
> +
> +void __ubsan_handle_out_of_bounds(void *_data, void *index);
> diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
> index 8a194fb1f6cf..55a8f6db8555 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
> @@ -13,7 +13,6 @@
>  #include <asm/kvm_ubsan.h>
>  #include <asm/kvm_debug_buffer.h>
>  #include <kvm/arm_pmu.h>
> -#include <ubsan.h>
>  
>  DEFINE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
>                  kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
> @@ -44,7 +43,18 @@ void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr) {}
>  
>  void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr) {}
>  
> -void __ubsan_handle_out_of_bounds(void *_data, void *index) {}
> +void __ubsan_handle_out_of_bounds(void *_data, void *index)
> +{
> +	struct kvm_ubsan_info *slot;
> +	struct out_of_bounds_data *data = _data;
> +
> +	slot = kvm_ubsan_buffer_next_slot();
> +	if (slot) {
> +		slot->type = UBSAN_OUT_OF_BOUNDS;
> +		slot->out_of_bounds_data = *data;
> +		slot->u_val.lval = index;
> +	}
> +}
>  
>  void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs) {}
>  
> diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
> index 4a1959ba9f68..a1523f86be3c 100644
> --- a/arch/arm64/kvm/kvm_ubsan_buffer.c
> +++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
> @@ -17,6 +17,15 @@
>  DECLARE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
>  		kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
>  
> +void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
> +{
> +	switch (slot->type) {
> +	case UBSAN_OUT_OF_BOUNDS:
> +		__ubsan_handle_out_of_bounds(&slot->out_of_bounds_data,
> +				slot->u_val.lval);
> +		break;
> +	}
> +}
>  
>  void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
>  {
> @@ -26,6 +35,7 @@ void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
>  	slot = (struct kvm_ubsan_info *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buffer);
>  	for (i = left; i < right; ++i) {
>  		/* check ubsan data */
> +		__kvm_check_ubsan_data(slot + i);

Not sure why this is breaking out into another function. The code will not
be shared with any other user.

>  		slot[i].type = 0;

This invalidation is redundant. The buffer's cursor will be reset on next
hypercall, which will implicitly invalidate all entries.

>  	}
>  }
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
