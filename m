Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91E320BC03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 23:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFZV5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZV5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:57:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852E6C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:57:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so10802964wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaefEko3kEAOd19TubqWqNAf+AVqFUJ4Wq5QM8k6oA0=;
        b=qL1iJ7bZpKKnvVKjD187zlZlhBdctCIOERlzFxD2/eUC+EigcNn9fFXpSLUQiHsyPM
         J2GyHAN1uXx0fDpU6ax3Q+zfqDjOXSEV4Imh/Rr/W9vmTL3sHKRmaPqoKv/uCzOoM5xe
         jnSN/Kniwd9tOv+pNM5FyqOtdLSjaqdhl1eCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaefEko3kEAOd19TubqWqNAf+AVqFUJ4Wq5QM8k6oA0=;
        b=WX2bn2IrQemDnRRQusVj2t3QrmDrRvanzh5ErBNUK3NqP5pJLyatY7ysj+KdOvSVFj
         cXg+p3OWpdkQ2P3ZuDtWHHiQ5fP1sJt9U+qOQ82wyOCUunUCE0UDvPx3pBYXppwElrxs
         VtBxCO9u1WP5ApthlwEuCGJOXAC5MD+m/kgcnL1FL9Fcg8dUbtlUymBJpK4semDpkE/4
         N6ulIIF5LaEibD6YOZMbgl6Xxwyw3vnERwYq1bHQFFZm1zcyvcnFNPybhPIxJ/97Azlr
         e+6BlTdbhE9N94owxwo+bw1ZAyguzui+FhibyYOfEI3fVORfTX8qIz2UjCb3/ml9EXsA
         0qFw==
X-Gm-Message-State: AOAM531QY/aX0XLLwdLXFw3SYd/mT/0exM1S+KqoSHrpHK6+4CF27iSY
        OzMqqfJQbJWzLqzNSrVbo+Z09l0zdi1LaK8NaJbY
X-Google-Smtp-Source: ABdhPJyOcljMPyApSrrEvUL7seEvgR6bpWPbI+cLBCYQT1ljE7hdK0sJpijoILYe0Ntw+U/b51zVLnq6pnDNP2TU1tE=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr5616423wrv.162.1593208664289;
 Fri, 26 Jun 2020 14:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200625234516.31406-1-atish.patra@wdc.com> <20200625234516.31406-11-atish.patra@wdc.com>
 <8b71b663-8a68-26f3-c806-a2873a6d8923@gmx.de>
In-Reply-To: <8b71b663-8a68-26f3-c806-a2873a6d8923@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 26 Jun 2020 14:57:33 -0700
Message-ID: <CAOnJCU+=0Ozz=qfMULsN4-4rq_q4UFYsnkH50Bo5PfzUU45e6g@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] efi: Rename arm-init to efi-init common for all arch
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 8:00 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/26/20 1:45 AM, Atish Patra wrote:
> > arm-init is responsible for setting up efi runtime and doesn't actually
> > do any ARM specific stuff. RISC-V can use the same source code as it is.
> >
> > Rename it to efi-init so that RISC-V can use it.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  drivers/firmware/efi/{arm-init.c => efi-init.c} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
> >
> > diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/efi-init.c
> > similarity index 100%
> > rename from drivers/firmware/efi/arm-init.c
> > rename to drivers/firmware/efi/efi-init.c
> >
>
> After each patch we should have code that builds. This helps when

Absolutely.

> bisecting. Therefore I would have expected an adjustment of
> drivers/firmware/efi/Makefile in this patch and not in patch 11/11:
>
> -arm-obj-$(CONFIG_EFI)                  := arm-init.o arm-runtime.o
> +arm-obj-$(CONFIG_EFI)                  := efi-init.o arm-runtime.o
>

I think I messed it up while rebasing. My bad. I will fix it in the
next version.

> Best regards
>
> Heinrich
>


-- 
Regards,
Atish
