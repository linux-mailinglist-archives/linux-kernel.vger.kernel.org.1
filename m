Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7C2B16A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKMHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:43:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgKMHn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:43:28 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19624208D5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605253408;
        bh=ZOKRhZl60zkw6TlwLCGXnB92afCnmJotHM3fZpDLG5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kJuXvqyoM726DCsK8a6url1MIZ3ZQask/5zq3M23xPQPa/af+8Y3e8GTNbMBfQdMw
         I7BpaxBmcq60QNOq/+lzcRUWcFHnpPKIYsOtQqZS8SVICUNLSCmLWZ4h5fZFaslhAL
         ANpBMYc3pLIiA3M/dRm5v09AInlNChr+Pd1WN4tQ=
Received: by mail-ot1-f52.google.com with SMTP id n15so8171942otl.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:43:28 -0800 (PST)
X-Gm-Message-State: AOAM530qy95hUX6yaPrlw0X0E++6RQkXAxkZoVhkQ9P+H7xV1/aoxrZ/
        PA/nFfNYKctv1tYcy1BkdWTO5NV+Ge7NIC+2Qa0=
X-Google-Smtp-Source: ABdhPJzxQ/DzbfMtSE25cqTCkclxukxeLOzljrvzX28u8swe8wlV/YCI8+7Pi0sGtIOHTaAgyepEJRCKclmJYAuL28g=
X-Received: by 2002:a05:6830:115a:: with SMTP id x26mr690157otq.77.1605253407382;
 Thu, 12 Nov 2020 23:43:27 -0800 (PST)
MIME-Version: 1.0
References: <1605252614-761-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1605252614-761-1-git-send-email-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 08:43:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHUHeR4CDNPc8BHUvh_DG_x8ScyRJGw1YkXz9tCgK22hQ@mail.gmail.com>
Message-ID: <CAMj1kXHUHeR4CDNPc8BHUvh_DG_x8ScyRJGw1YkXz9tCgK22hQ@mail.gmail.com>
Subject: Re: [PATCH V3] arm64/mm: Validate hotplug range before creating
 linear mapping
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 at 08:31, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> During memory hotplug process, the linear mapping should not be created for
> a given memory range if that would fall outside the maximum allowed linear
> range. Else it might cause memory corruption in the kernel virtual space.
>
> Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
> both its ends but excluding PAGE_END. Max physical range that can be mapped
> inside this linear mapping range, must also be derived from its end points.
>
> This ensures that arch_add_memory() validates memory hot add range for its
> potential linear mapping requirements, before creating it with
> __create_pgd_mapping().
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on 5.10-rc3
>
> Changes in V3:
>
> - Dropped comment paragraphs from code and commit message per Ard
> - Dropped parenthesis brackets in the comparison per Ard
>
> Changes in V2: (https://lore.kernel.org/linux-arm-kernel/1605236574-14636-1-git-send-email-anshuman.khandual@arm.com/)
>
> - Replaced (start + size) with (start + size - 1) in the comparison per Ard
> - Dropped parenthesis brackets in the comparison per Ard
>
> Changes in V1: (https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/)
>
>  arch/arm64/mm/mmu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1c0f3e02f731..ca692a815731 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1444,11 +1444,28 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>         free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
>  }
>
> +static bool inside_linear_region(u64 start, u64 size)
> +{
> +       /*
> +        * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
> +        * accommodating both its ends but excluding PAGE_END. Max physical
> +        * range which can be mapped inside this linear mapping range, must
> +        * also be derived from its end points.
> +        */
> +       return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
> +              (start + size - 1) <= __pa(PAGE_END - 1);
> +}
> +
>  int arch_add_memory(int nid, u64 start, u64 size,
>                     struct mhp_params *params)
>  {
>         int ret, flags = 0;
>
> +       if (!inside_linear_region(start, size)) {
> +               pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
> +               return -EINVAL;
> +       }
> +
>         if (rodata_full || debug_pagealloc_enabled())
>                 flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
