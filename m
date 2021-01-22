Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD3300055
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbhAVKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbhAVJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:49:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50887C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:48:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m1so3754446wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=STsRtcsh5EZY9rIDA5wX7lDe2Z60MDFpJfKdBbxUPaQ=;
        b=VSI2yvYK00AS6ys7r97tMDnuUsFWaE9s8dqZzJpILB87gbIMU8P2izNPKr+5vx8/is
         phdD3Gg1bIRJeQdtYHAcjt9v8A1gSTEVlxrzNMke7PokhNP7J8oPDlLk/T3xzk/Uq4Mr
         rhgAhst7kyyOhBpYu/wAJfI3UqZybSKe6QFTYbqWtkuVs2XW2bTAC3+Vx4kUxKgEh/hM
         pGNSgmOxauY+IsNdxbALkz7qCFYMsdgiRSIAW11202tKLCN6PQso1qfNRp4+cWzQvxgu
         l7+uJ6yZMKQ/4fnjvSLZSYVC7mol3C3G6M72sI6dnsym1aTTtdqOszjrv5Zm3sQPsfMZ
         Z6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STsRtcsh5EZY9rIDA5wX7lDe2Z60MDFpJfKdBbxUPaQ=;
        b=VStoviiJ8tl6XxLhlPR9GT+XZw4Jw5m06QeMt7wRZLH8Pe9d2tnO7KROqVFENh1Ja5
         SnaVRMfAogQo6g+7TP3YkzE1IaQdoXs4y+ux+WR42sXxHb0l23M7Zc7rcjUju+NzDtvq
         ZIylLChGTgFK9zU+cRLteAqWCSa0NpuzeOQEUz0he9okPIRwPXDHdkzUOL5xmkZo9uv0
         oDhxz8H1zH0AaZfng3+rOfPucrc7Z+Hd8SS5ON8x5cSB7bBKK47QWUz/fc3KEvOtBOY6
         b3ZahwKd55WQcI4SlnCk9EsKI4ap2V6uWhXnGhi9JyjJRNYLmbqSqmoeWvwGipGw0YYp
         QEKg==
X-Gm-Message-State: AOAM530v3PfFiGyHDw3moFiqm3O1sOGYku+eB0Yu+irOSy0wWpW3A0KX
        wVz0Ny3RftOa5ZwySSjw+pc7SQ==
X-Google-Smtp-Source: ABdhPJzfdUU5skgC5NOdL/+mlNzybWwl8Q5QHaldHgp/250cx1oiZTg2l3L0OOCkt/b0yJ8ytz+skA==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr462539wrw.410.1611308892995;
        Fri, 22 Jan 2021 01:48:12 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n193sm10924529wmb.0.2021.01.22.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 01:48:12 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:48:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Make memory allocations more robust
Message-ID: <20210122094810.6o32gzoqtwgqi5hn@maple.lan>
References: <1611308311-2530-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611308311-2530-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 03:08:31PM +0530, Sumit Garg wrote:
> Currently kdb uses in_interrupt() to determine whether it's library
> code has been called from the kgdb trap handler or from a saner calling
> context such as driver init. This approach is broken because
> in_interrupt() alone isn't able to determine kgdb trap handler entry via
> normal task context such as [1].
> 
> We can improve this by adding check for in_dbg_master() which explicitly
> determines if we are running in debugger context. Also, use in_atomic()
> instead of in_interrupt() as the former is more appropriate to know atomic
> context and moreover the later one is deprecated.

Why do we need the in_atomic() here? Or put another way, why isn't
in_dbg_master() sufficient?


Daniel.


> 
> [1] $ echo g > /proc/sysrq-trigger
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index 7a4a181..7a9ebd9 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -231,7 +231,7 @@ extern struct task_struct *kdb_curr_task(int);
>  
>  #define kdb_task_has_cpu(p) (task_curr(p))
>  
> -#define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
> +#define GFP_KDB (in_atomic() || in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
>  
>  extern void *debug_kmalloc(size_t size, gfp_t flags);
>  extern void debug_kfree(void *);
> -- 
> 2.7.4
> 
