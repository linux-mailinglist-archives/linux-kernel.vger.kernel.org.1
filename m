Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8A279D2F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 02:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgI0Afa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 20:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgI0Afa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 20:35:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249F1C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:35:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so6259814pfp.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XqtqK11C6EYp3TxI68gPMvhecqGFaleQrHQDt6dRtSo=;
        b=RcTE74DKb6HWl+IWw5w/4AS2rnlo67wcmDI3OVW2aJ1IOUEQiTmRDpcGKXwstYlIYG
         GltKiOGEAMimsPCbTGKHOd8W735oQ6p/QhPWls6bcVbBQ+h3bbv29S0Ry+WxNMdqnWu5
         5pSF/CzFs4p6kGnfKs26XTQPBbI/1YndbZEWnGPlw1L/0JlY/NP2makl8ogFDZGQGcjh
         O4Qavt2XscCKNGtlWlSn5fwG82aGyLG2V05ZIgTz3mzGLjr/HAtQKhk6BkoL0IQJzAjY
         1HJq+3zBvL7qxlclndfJIP2hZvDdHxsRrncZ7sl31F8f4v1roAaRcdfILQbmFOHQxwVF
         1M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XqtqK11C6EYp3TxI68gPMvhecqGFaleQrHQDt6dRtSo=;
        b=nXX1bbIe66T0XrjqbvSLTs0P5RwOCaFPW9r+DKH7PIefOHITz42lxNyZrhgW4cm1rt
         B/bsZ0wZMVNoQUlmVOCrIvU7tCTnVi1pkD91KLSYT/DxaRFndbjfcVI695QiM25s9cGW
         VjXWnVW+o+CbZlMpEG0e9hipvcLlFJEUvQhzpkTesKJMynQiJCA2fcNvg8u2psAvyHTu
         2q8bvtHO7DIib7lTxFedPWbxB/z0JWiZW+tewhPxy9H5bKPXIzj1KTBQS2k+SkJ0oOFb
         NF9t3/+42vgo1sLov3mKSYZKJz0VO0QhA8dQGX8bMBv9qKTzLPsIo/wWl/XneDNyElv6
         FZ9Q==
X-Gm-Message-State: AOAM530RfQSiTgn0a5LQAfFAf+LofhPMwMN4+Ak+t/2qhAHAGC45rdsT
        bzMiblKuJUx52eDhau99YU/9ig==
X-Google-Smtp-Source: ABdhPJx8AynfC3lOSrY8k59qcyqfjpr6GSeCaIP8xhW0ff6mYLWyOIrtvz4coZ8ArlPQ2ylV7L86Mw==
X-Received: by 2002:aa7:96af:0:b029:142:6a8f:c04b with SMTP id g15-20020aa796af0000b02901426a8fc04bmr5456120pfk.30.1601166929558;
        Sat, 26 Sep 2020 17:35:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x13sm6744416pff.152.2020.09.26.17.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 17:35:28 -0700 (PDT)
Date:   Sat, 26 Sep 2020 17:35:28 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Sep 2020 17:35:26 PDT (-0700)
Subject:     Re: [V2] riscv: fix pfn_to_virt err in do_page_fault().
In-Reply-To: <1600419358-21446-1-git-send-email-liush@allwinnertech.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, peterx@redhat.com,
        daniel.m.jordan@oracle.com, walken@google.com, vbabka@suse.cz,
        rppt@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, liush@allwinnertech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liush@allwinnertech.com
Message-ID: <mhng-6b275467-464f-45b7-9ada-7c86add704f6@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 01:55:58 PDT (-0700), liush@allwinnertech.com wrote:
> The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

> Signed-off-by: liush <liush@allwinnertech.com>

IIUC you're supposed to use an actual name.

> ---
>  arch/riscv/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 716d64e..3e560ec13 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -198,6 +198,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  		pmd_t *pmd, *pmd_k;
>  		pte_t *pte_k;
>  		int index;
> +		unsigned long pfn;
>
>  		/* User mode accesses just cause a SIGSEGV */
>  		if (user_mode(regs))
> @@ -212,7 +213,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  		 * of a task switch.
>  		 */
>  		index = pgd_index(addr);
> -		pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> +		pfn = csr_read(CSR_SATP) & SATP_PPN;
> +		pgd = (pgd_t *)pfn_to_virt(pfn) + index;
>  		pgd_k = init_mm.pgd + index;
>
>  		if (!pgd_present(*pgd_k))
