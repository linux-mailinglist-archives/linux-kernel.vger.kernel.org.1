Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502FD2CC623
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgLBTFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgLBTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:05:24 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256ADC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:04:44 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id p21so929523pjv.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwFCcSF3JbZEcp9Z3pjvQUej5xg0kXdcQPMPFZwHFX8=;
        b=lwIJo2u0tzYkuHiYMvmii8cyOx50NaH8QvTxFNVCeSjxSaWfHw5bNbtbkEmwIVS65i
         hBg1Q0Qa6kINYzGAC8cBLP5xbA5StsYX+Ex6Q5422xUQ+4M0FtRh2ZJi+lcTYh1E0vsy
         RyMyyeYJSdJYvUXlYNzbqwBcZkW/KSJaiSY24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwFCcSF3JbZEcp9Z3pjvQUej5xg0kXdcQPMPFZwHFX8=;
        b=Lz5k9Z8vQC3uYtloI4pnwEHLazeLdt9YYqBJZKjOgNIGhHYgBMnzN6/ChccqenK/ka
         VXbw8+RnwCLAgr+4TrLL/pfe9jGRniWMLx9SysT+cswNHe8Kg5F5zLW92XERLbtPsgpw
         xzwyJyL8CDAwvQgG0lWakLoBpCO+2gNP+KQxeZqFJXjhjBOZaeu89AMI/V/OF8cmL/9X
         5IsPxF9Y66fC1K7P6Bogkr0iOcSyLgpDMVkTKid6YCm7xaMNhVy9ZWPoJPbC4SXUmPjT
         K9LGAKIG8A61RnFUPZ+A5hnR823ol/3tDsSvvb9e8ssBB7p9fg06Pv84JaW5cyHfGx/T
         OURQ==
X-Gm-Message-State: AOAM533RT2n+tv8XTt9fBbHWvlOgGBr78RBwi56/9s+IuxXM9VJ3rJ0q
        cGf1pQg9L/sosFGd3cK1IRx4tw==
X-Google-Smtp-Source: ABdhPJzc+grIh3FrlarD3mXxGH7nSP9p14zHQKfUiLiFIiwk52p3LcrnA0c2+0F5W9/96DViXwklJA==
X-Received: by 2002:a17:90a:2d6:: with SMTP id d22mr1255625pjd.38.1606935883731;
        Wed, 02 Dec 2020 11:04:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g85sm530108pfb.4.2020.12.02.11.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:04:42 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:04:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/uprobes: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-ID: <202012021103.5A8030BF7A@keescook>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
 <160689907597.3084105.18019089399087866918.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160689907597.3084105.18019089399087866918.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:51:16PM +0900, Masami Hiramatsu wrote:
> Since the insn.prefixes.nbytes can be bigger than the size of
> insn.prefixes.bytes[] when a same prefix is repeated, we have to
> check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> of insn.prefixes.nbytes.
> 
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> Cc: stable@vger.kernel.org
> Reported-by: Kees Cook <keescook@chromium.org>

This should probably be:

Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
Debugged-by: Kees Cook <keescook@chromium.org>

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 3fdaa042823d..bb3ea3705b99 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -257,7 +257,7 @@ static bool is_prefix_bad(struct insn *insn)
>  {
>  	int i;
>  
> -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
>  		insn_attr_t attr;
>  
>  		attr = inat_get_opcode_attribute(insn->prefixes.bytes[i]);
> @@ -746,7 +746,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
>  	 * No one uses these insns, reject any branch insns with such prefix.
>  	 */
> -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
>  		if (insn->prefixes.bytes[i] == 0x66)
>  			return -ENOTSUPP;
>  	}
> 


-- 
Kees Cook
