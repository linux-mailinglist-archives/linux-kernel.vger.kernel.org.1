Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB22D281069
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbgJBKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:12:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B32EC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 03:12:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so1149323wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5KRvAGud7PfkCWHujyApubuLJ/cgvQYNI0N2x1lnqs=;
        b=y2hruMmYXIlqAurcpMRZPPZNpXgjSi/RI0w3h33GlMuh4lvCpzpjNUa1vK7VmGkNsi
         2nNCylsCh2UaXdWx1xG5zNL5pa63YNRSMk5/krYCBINvB2mhY+QP7lJ8EX8AGWakJ+zI
         o2MVf+xTi9URdTa3nw8KNUkUHy70aE8AXjFpXD5DUG/R5uyp9dfjnMeeVmH/7n8IIdHz
         q17cAqlyd35srRYwaRzOVw+KaSfjv51QC9g1pRM9SZtdYfgHKd3WjFzSBv5mriwRo2M2
         K1TjrZo7O4fumuNFvLy6KpOiRAnSRTW72SQi5WtYe1XsKtsnH++UdX+7o9lEoDWlplWt
         VWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5KRvAGud7PfkCWHujyApubuLJ/cgvQYNI0N2x1lnqs=;
        b=WfIdFg48Jk132CDY1W82UrbGJqKpN+WElZ75JUM33Z6kwHl+RU+lilPig5hOwDubt4
         GlJKJsRQw57N+eDzvNDaNdlSw3ixxKHbt3/522utZE8aK5G8MRNvQM8Fm1MtLY9f/Eij
         VLGw7Vym7Td42rfkbtN4SLh1wxbtLsUnj104eTmtX32rsAokFGrVeHWHjcu4o2tb7NqC
         6FkaoyMh3q+qRo7W1HEdkp/RLY0MzCqjU2HVpecr8xQA0EEBIeb4EVW9wPRc44uQ7qzZ
         UjiCOfL8tTzL2LzFIoECfNrEmD1SA4RGvfPJ86Xcz6sNUOkeMaagB3JR72Qwr+aujFAe
         BQUw==
X-Gm-Message-State: AOAM533VP9KchnNWhU/y9JSQzej30RLN/CIYlXGKZbelJUetNFSlsPbu
        E2ijqMpSZkhRQ3+05dYrzmHtO3sQ0WBGRNCiJnKxdw==
X-Google-Smtp-Source: ABdhPJzZ9Sz18Pa+tPT+RQ66vm2EyUfR0eZjMK5UfCoxFcX/40FOLqWXiMQrpdhTD/SrXITGPZ6RNkhJ2+4ISKdbTkY=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr2289641wrp.390.1601633561729;
 Fri, 02 Oct 2020 03:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201001190557.2860741-1-atish.patra@wdc.com>
In-Reply-To: <20201001190557.2860741-1-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Oct 2020 15:42:23 +0530
Message-ID: <CAAhSdy2bw-htb5_3Yz571=_Z_JKYDGCaiVv3Dh7EPvFQZPKmOg@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Remove any memblock representing unusable
 memory area
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 12:36 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> RISC-V limits the physical memory size by -PAGE_OFFSET. Any memory beyond
> that size from DRAM start is unusable. Just remove any memblock pointing
> to those memory region without worrying about computing the maximum size.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
>
> ---
> Changes from v2->v3
> Updated comment as per Mike's suggestion.
> ---
>  arch/riscv/mm/init.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ca03762a3733..564e0be677b7 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -146,8 +146,6 @@ static phys_addr_t dtb_early_pa __initdata;
>  void __init setup_bootmem(void)
>  {
>         struct memblock_region *reg;
> -       phys_addr_t mem_size = 0;
> -       phys_addr_t total_mem = 0;
>         phys_addr_t mem_start, end = 0;
>         phys_addr_t vmlinux_end = __pa_symbol(&_end);
>         phys_addr_t vmlinux_start = __pa_symbol(&_start);
> @@ -155,21 +153,18 @@ void __init setup_bootmem(void)
>         /* Find the memory region containing the kernel */
>         for_each_memblock(memory, reg) {
>                 end = reg->base + reg->size;
> -               if (!total_mem)
> +               if (!mem_start)
>                         mem_start = reg->base;
>                 if (reg->base <= vmlinux_start && vmlinux_end <= end)
>                         BUG_ON(reg->size == 0);
> -               total_mem = total_mem + reg->size;
>         }
>
>         /*
> -        * Remove memblock from the end of usable area to the
> -        * end of region
> +        * The maximal physical memory size is -PAGE_OFFSET.
> +        * Make sure that any memory beyond mem_start + (-PAGE_OFFSET) is removed
> +        * as it is unusable by kernel.
>          */
> -       mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> -       if (mem_start + mem_size < end)
> -               memblock_remove(mem_start + mem_size,
> -                               end - mem_start - mem_size);
> +       memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
>
>         /* Reserve from the start of the kernel to the end of the kernel */
>         memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
