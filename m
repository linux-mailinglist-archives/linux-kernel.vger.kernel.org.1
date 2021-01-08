Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371C2EF663
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbhAHRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:21:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36228 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbhAHRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:21:32 -0500
Received: from zn.tnic (p200300ec2f0a31007b8134cbda999f41.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3100:7b81:34cb:da99:9f41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1E0A1EC01A8;
        Fri,  8 Jan 2021 18:20:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610126451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cNB3A8JXXFnx2hlchehGk7Dg8xjpACIq7MqfYUDn3ko=;
        b=q7VuqbSOvA0HFMW1ffzG8Akn7AZ1WL0hLrfnASBKY2ybetsOdtMY8AqZrfKYF5hpRPsWUw
        S5gC6KNfYBfQdr5fBOrwNEGrBJX2YThqddZrfGIUzt06OrIrrxFJzL9rLlkQLwjRYkNI/t
        uFbMqyhJXg5rbDniIk0T+rpBzxFdIb0=
Date:   Fri, 8 Jan 2021 18:20:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Hyunwook (Wooky) Baek" <baekhw@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/sev-es: Fix SEV-ES #VC handler for string port IO
Message-ID: <20210108172049.GF4042@zn.tnic>
References: <20210108025107.1223487-1-baekhw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108025107.1223487-1-baekhw@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 06:51:07PM -0800, Hyunwook (Wooky) Baek wrote:
> Don't assume dest/source buffers are userspace addresses when manually
> copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
> if handed a kernel address and ultimately lead to a kernel panic.
> 
> Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  arch/x86/kernel/sev-es.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 0bd1a0fc587e..812494d216ba 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -286,6 +286,12 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
>  	u16 d2;
>  	u8  d1;
>  
> +	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
> +	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
						^^^

Just by looking at this patch I know you haven't tested it before sending.

:-(

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
