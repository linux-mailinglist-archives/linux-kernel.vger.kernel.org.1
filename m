Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D510294137
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395343AbgJTRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgJTRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:15:13 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9885C0613CE;
        Tue, 20 Oct 2020 10:15:12 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id b138so2563510yba.5;
        Tue, 20 Oct 2020 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMAkat+pr5AcmRrqVNZdhPbCE53YYvyE9XEgmZQh4KQ=;
        b=Spbm/aKU6Nigo9+i+NndMi/GW83wFIUo938iEB5K/8GZR/P7SQnT7TmcxWb/W/l7+M
         6v4Snd7hw6TnRROtOp4w8vTbM7GwCBuwzl+CnjmU8pDuM0ziq5fYH/9iI+JlXk6dbLBe
         BhrlnatlDFlvnycknRLSMAxZyzXjfYzplXGpMERyC+Qeu7/kbCMFyNTi2UrZnbyN29E0
         kHrHUkxljeM+WQENLvmBa2gpsj3RQpZQ+bRJLHV58g2cBF3j6f7cKYYbf+hXhwPk6xSp
         B9V4kNgoDv0KMo5BcDFtmMCrzWJCMDcxtszjgPDLQHs5CwBmavcuah24LAA6BrOVTJyq
         negw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMAkat+pr5AcmRrqVNZdhPbCE53YYvyE9XEgmZQh4KQ=;
        b=t5dVbEiLmQaFG4M97glY4ByuGVhekWOAAffbgeNK3uONRCdzcwaLZ+3/OxES5gQ2ID
         hKwogZTgwLMogJ7ZAdUpiTofopFNS6emUp9zvO0SJIvtd6hJGsLtXgRnn/SQat5xhFkG
         RuQUjAu5YcV1lqvJ+lI6aJwHsUrtFeTOm26XSUwF/KelAfltJyVlWYIAVErMFbMbhNHc
         3jPe1xB9JgP7OzEv0b4KGPw/y67/4cLvVmM9auKqTQY9FoyrsEzQHDpAf5Bv3rTnDLgs
         PjFrIvqYt/x13SU1tk550XrUqnZCQ5JuIrx/Mhv96ym6H9sfanNeTqC1PdCUv27cYytS
         d/8w==
X-Gm-Message-State: AOAM530vu5mEjZxs409vT+0ZUq4ez23klIaLBPfMXMhulx+K3U0Wp2Vk
        /TiqRkPuu/3v5qaM4aqe9+OnueqJ/2A2TJ8i6lg=
X-Google-Smtp-Source: ABdhPJz5MwUa16z/QjSEWXsmtin1xAnYxDeT9G19ciJL5EqNz/xWP/NXU/NzFOZH8LHtwhuJ10Ji1PPXe84KHhQT52M=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr5538938ybe.403.1603214112091;
 Tue, 20 Oct 2020 10:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
In-Reply-To: <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Oct 2020 10:15:01 -0700
Message-ID: <CAEf4BzZBpnFx+03xE-a9wA1zHbH+HfEQPDWN5cdZ6y1wa9y7tA@mail.gmail.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 3:51 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 19. 10. 20, 1:18, =C3=89rico Rolim wrote:
> > I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
> > `CONFIG_DEBUG_INFO_BTF=3Dy`, which requires pahole for building. Howeve=
r, pahole
> > version 1.18 segfaults during the build, as can be seen below:
> >
> > PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
> > '__kvm_nvhe_arm64_ssbd_callback_required', cu:
> > 'arch/arm64/kernel/cpu_errata.c').
>
> The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
> __kvm_nvhe_arm64_ssbd_callback_required =3D arm64_ssbd_callback_required;=
;

What's readelf's output for that symbol? If it's legal for SST_OBJECT
to have size zero, then we should just skip those in pahole. But it
shouldn't crash in either case, of course. But as Arnaldo mentioned,
that code changed significantly recently, so please check with latest
pahole from tmp.libbtf_encoder branch.

>
> > PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force
> > emit the btf.
> > scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
> > LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> >    LD      .tmp_vmlinux.kallsyms1
> >    KSYM    .tmp_vmlinux.kallsyms1.o
> >    LD      .tmp_vmlinux.kallsyms2
> >    KSYM    .tmp_vmlinux.kallsyms2.o
> >    LD      vmlinux
> >    BTFIDS  vmlinux
> > FAILED: load BTF from vmlinux: Unknown error -2make: ***
> > [Makefile:1162: vmlinux] Error 255
> >
> > It is possible to force the build to continue if
> >
> >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> >
> > in scripts/link-vmlinux.sh is changed to
> >
> >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}
> >
> > The suggested `-j` or `--force` flags don't exist, since they were remo=
ved in
> > [1]. I believe `--btf_encode_force` should be suggested instead.
>
> Agreed, '--btf_encode_force' makes pahole to proceed without crashes.
>
> > It should be noted that the same build, but with pahole version 1.17, w=
orks
> > without issue, so I think this is either a regression in pahole or the =
script
> > will need to be changed for newer versions of pahole.
>
> Yeah, I observe the very same. I reported it at:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1177921
>
> The backtrace:

[...]

>
>
> I suspect:
> commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> Author:     Hao Luo <haoluo@google.com>
> AuthorDate: Wed Jul 8 13:44:10 2020 -0700
>
>      btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.
>
>
> Which added this machinery (btf_elf__add_datasec_type in particular).
>
> > - [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/pah=
ole.c?h=3Dv1.18&id=3D1abc001417b579b86a9b27ff88c9095d8f498a46
> >
> > Thanks,
> > =C3=89rico
> >
>
>
> --
> js
> suse labs
