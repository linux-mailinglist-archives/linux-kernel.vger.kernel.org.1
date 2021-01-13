Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A52F4227
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbhAMC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbhAMC6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:58:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF5B123120
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610506656;
        bh=A2X9yAJjMelGsnUZoFeBcSZDu8oKUroi/CJv9/mXNCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fkC/OTEwMOc1ls89758/bPG65vPCysFvTAGXFqzRzS7YoGiCuSlwPFZ/xouX3dvDs
         R1duE0mjZrHOZmpS6SB3pGEmyGxtk69DuUV19Dnz9phAaYAyGQUhGovoRzkoGfWvg/
         eUqlSevoePa/Si6iEq+dnfrQo7mLrk7TwqqXcXQ6IlLpOVBcMsmdmRr6+RpbcyytPl
         KIJUzE5DePPJgUKkQrT8xVzdDxOwaQdcG8/Mr0KFkFIFyZWtGhMArrs1Yth9Rs7iun
         VnoX7DWj1WbCVrJw+wAYQLpiQy8kclwqkYzhI9AS/SWIpgsZhDxW0QLUAW+Lo0fV3L
         QmuXWtmz3tpHA==
Received: by mail-lf1-f54.google.com with SMTP id b26so562563lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:57:35 -0800 (PST)
X-Gm-Message-State: AOAM530eCWxZfKwg+xxcWO039+Xt+4YIM/QXbmCqyrSxyq9PU9FBfe++
        TfPLtSymsPF+5y0x5HbMFCEtW5eOFXC/N8PSYg4=
X-Google-Smtp-Source: ABdhPJwlhGXDaVk1dHC2iXVm1w5QTAinOx5BgK1PGcETU2AuiXP4xhOlgjZ7sCe4ka/j4bOSE6viYJm2r3RIZu5N+Fk=
X-Received: by 2002:a19:38e:: with SMTP id 136mr852405lfd.346.1610506654053;
 Tue, 12 Jan 2021 18:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20210112023534.117354-1-guoren@kernel.org> <CAOnJCUK89rwjfnpMtavbaf-pwBndnS-=kVwsdP2yJnJAwJi-kg@mail.gmail.com>
In-Reply-To: <CAOnJCUK89rwjfnpMtavbaf-pwBndnS-=kVwsdP2yJnJAwJi-kg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Jan 2021 10:57:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQYT-pkUrdoCiZsLX+SwYk89FKO=tgscwwQrdtHEobPpQ@mail.gmail.com>
Message-ID: <CAJF2gTQYT-pkUrdoCiZsLX+SwYk89FKO=tgscwwQrdtHEobPpQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove duplicate definition in pagtable.h
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 4:18 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Jan 11, 2021 at 6:38 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > PAGE_KERNEL_EXEC has been defined above.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 41a72861987c..dff51a84e52e 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -101,7 +101,6 @@
> >  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
> >  #define PAGE_KERNEL_EXEC       __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
> >  #define PAGE_KERNEL_READ       __pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
> > -#define PAGE_KERNEL_EXEC       __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
> >  #define PAGE_KERNEL_READ_EXEC  __pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
> >                                          | _PAGE_EXEC)
> >
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> It's already on the fixes.
>
> http://lists.infradead.org/pipermail/linux-riscv/2021-January/004134.html
Great, ignore mine :)


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
