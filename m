Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AA2B6F12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgKQTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgKQTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:45:06 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93CA24654;
        Tue, 17 Nov 2020 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605642306;
        bh=qNozKMsilVGHcKuDFqYgNc1oR4jJ69WTtekuHemKsA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uzOYWmAFsp5u8A1goye7laB+uln8gqXV99XauIwSEYwYTGXnrkndJ1sdA0QPbsHW/
         uXFPVcvnzkLe+GYCOMvNnDStRP9jwZYNOFkt+AwKP1ltA3sG4bxugT2gpWZQD9Krqq
         7zwau8mE4xSeZENQKfIlP12S23rRKNZejLI/7ECQ=
Received: by mail-ot1-f52.google.com with SMTP id a15so20644085otf.5;
        Tue, 17 Nov 2020 11:45:05 -0800 (PST)
X-Gm-Message-State: AOAM5326K/lD+bUu0rZXSicp8roCoOvGJGIWq/L/L6aMsWuVHJNWs9DA
        UVPV6DhTCQZhkIOKRcpSoDzegIK1SfXcWlGQBQ==
X-Google-Smtp-Source: ABdhPJw7Y8/Ws5bUvi26+LLUZzk81vYwcXh6i4hVHe44wC1JXmPPzqpT+2F4tA2/k2KaDRk1Kh11f9DUxexOONIhShQ=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr4284277otd.192.1605642305060;
 Tue, 17 Nov 2020 11:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com> <20201117181607.1761516-16-qperret@google.com>
In-Reply-To: <20201117181607.1761516-16-qperret@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Nov 2020 13:44:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+xAy9+HjH6vqfmaAEKBe9MMm+wWvUtiz5dFnHmMneqNw@mail.gmail.com>
Message-ID: <CAL_Jsq+xAy9+HjH6vqfmaAEKBe9MMm+wWvUtiz5dFnHmMneqNw@mail.gmail.com>
Subject: Re: [RFC PATCH 15/27] of/fdt: Introduce early_init_dt_add_memory_hyp()
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        android-kvm@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:16 PM Quentin Perret <qperret@google.com> wrote:
>
> Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
> of the memory regions parsed from DT. This will be needed in the context
> of the protected nVHE feature of KVM/arm64 where the code running at EL2
> will be cleanly separated from the host kernel during boot, and will
> need its own representation of memory.
>
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

Can this be done right after we add all the memblocks using the
memblock API? I thought EFI would also need to be handled, but looks
like it just calls early_init_dt_add_memory_arch(). That's odd
especially for ACPI systems...

I don't really like putting what looks like an arm64 only hook here,
but then I don't want an arm64 version of
early_init_dt_add_memory_arch() either. We're almost to the point of
getting rid of the arch specific ones. But I don't have a better
suggestion currently.

Rob
