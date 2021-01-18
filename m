Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B651C2FA128
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbhARNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392090AbhARNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:15:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:15:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d26so16410750wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/8+eCjMadN4hEryRCq5t61h0Kw3XOPXiND7TB0YLFkM=;
        b=POEfM+et/dcTeVjJtAwq/2yXoy6V3wf7ul3s27ev5mHWELYMXtXCj7/gO6jo59jZVn
         cs5u23n+N+VtOZrULvMG1Q/dEXmAM6xLLHcc3B0s/Zay9YGRESfIMny06wivrXUKnB+X
         Fw/lmIJxeH1zTm5V+bkKESe2/3nYIfaBPfGjnqLUpQn2Co6f2TdJsPp6pGDzB69pPXXV
         WsI0Vis835YnO0tVbq9uo/yoKVMoOs2CI93pguLm3mYL1BvBYfpknR7l0LVn21222UHK
         ir8LfXPL4tlSTHEDH3+YxSGGb4KDBD29ojK6NhRpvKS/wKUTx8xqiM5fMY6IW2AP7VNB
         uisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8+eCjMadN4hEryRCq5t61h0Kw3XOPXiND7TB0YLFkM=;
        b=COTdTYasmF6V1CK/ywrE9aUWyEz37PCEMrP6aLQhOudYus/Tum+N64LUzLLync3frc
         fAlBiatmu9JsYF/0JR5AjoD0D+BfdmOIYHzd0JEGlY3p780cNDFm7nteNFG+zYnbyaLB
         gWcHLmtJBaFqzgDWMF/J8i0dTi9CArAQrbh6Cm2Om9xyRY9urTO+I0gAvNt8dAlG33It
         zHw3tw3gKZrpYrT7NbHxm2ljs5afe2Tf3jEudd6GUr+iD4fXGm8uXrgpuDWce+lQZOY4
         1khsHjer94RWP51v2rl87BU8OsCP3nXUnN4OWfgRq3LOtKtQZGsnS9/SUnD1DK4k3DEW
         epGg==
X-Gm-Message-State: AOAM532DgKUFOLbcgpYEPGyzjHBTqsuAJBJj9DyYXBucke4AfQC6S5lQ
        Rdh5o/6De1VT9G2c8bnm16cA3uVP9ZDCBA==
X-Google-Smtp-Source: ABdhPJzmPlfcSrGqBJwt+ReFSFMEuRuGZv6bGgz8c75Q6bbIP50Hu5TPT8/BskwWGDST3jm1ca0mEA==
X-Received: by 2002:adf:ae01:: with SMTP id x1mr25557426wrc.381.1610975699419;
        Mon, 18 Jan 2021 05:14:59 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id h23sm4761819wmi.26.2021.01.18.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:14:58 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:14:57 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 14/21] arm64: Honor VHE being disabled from the
 command-line
Message-ID: <20210118131457.47ppbilsaq7cdtft@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-15-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-15-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:26AM +0000, Marc Zyngier wrote:
> Finally we can check whether VHE is disabled on the command line,
> and not enable it if that's the user's wish.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>

> ---
>  arch/arm64/kernel/hyp-stub.S | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 59820f9b8522..bbab2148a2a2 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -77,13 +77,24 @@ SYM_CODE_END(el1_sync)
>  SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	// Sanity check: MMU *must* be off
>  	mrs	x0, sctlr_el2
> -	tbnz	x0, #0, 1f
> +	tbnz	x0, #0, 2f
>  
>  	// Needs to be VHE capable, obviously
>  	mrs	x0, id_aa64mmfr1_el1
>  	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
> -	cbz	x0, 1f
> +	cbz	x0, 2f
>  
> +	// Check whether VHE is disabled from the command line
> +	adr_l	x1, id_aa64mmfr1_val
> +	ldr	x0, [x1]
> +	adr_l	x1, id_aa64mmfr1_mask
> +	ldr	x1, [x1]
super nit: There's a ldr_l macro

> +	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
> +	ubfx	x1, x1, #ID_AA64MMFR1_VHE_SHIFT, #4
> +	cbz	x1, 1f
> +	and	x0, x0, x1
> +	cbz	x0, 2f
> +1:
>  	// Engage the VHE magic!
>  	mov_q	x0, HCR_HOST_VHE_FLAGS
>  	msr	hcr_el2, x0
> @@ -152,7 +163,7 @@ skip_spe:
>  	orr	x0, x0, x1
>  	msr	spsr_el1, x0
>  
> -1:	eret
> +2:	eret
>  SYM_CODE_END(mutate_to_vhe)
>  
>  .macro invalid_vector	label
> -- 
> 2.29.2
> 
