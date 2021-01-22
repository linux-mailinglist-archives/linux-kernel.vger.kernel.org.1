Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808E530007D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbhAVKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbhAVKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:34:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE061C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:33:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so4591694wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qsVmGWHN+aWas1ndy6vVi8X4aWqjPl6LXWdXgXgZ6hE=;
        b=AmidOvt0BWeDL5UDH6nolVCvRaYhkLdwRsroCNnOcsARgZY2yplFFZyMriHytFx25N
         XTyrNFCAY3e19+ch/izUUxar0Q0sYEi/FFXqmUK2ERpkzK7pnjuUBu/tfO14vwteRKUY
         luJTD9sd9md+mQdoNUY7R2NGXfgxY9Mie6G6RdbR7j8Ta486lODqifuvquuG6Fpd79aw
         xVFubvHxBlLe9cxPXKzzZ8j/AzuzOhAQBeJJriPKKkw1hNU/N41+mTa6mMAcPGPT7/5L
         uJMAzUc3KmcmrHjR8/FJwWlo6Ej9ZV8i90vTkZpaLPXOD+BjrMQiIWTBMvTfC0R5FJvD
         7Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qsVmGWHN+aWas1ndy6vVi8X4aWqjPl6LXWdXgXgZ6hE=;
        b=V3Y6FSYJ7Oxn9BKLo7c4wH1Ymb+GgeblveTLjl/hDk+C8F/3wGqEUyK+1aabyD3zoz
         pZPC1T6f1EkeX9OebnBI6MG5ZJXxbi8LCQaZCFic9Q0njeMweCpipHolFGqBKJVHPyFp
         9ec4PxGjjVxK0RhfXGe1K/S5d9pNyLAbwy5BnpxryzCXHN1blXDbPBHLG2W3msixqKT/
         73pEBvdNQ7xVIBpIxVIz73F6Jz1MiHgulhQuqgb5LQyRG8GdzhjEEB7RJvSRx28mCzFi
         WuvYMuKOCoqBtRHCzD6Aw17bk/0XX7jcq6UMZtk0i7/N1OeDqnyk9duK0OPk8LcPZnXL
         gjiA==
X-Gm-Message-State: AOAM532oeyoyVnrfi4sT/nzuIPPaKLtylVgMCa1Hat5lNWNyvj5fP0wv
        qK2g1CZdjStO8s7ZkhU2USJ/Hg==
X-Google-Smtp-Source: ABdhPJyIDmWFqA4gaAO68QLMD1nAkxDh4PtWNNL8FlfQVE7BnDTlQrS9lz0Zj1rHBJ6hXiT1eYaobw==
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr3890550wru.0.1611311638694;
        Fri, 22 Jan 2021 02:33:58 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q63sm11090728wma.43.2021.01.22.02.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 02:33:57 -0800 (PST)
Date:   Fri, 22 Jan 2021 10:33:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Make memory allocations more robust
Message-ID: <20210122103356.pekf7wx3smknyotl@maple.lan>
References: <1611310850-3339-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611310850-3339-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 03:50:50PM +0530, Sumit Garg wrote:
> Currently kdb uses in_interrupt() to determine whether it's library

Looks like a good change just a few nitpicks with the description:

s/it's/its/

> code has been called from the kgdb trap handler or from a saner calling
> context such as driver init. This approach is broken because
> in_interrupt() alone isn't able to determine kgdb trap handler entry via
> normal task context such as [1].

Why footnote this and aren't breakpoints a far more natural reason to
enter the debugger?

The following will be clearer for backporting, etc:

... detmermine kgdb trap handler entry from normal task context. This
can happen during normal use of basic features such as breakpoints
and can also be trivially reproduced using: echo g > /proc/sysrq-trigger



> 
> We can improve this by adding check for in_dbg_master() instead which
> explicitly determines if we are running in debugger context.
> 
> [1] $ echo g > /proc/sysrq-trigger
> 

Cc: stable@ ?


> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>


Daniel.



> ---
> 
> Changes in v2:
> - Get rid of redundant in_atomic() check.
> 
>  kernel/debug/kdb/kdb_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index 7a4a181..344eb0d 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -231,7 +231,7 @@ extern struct task_struct *kdb_curr_task(int);
>  
>  #define kdb_task_has_cpu(p) (task_curr(p))
>  
> -#define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
> +#define GFP_KDB (in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
>  
>  extern void *debug_kmalloc(size_t size, gfp_t flags);
>  extern void debug_kfree(void *);
> -- 
> 2.7.4
> 
