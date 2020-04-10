Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6A1A3D29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 02:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDJABq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 20:01:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43170 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:01:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id s4so236217pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfliXDX1Ymsggc4DabpVxNTeN6zHMaFuavIUQZv83/0=;
        b=DvFGg3oFXnnQxUL5pHpYQ6dHu8U3ro9D6atqz+8PGLUtvoCIPsx+DmaDo3D5jjW3TN
         mStoRntCkHKEdA9/JMNf9ulVM0JVlltV+AxI41WETYYnbFzXx17p/iusZ1LyZNKFzZ59
         CghU1HcG4Mbq3OnwN41Q2bjdQmUcOL+6vOzGu5nSELnNSYP6Ms9+L2sPoAhYMCJImXf1
         rM/8CNlIcAsCywNiK8mC60qgqjcS+UgleeCpKz7nig09hx8DmJRvy0Sw4DMymxuevGDZ
         WmHOdum/QKHkYki2S5R4/q7GLFkGFaz2GL/BCnu62WsDC9QbpyenGwbIBuMyWp+4jyqw
         UEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfliXDX1Ymsggc4DabpVxNTeN6zHMaFuavIUQZv83/0=;
        b=ND/vKw/c/XQ9ZO16ac+l2iFb1v+zAYibYL18WRNw/kmUObNfl222xUomd6m0jWGH/R
         /X2TJqOLZNg9+4QDDGKLJ58s2HHLT1Ft6aSZcihfkUQVHOoKJRYfTvyqdjI8zmub0gij
         8JuyyWUD5H/9sqOqWFvUj5YkzmhPF4gFwyLmEZnu0vlMXvejQPGPUvYnwba9pCPbBSa1
         JfX4y5eDsM1luNdGI4fTAVt+h/tTLDp+OGcGdkQbWIZ4a4ntMXXunCeWPvvPut69ELlz
         b/5U6R29dbpKZ7c1+d7ep/8vMv36oUL4z2IkI93UlYdB+JI3I4tKjdqIKJlK5BYXNU7i
         bXUA==
X-Gm-Message-State: AGi0PuZ8LBlFNMW3r7yiOG28br+5KPZEYWMMxrB7fGow64l4kQOFJaG6
        y9iXMqa2mjIDNXdoYEXzfWVCA0ZBrZ339QgQFctQNA==
X-Google-Smtp-Source: APiQypJseTCHzeZtziKweVcMeV2FfOR5o5Zn7BHGyFeGb76AXp7DOTg9ScYedtjAFCzO+5s/pN/1Ly0ICNpwNhDzLcQ=
X-Received: by 2002:a65:6704:: with SMTP id u4mr1927192pgf.263.1586476904758;
 Thu, 09 Apr 2020 17:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com>
In-Reply-To: <20200409232728.231527-1-caij2003@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Apr 2020 17:01:33 -0700
Message-ID: <CAKwvOdkot0Q7FSCMKGm6ti4hhvD3N+AMUK4Xv2Xxiiu3+pURgQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Jian Cai <caij2003@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Manoj Gupta <manojgupta@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 4:28 PM Jian Cai <caij2003@gmail.com> wrote:
>
> iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> Skip this file if LLVM integrated assemmbler or LLD is used to build ARM

Hi Jian, thank you for the patch.  It's pretty much spot on for what I
was looking for.  Some notes below:

s/assemmbler/assembler

:set spell

;)

Also, could use a link tag, ie.

Link: https://github.com/ClangBuiltLinux/linux/issues/975

(Always include the link tag to help us track when and where patches land).

Finally, I think the hunks for the two different files should be
split; the init/Kconfig change should be it's own dedicated change
that goes to Masahiro, the maintainer of the Kbuild tree.  Then when
we have that, the dependent configs should go separately.  Would you
mind splitting this patch in two, and re-sending just the Kbuild patch
for now?  Since you used Sami's patch for inspiration
(https://github.com/ClangBuiltLinux/linux/issues/975#issuecomment-611694153,
https://github.com/samitolvanen/linux/commit/fe9786cb52a0100273c75117dcea8b8e07006fde),
it would be polite to Sami to add a tag like:

Suggested-by: Sami Tolvanen <samitolvanen@google.com>

or maybe better yet, take Sami's patch, add your signed off by tag
(maintaining him as the git author, see `git log --pretty=fuller`),
then rebase your AS_IS_CLANG hunk on top, make that a second patch,
then finally have the arm change as a third patch.

This change is exactly what I'm looking for, so these are just process concerns.

> kernel.
>
> Signed-off-by: Jian Cai <caij2003@gmail.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  init/Kconfig     | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 66a04f6f4775..39de8fc64a73 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -804,7 +804,7 @@ source "arch/arm/mm/Kconfig"
>
>  config IWMMXT
>         bool "Enable iWMMXt support"
> -       depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
> +       depends on !AS_IS_CLANG && !LD_IS_LLD && (CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B)
>         default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
>         help
>           Enable support for iWMMXt context switching at run time if
> diff --git a/init/Kconfig b/init/Kconfig
> index 1c12059e0f7e..b0ab3271e900 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -19,6 +19,12 @@ config GCC_VERSION
>  config CC_IS_CLANG
>         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
>
> +config AS_IS_CLANG
> +       def_bool $(success,$(AS) --version | head -n 1 | grep -q clang)
> +
> +config LD_IS_LLD
> +       def_bool $(success,$(LD) --version | head -n 1 | grep -q LLD)
> +
>  config CLANG_VERSION
>         int
>         default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
> --

-- 
Thanks,
~Nick Desaulniers
