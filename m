Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8F2FC0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbhASU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbhASUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:25:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:24:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so658419pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PIgo1AoKq/QNkl9sdqmNCwvTTcuChuuT7IVQW1TPqHU=;
        b=XCX8haXoigSPZNeJRbH+qv688CZq5/UyppWpQdrMjVLWBGmHTsUeojs9xqrJ1UNRpX
         adChEPtxT3v/RpLbyp917BxfRPL+B1TYS/Y3Pt8Ebcci9kYo6v2EdKMKFn+h7YPDafnz
         oDyUWlBwkA/fA7yJt95Ie9bWRd54658cyCiBrZCb6iEgwvMTasedX/K2+Y0sR01Mmhwr
         Sy1pvX2oSngUSICr2xWyi8eTo8569NE0hqQVTv6AnXeaim8qXH8357Ftx8uCizocqHuk
         qU+8xm8eKvcfhEYLl59Ki5r7YfA8nC88FbzRbakerXFWtnRSaUuXIfk9RAddEQICmORl
         DPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PIgo1AoKq/QNkl9sdqmNCwvTTcuChuuT7IVQW1TPqHU=;
        b=gIPL+Dy/T71Q99kB+LWgloTgwM88BAj1GZhrdWiqNGOJ3pEWi08IvWAcLtG2w4C8tL
         2WzWedhoY45lhu2jY7fxQrVyU6I4qYHa+yk0nyqr00PrS5vuxjf+yuZ62fNbVDEKxWf9
         XJnlWCEDwsY0FTuJOV+DRy60nCEVmapr8KEDZNBwB5oYgEJx8CUo6if8rn3C6gIs6lqZ
         yLiYz0shlyM+wtbhJthqT0yMiF8VVM+OM0gkTzhVdF55+b1LZIvrpLn5acKJCHrpxglB
         hoNZZ+/glRXCuZBygC1piJRZ6qd9uK8a8OFX4Iz1u/BuUXFUpqF5pCUSbVuxB5X51yoy
         WCTA==
X-Gm-Message-State: AOAM530UvmvSQ9lEo0Y6HdlkGj5gK2n7jwJUcJTb7Mv07+e82ZE2uWrP
        dCzeNm1gHCLurQwBkHj76kV80g==
X-Google-Smtp-Source: ABdhPJxJHsccxJIQ/ZXXRzDM/ux4QViH9HBl44g/0iJToKDtBxr3CY4v45NE2/X87p2CEuXItieFRQ==
X-Received: by 2002:a17:902:ce81:b029:de:6b3c:fcd2 with SMTP id f1-20020a170902ce81b02900de6b3cfcd2mr6433539plg.67.1611087883265;
        Tue, 19 Jan 2021 12:24:43 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id p15sm19706701pgl.19.2021.01.19.12.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:24:42 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:24:35 -0800
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
Subject: Re: [PATCH] x86/sgx: Fix free_cnt counting logic in epc section
Message-ID: <YAdAA6k7ZjqikE0R@google.com>
References: <20210118133347.99158-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133347.99158-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021, Tianjia Zhang wrote:
> Increase `section->free_cnt` in sgx_sanitize_section() is
> more reasonable, which is called in ksgxd kernel thread,
> instead of assigning it to epc section pages number at
> initialization. Although this is unlikely to fail, these
> pages cannot be allocated after initialization, and which
> need to be reset by ksgxd.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Sean Christopherson <seanjc@google.com> 

> ---
>  arch/x86/kernel/cpu/sgx/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index c519fc5f6948..9e9a3cf7c00b 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -48,9 +48,10 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>  					struct sgx_epc_page, list);
>  
>  		ret = __eremove(sgx_get_epc_virt_addr(page));
> -		if (!ret)
> +		if (!ret) {
>  			list_move(&page->list, &section->page_list);
> -		else
> +			section->free_cnt += 1;
> +		} else

Nit: the the "else" should also have curly braces.

>  			list_move_tail(&page->list, &dirty);
>  
>  		spin_unlock(&section->lock);

FWIW, taking section->lock could be moved inside the !ret flow so that EREMOVE
is done without holding the lock.  I've no idea if that'd actually change
anything in practice, but it's theoretically possible that ksgxd hasn't finished
sanitizing the EPC when userspace starts creating enclaves.

> @@ -646,7 +647,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
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
