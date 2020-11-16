Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A662F2B551D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgKPXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbgKPXfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:35:03 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826DDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:35:03 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so14620427pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pv3SdWEU94yZUVWUhkFKAAtzguyHPsl6uo1DKmUfEmk=;
        b=ThL2VPbq6tQT41obQs2rumy1Zc1xCnOh1BOu6+GeVE3t/4BxvetMa7F4W69LyAAC9j
         LIQpcBxhXa2Ob+07TKaeNMvqmEN80io1xTgb6V3heMoqjO+hqKIvaKxIrlzY7K3tRH9P
         FdGQ5oIvXRtNIb7nqybdwJ4MHbuXna8pFZSdhkXkIqUl7WIAxpOwSQCX4zeQ10AkvJAo
         AFmpoeENxPh3JIwxn+UzvGN4DPJWN0VUe+qMZKhvGTQhPcpaIPsGn88M48PAtiizOBEn
         dWbcWzakiWfvXGZLN+/+SbraF5s+9TAfnG5v2scLlv/aZYD0HXcL5Cyw/O8uARxGwaoy
         0abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pv3SdWEU94yZUVWUhkFKAAtzguyHPsl6uo1DKmUfEmk=;
        b=N0PzcfCJnZVWk66wCqfzjnQuXv9i5aPo9bV/kawh5/Rh0+33EVtW8iXrYku0xtP830
         ThfLuwjDdrXxE+glOtISW/ci/YgP0avpdmp5Y5V6pRh2fSJsiKv9XM44iPT6fSfR9wT9
         8FByF10GEgor2dwDAtXw/Jf3IU7V+fZWNp2pOBcMwygJiAcox3tYHXWfyy/vpmaiWoHz
         6sd1Jtz7DDJ1W2nu/Zy3D/pvdFny7Fb4GxD4SoudxMu6kUnYTDSzo6x3BuS/fz948gN/
         AkSUoGcm1HbC0VztVGHR6MfK5VW65d9eMVcqolOHah4QADa+XYU9e9q+LxjMBVG3u17r
         GWyg==
X-Gm-Message-State: AOAM53336JPKYX60PkRXAFU49V4TKt7heVAYGekvl0wX4SIzT7eI2wZx
        m1Uyz5wiNNzNac9cVN8pG+IIyDYnxnxdDMqiibn1Rg==
X-Google-Smtp-Source: ABdhPJzcW2PVHopBMd0xgsqMrcmed1NFI91MyTdyQEBc2n2hVm2m7NjtYpoGWbVzQ5DeMt6s9zbBJxpqggI7yAzKo1w=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr1447923pjh.32.1605569702981;
 Mon, 16 Nov 2020 15:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20201116120913.165317-1-mpe@ellerman.id.au>
In-Reply-To: <20201116120913.165317-1-mpe@ellerman.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Nov 2020 15:34:52 -0800
Message-ID: <CAKwvOdnhmcmGgSfKG0KEOEbf=WZnixV6c838ArQ8EOXUXqxfMQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Drop -me200 addition to build flags
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>, oss@buserror.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 4:09 AM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> Currently a build with CONFIG_E200=3Dy will fail with:
>
>   Error: invalid switch -me200
>   Error: unrecognized option -me200
>
> Upstream binutils has never supported an -me200 option. Presumably it
> was supported at some point by either a fork or Freescale internal
> binutils.
>
> We can't support code that we can't even build test, so drop the
> addition of -me200 to the build flags, so we can at least build with
> CONFIG_E200=3Dy.
>
> Reported-by: N=C3=A9meth M=C3=A1rton <nm127@freemail.hu>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for the patch; this should make randconfig builds not pick this
non-buildable config.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> More discussion: https://lore.kernel.org/lkml/202011131146.g8dPLQDD-lkp@i=
ntel.com
> ---
>  arch/powerpc/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index a4d56f0a41d9..16b8336f91dd 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -248,7 +248,6 @@ KBUILD_CFLAGS               +=3D $(call cc-option,-mn=
o-string)
>  cpu-as-$(CONFIG_40x)           +=3D -Wa,-m405
>  cpu-as-$(CONFIG_44x)           +=3D -Wa,-m440
>  cpu-as-$(CONFIG_ALTIVEC)       +=3D $(call as-option,-Wa$(comma)-maltive=
c)
> -cpu-as-$(CONFIG_E200)          +=3D -Wa,-me200
>  cpu-as-$(CONFIG_E500)          +=3D -Wa,-me500
>
>  # When using '-many -mpower4' gas will first try and find a matching pow=
er4
> --
> 2.25.1
>


--=20
Thanks,
~Nick Desaulniers
