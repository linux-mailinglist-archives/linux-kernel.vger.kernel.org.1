Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8170E2CEE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgLDMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgLDMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:39:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD47C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 04:38:33 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so5145155wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 04:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uwxrq7FVASlmAXmPpYkbuc2zGaGpKZv2xlcdJf5cyHg=;
        b=XCefAFORJRJCYIOWfIRO3Dz9m3NBadPYoskdZVFQY78un8n3mhE41FIViDlaeHqMYW
         uGnMUfqFW/U3zbBjbHdeTIScVQyGAeaCzX/BWsTslvrFfKTjo+gWWUCQ0TdT7uexA4Qm
         rjuD6sUg12bVtkVGSMxQ+MlIQze8TKiWLP8ozcRaiC7MR9ng2Om/ZXhJjS4XlD6cSN1c
         ISGQ05Y+sMh9EB1L8wkDXnpidK5Qb64XkkfJX3j1cdschl8KnwLLFcCZXO7EJlZ6QNhU
         0yShx4idl/21JpqACY9mGOJlGVyWQvmUUeML9wZMSB4JexUAd2UGw4arcusIIBzSU1T6
         lT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uwxrq7FVASlmAXmPpYkbuc2zGaGpKZv2xlcdJf5cyHg=;
        b=DmoNgh7xxA1fEF8v5nxmpJ9PKKMLYL8zO58A2iG66bH7itk+GARJfhAqCxKdsxKp/c
         /lDvjJjSiQKFM1RPRgEBPON2Lto7k+3wsfhu7IoUMcJJtdp10AApXmXjjSdyAQR5zek/
         c0eLJFGd7DMjLBddLk4vYIRkU69juvOIGoAvUMO7UG+CCkMVKHKI1njK648EuFWR0f5R
         BSaIcFarGFaYY3bcLPt7fsqzRhEx7ONdqzKvfNEO4QBur63T+WEZh1iC5PP4qZ+bwXZ1
         lsDpL5rgOj/07wWHLW2rLuu6hAXF3qGonmq32fB33s6P3jrht8i6i/5/a1Uxucu8i0Xl
         8GSw==
X-Gm-Message-State: AOAM530MJYSoA4cBPjFE7lltFpWoEbuoGjRpk1nTy24Sf2I1wHx8d0c0
        h0THOoDX28/2s8YgkLZD2TJATg==
X-Google-Smtp-Source: ABdhPJzWArthPy3iepLAspxEW3B6/qsGnFHlbvlTAvBty1ogWfOKvBtYb9RsPRSABAwtPsXfJC4KRw==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr4937077wrx.164.1607085512394;
        Fri, 04 Dec 2020 04:38:32 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id w3sm3066245wma.3.2020.12.04.04.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:38:31 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:38:25 +0100
From:   Marco Elver <elver@google.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        catalin.marinas@arm.com, will@kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org, david@redhat.com
Subject: Re: [PATCH] kfence: fix implicit function declaration
Message-ID: <X8otwahnmGQGLpge@elver.google.com>
References: <20201204121804.1532849-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204121804.1532849-1-anders.roxell@linaro.org>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 01:18PM +0100, Anders Roxell wrote:
> When building kfence the following error shows up:
> 
> In file included from mm/kfence/report.c:13:
> arch/arm64/include/asm/kfence.h: In function ‘kfence_protect_page’:
> arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of function ‘set_memory_valid’ [-Werror=implicit-function-declaration]
>    12 |  set_memory_valid(addr, 1, !protect);
>       |  ^~~~~~~~~~~~~~~~
> 
> Use the correct include both
> f2b7c491916d ("set_memory: allow querying whether set_direct_map_*() is actually enabled")
> and 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64") went in the

Note that -mm does not have stable commit hashes.

> same day via different trees.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Ack, we need this patch somewhere but we should probably fix the patch
that does the move, otherwise we'll have a build-broken kernel still.

> I got this build error in todays next-20201204.
> Andrew, since both patches are in your -mm tree, I think this can be
> folded into 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64")

I don't think that's the right way around. This would result in a
build-broken commit point as well.

Looking at current -next, I see that "set_memory: allow querying whether
set_direct_map_*() is actually enabled" is after "arm64, kfence: enable
KFENCE for ARM64".

I think the patch that introduces set_memory.h for arm64 simply needs to
squash in this patch (assuming the order is retained as-is in -mm).

Thanks,
-- Marco

>  arch/arm64/include/asm/kfence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
> index 6c0afeeab635..c44bb368a810 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -3,7 +3,7 @@
>  #ifndef __ASM_KFENCE_H
>  #define __ASM_KFENCE_H
>  
> -#include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>  
>  static inline bool arch_kfence_init_pool(void) { return true; }
>  
