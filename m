Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1F2AFC73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgKLBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgKLATB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:19:01 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEDDC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:19:01 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b3so1830945pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LtCB6ZCF5AGvMeS9/icU9Rx1IjLI7o2d2+oG/pddwrw=;
        b=OaS8OCI9vb4kX6A8hupmj8NATt3fN/fgdTiQcAD1/I6BOuJtVeBmYKpIfu2F3qcqzR
         eoTGEp9h8KeTFRsVOWOaV8C86OTlRGI6nzhp5AlfFoqLV3+DTgYfo6ZX2vzN2TsKr1KF
         MljKYMnhYJHUDG21TW1ClzitF5AxABIlSe/sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtCB6ZCF5AGvMeS9/icU9Rx1IjLI7o2d2+oG/pddwrw=;
        b=T7OLpTNmmrSFItA5gG8JdiNP9HmOZX+bUYXziuxcY3h+cxpEi5/V/i8CNhpoxvkd+l
         0TnOTHLauAfjKgrMJWPCqK2WfWQ+OTUrZYVKKHDY38Qg/2lDsWJUg8UmtqV/YNIhqO73
         Del2NK2I4GfoFiP0Oqgk2Fga9Gkr70zTonlnHhh9dFxJAoQ40kua1KjX99shF4ofYh2D
         yOAjINh44JvsnTQXSz4Ah6H02TShWoUFon3NeCOXXRt7x1WO0JUZQDhFRGfuoa9ZRSSk
         EblExXZsD9H4VUn8GVWmiXpZ8CckABPq/kOMk0P9Uyp3bZoAhkUH3f15dVkdkzVz7poJ
         f/Yw==
X-Gm-Message-State: AOAM530iNNvQzUojN3AwMTfBFYdiOyVRKiH5x1CvOdN1EU3mxOUlccE+
        NYIZbKyWs2ZANIruCiFd/rMDYg==
X-Google-Smtp-Source: ABdhPJy98FONnxapcMcTx6KXTK44zmyO5NEg2p5+rPybfcQDvSFSP+aBjDKSJ/YVgs6sXsi40n6ejA==
X-Received: by 2002:a17:902:7482:b029:d6:682d:5c6c with SMTP id h2-20020a1709027482b02900d6682d5c6cmr22661750pll.84.1605140340819;
        Wed, 11 Nov 2020 16:19:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm4040230pfd.203.2020.11.11.16.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 16:18:59 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:18:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: Enable seccomp architecture tracking
Message-ID: <202011111618.8315C4F4@keescook>
References: <20201028002000.2666043-1-keescook@chromium.org>
 <20201028002000.2666043-2-keescook@chromium.org>
 <X6rNTgw8z4kreVD9@trantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6rNTgw8z4kreVD9@trantor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 05:26:38PM +0000, Catalin Marinas wrote:
> On Tue, Oct 27, 2020 at 05:19:59PM -0700, Kees Cook wrote:
> > To enable seccomp constant action bitmaps, we need to have a static
> > mapping to the audit architecture and system call table size. Add these
> > for arm64.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/include/asm/seccomp.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
> > index c36387170936..40f325e7a404 100644
> > --- a/arch/arm64/include/asm/seccomp.h
> > +++ b/arch/arm64/include/asm/seccomp.h
> > @@ -19,4 +19,19 @@
> >  
> >  #include <asm-generic/seccomp.h>
> >  
> > +#ifdef CONFIG_ARM64
> > +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_AARCH64
> > +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> > +# define SECCOMP_ARCH_NATIVE_NAME	"arm64"
> 
> "aarch64"? (to match ELF_PLATFORM; not sure what this is used for as
> SECCOMP_ARCH_NATIVE_NAME is not defined in 5.10-rc3)

Ah yes, I was thinking of the arch/arm64 name. :) I will fix this.

> 
> > +# ifdef CONFIG_COMPAT
> > +#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_ARM
> > +#  define SECCOMP_ARCH_COMPAT_NR	__NR_compat_syscalls
> > +#  define SECCOMP_ARCH_COMPAT_NAME	"arm"
> > +# endif
> > +#else /* !CONFIG_ARM64 */
> > +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_ARM
> > +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> > +# define SECCOMP_ARCH_NATIVE_NAME	"arm"
> > +#endif
> 
> Why do we need a !CONFIG_ARM64 in an arm64 header file?

Heh, again, sorry -- I'm so used to the 32/64 being combined as I did
the other architectures. I'll fix this too.

Thanks!

-- 
Kees Cook
