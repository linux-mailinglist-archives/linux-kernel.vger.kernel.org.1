Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B42AE0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgKJUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKJUiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:38:19 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4452063A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605040698;
        bh=dC2cst0+NehiX2IqKyhIGqMDMr6AVk93A52+2YUUDYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ydR4/EiraONC/eDzv3t+v7EPeyfeQc1mmt2M/m+lKadnm8O1QU9H71rzaLzkKUiN8
         zYyCdDCpN8vphm6svn66M1VfMUesY8cq2Fb7w8puJlZg6lEpH/BuH+pHwMosQ9/MxZ
         V72En7fsMYWUBX52drVvNfBuPlUjB6Obe4auUmho=
Received: by mail-ot1-f50.google.com with SMTP id l36so6136ota.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:38:18 -0800 (PST)
X-Gm-Message-State: AOAM5318EezkBzgoA/tfEJagFmn2AIHRAK/hYpkB0ULRB2fSDaTz2kkg
        DHYWzlDQNDRfnDRZZwBrBMG3L4FZRbBM7GsLFsU=
X-Google-Smtp-Source: ABdhPJxWsltJYzyOIUKf+sHvuw0kAUSXKj+mqDZv0jEhae06t2cIBzZfqPoE0IenaIXO6cMdDs5B/+1apE8QpJAq2GQ=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr13918918otc.305.1605040697642;
 Tue, 10 Nov 2020 12:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
 <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com>
 <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
 <CAKwvOdkXz5wOwKQDsi5jt21ov3xETSByAqxGLQ=7U6Gsp46zcQ@mail.gmail.com>
 <CA+SOCLJSSR62VfWhKx9R1cxT-CHXD7RN08eJBYxUH8zzyWos9Q@mail.gmail.com> <CAKwvOdkpHdQF9Ko8FbP_SN=QfDiMq8ra5TSj_KHGRCbJdyYm6w@mail.gmail.com>
In-Reply-To: <CAKwvOdkpHdQF9Ko8FbP_SN=QfDiMq8ra5TSj_KHGRCbJdyYm6w@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Nov 2020 21:38:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1tU8g4HfsoYH4qa6C4Kv8QE3nv=UPSyH7824GXCYwUDQ@mail.gmail.com>
Message-ID: <CAK8P3a1tU8g4HfsoYH4qa6C4Kv8QE3nv=UPSyH7824GXCYwUDQ@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jian Cai <jiancai@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 9:11 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Tue, Nov 10, 2020 at 12:10 PM Jian Cai <jiancai@google.com> wrote:
> >
> > I tried to verify with ixp4xx_defconfig, and I noticed it also used CONFIG_CPU_BIG_ENDIAN=y to enable big endianness as follows,
> >
> > linux$ grep ENDIAN arch/arm/configs/ixp4xx_defconfig
> > CONFIG_CPU_BIG_ENDIAN=y
> >
> > Also it appeared arch/arm/kernel/iwmmxt.o was not built with ixp4xx_defconfig. The commands I used
> >
> > linux$ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CC=clang ixp4xx_defconfig
> > linux$ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j32 CC=clang
> > linux$ ls arch/arm/kernel/iwmmxt.o
> > ls: cannot access 'arch/arm/kernel/iwmmxt.o': No such file or directory
> >
> > Did I miss any steps?
>
> Yes, you need to manually enable CONFIG_IWMMXT in menuconfig or via
> `scripts/configs -e`.

To clarify: ixp4xx and pxa3xx were two platforms based on the XScale core.
ixp4xx was commonly used in big-endian mode but lacked iWMMXt. pxa3xx
had iWMMXt but doesn't allow enabling big-endian mode because of a Kconfig
dependency, meaning that nobody has ever tried it, and it's likely broken.

Later 'mvebu' parts (Armada 510) do have iWMMXt and allow big-endian
mode, but those are BE8, with non-reversed byteorder for the instructions.

So none of this matters in practice, but it's very satifiying to know
it is finally
all working with the integrated assembler in all those combinations, at
least in theory!

      Arnd
