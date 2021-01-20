Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F362FCE44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbhATKT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbhATKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:08:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256CC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dWRKnysMoCYVgpiHotWOpoe9PF3rMjzOvG2xl7rGJB4=; b=yLc58B08pClT6QzHO0Z7IA7SAV
        XYaYC+U+bDEYYrdca+4yw2uImJyiRcqXyiOb/BsHaTEoFH3ns3tLfRFDzwHWz6z4yo38f6iASUvPD
        C3CYQtn7DnBnKAZCDzhvC4ylJrKOiP2ZNhqCz97f16BGk1DTWXMecpcrdDVWQrCOndUbDujFmZtjm
        fJjxSDN4l/18y5eXvzX7cKVUdo6DVDOakD0cwaAAeJcFnac+ydAP6YS55mszlVR9vs7rzE8vta/Dp
        ozNxSv06quRTfa3QRCub81EeIKgPXiYlHT+kss0SBiWs6UteOIE5VbSL+vswTI1TyQP48UcmAQfbT
        1riSy+fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2AOS-0006dN-1M; Wed, 20 Jan 2021 10:07:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A12C5301959;
        Wed, 20 Jan 2021 11:07:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F94F206A9211; Wed, 20 Jan 2021 11:07:11 +0100 (CET)
Date:   Wed, 20 Jan 2021 11:07:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 4/4] x86/fpu/64: Don't FNINIT in kernel_fpu_begin()
Message-ID: <YAgAz4qYESIv8iNR@hirez.programming.kicks-ass.net>
References: <cover.1611077835.git.luto@kernel.org>
 <803d45a172a25314fdaec0a01aada8333d55df4e.1611077835.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <803d45a172a25314fdaec0a01aada8333d55df4e.1611077835.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:39:02AM -0800, Andy Lutomirski wrote:
> The remaining callers of kernel_fpu_begin() in 64-bit kernels don't use 387
> instructions, so there's no need to sanitize the FPU state.  Skip it to get
> most of the performance we lost back.
> 
> Reported-by: Krzysztof Olędzki <ole@ans.pl>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/fpu/api.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 38f4936045ab..435bc59d539b 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -32,7 +32,19 @@ extern void fpregs_mark_activate(void);
>  /* Code that is unaware of kernel_fpu_begin_mask() can use this */
>  static inline void kernel_fpu_begin(void)
>  {
> +#ifdef CONFIG_X86_64
> +	/*
> +	 * Any 64-bit code that uses 387 instructions must explicitly request
> +	 * KFPU_387.
> +	 */
> +	kernel_fpu_begin_mask(KFPU_MXCSR);

I'm also still sitting on this:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fpu

what do we do with that?
