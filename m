Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FF2FD83B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404680AbhATS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:26:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391967AbhATSSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:18:51 -0500
Received: from zn.tnic (p200300ec2f0bb000f815c9e084808a0b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:f815:c9e0:8480:8a0b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C699F1EC04D1;
        Wed, 20 Jan 2021 19:18:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611166688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YdsY64auz+N4Ke+6Uorfvs1e0o4cdCe8WQpfT5eDLSU=;
        b=YTPOvvCTWi8wDa1Njffe848Yoloadu1DGr7T9DL9MlfpgGosH3d+CmaJZ2Fl75fq0/Tg67
        E730Gx0BIyHJ6i6Mq123KgAPnIFqxMSIXI2/8F3aMDkYlURkZK1yqtVNXlqw/BVIivos/H
        iUylhhYiM3xcUzkEUXBjecppuqDzjPI=
Date:   Wed, 20 Jan 2021 19:18:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] x86/mmx: Use KFPU_387 for MMX string operations
Message-ID: <20210120181802.GH825@zn.tnic>
References: <cover.1611077835.git.luto@kernel.org>
 <cd68d61ece035201804a06e6993a2bd06bfe298b.1611077835.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd68d61ece035201804a06e6993a2bd06bfe298b.1611077835.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:39:00AM -0800, Andy Lutomirski wrote:
> The default kernel_fpu_begin() doesn't work on systems that support XMM but
> haven't yet enabled CR4.OSFXSR.  This causes crashes when _mmx_memcpy() is
> called too early because LDMXCSR generates #UD when the aforementioned bit
> is clear.
> 
> Fix it by using kernel_fpu_begin_mask(KFPU_387) explicitly.
> 
> Fixes: 7ad816762f9b ("x86/fpu: Reset MXCSR to default in kernel_fpu_begin()")
> Reported-by: Krzysztof Mazur <krzysiek@podlesie.net>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Cc: <stable@vger.kernel.org> I guess.

> ---
>  arch/x86/lib/mmx_32.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
> index 4321fa02e18d..2a6ad7aa148a 100644
> --- a/arch/x86/lib/mmx_32.c
> +++ b/arch/x86/lib/mmx_32.c
> @@ -26,6 +26,16 @@
>  #include <asm/fpu/api.h>
>  #include <asm/asm.h>
>  
> +/*
> + * For MMX, we use KFPU_387.  MMX instructions are not affected by MXCSR,
> + * but both AMD and Intel documentation states that even integer MMX
> + * operations will result in #MF if an exception is pending in FCW.
> + *
> + * We don't need EMMS afterwards because, after we call kernel_fpu_end(),
> + * any subsequent user of the 387 stack will reinitialize it using
> + * KFPU_387.

Please use passive voice and convert the "we" to something impersonal.
For example:

"Use KFPU_387 for MMX. MMX instructions are not affected by MXCSR, but
both AMD and Intel documentation states that even integer MMX operations
will result in #MF if an exception is pending in FCW.

EMMS afterwards is not needed because, after kernel_fpu_end(), any
subsequent user of the 387 stack will reinitialize it using KFPU_387."

Voila, de-we-fied!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
