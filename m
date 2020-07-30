Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0823321F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgG3M3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgG3M3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:29:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D10C0619D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:29:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 11so25386539qkn.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9jZH6Ll+sEH5WFMFRXAZ0o9TX5SDfud55CbQYcvoaA=;
        b=WSj5RPMJbQFYGXKFa57Tt+1uPT5FuT5rpSK8NNCi9wwgIMbSj0cdw0haGQ+8Pcc9Qe
         dg0s35Nr8WipD1fDqaycqfRTfRYaUSLSNg1xHVWXbk4HeNwAEqLnxquDP24Imbk3gdfc
         ZUUmg1QaWMBy4qV6M7SNEDwwMG6nUcjtUPZ8YJWXAPmMbFYX3FypuDhVEad1lccx+T5H
         yBMguWxzxZ1flfBGjdFG1kwZOApBkSk7556CwptBg9W1mNKWlJ8xSs2YP8CWp7pbnWGp
         QOIpWQORAgijBiOZblNHDMwVZTM14QvSL39XQmVsNxa1VPiz6E2x0SpxLIVFMlDyEyAs
         4W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9jZH6Ll+sEH5WFMFRXAZ0o9TX5SDfud55CbQYcvoaA=;
        b=e3AQ0ZR+TV97n9NmqGzqTUANCJwkjW3CMXeaTpv+XznG4j9sOqcEboQJ9yn7CeOYHt
         u7sHRbvw2OBuvty27+11hBv0QIAcAgz1RlIqmZpMkiFiqjjzFuwYOJbzR0zC9bfPYcSM
         1nq7Pj4jzJxAjfLu6sX2PQiG5Xg6gz+MozTmj71/GWte7Eiv5HtReRJQXoNxJScxs9MM
         xQQICBhNAyLUqNfVYJDiGQnHrjufsQIdQVx8UWgIimNWZSFv4qcwkJ7cvDD6znwIS7Ch
         mAnbjd7hREBkxb7rnYuUCG6U2UOesyLp2FfIq4OItVsn5lXKbs0eMvT9ZRW5AeNkmLIV
         IThQ==
X-Gm-Message-State: AOAM533wNIhMIJWiNUUoL2D6JfCTmsAyWl0AresMn+wOuQkqpIz5L+Nr
        /nTmSaLPb7Ngg753rjKAOVYncg==
X-Google-Smtp-Source: ABdhPJwSdsCtQ0DJ9ivSf+lIOXepWUFKgPioDAv68OAiCRuMu9agvZzMQmfas/iKby0HEJZ0V8rCqA==
X-Received: by 2002:a37:a45:: with SMTP id 66mr39219924qkk.435.1596112143280;
        Thu, 30 Jul 2020 05:29:03 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b8sm4129626qtg.45.2020.07.30.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 05:29:02 -0700 (PDT)
Date:   Thu, 30 Jul 2020 08:28:56 -0400
From:   Qian Cai <cai@lca.pw>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        songliubraving@fb.com, andriin@fb.com, daniel@iogearbox.net,
        catalin.marinas@arm.com, john.fastabend@gmail.com, ast@kernel.org,
        zlim.lnx@gmail.com, kpsingh@chromium.org, yhs@fb.com,
        will@kernel.org, kafai@fb.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
Message-ID: <20200730122855.GA3773@lca.pw>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <20200728152122.1292756-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728152122.1292756-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:21:26PM +0200, Jean-Philippe Brucker wrote:
> When a tracing BPF program attempts to read memory without using the
> bpf_probe_read() helper, the verifier marks the load instruction with
> the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
> this flag it falls back to the interpreter.
> 
> Add support for BPF_PROBE_MEM, by appending an exception table to the
> BPF program. If the load instruction causes a data abort, the fixup
> infrastructure finds the exception table and fixes up the fault, by
> clearing the destination register and jumping over the faulting
> instruction.
> 
> To keep the compact exception table entry format, inspect the pc in
> fixup_exception(). A more generic solution would add a "handler" field
> to the table entry, like on x86 and s390.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This will fail to compile on arm64,

https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config

arch/arm64/mm/extable.o: In function `fixup_exception':
arch/arm64/mm/extable.c:19: undefined reference to `arm64_bpf_fixup_exception'

> ---
> Note: the extable is aligned on 32 bits. Given that extable entries have
> 32-bit members I figured we don't need to align it to 64 bits.
> ---
>  arch/arm64/include/asm/extable.h |  3 ++
>  arch/arm64/mm/extable.c          | 11 ++--
>  arch/arm64/net/bpf_jit_comp.c    | 93 +++++++++++++++++++++++++++++---
>  3 files changed, 98 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
> index 56a4f68b262e..bcee40df1586 100644
> --- a/arch/arm64/include/asm/extable.h
> +++ b/arch/arm64/include/asm/extable.h
> @@ -22,5 +22,8 @@ struct exception_table_entry
>  
>  #define ARCH_HAS_RELATIVE_EXTABLE
>  
> +int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
> +			      struct pt_regs *regs);
> +
>  extern int fixup_exception(struct pt_regs *regs);
>  #endif
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 81e694af5f8c..1f42991cacdd 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -11,8 +11,13 @@ int fixup_exception(struct pt_regs *regs)
>  	const struct exception_table_entry *fixup;
>  
>  	fixup = search_exception_tables(instruction_pointer(regs));
> -	if (fixup)
> -		regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
> +	if (!fixup)
> +		return 0;
>  
> -	return fixup != NULL;
> +	if (regs->pc >= BPF_JIT_REGION_START &&
> +	    regs->pc < BPF_JIT_REGION_END)
> +		return arm64_bpf_fixup_exception(fixup, regs);
> +
> +	regs->pc = (unsigned long)&fixup->fixup + fixup->fixup;
> +	return 1;
>  }
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 3cb25b43b368..f8912e45be7a 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -7,6 +7,7 @@
>  
>  #define pr_fmt(fmt) "bpf_jit: " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/bpf.h>
>  #include <linux/filter.h>
>  #include <linux/printk.h>
> @@ -56,6 +57,7 @@ struct jit_ctx {
>  	int idx;
>  	int epilogue_offset;
>  	int *offset;
> +	int exentry_idx;
>  	__le32 *image;
>  	u32 stack_size;
>  };
> @@ -351,6 +353,67 @@ static void build_epilogue(struct jit_ctx *ctx)
>  	emit(A64_RET(A64_LR), ctx);
>  }
>  
> +#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
> +#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
> +
> +int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
> +			      struct pt_regs *regs)
> +{
> +	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
> +	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
> +
> +	regs->regs[dst_reg] = 0;
> +	regs->pc = (unsigned long)&ex->fixup - offset;
> +	return 1;
> +}
> +
[]
