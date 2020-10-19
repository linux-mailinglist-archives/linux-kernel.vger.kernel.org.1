Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F3292C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgJSRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgJSRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:00:14 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831CFC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:00:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so493915ior.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6egaM982RqgjxcvTIgx5sfX9sE4hVawM2afWAGzirtk=;
        b=MYi01MB8T13mPZwtbJHRnvdXtQxZWUylyMI3H1w9YAN621uOLZ3Y82rI17aKWMkBAE
         YiOsb4WJ5M5sPzfVkYcH1LLffGBobxN/97pG/X43pv0RtdNbNHos24NWUufvqtBYvtSp
         OvQxp23uOvj1ZGPyTQVb40QoqJxWHkPtnhHoM44D7wWaymFbUJAUDA31hpb69C+BmPQt
         t1Px6I7e6WHr+0OKyXNbCR1B1Qs6NMBwkfdlnmDIz6wnoHir2IK2ZI4jZIdgd3U3EorV
         TYW+bMakcszksHOZ8fmsHFa26jCGUO1JG2nQqB1VXTk49IFk9ZTP+xub59HI8zrvv68d
         8MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6egaM982RqgjxcvTIgx5sfX9sE4hVawM2afWAGzirtk=;
        b=AHexjzmzWVZwur2zyLMAo6+4uZqXq1GUz9jT5GZJShBAIA19+cfacO4q5d7D58MK6N
         w/yLN7Xp1rgMzB51texZviZZlTVrpN2vRJIpXxq4qq0BWBSejI2PIvpC9JS6VhT6zGUy
         zjjVIWCuhiejXgICfpFkkDhjVEITzBAxZ4YgP4s94lyrSi1hJN4yEBpbojcTrd+411l7
         BuCrLvgWrkyA/+tJh2K4T1hwJGmEVjg48zYAplRi4hTxBPXaICszXFcH/rN5j0pK2Nfr
         tbnPteqIk/ja744C+kwtMybtX4fTUrjYvN7Y1l5rUmj7DL3Gb1xJ3bWJJ6TzDD5oaHxG
         4M6Q==
X-Gm-Message-State: AOAM530bFnDe9xsEj3ZrJL0nIZxRrmUzr0EZxEF49ciplT4lOBx3fthQ
        lGlS1O5ScTKhUB9wFjlN0RlTwLxjcXRZng==
X-Google-Smtp-Source: ABdhPJyfxP9Wcrw4aQCqdGVRKjLYhpTzs+D2az73GqryeFpk5C6kz4b8AA9raT6rngLnVrMDNDUqHA==
X-Received: by 2002:a6b:b7c6:: with SMTP id h189mr297804iof.41.1603126812757;
        Mon, 19 Oct 2020 10:00:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a11sm188381ilk.81.2020.10.19.10.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:00:11 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 13:00:08 -0400
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201019170008.GA2701355@rani.riverdale.lan>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019151121.826-4-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 05:11:19PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Check whether the hypervisor reported the correct C-bit when running as
> an SEV guest. Using a wrong C-bit position could be used to leak
> sensitive data from the guest to the hypervisor.
> 
> The check function is in arch/x86/kernel/sev_verify_cbit.S so that it
> can be re-used in the running kernel image.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---

> +
> +	/* Store value to memory and keep it in %r10 */
> +	movq	%r10, sev_check_data(%rip)
> +

Does there need to be a cache flush/invalidation between this and the
read below to avoid just reading back from cache, or will the hardware
take care of that?

> +	/* Backup current %cr3 value to restore it later */
> +	movq	%cr3, %r11
> +
> +	/* Switch to new %cr3 - This might unmap the stack */
> +	movq	%rdi, %cr3

Does there need to be a TLB flush after this? When executed from the
main kernel's head code, CR4.PGE is enabled, and if the original page
mapping had the global bit set (the decompressor stub sets that in the
identity mapping), won't the read below still use the original encrypted
mapping if we don't explicitly flush it?

> +
> +	/*
> +	 * Compare value in %r10 with memory location - If C-Bit is incorrect
> +	 * this would read the encrypted data and make the check fail.
> +	 */
> +	cmpq	%r10, sev_check_data(%rip)
> +
> +	/* Restore old %cr3 */
> +	movq	%r11, %cr3
> +
> +	/* Check CMPQ result */
> +	je	3f
> +
> +	/*
> +	 * The check failed - Prevent any forward progress to prevent ROP
> +	 * attacks, invalidate the stack and go into a hlt loop.
> +	 */
> +	xorq	%rsp, %rsp
> +	subq	$0x1000, %rsp
> +2:	hlt
> +	jmp 2b
> +3:
> +#endif
> +	ret
> +SYM_FUNC_END(sev_verify_cbit)
> +
> -- 
> 2.28.0
> 
