Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA52FE527
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbhAUIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbhAUIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:37:26 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F0AC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:36:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i17so1566103ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShR8Iy4EKAtV+wsW/PAamwnSHxI0o7jW0AkYvsGe0P0=;
        b=AswVHO+MLeAxMP7iBCrY7vQWJJcUXaVLKJp1j11dy9eaDqKO7JBHXWvek+yAHgr1bI
         g++s72a6eYpV6mcdgmFCDnp/CqoWOtLxPzV1dVSsUxP8CqaTXlJkm6D3SfPpq2sWqeEk
         JJbWBe/zOkdobaYJsaAF3j1pTKVnBfCGy0QGVVhxZqrR3NzwRsTscvKeYPLZTwpn0I4Y
         L9VaG+ECbPQpC5T4a6cOOqbONxfMmCeGRWWeBfJueOYriB8wK/28hcpcDsMwGGpGqT+N
         PC26/BnFsimTVMrjQqBgmLfgllRJR0sefmnjnNp715Kg3D0JC10+aRfeR+zgTwziRBga
         aMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShR8Iy4EKAtV+wsW/PAamwnSHxI0o7jW0AkYvsGe0P0=;
        b=fKsBYX2msPC1OGeBV1rMdvSTCPHKGvQ0f5olQDnqCv47CsoLbj9ru5hu6CTg8Lg0hU
         fzzAoOoEcSLf68grhRZ1XVF4cGU0j1l6IznqHU4h7yDItq1wnMn9Tg16wei1si4ItdWf
         sZOvv4UMIP5LvA6NzrLWdy8UNA2fnYXaYqXlpbvaPaPVDqjdCLwGCO7xANyNaXD+/L4+
         3l5vBmerjTPaVR/HcKKErOaascmaMGlJkriJUm97VG1L1vT2GtqPkCA/oZ73lQSSNM18
         XUouRaoNhD4nyI19TCBOnReyEOInWmZB/zv608lOx9+euShwwVQM9Nw713ss6F2b+CSn
         MuSQ==
X-Gm-Message-State: AOAM531AleM9SUYZUCtFF20PdA5lM/YdNC46J8lWHrp3hhqRtRbdpV1+
        ueITx6/3ZvAOW+VWEAqMG/QqtkaxWIqW1vIky5edgg==
X-Google-Smtp-Source: ABdhPJyXPK2yeW7G88IJAq/LsL0xOATh2YuYCQPpmAnIz8szFSS4/u7oMsgNJ75r+04C5EQnocZS/zWDinPPAxIOf1Q=
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr3278111ljm.273.1611218203448;
 Thu, 21 Jan 2021 00:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20210120125010.10896-1-carver4lio@163.com>
In-Reply-To: <20210120125010.10896-1-carver4lio@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 09:36:32 +0100
Message-ID: <CACRpkda5VXyg5F7r4RaHrSh303KZ3FjxnLEsQ1tFNXjMhxDqLw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] arm/mm/ptdump:Add address markers for KASAN regions
To:     Hailong liu <carver4lio@163.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Hailong Liu <liu.hailong6@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:54 PM Hailong liu <carver4lio@163.com> wrote:

> From: Hailong Liu <liu.hailong6@zte.com.cn>
>
> ARM has recently supported KASAN, so I think that it's time to add KASAN
> regions for PTDUMP on ARM.
>
> I have tested this patch with QEMU + vexpress-a15. Both CONFIG_ARM_LPAE
> and no CONFIG_ARM_LPAE.
>
> The result after patching looks like this:
>  ---[ Kasan shadow start ]---
>  0x6ee00000-0x7af00000         193M     RW NX SHD MEM/CACHED/WBWA
>  0x7b000000-0x7f000000          64M     ro NX SHD MEM/CACHED/WBWA
>  ---[ Kasan shadow end ]---
>  ---[ Modules ]---
>  ---[ Kernel Mapping ]---
>         ......
>  ---[ vmalloc() Area ]---
>         ......
>  ---[ vmalloc() End ]---
>  ---[ Fixmap Area ]---
>  ---[ Vectors ]---
>         ......
>  ---[ Vectors End ]---
>
> v2:
> - fix the puzzling subject and the description due to my
> carelessness.
>
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker.

Yours,
Linus Walleij
