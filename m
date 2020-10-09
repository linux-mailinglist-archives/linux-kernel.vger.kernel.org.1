Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEA288FF4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbgJIRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbgJIRZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:25:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846DCC0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 10:25:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g12so11082711wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=218xaHs2rZNa9jTYJXmDVRRaape+5jpCuo1cSZDE68Y=;
        b=creOSRKTUeYhh/6OYZA4joo2NuLZpIGt9Kw1OHbgUY8hTfB7xaWX0/NbfNllme2edb
         dgib8pb5T89oPSoxmq9gfSlt0+qO3IE44aMVJy+zAByETZ3fwQ9450NdqyJ5xFO85rZc
         gIrHGYk3HhI/emo4vCgsDyZi4yXDNglUqAmKNk5MSc3PO+YSsTfiCWDckdbwGUgpXpaT
         kRsCyo/cWSpbCUtgrFJDj5IWoTjTpPx7kXn8M4kazm1lbgPWj0UNidKVnWwEATuk1x+7
         kqKBRLlcnmIaUKKlfA9GtaA3AIRxvIHfJ/U8AbBe5EzlvroiSp3xB1UUS3Pblb5hnqB7
         j4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=218xaHs2rZNa9jTYJXmDVRRaape+5jpCuo1cSZDE68Y=;
        b=kCJierbyjjQJR8Hau4cKIylX0c3ofcy1WtRous9BuGM9aK1gKdRg8RFUaswy6jvEM0
         LvmrJgTgVJcJDuv+Z0R6TZwIhYH2734rzIEwLBMl0TviCLsdsCe2Wlz+4n+wxGIxlmnp
         wzli0xNBm+3GkZNvwL6L9tE2tVn5hvf3+k2WPTEP6JCrY0j1DFb2vzoGha/LApRjcdo8
         OzE+5Pk3xEtzMef4Vwo7OIbvzIirpOgdKBDVOKjqHyqO1p8W/fZqnHZ4wCBopMK5emdr
         KEYeN50Gttv+IaWgDQO+ObD9Vm8bxaqPgXJhdKKotVDTCdZEDPwdpI/YlHdZTRwISWU8
         U+Yw==
X-Gm-Message-State: AOAM530yi72lTiNs9Hyl4RlrWqkk6LsLdg+vjvueQD6rZJ7uDs2QM2gU
        g+fAwi1pXg8m3w0sm8A2Je7iNRIAzy0M1i6Pao56SA==
X-Google-Smtp-Source: ABdhPJw8wFSMxS4yjlgkAhvA1enAoa/MDoiy6oG3g4JoOICMO5+l65LTJwkqsXFSbFkPwPeX5NdjEccKlSXmutiQx/U=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr16465051wrw.18.1602264312119;
 Fri, 09 Oct 2020 10:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <122e3e70cf775e461ebdfadb5fbb4b6813cca3dd.1602263422.git.yifeifz2@illinois.edu>
In-Reply-To: <122e3e70cf775e461ebdfadb5fbb4b6813cca3dd.1602263422.git.yifeifz2@illinois.edu>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 9 Oct 2020 10:25:00 -0700
Message-ID: <CALCETrUD7z3-zL_rATzTyDUzgerOzXJHdn-hntNMG=vnX8ZF2w@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 3/5] x86: Enable seccomp architecture tracking
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 10:15 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: Kees Cook <keescook@chromium.org>
>
> Provide seccomp internals with the details to calculate which syscall
> table the running kernel is expecting to deal with. This allows for
> efficient architecture pinning and paves the way for constant-action
> bitmaps.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/x86/include/asm/seccomp.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
> index 2bd1338de236..03365af6165d 100644
> --- a/arch/x86/include/asm/seccomp.h
> +++ b/arch/x86/include/asm/seccomp.h
> @@ -16,6 +16,18 @@
>  #define __NR_seccomp_sigreturn_32      __NR_ia32_sigreturn
>  #endif
>
> +#ifdef CONFIG_X86_64
> +# define SECCOMP_ARCH_NATIVE           AUDIT_ARCH_X86_64
> +# define SECCOMP_ARCH_NATIVE_NR                NR_syscalls
> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT          AUDIT_ARCH_I386
> +#  define SECCOMP_ARCH_COMPAT_NR       IA32_NR_syscalls
> +# endif
> +#else /* !CONFIG_X86_64 */
> +# define SECCOMP_ARCH_NATIVE           AUDIT_ARCH_I386
> +# define SECCOMP_ARCH_NATIVE_NR                NR_syscalls
> +#endif

Is the idea that any syscall that's out of range for this (e.g. all of
the x32 syscalls) is unoptimized?  I'm okay with this, but I think it
could use a comment.

> +
>  #include <asm-generic/seccomp.h>
>
>  #endif /* _ASM_X86_SECCOMP_H */
> --
> 2.28.0
>


-- 
Andy Lutomirski
AMA Capital Management, LLC
