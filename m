Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24BE2F189A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbhAKOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbhAKOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:46:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3FB229C4;
        Mon, 11 Jan 2021 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610376322;
        bh=l6ToqVwqm3E7ql9O4XRtENEPRhqlUUCrKobd4xM3lgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uZZApSfe3FBkwQ18jphBQE5TJf9VCYIcQg1oER0tBBAyxp29dxOxPD2ljGcZiwXvb
         QisYFN8GIZkXjZMiKHlRGvFQQJEjYRAFn9JDenRW8Kwcn0XE4cuPc1xasD9RFWdLCZ
         rEpzO7GRrDHPDyIkZ0TND+BTEwx39IlCN3wmZ0sBzwV6F6nqbwkA/ovLdCtGuozEBd
         dlmaNpQSDPgkq96V2JO3lBcHV8CdHNP8D18tz6LrkF7L9V56DMhVZ4yCokdo/G1F6Z
         L2/aA4Hu1SWwVage5ZwkLSzXgMq1OdlaUENqFCM4kKga+DZFq3vfMk2Sdtgb2FqlBH
         xzP5UFzB1v3uQ==
Received: by mail-qv1-f43.google.com with SMTP id d11so7450756qvo.11;
        Mon, 11 Jan 2021 06:45:22 -0800 (PST)
X-Gm-Message-State: AOAM530i5E+8oWFkFRKkiS8guv1MSCAaGSiN+Grbo35FH91A0E0BzYJL
        0Py0QCQGoFnjXLK3Nu54BEShQqXW0SU7pkPnIg==
X-Google-Smtp-Source: ABdhPJymgMsMHFwjNXskq64kJCyaSLMJ3Do+hKilu0I/FvQeFX2WQUWySyGObrImhXuZnCRNVT6HEOiCX2LEoJH6Aqs=
X-Received: by 2002:a0c:fe47:: with SMTP id u7mr13111qvs.4.1610376321947; Mon,
 11 Jan 2021 06:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com> <20210108121524.656872-16-qperret@google.com>
In-Reply-To: <20210108121524.656872-16-qperret@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Jan 2021 08:45:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
Message-ID: <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/26] of/fdt: Introduce early_init_dt_add_memory_hyp()
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 6:16 AM Quentin Perret <qperret@google.com> wrote:
>
> Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
> of the memory regions parsed from DT. This will be needed in the context
> of the protected nVHE feature of KVM/arm64 where the code running at EL2
> will be cleanly separated from the host kernel during boot, and will
> need its own representation of memory.

What happened to doing this with memblock?

> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/of/fdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4602e467ca8b..af2b5a09c5b4 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1099,6 +1099,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  #define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
>  #endif
>
> +void __init __weak early_init_dt_add_memory_hyp(u64 base, u64 size)
> +{
> +}
> +
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
>         const u64 phys_offset = MIN_MEMBLOCK_ADDR;
> @@ -1139,6 +1143,7 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>                 base = phys_offset;
>         }
>         memblock_add(base, size);
> +       early_init_dt_add_memory_hyp(base, size);
>  }
>
>  int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
