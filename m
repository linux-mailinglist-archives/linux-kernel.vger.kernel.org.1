Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248592D5618
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgLJJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:07:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44093 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgLJJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:07:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id d189so4958316oig.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoVanH6PpJItaGusWTgG8SDNfnDJUsCWIBki9TqzoFs=;
        b=SRgJDLqW5nef4dLbLEzoQyHJ5d6WwPBcKzARziZ0RCtwAQPeAqcQy8k+YPKYgCa5a2
         qz0y8sQYqsHJVFKv61qUCzdM1sOFLgR10OWhu8TG8hqR010/emgEiUn/aLkbGgWbYNSg
         L234yxDaS8f+msgt2gEf5p2wl7fMRZtxYDEswUxRGVvAh+Z3C4NDuHgxMSE3K3mmSjsL
         aseW2I+se59cqF49aKxcFyKATcK5rWSv8eXOjV/NObZUX67CDVqNGqmZ2oylggeJ8sYN
         iXPkqDatOLEX1GJAwRReYXgZ+PIg4DDfEzdf1mqOXsV4InQg8V2LZXw9YvCaaeriUy4e
         0SrQ==
X-Gm-Message-State: AOAM532DcAU5ukMSV1CkRbdmn8RHEF86a8pLFjqhWg/xk5GZHXkvpDq7
        YAi9K/jLUMnIHXpEj3bg0JWBbrHkjyYqiLopkUAha4vsusY=
X-Google-Smtp-Source: ABdhPJzf0knRERLR8YZ9NOPlwbDHfzdOFzLG3U//gA4Oz4mzugiWqtafnbqK+P57McZqu6A2QdWTyRu7WWlaN6pAFJI=
X-Received: by 2002:aca:5c08:: with SMTP id q8mr4829513oib.54.1607591221309;
 Thu, 10 Dec 2020 01:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120025757.325930-1-npiggin@gmail.com> <20201120025757.325930-3-npiggin@gmail.com>
In-Reply-To: <20201120025757.325930-3-npiggin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Dec 2020 10:06:50 +0100
Message-ID: <CAMuHMdUdorW03=mipgm92SXNPBZO5owW1Wp6_SacRDZ7fOe9gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: Trim offlined CPUs from mm_cpumasks
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On Fri, Nov 20, 2020 at 4:01 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> When offlining a CPU, powerpc/64s does not flush TLBs, rather it just
> leaves the CPU set in mm_cpumasks, so it continues to receive TLBIEs
> to manage its TLBs.
>
> However the exit_flush_lazy_tlbs() function expects that after
> returning, all CPUs (except self) have flushed TLBs for that mm, in
> which case TLBIEL can be used for this flush. This breaks for offline
> CPUs because they don't get the IPI to flush their TLB. This can lead
> to stale translations.
>
> Fix this by clearing the CPU from mm_cpumasks, then flushing all TLBs
> before going offline.
>
> These offlined CPU bits stuck in the cpumask also prevents the cpumask
> from being trimmed back to local mode, which means continual broadcast
> IPIs or TLBIEs are needed for TLB flushing. This patch prevents that
> situation too.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks for your patch!

> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -911,6 +911,8 @@ static int smp_core99_cpu_disable(void)
>
>         mpic_cpu_set_priority(0xf);
>
> +       cleanup_cpu_mmu_context();
> +

I guess this change broke pmac32_defconfig+SMP in v5.10-rc7?

arch/powerpc/platforms/powermac/smp.c: error: implicit
declaration of function 'cleanup_cpu_mmu_context'
[-Werror=implicit-function-declaration]:  => 914:2

http://kisskb.ellerman.id.au/kisskb/buildresult/14423174/


>         return 0;
>  }
>
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 54c4ba45c7ce..cbb67813cd5d 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -143,6 +143,9 @@ static int pnv_smp_cpu_disable(void)
>                 xive_smp_disable_cpu();
>         else
>                 xics_migrate_irqs_away();
> +
> +       cleanup_cpu_mmu_context();
> +
>         return 0;
>  }
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index f2837e33bf5d..a02012f1b04a 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -90,6 +90,9 @@ static int pseries_cpu_disable(void)
>                 xive_smp_disable_cpu();
>         else
>                 xics_migrate_irqs_away();
> +
> +       cleanup_cpu_mmu_context();
> +
>         return 0;
>  }
>
> --
> 2.23.0
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
