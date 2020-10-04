Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE0282E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJDXWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 19:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 19:22:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A2C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 16:22:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so5418827pfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4oL2znr6LsSIkLcSKWov235WOf1EfUgHpIbLNjwTdEM=;
        b=V5hDXA7Lu3qbEuROZq2ipYj0K+ZCKZ7rTKiD11nKdv87dxXIi6Gm9+97FS76QlwqlG
         fCnMV6ZW9kBbQgpyq7+NOdKkzne4JlU20Zul3raozoRuMqnNWYw4TjGtLmmKEDh9tdXH
         HtBBoMCsN4CDjRCebYCYy+GXUMjcccr0j/jhVgG8CxQqYPWtJTsE0LF9hPw3sxclWc3F
         mD4qAFIT3nN+vq3dA0ESs9/8/JqfBX+41UyLhezbBKDqmMw0ONqKnCWDdesMWp+sLvMK
         KsM3bdAeV8gxKZtv6Ys9Chrw+biKqJinCSdV25bM89tamRvU5NCZoMSbyWDO9utI7YLt
         GWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4oL2znr6LsSIkLcSKWov235WOf1EfUgHpIbLNjwTdEM=;
        b=cBShs0zNikkxY1j2lzG7c0Ttw8IVbTcWzgIn9hNzg6t+MnM2bGwXBnPZJR/PLfwKum
         i8qk2Ls704YgodbMY9e0xz1iUvnTnGozWhIzvO0q1lW9PMId7UCCBtKc8DyytfGTDHQY
         YJJ5eg9HmLia4cwoPQrykSR3QzG0JA03pb+EMFYxbf3iFz/VtTbzUwvp3uSpFI/oC8gP
         RRWKm/F1DYqvxx58nhb5ltH534gljZ4tm7JfddW4/zX7CqvJ09wiFExh9cn9EssE9OT1
         otOvKhpaWITELlZPQKJkeL8yt2cKLjmpL6dYMmmax7lX0Wid1bsJxp54ML2NJCOAv9tR
         /EBg==
X-Gm-Message-State: AOAM5321dcEkmKMEZIJJqczDUsaY/6suKRSwzIHlwTXqiwQ/E2Yi2xIL
        YH1nrS1xJ7kWGQEUn/muBxzjLkugzbVFbXrK
X-Google-Smtp-Source: ABdhPJw+aJqCbL831y3oSufm7WJkD4N53sPu7ikpVPcvaRYICkDSaFSLS3fkUBj4njIloL4iUsosvA==
X-Received: by 2002:a63:1252:: with SMTP id 18mr12168100pgs.246.1601853721184;
        Sun, 04 Oct 2020 16:22:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a1sm8284798pjh.2.2020.10.04.16.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 16:22:00 -0700 (PDT)
Date:   Sun, 04 Oct 2020 16:22:00 -0700 (PDT)
X-Google-Original-Date: Sun, 04 Oct 2020 16:21:58 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Remove any memblock representing unusable memory area
In-Reply-To: <20201001190557.2860741-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        rppt@linux.ibm.com, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-ea11e9ee-62e2-4441-963f-63017f370845@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 12:05:57 PDT (-0700), Atish Patra wrote:
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
>  	struct memblock_region *reg;
> -	phys_addr_t mem_size = 0;
> -	phys_addr_t total_mem = 0;
>  	phys_addr_t mem_start, end = 0;
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
> @@ -155,21 +153,18 @@ void __init setup_bootmem(void)
>  	/* Find the memory region containing the kernel */
>  	for_each_memblock(memory, reg) {
>  		end = reg->base + reg->size;
> -		if (!total_mem)
> +		if (!mem_start)
>  			mem_start = reg->base;
>  		if (reg->base <= vmlinux_start && vmlinux_end <= end)
>  			BUG_ON(reg->size == 0);
> -		total_mem = total_mem + reg->size;
>  	}
>
>  	/*
> -	 * Remove memblock from the end of usable area to the
> -	 * end of region
> +	 * The maximal physical memory size is -PAGE_OFFSET.
> +	 * Make sure that any memory beyond mem_start + (-PAGE_OFFSET) is removed
> +	 * as it is unusable by kernel.
>  	 */
> -	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> -	if (mem_start + mem_size < end)
> -		memblock_remove(mem_start + mem_size,
> -				end - mem_start - mem_size);
> +	memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
>
>  	/* Reserve from the start of the kernel to the end of the kernel */
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);

Thanks, this is on for-next.
