Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BED2AC076
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgKIQEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIQEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:04:48 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C5C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:04:48 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so13152932lfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jeP73yjot5P5PYYoDTHv8FWcNF9fYzo7D6kb+Sl6j0A=;
        b=DhfVSYytQa41IShEE+cQjYskmCpWinvvfZR7MH3wG2xOAhdpSP1Y0uX+DL8NMmqE9C
         hdwcJgkhXxlIBMKzS7jTSPNY/X5VTGEDovba3wdZlzPDUKtQrTt0kBzzYd+KZEoma9Jg
         HzwrAdF4a93O/Si8uRG8fa4ovmMtxKelWKWq8tK+dSyJCorOLnTHsqSe5MyMCG1Jvf1/
         jaTU5kuN0Ia5/1HSNTqNd9Mxxct3jrUoKUSqeRK+qdnU+21cUFy3uztJUvZoiFQDRQX0
         bJtdmaoD2BO1LmHzkuD7U2eY0vP+MGwg8RVn7ivLSrsbIMcXoEIGsgOtjo0vlJiMEFFk
         Eaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jeP73yjot5P5PYYoDTHv8FWcNF9fYzo7D6kb+Sl6j0A=;
        b=WPgAdpHzFts6rh9/1/H0FhtozV/iaWwgiN5lw64C3nFF3Ro4Z+NB+ZxhmfzRJcEp7i
         0gTINzDRHUVbHCCd1hnKprcL0IaJV78aT7XWlvO8+UTNOUN1ih+19MqcWTlp+zmxiuOF
         qW00p0+NnpQ/QIGNYX3Mnorg3YaHQDWr/6yvjL+YQdESJhg0gxEoeJN/JnuxrXv5IfMu
         Z0F6+ei9fK1eOMT9rGgs3ac8o7ma2Y9RpkTDSv0rDaB9lDn1ItOano/p9vGjoSt/P0u6
         Vw545Zto2a3ogG7OGyrFu/NPQBJqTuOvuPV7eIOOOEXKfssO/4nmhYWGi4BD9XpM4Orp
         CmSQ==
X-Gm-Message-State: AOAM5332+fMh3KUd/2CjOR+5n7EoFOjOektkbCirAH5Pzw2gqQCsdp1z
        2n6xvNlZ5DAsTKb9/aPWuLtRuZDltV1bs5BcklT88A==
X-Google-Smtp-Source: ABdhPJzDzkdosffI0Mz9qLpul3enRFWSt2c0NCrg0WZV4atZRzqfffs3kK/kAltbrs5+oqV1+15LwEjKbdf1Q9yaSRw=
X-Received: by 2002:a19:ca05:: with SMTP id a5mr2891098lfg.571.1604937886671;
 Mon, 09 Nov 2020 08:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20201108222156.GA1049451@ubuntu-m3-large-x86> <20201109001712.3384097-1-natechancellor@gmail.com>
In-Reply-To: <20201109001712.3384097-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Nov 2020 17:04:35 +0100
Message-ID: <CACRpkdZV3nPZ29MmKXfw87eL+3CcOXC5LTeQf5WuLRsrJeEKLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: boot: Quote aliased symbol names in string.c
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joe Perches <joe@perches.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 1:19 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Patch "treewide: Remove stringification from __alias macro definition"
> causes arguments to __alias to no longer be quoted automatically, which
> breaks CONFIG_KASAN on ARM after commit d6d51a96c7d6 ("ARM: 9014/2:
> Replace string mem* functions for KASan"):
>
> arch/arm/boot/compressed/string.c:24:1: error: attribute 'alias' argument=
 not a string
>    24 | void *__memcpy(void *__dest, __const void *__src, size_t __n) __a=
lias(memcpy);
>       | ^~~~
> arch/arm/boot/compressed/string.c:25:1: error: attribute 'alias' argument=
 not a string
>    25 | void *__memmove(void *__dest, __const void *__src, size_t count) =
__alias(memmove);
>       | ^~~~
> arch/arm/boot/compressed/string.c:26:1: error: attribute 'alias' argument=
 not a string
>    26 | void *__memset(void *s, int c, size_t count) __alias(memset);
>       | ^~~~
> make[3]: *** [scripts/Makefile.build:283: arch/arm/boot/compressed/string=
.o] Error 1
>
> Quote the names like the treewide patch does so there is no more error.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Hi Andrew,
>
> Stephen said I should send this along to you so that it can be applied
> as part of the post -next series. Please let me know if you need any
> more information or clarification, I tried to document it succinctly in
> the commit message.

I wasn't even aware that there was such a thing as post-next.

Thanks,
Linus Walleij
