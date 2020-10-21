Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8286295545
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507219AbgJUXki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507212AbgJUXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:40:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477CC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:40:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b26so2436346pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O9rYzRnSkF2UD97oO4EZ0NEFG4S2m4ydCre3ge1rKBo=;
        b=YRDA3LM3mSoV+qVHj0WcfDRccqbiy+Vs53VdVmWN0gDDOWE6TRTrOq4P3bSYMsJL/M
         LN90r/7t5oX/RYXLEIlYtQCjBeFpuifOz/VJKj8mxFU09fTHL+CdmKdb9Cbv/ziL8gH2
         AUnMcPagIb2YvtdIKujUiCI5d4Jnei3Tvi53U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9rYzRnSkF2UD97oO4EZ0NEFG4S2m4ydCre3ge1rKBo=;
        b=cby4Cd8sQT8DLsQR+cXnz4sUPToSrvLW/nhAZDKZwL+B6KLR+QwFA+3oYp6e87LDv5
         YB4HdtPmYPVCrxOZcJCaP1kQreSKaeUNmU3V8dtqd07Tkg63P6QJ4OFrtVJ92Zu4fZ3t
         +3BXhy/jY21qa3I/Q0roE70EuTqpy0E0aUTWLZw4c/aez6KmGUWOejC7VrOiJtQH//Gm
         HgFmSLRpiHxG7dksvhp+bJBZgDgqMLJJRNeqSrQ/9ZRMpZpeFYJIFaae+90f1Vpjnac2
         XId0i5sfcubbEBL0bAwtTxhK5c1R4Bl7Fx/4WthIdggjgw1+Fd/tHW556U+Im2t68WIh
         hg8Q==
X-Gm-Message-State: AOAM532R7nQKGCxmyurPPevm5oHGPVbdXZa+a9z9Fx84n+CezkJIvMZy
        w8UcrHRvDuNOJRZR31Fx8+J4MQ==
X-Google-Smtp-Source: ABdhPJzanjxc4NIOzF2s4oNQAJsI/jJirh6Lls2RWMsMFJPP35SrjVOC4hEaHo0pft8xghEOjUn6LQ==
X-Received: by 2002:a63:c806:: with SMTP id z6mr21407pgg.430.1603323636408;
        Wed, 21 Oct 2020 16:40:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ne16sm12877pjb.11.2020.10.21.16.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 16:40:35 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:40:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
Message-ID: <202010211637.7CFD8435@keescook>
References: <20201021225737.739-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021225737.739-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> The vfp_kmode_exception() function now is unreachable using relative
> branching in THUMB2 kernel configuration, resulting in a "relocation
> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
> linker error. Let's use long jump in order to fix the issue.

Eek. Is this with gcc or clang?

> 
> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")

Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections") ?
That commit may have implicitly moved the location of .vfp11_veneer,
though I thought I had chosen the correct position.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/vfp/vfphw.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> index 4fcff9f59947..6e2b29f0c48d 100644
> --- a/arch/arm/vfp/vfphw.S
> +++ b/arch/arm/vfp/vfphw.S
> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
>  	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
>  	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
>  	teq	r3, #USR_MODE
> -	bne	vfp_kmode_exception	@ Returns through lr
> +	ldr	r1, =vfp_kmode_exception
> +	bxne	r1			@ Returns through lr
>  
>  	VFPFMRX	r1, FPEXC		@ Is the VFP enabled?
>  	DBGSTR1	"fpexc %08x", r1

This seems like a workaround though? I suspect the vfp11_veneer needs
moving?

-- 
Kees Cook
