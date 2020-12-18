Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA092DE793
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgLRQpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgLRQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:45:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BAC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:44:26 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 91so2881580wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t0Ae0BlblXLltnFfoNJihJIVc00OrJVjKuvUxXPzmjA=;
        b=JNUJOrowEiPgl9if8ptB/nePbTG2zmOqCmhOl/03duibUxyt6Fgdz/yAj96No9CKOl
         1J4cJblRP5PnL72EeAwrBloxXCWfzOZNy8+T6xuxZROfZQcKY172uyqrwjg4+9syC4TC
         3n+DfoLYTMZ8aSb+llcJmxaKStpCyY+cX9mbX72PP50PFl4FHntr5hrFo3bivRbl4pwc
         /6jpGK/sb1Avz29Pg485BbNMLZBQKov1lOXklV54Hgp7HDS63azgeEgvqbtnVybzQeOD
         6z0fpzuYhvO8cMwM7mr7fKsm92lp2mfjb0sxmxEprN9ppcpdKYqFmsg3uMJB4OQ0muj9
         yZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t0Ae0BlblXLltnFfoNJihJIVc00OrJVjKuvUxXPzmjA=;
        b=kWn4d7h3+TF1YBW9sbgHJUJq53ajmHJbIpnQslcsXkVwDTwmzye35fvOB9Knxz5N9U
         td0JZBl/Ms4S5FiMV6VF02LZguZwNVU+lcdeKuq/s1MWJwu34dYhF91T/uNlErF8spOq
         +UpgKhkOyscrWkXKq1eeM1xUeK/mtvHMQieY/QCUwu3WNefIwHN58lYpO1CsYLGicGdv
         UjhGJ+lllEvKBBYMWcR008SirRiVfqPWuyLSYyHNOpDUv3AIyuDL14ad1Txh5zDeIbca
         150YEORGUqrNb80Zc9j6MHUkGnv1fOGNGzL5Y9XSuoKARcX0n87L2MI0BoMfh9J18tPQ
         AhjQ==
X-Gm-Message-State: AOAM532pGSMfN9h8Td4g9guegq7FVEBsVX4ZCHrJfF+/STQYs6Yq/3cm
        YWOb2ruQZ4EQAw9G8Facjsrr2w==
X-Google-Smtp-Source: ABdhPJzo8FnIm/nnsrHLcn+VnuE+Xt6v+yZVDSArCtqkLoNYRbUcTO8Kp6aM2GFhZ0np7EGAOGEKcw==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr5370506wru.197.1608309864740;
        Fri, 18 Dec 2020 08:44:24 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j15sm14373163wrr.85.2020.12.18.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 08:44:23 -0800 (PST)
Date:   Fri, 18 Dec 2020 16:44:21 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stefan Saecherl <stefan.saecherl@fau.de>
Cc:     x86@kernel.org, linux-kernel@i4.cs.fau.de,
        Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kgdb: Allow removal of early BPs
Message-ID: <20201218164421.qy5ov2lyhrfi3kr6@holly.lan>
References: <20201214141314.5717-1-stefan.saecherl@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214141314.5717-1-stefan.saecherl@fau.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

On Mon, Dec 14, 2020 at 03:13:12PM +0100, Stefan Saecherl wrote:
> The problem is that breakpoints that are set early (e.g. via kgdbwait)
> cannot be deleted after boot completed (to be precise after mark_rodata_ro
> ran).
> 
> When setting a breakpoint early there are executable pages that are
> writable so the copy_to_kernel_nofault call in kgdb_arch_set_breakpoint
> succeeds and the breakpoint is saved as type BP_BREAKPOINT.
> 
> Later in the boot write access to these pages is restricted. So when
> removing the breakpoint the copy_to_kernel_nofault call in
> kgdb_arch_remove_breakpoint is destined to fail and the breakpoint removal
> fails. So after copy_to_kernel_nofault failed try to text_poke_kgdb which
> can work around nonwriteability.
> 
> One thing to consider when doing this is that code can go away during boot
> (e.g. .init.text). Previously kgdb_arch_remove_breakpoint handled this case
> gracefully by just having copy_to_kernel_nofault fail but if one then calls
> text_poke_kgdb the system dies due to the BUG_ON we moved out of
> __text_poke.  To avoid this __text_poke now returns an error in case of a
> nonpresent code page and the error is handled at call site.
> 
> Checkpatch complains about two uses of BUG_ON but the new code should not
> trigger BUG_ON in cases where the old didn't.
> 
> Co-developed-by: Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
> Signed-off-by: Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
> Signed-off-by: Stefan Saecherl <stefan.saecherl@fau.de>

I took this to be a gap in the kgdbtest suite so I added a couple of
tests that cover this area. Before this patch they failed now they
pass (at least they do for ARCH=x86).

I don't see any new failures either, so:

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.



> ---
>  arch/x86/kernel/alternative.c | 16 +++++++----
>  arch/x86/kernel/kgdb.c        | 54 ++++++++++++++++++++++++-----------
>  2 files changed, 48 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 2400ad62f330..0f145d837885 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -878,11 +878,9 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
>  		if (cross_page_boundary)
>  			pages[1] = virt_to_page(addr + PAGE_SIZE);
>  	}
> -	/*
> -	 * If something went wrong, crash and burn since recovery paths are not
> -	 * implemented.
> -	 */
> -	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
> +
> +	if (!pages[0] || (cross_page_boundary && !pages[1]))
> +		return ERR_PTR(-EFAULT);
>  
>  	/*
>  	 * Map the page without the global bit, as TLB flushing is done with
> @@ -976,7 +974,13 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  {
>  	lockdep_assert_held(&text_mutex);
>  
> -	return __text_poke(addr, opcode, len);
> +	addr = __text_poke(addr, opcode, len);
> +	/*
> +	 * If something went wrong, crash and burn since recovery paths are not
> +	 * implemented.
> +	 */
> +	BUG_ON(IS_ERR(addr));
> +	return addr;
>  }
>  
>  /**
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index ff7878df96b4..e98c9c43db7c 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -731,6 +731,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  {
>  	int err;
> +	void *addr;
>  
>  	bpt->type = BP_BREAKPOINT;
>  	err = copy_from_kernel_nofault(bpt->saved_instr, (char *)bpt->bpt_addr,
> @@ -747,8 +748,14 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  	 */
>  	if (mutex_is_locked(&text_mutex))
>  		return -EBUSY;
> -	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
> -		       BREAK_INSTR_SIZE);
> +
> +	addr = text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
> +				BREAK_INSTR_SIZE);
> +	/* This should never trigger because the above call to copy_from_kernel_nofault
> +	 * already succeeded.
> +	 */
> +	BUG_ON(IS_ERR(addr));
> +
>  	bpt->type = BP_POKE_BREAKPOINT;
>  
>  	return 0;
> @@ -756,21 +763,36 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  
>  int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  {
> -	if (bpt->type != BP_POKE_BREAKPOINT)
> -		goto knl_write;
> -	/*
> -	 * It is safe to call text_poke_kgdb() because normal kernel execution
> -	 * is stopped on all cores, so long as the text_mutex is not locked.
> -	 */
> -	if (mutex_is_locked(&text_mutex))
> -		goto knl_write;
> -	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
> -		       BREAK_INSTR_SIZE);
> -	return 0;
> +	void *addr;
> +	int err;
>  
> -knl_write:
> -	return copy_to_kernel_nofault((char *)bpt->bpt_addr,
> -				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
> +	if (bpt->type == BP_POKE_BREAKPOINT) {
> +		if (mutex_is_locked(&text_mutex)) {
> +			err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
> +							(char *)bpt->saved_instr,
> +							BREAK_INSTR_SIZE);
> +		} else {
> +			/*
> +			 * It is safe to call text_poke_kgdb() because normal kernel execution
> +			 * is stopped on all cores, so long as the text_mutex is not locked.
> +			 */
> +			addr = text_poke_kgdb((void *)bpt->bpt_addr,
> +							bpt->saved_instr,
> +							BREAK_INSTR_SIZE);
> +			err = PTR_ERR_OR_ZERO(addr);
> +		}
> +	} else {
> +		err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
> +						(char *)bpt->saved_instr,
> +						BREAK_INSTR_SIZE);
> +		if (err == -EFAULT && !mutex_is_locked(&text_mutex)) {
> +			addr = text_poke_kgdb((void *)bpt->bpt_addr,
> +						bpt->saved_instr,
> +						BREAK_INSTR_SIZE);
> +			err = PTR_ERR_OR_ZERO(addr);
> +		}
> +	}
> +	return err;
>  }
>  
>  const struct kgdb_arch arch_kgdb_ops = {
> -- 
> 2.20.1
