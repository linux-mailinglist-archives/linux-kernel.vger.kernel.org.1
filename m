Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965681EB3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 05:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFBDI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 23:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgFBDI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 23:08:28 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FE820734
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 03:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591067307;
        bh=OSeKIBeNKdViZCLRp/a6oN0A3BXom2MMiKOlG4JOszY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p86VHXmH+JPweu+gOsbLIcYD0DrJgbf2BLnT10K/gjaNhTifoYYaQq2u9EliMi3SV
         EzSMy0zTWYGeElwnM13nU0tkysAwWWifCFuxKXNUE2mAHSPb/o0xO2ESCtF5tn9jk6
         Kp45e+zS3mYV25/5uFkc4G/eq9BWLDm5JaGsa8tU=
Received: by mail-lf1-f41.google.com with SMTP id x27so5222461lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 20:08:27 -0700 (PDT)
X-Gm-Message-State: AOAM530OdVmxTN/es5IP+rD3Z4kCkHKbqTB1YjHaH3ZpuowSYdythqdG
        jKmsUEJZNfR4y6xgByEY22zbK8yZzL6wV/Spv7s=
X-Google-Smtp-Source: ABdhPJyymHI6pTAhHP8b9+puyjeWJcXgpaifJQGqwrdAGwJBOwvz5qcT1uT26G60cDLA8s66fWq+rX1Ixl4ocaCP43M=
X-Received: by 2002:a05:6512:3111:: with SMTP id n17mr12611309lfb.137.1591067305860;
 Mon, 01 Jun 2020 20:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <CAJF2gTTxaZtyLYok68a5bBnLMuZjrwcQ7dvTR8NGdJc3Cqv81g@mail.gmail.com>
 <CAHCEehLunCV4ZY_=j_bwPWMppXBQ8vj_0oScVpt4ySR9rAjtyA@mail.gmail.com>
In-Reply-To: <CAHCEehLunCV4ZY_=j_bwPWMppXBQ8vj_0oScVpt4ySR9rAjtyA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 2 Jun 2020 11:08:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTRKWP47Y4bXmXpPdG-ay4Je2+HUOaMOMz37qDxZSiu6A@mail.gmail.com>
Message-ID: <CAJF2gTTRKWP47Y4bXmXpPdG-ay4Je2+HUOaMOMz37qDxZSiu6A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/13] riscv: Add vector ISA support
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 10:21 AM Greentime Hu <greentime.hu@sifive.com> wrot=
e:
>
> Guo Ren <guoren@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8831=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:52=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Greentime & Vincent,
> >
> > Thx for the dynamic vlen implementation. I've two suggestions:
> >  - Please give out glibc patches mail URL, we need to review them toget=
her.
> >  - We need to consider that not all processes need vectors. Most
> > system processes do not have vector features, and we should not force
> > save/restore vector for every process.
> >
>
> Hi Guo,
>
> Thanks for reviewing the patch. We are still cooking the glibc patch,
> we will add the glibc link address once we post it.
> For the save/restore mechanism in signal, it is basically the same
> with FPU porting, we can optimize it when setup_sigcontext() for both
> FPU and VECTOR in the future.
>
> /* Save the floating-point state. */
> if (has_fpu)
>         err |=3D save_fp_state(regs, &sc->sc_fpregs);
> /* Save the vector state. */
> if (has_vector)
>         err |=3D save_v_state(regs, sc);
>
> There should be a better way to detect whether this task use
> fpu/vector or not. Might be elf attributes or something else.
Ok, we could improve it in future patches.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
