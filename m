Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C22A85A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgKESEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKESEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:04:01 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:04:00 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h4so470540pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zX4VMo7vZEE7ICionhSrGJsNWvksBKu00y6yhaRC4qY=;
        b=DaEIMJCI8LEsV7IGW7Y7Q0SLQbEHx4PJkrEbmDm0MBWt0uBvA3xBaQZNWWB8kSb5ze
         tp4WhyOdsiHbpjTXbMAar0RIzRb8aDMx9e6VvmI1tdtHL7i6DG6uSmsI4waMfOteRi5O
         VIaBHRQhuYGR5imXpzSQA5WR3zs+aD6Jbhtlpj7JOZzohojkgZ/kpRXWUZCAcLvwUH5b
         qTWXuZ9lR/2S85OCOWrb/HhIOGXCttfuW7rHZB6/9fYoMsVZdqvwjXBuAE5+NPKH3jGc
         JFbSb9k9n0bYzl/TgKi8PLOT1amtOcrZGW9dyFrmxv22r9mQah3XuEASZtjfd8zUI/I0
         ubWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zX4VMo7vZEE7ICionhSrGJsNWvksBKu00y6yhaRC4qY=;
        b=pRi8vsY/EZmWrY9ZLF/pF7V2ofX4zEwmEO+oaWvHXF2kq7/bUHMBgvtm+5DkV6i6po
         2EBfpDtjxu9QsRvbByB+zlXYyOmJtWMGRkBItHiZJ50h1KbB6kx9nw/AOQALQruutYhV
         423P6qnAW55jYxTtl7VmWYemspFK6ixhLmQ/FMty/39liwR38MdNDX0LX44887xiUsoa
         n+4T585sDCvOEeikJqTf+SrvDHcgMw3ZDbDqibb8u03nnEfHqzIFePHymR3R/Nq9xdhx
         CwJ/bZSptBlOq6kZt2Sh3OxHLs1kEAQoH2kL9A290lgjIM+Jbh5rcYCYGw5P12GiV9mq
         92mQ==
X-Gm-Message-State: AOAM531NwtWOE+4jAgZJPst7Yf72hQ8eR5by5VjFALxmvJ8SpG1wLdcn
        /b5PqQTj5yiasB7ziB1vP6U86K3j8+c6JA==
X-Google-Smtp-Source: ABdhPJzEsdDVrmyeGMdJHHmFTIFpuHkdbjOIsRDANFCa+H4pqi6R0Eu/fQZtW9Q9PGisJjj9KQvytw==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr3411183pjb.218.1604599439388;
        Thu, 05 Nov 2020 10:03:59 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k5sm3019100pjs.14.2020.11.05.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:03:58 -0800 (PST)
Date:   Thu, 05 Nov 2020 10:03:58 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 09:56:21 PST (-0800)
Subject:     Re: [PATCH v4] RISC-V: Remove any memblock representing unusable memory area
In-Reply-To: <20201007215159.1287602-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        rppt@linux.ibm.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-93876e12-52f0-414a-bdea-1a2c06392854@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Oct 2020 14:51:59 PDT (-0700), Atish Patra wrote:
> RISC-V limits the physical memory size by -PAGE_OFFSET. Any memory beyond
> that size from DRAM start is unusable. Just remove any memblock pointing
> to those memory region without worrying about computing the maximum size.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> Changes from v3->v4:
> 1. Rebased on top of for-next.
> ---
>  arch/riscv/mm/init.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4eda1a7e8521..da43c17544c5 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -156,9 +156,8 @@ static void __init setup_initrd(void)
>
>  void __init setup_bootmem(void)
>  {
> -	phys_addr_t mem_size = 0;
> -	phys_addr_t total_mem = 0;
> -	phys_addr_t mem_start, start, end = 0;
> +	phys_addr_t mem_start = 0;
> +	phys_addr_t start, end = 0;
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
>  	u64 i;
> @@ -166,21 +165,18 @@ void __init setup_bootmem(void)
>  	/* Find the memory region containing the kernel */
>  	for_each_mem_range(i, &start, &end) {
>  		phys_addr_t size = end - start;
> -		if (!total_mem)
> +		if (!mem_start)
>  			mem_start = start;
>  		if (start <= vmlinux_start && vmlinux_end <= end)
>  			BUG_ON(size == 0);
> -		total_mem = total_mem + size;
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

This is on fixes.  Thanks!
