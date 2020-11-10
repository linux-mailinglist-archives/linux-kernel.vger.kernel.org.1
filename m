Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6042AE083
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgKJULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:11:36 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EABC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:11:36 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so11229849pgk.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dF4wNWErsCaTFjbAYZ5rOT8K7SSx1h9isfYodFGRVTA=;
        b=wPVJ2kjrCdXfic4OirA/w3wgoBc/It/D83vsJEJN6hm/H7G+iRjyYDIkKmgRwYzKDx
         hYimeswpWH+DAYxdTvefM2YJIoTW6vjLotcZa1n65Kg8Zt2457EJxJgW9Qi2Ux2e68VA
         /OJKNHBe1/wv2AeXEXC3/wU4IQT3e7mZjrXTemunce2bKovomyv/rQ9iqiEk7jT26aaE
         MhclsAIOtGp575YcYh3ISx7NPJr6v+aZ7IQCtGLWB+hnWVnKKnnDbt5aYIPpdvQ5BCaF
         SacUG8t5U24sunNlBeeQxoGenr+obbr+8YVAxGxxmwqW8FrYTSmpZL27Kzq+zGgKnTLD
         tfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dF4wNWErsCaTFjbAYZ5rOT8K7SSx1h9isfYodFGRVTA=;
        b=gSETnTTQ6O8tc9njy/34TNAzHxpS4n/pAMm4Z2DbPnpjjMEOZ6T0R5xfB1/h4SJYlV
         WynGATRQo+fwzfvMDv2SnkTO/humiQczcGEP8UDKAje5fxWpyvI0X5GRFYkVPVYM4GDn
         aQmR+W5c+Q/JK84MTImUhMbblaNaEMRXsz6fTBKPkG/7bAjPIq/qQibAs9JJHLSVOI1p
         hDrpX1inQhIGKFGwM+Exc2o9pa/uaoQC7p2Fd7d+mbCWczql55hyc/lI1TYVTpkuq5Em
         hD5HSXr3wbrQeQunGHbVT4rc/87FRDydSPR6I0WfeuF/ekY0UTtaSCZLvEhlTSe753hQ
         4a1g==
X-Gm-Message-State: AOAM531PYFwEYLT3LTUweVTWv8411dUv6bt6rQpqmsNDOYxDKBD/NQbi
        1SwXoh17LXOU8cxoqG5Qe89efPPzYgoICxBWGG00VA==
X-Google-Smtp-Source: ABdhPJxOBkdmt2COhStQnhUQZimbjSVPpiS2aYJmX1CwrQED3PuwvBG3ZtHBosfjOBL3311Aa1HKRQ/72xCb/hztrcs=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr867608pjj.101.1605039095998;
 Tue, 10 Nov 2020 12:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
 <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com>
 <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
 <CAKwvOdkXz5wOwKQDsi5jt21ov3xETSByAqxGLQ=7U6Gsp46zcQ@mail.gmail.com> <CA+SOCLJSSR62VfWhKx9R1cxT-CHXD7RN08eJBYxUH8zzyWos9Q@mail.gmail.com>
In-Reply-To: <CA+SOCLJSSR62VfWhKx9R1cxT-CHXD7RN08eJBYxUH8zzyWos9Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 12:11:24 -0800
Message-ID: <CAKwvOdkpHdQF9Ko8FbP_SN=QfDiMq8ra5TSj_KHGRCbJdyYm6w@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Jian Cai <jiancai@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

On Tue, Nov 10, 2020 at 12:10 PM Jian Cai <jiancai@google.com> wrote:
>
> I tried to verify with ixp4xx_defconfig, and I noticed it also used CONFIG_CPU_BIG_ENDIAN=y to enable big endianness as follows,
>
> linux$ grep ENDIAN arch/arm/configs/ixp4xx_defconfig
> CONFIG_CPU_BIG_ENDIAN=y
>
> Also it appeared arch/arm/kernel/iwmmxt.o was not built with ixp4xx_defconfig. The commands I used
>
> linux$ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CC=clang ixp4xx_defconfig
> linux$ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j32 CC=clang
> linux$ ls arch/arm/kernel/iwmmxt.o
> ls: cannot access 'arch/arm/kernel/iwmmxt.o': No such file or directory
>
> Did I miss any steps?

Yes, you need to manually enable CONFIG_IWMMXT in menuconfig or via
`scripts/configs -e`.

-- 
Thanks,
~Nick Desaulniers
