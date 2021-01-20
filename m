Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC652FD5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403889AbhATQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391470AbhATQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:27:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EC0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:27:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id p18so15499765pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6t8lIgtuar9+s884zrcCGunoGFI/cGmR+eRx6cwTKyA=;
        b=MPP/+wUKoze/haoerTH7BHaM2dJr1jwyfgdp5zkk4hD8jlpk+fFbidiCfNyrlaorXM
         lzPae+2FklwoExVYZm2xucxpEmzh82XB8+m287adQp7CXeiHIyQCC75MxVG+bOUZPYad
         88f9lAIcVAvkDkdH7ASQvPRCV0nlAVb9JvwsSuNdBnMVDWlpbRi4iPgv4i2kSJkQsCmT
         lxVuhe9NNDZacJflG22XQNio9h1nXbkJzEeiF1l5ccX/MJ6hKpAin8oqqqGQ8qx5fc3/
         gDArMHrdDWjzpbNmJtybAghkjVJXHATb/iVIMkx70NSQncRWqdkAIbDIwdfn4CPtKZyS
         UC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6t8lIgtuar9+s884zrcCGunoGFI/cGmR+eRx6cwTKyA=;
        b=g59Xw2A8EP8I3WVUzaO9ZU1Xtuw8rwgO2+4hjIsk2eICU0IMMT28Tifqx8kEPkaI92
         6wazdiJwWdgFX6Dv5lQUg7sg87rMboD5e2yZbExP0pNkps8kQ1Qxdxs5YBHN73oDuNtX
         Xc+CWaMfaiLlwz8uHcrfFtOLViZiJJBFsus7C+gDgV0V5jABa9PxcQxb2jCw2S0WrKE9
         q+il3RxcfYI4LlvXzvkx19IHp13X6B0hYPDbFtEDRxUOdw5zoxe64YAjSiozWrhwOalj
         OA0k/J510vJnPIemu+G8b00lTOBitCdr3H0Ewkae6mgtEhDzHqt/J03+9i/KyIDcTZGk
         j2FA==
X-Gm-Message-State: AOAM5330PK8zjbV4ILNrhb7gUFjjP2eRMHkhkg8TKHDF0Dlk04S7eohl
        NO987eXgViN9tSUpVyBxAFlBsg==
X-Google-Smtp-Source: ABdhPJz7dUcR1alzxkCcyHLt1xuXoOZnOv77pS6JOGtFsS/jVbsXQI+VxnB7Mp7CPzHx6f7db+yiDg==
X-Received: by 2002:a65:628a:: with SMTP id f10mr9991712pgv.380.1611160030001;
        Wed, 20 Jan 2021 08:27:10 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id k141sm530954pfd.9.2021.01.20.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:27:09 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:27:02 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v2] x86/sgx: Fix free_cnt counting logic in epc section
Message-ID: <YAhZ1vydPiLtDOcj@google.com>
References: <20210120035320.19709-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120035320.19709-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021, Tianjia Zhang wrote:
> Increase `section->free_cnt` in sgx_sanitize_section() is more
> reasonable, which is called in ksgxd kernel thread, instead of
> assigning it to epc section pages number at initialization.
> Although this is unlikely to fail, these pages cannot be
> allocated after initialization, and which need to be reset
> by ksgxd.
> 
> At the same time, taking section->lock could be moved inside
> the !ret flow so that EREMOVE is done without holding the lock.
> it's theoretically possible that ksgxd hasn't finished
> sanitizing the EPC when userspace starts creating enclaves.

Moving the lock should be in a separate patch, they are clearly two different
functional changes.

> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>

Moving lock was suggested by me, the original patch was not.

> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index c519fc5f6948..34a72a147983 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -41,16 +41,18 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>  		if (kthread_should_stop())
>  			return;
>  
> -		/* needed for access to ->page_list: */
> -		spin_lock(&section->lock);
> -
>  		page = list_first_entry(&section->init_laundry_list,
>  					struct sgx_epc_page, list);
>  
>  		ret = __eremove(sgx_get_epc_virt_addr(page));
> -		if (!ret)
> +
> +		/* needed for access to ->page_list: */
> +		spin_lock(&section->lock);

This can actually be even more precise, as the lock doesn't need to be taken
if __eremove() fails.  The lock protects section->page_list, not page->list.
At that point, the comment about why the lock is needed can probably be dropped?

> +
> +		if (!ret) {
>  			list_move(&page->list, &section->page_list);
> -		else
> +			section->free_cnt += 1;

Belated feedback, this can use "++".

> +		} else

Need curly braces here.

E.g. when all is said and done, this code can be:

		if (!ret) {
			spin_lock(&section->lock);
			list_move(&page->list, &section->page_list);
			section->free_cnt++;
			spin_unlock(&section->lock);
		} else {
			list_move_tail(&page->list, &dirty);
		}

>  			list_move_tail(&page->list, &dirty);
>  
>  		spin_unlock(&section->lock);
> @@ -646,7 +648,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>  		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
>  	}
>  
> -	section->free_cnt = nr_pages;
>  	return true;
>  }
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
