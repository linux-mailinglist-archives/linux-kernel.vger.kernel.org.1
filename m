Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3742DE3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgLROCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgLROCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:02:19 -0500
X-Gm-Message-State: AOAM533sL/sWqRHbc4OAyr0LWI7W2qP28JCZXxiMPb1KMRl++tXDGDWN
        9wiqh4fpUvn6fEwgjs3H7OiaHBQpUEL5rYS8Jh4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608300098;
        bh=miwkI0PmCMwOfEXPMjjP6cSe57nffSfctnHXxbZBarQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IrFvXWjU7XE/SwiW2mr9MmGVUUVu17jdixAOieaOxrr01qkOfqyQAJXPYzst51SMg
         whjovhe+t2IDYYO5nipr5cUm4FYOE6nyqK4dLCuu/ehL25zwJQP927m+Ndg1VL9Km5
         4qnIYzQpaIoNyxqLo5iFVoeBiYHQkB2mAgT/dPlPUfm2NC81eaQxATmekf/jSq8N60
         Il58b/vyic66fMkp2FDFDOShFciGO/7bda81XfDUj01mIVx2CVen6H0qsHYpA9w2WD
         xgi6aIjkE5KVnUaNti4bWtMkJ8uOm3a4IweJb3xGAM3b7THJTQFoCp1n3eyGYJK0Tl
         WZFQvCqjbCObQ==
X-Google-Smtp-Source: ABdhPJxoDnRSrK0Cqu7UIi/AivYvrI05XKsd5SNNHqDhT7Ha5gZK7VwqkVmmVt/9eg2/LO0vNAQrZZEYHtwmtkhben4=
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr2833570ote.108.1608300097855;
 Fri, 18 Dec 2020 06:01:37 -0800 (PST)
MIME-Version: 1.0
References: <5fdc89c3.1c69fb81.c9707.68bb@mx.google.com> <3e1680ed-94b8-74c9-ffe6-c2bd71f2a705@collabora.com>
 <20201218140018.GZ1551@shell.armlinux.org.uk>
In-Reply-To: <20201218140018.GZ1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Dec 2020 15:01:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH-z91_EOpw8_5DCm22DiaU7FxzsCMmWV3-4=uM-FCM1g@mail.gmail.com>
Message-ID: <CAMj1kXH-z91_EOpw8_5DCm22DiaU7FxzsCMmWV3-4=uM-FCM1g@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on ox820-cloudengines-pogoplug-series-3
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 at 15:00, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Dec 18, 2020 at 01:48:09PM +0000, Guillaume Tucker wrote:
> > Please see the bisection report below about a boot failure on
> > ox820-cloudengines-pogoplug-series-3.  There was also a bisection
> > yesterday with next-20201216 which landed on the same commit, on
> > the same platform and also with oxnas_v6_defconfig.  I'm not
> > aware of any other platform on kernelci.org showing the same
> > regression.
>
> Ah, I bet I know what's happening.
>
> We test for the presence of VFP by issuing an instruction to read
> FPSID. If VFP is not present, this will raise an undefined instruction
> exception, and we expect to head into the vfp_testing_entry code.
>
> I bet Pogoplug, being an ARM11 MPCore platform, either raises an
> exception here.
>
> We probably need to also rework the code in vfp_init() as well to
> register a temporary hook when reading the FPSID.
>

Thanks for diagnosing that - I wasn't quite sure what was going on.

I will look into this later today.
