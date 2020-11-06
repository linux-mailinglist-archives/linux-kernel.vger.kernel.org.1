Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77CA2A8EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKFFP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgKFFP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:15:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC46C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:15:24 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 13so247960pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bOyMY+kSzPHfwt/YncbXWhyMG339YQ0Eyf//8x4re5M=;
        b=sxzKNtT3Kl3Pq5Hy6+8t255HdE0ljEqClI1T55mSDPoCbBsKt74RNGf5oBWIzC0GPd
         hpi4pU2ufKZQJqRb84TjQaB4cTCCSRVg17X98+Ptpg0ieIQjkUvuhTdMGE+50UtgHiXK
         sCJsyjb5khhk39QbRNw0qGChaD8o4vWr/PRdlPWK+Ha/ozovwEqvde8HCYLr0Gft7Szj
         8c791wMbmFDcTvJRmIKp79/YrGCSUgpy9Xq13o6J1+lmUH6c24ItQ4pxaCYyL+QWE2DL
         aufscq+4M3Oh4O8FeB7yMqMYT4YWGGHR+FxfunvHJhNYisQXQRBgmuvPOV4y1P2z3cnE
         JCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bOyMY+kSzPHfwt/YncbXWhyMG339YQ0Eyf//8x4re5M=;
        b=dDGF3zl/ZmEGXGJW6sPNaTPUav8On2e5PqXvAK5hsLgo0vJmaj9IA0B6o+Bmvegi2y
         fpJXrPQwdbVCL5AmSJow//u6rP+T7IRHAzsl6lusZ4oIjdd8buKpXihAf7L/PuJ6+otV
         Hc7J0vuKyid8RHwUnJ3im5Y1HDR3MAy5B74LZJ4xPvh29zmbF4qeYWrtGL1Vhv/O0GeE
         AH/Jr6qyQb8NgJsn4BjCL9jQPBAaOh9x4ClMr4rRuY6DSljuZ73OvU1f9bM6LvTYCp+o
         luNOcm6w4u0O/QvvCngq/Uw7oNvMaGNTqCB4EhnwQgdnnKJf7fMaFqkoheLPeALfSONU
         ndjA==
X-Gm-Message-State: AOAM530gTt0qB3PygcprnlMsS3LT4xIsvoY/mUZphfc6Kz5cqgjFZ8Q3
        jn5FqB9eRxQ2HSn84oj1jnBTX+5/K0E6ZFDm
X-Google-Smtp-Source: ABdhPJy03qWK3hg/CNy1wVGvdT9LABzVtA/BxBq+lNzIlCFWd3Z1xTdXuDWwracFQ7Cunk4gx7mSaQ==
X-Received: by 2002:a63:180f:: with SMTP id y15mr294401pgl.324.1604639724127;
        Thu, 05 Nov 2020 21:15:24 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g7sm371018pfi.16.2020.11.05.21.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 21:15:23 -0800 (PST)
Date:   Thu, 05 Nov 2020 21:15:23 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 21:14:46 PST (-0800)
Subject:     Re: [PATCH v3] riscv: fix pfn_to_virt err in do_page_fault().
In-Reply-To: <1603715214-29082-1-git-send-email-liush@allwinnertech.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        penberg@kernel.org, akpm@linux-foundation.org, peterx@redhat.com,
        vbabka@suse.cz, walken@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, liush@allwinnertech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liush@allwinnertech.com
Message-ID: <mhng-eb94691e-6afe-4802-bf03-949f0a22b467@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 05:26:54 PDT (-0700), liush@allwinnertech.com wrote:
> From: Liu Shaohua <liush@allwinnertech.com>
>
> The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: liush <liush@allwinnertech.com>
> ---
>  arch/riscv/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 1359e21..3c8b9e4 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -86,6 +86,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	pmd_t *pmd, *pmd_k;
>  	pte_t *pte_k;
>  	int index;
> +	unsigned long pfn;
>
>  	/* User mode accesses just cause a SIGSEGV */
>  	if (user_mode(regs))
> @@ -100,7 +101,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	 * of a task switch.
>  	 */
>  	index = pgd_index(addr);
> -	pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> +	pfn = csr_read(CSR_SATP) & SATP_PPN;
> +	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
>  	pgd_k = init_mm.pgd + index;
>
>  	if (!pgd_present(*pgd_k)) {

This is on fixes, thanks!
