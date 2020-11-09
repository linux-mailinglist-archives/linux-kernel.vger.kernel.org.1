Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB632AC19B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgKIQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIQ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:59:39 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:59:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so7936494wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xpU6aOe7zsc2ojDYPHqW1B2hesNecHBAri6xa34+HU=;
        b=ub6t8/MOSTRAo1q64ajRgsXANVnqPQ0Z+9yCni3FNC/THKKkF0KWrlmaz4Olll8n91
         kVKuS1MZQFSC+t2hiWbsvar3jXt0qc4njXZbFuvLN1ktikhMbKhhMP1Wc8q/Yv/TPP+b
         hJ/NE1YGg+VVLbCCGwZqOoijzhJ6rvi/OyPoa3eCHndq0cb9TzQ80jQHnMpFHsHFbMsW
         Ft2Z4y5VsrwEdcbniSqDvm5r6hrmmARhroKk1GDg7iOaPJ7T8d6t7PSsh9AjUU6TsIIy
         MB6nqhIpOYeFZ/s894F5jblZArz/cSbk1ckM9cDku2Kgjpo3YCxBR4jSgQsufS9ldBO0
         c6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xpU6aOe7zsc2ojDYPHqW1B2hesNecHBAri6xa34+HU=;
        b=XwSNkSxNmspPvVKPnLu7F7jXAP3HaQW1uYYHHwNrYEn74NabKZOUYsoOQ7MWmg6s19
         994Kl4dLz1vzvZBgeQ73vuspN+cYQny/XFuK4BFgbeftD8pu5p7Uph0J/bJ7SgeK/ben
         qSUbLf0lEsmYxksDeDZihaT7dUWsMFVyxEROqEZpPSIX37k4MAl8rQZzZYcJBTZ6Ry1a
         JHGnsRALRDSmFdLqe6AQPfjMbwIzBkYojInS0YZLDVsqfRHAgi/ZTPwmWqdsklebXqL2
         7pyLS1IPNOBKoml5WRkMnO4cy2cEn2KwEDSUilmWtTZrkvQaZqTkkk0n6cN1TsZakjoS
         sG2w==
X-Gm-Message-State: AOAM533UCLVljOK7LqwyA0plnxifCtijOrMNqLqpaZB4YBIUgz8Iun31
        8Uw3nioA4/PuFPIFCYEdM8iJNw==
X-Google-Smtp-Source: ABdhPJxTSTLsT2jswsky+1lrZdCHipmnbSyPEtOAfZOAYkuKuCpAmY1FsIwpQPGF3duv+aoj3xTxKw==
X-Received: by 2002:a5d:6689:: with SMTP id l9mr12801967wru.134.1604941177704;
        Mon, 09 Nov 2020 08:59:37 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id b8sm7527771wrv.57.2020.11.09.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:59:37 -0800 (PST)
Date:   Mon, 9 Nov 2020 16:59:33 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 17/24] kvm: arm64: Add __hyp_pa_symbol helper macro
Message-ID: <20201109165933.GA447754@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-18-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109113233.9012-18-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey David,

On Monday 09 Nov 2020 at 11:32:26 (+0000), David Brazdil wrote:
> Add helper macro for computing the PA of a kernel symbol in nVHE hyp
> code. This will be useful for computing the PA of a PSCI CPU_ON entry
> point.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/psci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
> index b0b5df590ba5..7510b9e174e9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci.c
> @@ -20,6 +20,16 @@ s64 hyp_physvirt_offset;
>  
>  #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
>  
> +#define __hyp_pa_symbol(sym)					\
> +	({							\
> +		extern char sym[];				\
> +		unsigned long kern_va;				\
> +								\
> +		asm volatile("ldr %0, =%1" : "=r" (kern_va)	\
> +					   : "S" (sym));	\
> +		kern_va - kimage_voffset;			\
> +	})
> +

Could this be simplified to __hyp_pa(hyp_symbol_addr(sym))? That would
avoid the dependency on kimage_voffset.

Thanks,
Quentin
