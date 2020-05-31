Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC31E94D1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 02:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgEaA6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 20:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbgEaA6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:58:32 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94782207BB
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590886711;
        bh=JbOlPoSFTbkOH73nISpJKwEQd/K9csLx3Rzwa6BPkrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cvXbct1LgEqRN/PobmWFvR5aqQ9BiTwClqTK1FZrkyyBVWkfEtsS5vegje0iGV+XM
         JGNpb2J6ai25wyT8pLlCThYe0Clh5AsPicS+B72p5cx086V7oZ2CkhZVwrj8RFhuYr
         mQyaVMITewT3Ji/IflYw+zwxmVvz7+HfsXcMsyx8=
Received: by mail-lj1-f173.google.com with SMTP id 9so2353717ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 17:58:31 -0700 (PDT)
X-Gm-Message-State: AOAM5316RwetmXR8XVHmXnl52WEtZ4+EKGj2+F3jBdmf8ZyYnM0ds9og
        mplZ2w4ICl74NavwDyZzOSEKchNFjksz1P8reQM=
X-Google-Smtp-Source: ABdhPJwkIEnM5+gFTBl2ysUpEWPJtTPeA2XcCNsOs/ru0Ac1pwGW4eju8vBsmFep5QctcbFMC7fClt9xUUS1LCo0HqI=
X-Received: by 2002:a2e:8654:: with SMTP id i20mr6924125ljj.79.1590886709942;
 Sat, 30 May 2020 17:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <e896db91e3303f64ac401021f848e536e9d42aaa.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <e896db91e3303f64ac401021f848e536e9d42aaa.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 31 May 2020 08:58:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTdyXybMGPzqKi1Z_ueQkf5XxiZK2X1HrDnZkCaVU1DAg@mail.gmail.com>
Message-ID: <CAJF2gTTdyXybMGPzqKi1Z_ueQkf5XxiZK2X1HrDnZkCaVU1DAg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/13] riscv: Add has_vector/riscv_vsize to save
 vector features.
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        palmerdabbelt@google.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Tue, May 26, 2020 at 3:03 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch is used to detect vector support status of CPU and use
> riscv_vsize to save the size of all the vector registers. It assumes
> all harts has the same capabilities in SMP system.
>
> [greentime.hu@sifive.com: add support for dynamic vlen]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c8527d770c98..5a68a926da68 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -16,6 +16,10 @@ unsigned long elf_hwcap __read_mostly;
>  #ifdef CONFIG_FPU
>  bool has_fpu __read_mostly;
>  #endif
> +#ifdef CONFIG_VECTOR
> +bool has_vector __read_mostly;
> +unsigned long riscv_vsize __read_mostly;
> +#endif
>
>  void riscv_fill_hwcap(void)
>  {
> @@ -73,4 +77,11 @@ void riscv_fill_hwcap(void)
>         if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
>                 has_fpu = true;
>  #endif
> +
> +#ifdef CONFIG_VECTOR
> +       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +               has_vector = true;
> +               riscv_vsize = csr_read(CSR_VLENB) * 32;
No magic number 32.
eg:
#define VECTOR_REGS_NUM 32

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
