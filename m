Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6735A2DB11B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgLOQQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbgLOQQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:16:03 -0500
X-Gm-Message-State: AOAM530J6vbuNBZbZuD7UCGHv3AJSSDSYuihK3P4V4WX9E4pjTRcYrhw
        58s9XWp0ouHAKRcQlx0SpNwDWHJM6ZXBnrRwNgyPvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608048922;
        bh=NSmRzlg/JQLFlqEfSVhG0M93gbE91QssCPAEe8Ycpjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lYDhqIbLEu3n2CkajFDk2CI/IYkWFxMVFbmfTyb4FgMGhkkt15705cBxpvU7m8oKp
         J+St9zJxLc9kW+vywdYdrVVqVJU2RY/p6DxE11DuIfcApW21Bbk9JoPKacyaHDJMc7
         2Bp5f94AIYtKEANjqxkJMO7cgGLiT2HETDL6KR4gYmyIixg9g0hLeeliCxrjko5KTe
         T2ldKdWhK13SIcjR4Y+ghanB7SAckTRU3MCHW00548Au/ASkraxRrgdeZ8RjsJLSpS
         IqF5/2aLj/3Lc+sTy2zWv8wbaRMAN4afMPvfYM/bxxAhxHS/dDWEDV535aX9e9O+si
         oEkxWTvYC/Bpg==
X-Google-Smtp-Source: ABdhPJxDl85bST73mTnx1jeOrEu2XGSd20J2aEeSCjyo8qMWFulGV5ssjOPBTDcdE+AqtYtZJJV89DR0vsrPjwYVJbU=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr19245025wrq.75.1608048920820;
 Tue, 15 Dec 2020 08:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20201215160314.18773-1-info@metux.net>
In-Reply-To: <20201215160314.18773-1-info@metux.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Dec 2020 08:15:09 -0800
X-Gmail-Original-Message-ID: <CALCETrWukL-wMnq==-V4dvh_Q+h_sRvJBuTF3jQtHPo4MZ3AQA@mail.gmail.com>
Message-ID: <CALCETrWukL-wMnq==-V4dvh_Q+h_sRvJBuTF3jQtHPo4MZ3AQA@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: entry: vdso: fix type conversion on printf() call
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 8:03 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Fixing the following compiler warning by explicit conversion to long:
>
> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:162:0:
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>                                                     ^
>   CC      mm/filemap.o
> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:166:0:
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/x86/entry/vdso/vdso2c.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
> index 1c7cfac7e64a..5c6a4bbc63f9 100644
> --- a/arch/x86/entry/vdso/vdso2c.h
> +++ b/arch/x86/entry/vdso/vdso2c.h
> @@ -35,7 +35,8 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
>         if (offset + len > data_len)
>                 fail("section to extract overruns input data");
>
> -       fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> +       fprintf(outfile, "static const unsigned char %s[%lu] = {", name,
> +               (unsigned long)len);

This would be nicer if you put the line break after the equal sign and
before the {.

--Andy
