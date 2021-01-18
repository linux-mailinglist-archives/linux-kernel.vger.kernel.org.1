Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC82F98D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbhAREsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731139AbhAREsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:48:13 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A6C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 20:47:33 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i5so10205995pgo.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rTJZHyk4t8Gugvj+lnFByV1qa/S239wOnkv0tkeq884=;
        b=LcrQFfbq2DgyjtEw+XwXil8SMVWAvoBGFPQ1xNnHeqrSjU6FHo10ZmvcBDhRIVephc
         6/Bjug8Iwkbe987mh30YDtQ1eNA0JSnEioxymlCsS6zgy5BaSmGqIKVgxvXci7qHz+CX
         Hcj7UhFuI6eQ5WPOWQeMJ6ALX26h7YVUUQG7uwDcfzyewyPiv7RA/6wXxV2ijs5HtGl2
         N3yCD9hSxLa/e1pkMF3WZUCutFASEXihiMcG7IPYhM6JogqWNQH3TF8vD3pR0xcOovzJ
         EEiwq/afZTQz3Je1Pi+IdBVGrlLftD3O9oUuPrlhGDhm40aNt19SeVlqni9aXTd+/9S2
         tRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTJZHyk4t8Gugvj+lnFByV1qa/S239wOnkv0tkeq884=;
        b=OyCms1QLLf07R2w9KQg+zr3VS5FANYolWeSvCOubqHO7Q2Gg/BFDMzyoLlYzu7jz+n
         CgrD+CpKqlGn5jgc6pRKAxx+MfqsnmqiDrsIv0LWayf7ob1NsNpuBGM+IC7ymf69I3O9
         /IuXZ6UkxT79jJDuVakIXXm9QMWmsU2bqWvD7hc4kYCn78ks5AOrUX2FlaifQ0EY+NIc
         aWVIINonYrcARbbxkPgBj2+fxbClQZLGjodOLI9UjNPWBrcTWspyYE4ypwZTK23+0xoZ
         mllnIqvh5SeBOnr1sNuELKXTXKuuKCC86Zo7eQRIOFcO3vUkRbazZT+WmKvE3q3y6mzx
         PvQA==
X-Gm-Message-State: AOAM530t/7gpIpQgq7JAW3doKg9V5tuMBymdB9LhXzw/34FIGhDxDhHc
        1UA+JCPXwoIhWLLXrF9ti9mtVw==
X-Google-Smtp-Source: ABdhPJynUWLanc6SluN4pJDVPiUJTTJKU/6YxXhX0vjc19aR9mWq5EEgNrgbdwzek/NvTyhBfsFB0A==
X-Received: by 2002:a62:7e46:0:b029:19e:786b:9615 with SMTP id z67-20020a627e460000b029019e786b9615mr24394761pfc.37.1610945252531;
        Sun, 17 Jan 2021 20:47:32 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 145sm14726406pge.88.2021.01.17.20.47.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 20:47:31 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:17:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] arch: powerpc: Stop building and using oprofile
Message-ID: <20210118044729.g24gnfdmao7or5kp@vireshk-i7>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <fd155a0a1e52650ddc9ec57a1d211fdc777beddb.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd155a0a1e52650ddc9ec57a1d211fdc777beddb.1610622251.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-21, 17:05, Viresh Kumar wrote:
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> This commits stops building oprofile for powerpc and removes any
> reference to it from directories in arch/powerpc/ apart from
> arch/powerpc/oprofile, which will be removed in the next commit (this is
> broken into two commits as the size of the commit became very big, ~5k
> lines).
> 
> Note that the member "oprofile_cpu_type" in "struct cpu_spec" isn't
> removed as it was also used by other parts of the code.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/powerpc/Kconfig                          |   1 -
>  arch/powerpc/Makefile                         |   2 -
>  arch/powerpc/configs/44x/akebono_defconfig    |   1 -
>  arch/powerpc/configs/44x/currituck_defconfig  |   1 -
>  arch/powerpc/configs/44x/fsp2_defconfig       |   1 -
>  arch/powerpc/configs/44x/iss476-smp_defconfig |   1 -
>  arch/powerpc/configs/cell_defconfig           |   1 -
>  arch/powerpc/configs/g5_defconfig             |   1 -
>  arch/powerpc/configs/maple_defconfig          |   1 -
>  arch/powerpc/configs/pasemi_defconfig         |   1 -
>  arch/powerpc/configs/pmac32_defconfig         |   1 -
>  arch/powerpc/configs/powernv_defconfig        |   1 -
>  arch/powerpc/configs/ppc64_defconfig          |   1 -
>  arch/powerpc/configs/ppc64e_defconfig         |   1 -
>  arch/powerpc/configs/ppc6xx_defconfig         |   1 -
>  arch/powerpc/configs/ps3_defconfig            |   1 -
>  arch/powerpc/configs/pseries_defconfig        |   1 -
>  arch/powerpc/include/asm/cputable.h           |  20 ---
>  arch/powerpc/include/asm/oprofile_impl.h      | 135 ------------------
>  arch/powerpc/include/asm/spu.h                |  33 -----
>  arch/powerpc/kernel/cputable.c                |  67 ---------
>  arch/powerpc/kernel/dt_cpu_ftrs.c             |   2 -
>  arch/powerpc/platforms/cell/Kconfig           |   5 -
>  arch/powerpc/platforms/cell/spu_notify.c      |  55 -------

+ this..

diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 10064a33ca96..7ea6692f67e2 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -19,7 +19,6 @@ spu-priv1-$(CONFIG_PPC_CELL_COMMON)   += spu_priv1_mmio.o
 spu-manage-$(CONFIG_PPC_CELL_COMMON)   += spu_manage.o
 
 obj-$(CONFIG_SPU_BASE)                 += spu_callbacks.o spu_base.o \
-                                          spu_notify.o \
                                           spu_syscalls.o \
                                           $(spu-priv1-y) \
                                           $(spu-manage-y) \

-- 
viresh
