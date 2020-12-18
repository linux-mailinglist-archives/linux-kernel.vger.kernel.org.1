Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8237A2DE7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgLRRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgLRRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:19:47 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F0C0617A7;
        Fri, 18 Dec 2020 09:19:06 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q25so3532739oij.10;
        Fri, 18 Dec 2020 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yN8pXNZweJHRV+CIZdCyGPF9KgAKkYFH5yQW0e//tEA=;
        b=SNG5jPvU/IZiNrihKKiofbkedRSFiEUU0rlpuTRWSAV1yJBfz+O64zAcNG+X9jz8Yg
         lVD81nJNvZ1BhECARLCVBqI53pyP6qWwGSvTwtS3Rx0GR8lDi+EFzIxTIrlwjcFAPBfH
         fvEfUBaEtOlkJxlCrwoXum/cGNDG0Nbinc2ZjLkLZp2Oz9nEmJqWgdbqTeIAU6qlhOUC
         cWzkfJ742wWzcTOInNHHfOHb2qZl4KEWlj7rN0+brKtlOhiXWJsjrBl1/lms9oRhM1YK
         i5qn9qqSgpyPm8ebSCkhCaGdYt8BatJx5f1dy3jeAp8RZTtk8aJQgh0nxOV9ofR/5hFF
         LZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=yN8pXNZweJHRV+CIZdCyGPF9KgAKkYFH5yQW0e//tEA=;
        b=JSO4S3fy1n0RK1XteXNp4gvfbEfoHqBF+i9loEwvfCNLkQXY32uOkyyJy0T1QY/9A3
         6q/ofYNQg9FYHRAg77maFzUUvKLN2iWnrOFlTNK69O0QWvRMs5oMkGP5zqns88W2vrt+
         NpYfbp32WbtDJ4afv4S05mxFSIiXm91B21nyJgd6Ah4uFcwy1Yn8t3UoT1HcT21v/ior
         ypbAMJfrbF/U/uCBBZfdLATpYQBIBsFE5nwzXlmGWWS58JW/TffPYOwk5YrWjjwOeOMS
         0xahIVqnVUPGaijG2y7bInPgYTv29VOJJyJNsKcLX7dNcCxsF5H7ruMNj1k5PJkDsFo6
         jbdg==
X-Gm-Message-State: AOAM530H3rbxwbuNUrmHsCr3BWAfmrCia0sLtJTR2/2XWgYYJwdfWcX5
        GNZICyLCuFsGG3vifVCgRCfvI/ono0A=
X-Google-Smtp-Source: ABdhPJxUgmkw8GklMtkDhP0vMaUqWj6hBFAvs0kvb68WADoTS2bdbei5/8Zx+v6lpOwoPlRAB2Guxg==
X-Received: by 2002:aca:4355:: with SMTP id q82mr2153648oia.132.1608311946135;
        Fri, 18 Dec 2020 09:19:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65sm2003060otp.35.2020.12.18.09.19.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Dec 2020 09:19:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Dec 2020 09:19:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: fix build failure caused by memory model changes
Message-ID: <20201218171903.GA6466@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 06:35:50PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The change of ia64's default memory model to SPARSEMEM causes defconfig
> build to fail:
> 
>   CC      kernel/async.o
> In file included from include/linux/numa.h:25,
>                  from include/linux/async.h:13,
>                  from kernel/async.c:47:
> arch/ia64/include/asm/sparsemem.h:14:40: warning: "PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
>    14 | #if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
>       |                                        ^~~~~~~~~~
> In file included from include/linux/gfp.h:6,
>                  from include/linux/xarray.h:14,
>                  from include/linux/radix-tree.h:19,
>                  from include/linux/idr.h:15,
>                  from include/linux/kernfs.h:13,
>                  from include/linux/sysfs.h:16,
>                  from include/linux/kobject.h:20,
>                  from include/linux/energy_model.h:7,
>                  from include/linux/device.h:16,
>                  from include/linux/async.h:14,
>                  from kernel/async.c:47:
> include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
>  1156 | #error Allocator MAX_ORDER exceeds SECTION_SIZE
>       |  ^~~~~
> 
> The error cause is the missing definition of PAGE_SHIFT in the calculation
> of SECTION_SIZE_BITS.
> 
> Add include of <asm/page.h> to arch/ia64/include/asm/sparsemem.h to solve
> the problem.
> 
> Fixes: 214496cb1870 ("ia64: make SPARSEMEM default and disable DISCONTIGMEM")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Surprisingly, only Guenter's bot caught this.
> 
> @Andrew, if you prefer I can take this via memblock tree.
> 
>  arch/ia64/include/asm/sparsemem.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/sparsemem.h
> index dd8c166ffd7b..42ed5248fae9 100644
> --- a/arch/ia64/include/asm/sparsemem.h
> +++ b/arch/ia64/include/asm/sparsemem.h
> @@ -3,6 +3,7 @@
>  #define _ASM_IA64_SPARSEMEM_H
>  
>  #ifdef CONFIG_SPARSEMEM
> +#include <asm/page.h>
>  /*
>   * SECTION_SIZE_BITS            2^N: how big each section will be
>   * MAX_PHYSMEM_BITS             2^N: how much memory we can have in that space
> -- 
> 2.28.0
> 
