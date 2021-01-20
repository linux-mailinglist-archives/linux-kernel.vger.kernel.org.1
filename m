Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BBE2FCF82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbhATLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:36:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbhATKXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:23:30 -0500
Received: from zn.tnic (p200300ec2f0bb00025b63af061f9e1d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:25b6:3af0:61f9:e1d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C26B51EC0662;
        Wed, 20 Jan 2021 11:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611138164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uy4pncCkrGKMsjEhFoRsE+HAyvF7LiHaPJn+3qJN9h4=;
        b=Ypgc6K9mSbI6u0CUUX3csSNAqL9RbkJvkN7GiJbZitkl7R75ArQ17Ql/WJD70co/3vh8xh
        diIwGEq4in0LjwoeoQJrHqAGtdE0HLPHRHws5GO4u6O0CfwcLX/HQynDDk5zZO8u31IR/l
        ycSXshNZ/OPl/Z+HzYbuH7lO4lPz7Uk=
Date:   Wed, 20 Jan 2021 11:22:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, yu-cheng.yu@intel.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        kan.liang@linux.intel.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu/xstate: calculate the number by sizeof and
 offsetof
Message-ID: <20210120102238.GA825@zn.tnic>
References: <20210120064415.16977-1-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120064415.16977-1-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:44:15PM +0800, Yejune Deng wrote:
> In fpstate_sanitize_xstate(), use memset and offsetof instead of '= 0',
> and use sizeof instead of a constant.
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 5d8047441a0a..2e75630c86e9 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -161,20 +161,16 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
>  	 * FP is in init state
>  	 */
>  	if (!(xfeatures & XFEATURE_MASK_FP)) {
> +		memset(fx, 0, offsetof(struct fxregs_state, mxcsr));

I'd prefer the explicit zeroing instead of having to look at
fxregs_state and where the offset of mxcsr is.

> +		memset(fx->st_space, 0, sizeof(fx->st_space));

This is ok I guess.

>  		fx->cwd = 0x37f;
> -		fx->swd = 0;
> -		fx->twd = 0;
> -		fx->fop = 0;
> -		fx->rip = 0;
> -		fx->rdp = 0;
> -		memset(&fx->st_space[0], 0, 128);
>  	}
>  
>  	/*
>  	 * SSE is in init state
>  	 */
>  	if (!(xfeatures & XFEATURE_MASK_SSE))
> -		memset(&fx->xmm_space[0], 0, 256);
> +		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));

This too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
