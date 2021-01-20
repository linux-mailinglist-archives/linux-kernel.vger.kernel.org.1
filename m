Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518F12FD578
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbhATQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403869AbhATQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:21:13 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE9C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:20:33 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o20so6383542pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MBqThV9Olupan+r++p/11MWGguLV0PkDywP+wSQi6Ys=;
        b=uHr2OtDySDWynGYYVHmG0ZLx5k0Xy3+cFC6x79NNNa1TrWBKQOCABpQ2bdlD2NfWMi
         +/GIjyJLmUCsaXB/23nUzfp1zu2SliNMi8A6LgxHad+C/2ZVK5kZFAW+jOYUu/xSZk1z
         EeUJsxPMVvRK6t87oEbGkUYD9HUWh+/eZHJk0qPLpKgo5PyjgsRk7/fUTcvhL2CkJFXs
         KqzPtAqvrzSyUY9ug0lU74cZsa3LZPrDUIO4XYFHc92PGnpclqfTtS9yQcUmZyxRCM/d
         IMe3GOyNJNRshNj9B5TpSjLH3tG7KBOic6wfjWmCytNxziT4f9tJX+9TY7otjNedyENs
         zVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MBqThV9Olupan+r++p/11MWGguLV0PkDywP+wSQi6Ys=;
        b=mLvH02fGYrRYBtQC8pJDFx2ihgFoVDyzgtX+riXOZ3bPk/fUvelcqstf4YZPGxJXJs
         cEeB16gg9gII2OMp3XXL7HVH+cuANs9o2MqiB1k6c572fAGGMDbIuIjXyj83VYEBeH7c
         O1wjatDyZQT1+huMhYhGF7TjScOlih1qzpBMjqyaMOzdb8JsZ+fMwlDRLMezo6IRwHrT
         sT4/Oqg6U77LhV/wSBQDz1zNsOJH3CIFuiWodvajqTG+M7foELmqO1dqSFwbV5Xk618L
         LGwBpTFqgdtd8xOtU4pCooZWOrdx9juYUNITS1zRkWLEDknIbLpwu4lv6QpcP8goP/Jj
         op8w==
X-Gm-Message-State: AOAM533z2c/ArFUF0c96S+vrBVn6fefHftnD6ZIaHX09Is8+Rjw9dWty
        zpEwFrKw4vSveY6Z1WfA+zogQA==
X-Google-Smtp-Source: ABdhPJwXLSuAW3fgaBQRD1DO4EwQ6ZcDffSH9Tq2hezveyi9uLHs9gN6QuMVUx0nykOdqHLOYMS/7A==
X-Received: by 2002:a63:e40e:: with SMTP id a14mr10073281pgi.345.1611159632434;
        Wed, 20 Jan 2021 08:20:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id h6sm3049073pfr.47.2021.01.20.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:20:31 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:20:25 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v2] x86/sgx: Allows ioctl PROVISION to execute before
 CREATE
Message-ID: <YAhYSdpIr60EUnRI@google.com>
References: <20210120035309.19545-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120035309.19545-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021, Tianjia Zhang wrote:
> In function sgx_encl_create(), the logic of directly assigning
> value to attributes_mask determines that the call to
> SGX_IOC_ENCLAVE_PROVISION must be after the command of
> SGX_IOC_ENCLAVE_CREATE. If move this assignment statement to
> function sgx_open(), the PROVISION command can be executed
> earlier and more flexibly.

Use imperative mood to describe what you're doing, e.g. the "if" leaves the
reader wonder whether it's a suggestion or what the patch is actually doing.

E.g. something like

  Move the initialization of an enclave's allowed attributes_mask to
  sgx_open() to allow the ENCLAVE_PROVISION ioctl() to be invoked before
  ENCLAVE_CREATE.

> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/sgx/driver.c | 3 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c  | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
> index f2eac41bb4ff..8766580194ae 100644
> --- a/arch/x86/kernel/cpu/sgx/driver.c
> +++ b/arch/x86/kernel/cpu/sgx/driver.c
> @@ -36,6 +36,9 @@ static int sgx_open(struct inode *inode, struct file *file)
>  		return ret;
>  	}
>  
> +	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
> +				SGX_ATTR_KSS;

Probably don't need a newline before SGX_ATTR_KSS.  In fact, I wouldn't be
surprised if Boris explicitly requested letting the original code go past 80
chars to improve readability.  Either way, with a cleaned up changelog:

Reviewed-by: Sean Christopherson <seanjc@google.com> 

> +
>  	file->private_data = encl;
>  
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 90a5caf76939..1c6ecf9fbeff 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -109,7 +109,6 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl->base = secs->base;
>  	encl->size = secs->size;
>  	encl->attributes = secs->attributes;
> -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>  
>  	/* Set only after completion, as encl->lock has not been taken. */
>  	set_bit(SGX_ENCL_CREATED, &encl->flags);
> -- 
> 2.19.1.3.ge56e4f7
> 
