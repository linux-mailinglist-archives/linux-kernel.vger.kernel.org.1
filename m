Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD51A2FC09B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404335AbhASUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392215AbhASUGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:06:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97529C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:05:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id o20so4554185pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dEsHTOhzjzO6o9rD2N5DWat/JJ7Q/inxXOWFBgJvDTI=;
        b=K+bN7LxeDH9XpNlaRCisKxW2aaVCwJe4CNdTG6tvSMlY1NKYzVqi/c0D296XP5aKcQ
         vUnMolIDkQbec9Fxty0H5C7DMbnEja+e8mtAWtjuIXBlC69TJ+lZ2jBFF0EUm3YF4y4+
         mscHktxp4ZgF386MBk+ktfaMNkksLFDDCZPRSOlxx5FvNGZWrtkyH/zYAi+8i0kUhjHe
         6avmHs3Ff9t4FL8Mc3UN62O8S71aW3FfzgZEP2LTpvtvC4PL/6cQ7eI+u+8CsLOkNf4w
         zAwWWTe55Wff5axBTrbbA7IsfG91LIvnbel6MIKkmqYhg3Q1NbbsuvTpn2lpi71QiCCd
         qZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dEsHTOhzjzO6o9rD2N5DWat/JJ7Q/inxXOWFBgJvDTI=;
        b=Pi7y3gKaVJus5Gm20odDNiyYq2l+9G+In2QBbtKWUq1DCzjFvzuKg9KBpbgxwYOlK3
         KbtBPFNRW+QA4esg5kDYO2yRgHHIteOv0s7cAZjor+C6Q7dB0MVK5hKcG5SRefIc0APK
         knsrMuMjiIaenGo/c69xoXcS4AB74P9QjZP+ImiuqgH1AHmukjeYriPWUUMNZuAWk7tD
         LKvJoMtYqBZmBCky5Yn1fTdbqzotxG38fAREMtkWA1eCNvMpgehLS08begpWuOf013Pk
         Dp5mglvXiPJ6eJyKPmwPJ2Ix+PYvngjcI4ahpcqkuGQTy75KpfkcK6t7gEpdp3WRK4dl
         2HcA==
X-Gm-Message-State: AOAM531gW2+he1L5QEG8KIS04d0E6Dp3fRFaxJ6sFkaZO2SzevCF4sdC
        uDf1h86QU8/E48z0ZusXv7wEHw==
X-Google-Smtp-Source: ABdhPJxmIAjwqUXjXQNHFrRcsGx95boV03xzh9T8vnt0imRm6wf7NGD39Q/j7y43K/NTXLpdtIKPXw==
X-Received: by 2002:a62:a508:0:b029:1ba:621:ff29 with SMTP id v8-20020a62a5080000b02901ba0621ff29mr2692033pfm.44.1611086734975;
        Tue, 19 Jan 2021 12:05:34 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id a9sm19613789pfn.178.2021.01.19.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:05:34 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:05:27 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, haitao.huang@intel.com,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] x86/sgx: Allows ioctl PROVISION to execute before CREATE
Message-ID: <YAc7h3zQR06eWPhZ@google.com>
References: <20210118133335.98907-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133335.98907-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021, Tianjia Zhang wrote:
> In function sgx_encl_create(), the logic of directly assigning
> value to attributes_mask determines that the call to
> SGX_IOC_ENCLAVE_PROVISION must be after the command of
> SGX_IOC_ENCLAVE_CREATE. If change this assignment statement to
> or operation, the PROVISION command can be executed earlier and
> more flexibly.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index f45957c05f69..0ca3fc238bc2 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -108,7 +108,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl->base = secs->base;
>  	encl->size = secs->size;
>  	encl->attributes = secs->attributes;
> -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
> +	encl->attributes_mask |= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;

Alternatively, move the existing code to sgx_open()?  Initializing the field
when the encl object is allocated feels more correct.

>  	/* Set only after completion, as encl->lock has not been taken. */
>  	set_bit(SGX_ENCL_CREATED, &encl->flags);
> -- 
> 2.19.1.3.ge56e4f7
> 
