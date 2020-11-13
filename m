Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD7F2B13A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKMBDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgKMBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:03:35 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C87C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:03:35 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id e18so8724445edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rHcsSn4tvPHdEd3aSA+VI5udp3Ct0q3o9hwij9UMEQ=;
        b=ZFi5IgqOb9K+M2xVzFZ1Dj4wIiazGAiIKRobu7yknmcbmQ6bQvP0kH99tQFLNAOPlB
         0v99P4TViqiGe1DeMXs/6Vcv0hKoYpmnjugEwpflxekpA8YYEhn0krqLedZpWiC72ZQU
         k8o/k1XZd2BJEnheNsLiTSEQKS7vo/2X7KxBIKfrUXng4pGTPSdYRyv+wxl7kddmJjBh
         b+WIGyhV2hufXGRSLOSvsjfdqE/Oa8DFNXC2F/lYLtrbaYwspxeFIPDqKXcOITKqaOBk
         xsErUSJBxlbodtdR2iX+6AVPlfAehuEW7umj43T6Gs2I52CEcdbft5Z0xW5x9thRZgNx
         AUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rHcsSn4tvPHdEd3aSA+VI5udp3Ct0q3o9hwij9UMEQ=;
        b=dlqoMPBsM7PHLOTt6iRNUAMd3/dueAaRmOV/QUyzLGGpcSrwME8s8XatQnpBBJu8t8
         vlGE5s+qK/DriniTzrkF1MGa9ax2IbRUIVUf00ITBF+SknPtSP/Vtr3b6Dx2gYv5C+E8
         nMjQ4ZWeKrWExO0/QY+2PhBU0TVir3e4TIIYu75zrq2tuwRare3LkMpxRpX2N3v1paYo
         HIY5eNe03zBihuFU1YmnjniOrmHUOXwJv2tuDXivnPHBHV78gTXm2wM+PNTIL1EgjLxu
         BS0bMVpS8bAKtwaVcDZT6ryQekgnTsODgA0SqJCi/P5rKvAtKI+Hy09m7I6l6hLsnNQl
         gDAw==
X-Gm-Message-State: AOAM531gGCPom6UkKOp5rllZDQK8OWRvYzNE+zsntO0S72dlRhv21NDn
        gP8hZfsI6eu86tY7L3j6yRQyDhr3SrKIaec0G0IkBHcAxA==
X-Google-Smtp-Source: ABdhPJxgk9h7tG5lIlfb8RpVXqIs4njVIRR6YGvJXee5knc0Tq/r5hVZFfeh358uA/QWm7hROYzzQ/iT/MMxBhhd7DQ=
X-Received: by 2002:a50:99d6:: with SMTP id n22mr19914edb.261.1605229413879;
 Thu, 12 Nov 2020 17:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20201108203737.94270-1-natechancellor@gmail.com> <CAKwvOd=P2yFxkAXh9TUpJ=D5=jNnxnx7O5Nr3iTDeqV40UA19A@mail.gmail.com>
In-Reply-To: <CAKwvOd=P2yFxkAXh9TUpJ=D5=jNnxnx7O5Nr3iTDeqV40UA19A@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 12 Nov 2020 17:03:22 -0800
Message-ID: <CAGG=3QVQTQsHhsb5cSEejZ=D4Gq60cz7kMfD8moXWeVU1odTdQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Explicitly specify the build id style in vDSO
 Makefile again
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 4:53 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Nov 8, 2020 at 12:37 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Commit a96843372331 ("kbuild: explicitly specify the build id style")
> > explicitly set the build ID style to SHA1. Commit c2c81bb2f691 ("RISC-V:
> > Fix the VDSO symbol generaton for binutils-2.35+") undid this change,
> > likely unintentionally.
> >
> > Restore it so that the build ID style stays consistent across the tree
> > regardless of linker.
> >
> > Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Thanks for the fixup!
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> (I'm curious what --build-id linker flag does, and what kind of spooky
> bugs that led to a96843372331?)
>
--build-id generates a unique "build id" for the build. It can use
several different algorithms to do this. The BFD linker uses sha1 by
default while LLD uses a "fast" algorithm. The difference is that the
fast algorithm generates a shorter build id. This shouldn't matter in
general, but there are some tools out there that expect the build id
to be of a certain length, i.e. the BFD style's length, because BFD is
more prevalent. The obvious response "well, why don't they just change
the expected length?" is difficult in all situations. (Once an
assumption is made, it's hard to backtrack.)

You can add this if you like:

Reviewed-by: Bill Wendling <morbo@google.com>

> > ---
> >  arch/riscv/kernel/vdso/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > index cb8f9e4cfcbf..0cfd6da784f8 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -44,7 +44,7 @@ SYSCFLAGS_vdso.so.dbg = $(c_flags)
> >  $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
> >         $(call if_changed,vdsold)
> >  SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
> > -       -Wl,--build-id -Wl,--hash-style=both
> > +       -Wl,--build-id=sha1 -Wl,--hash-style=both
> >
> >  # We also create a special relocatable object that should mirror the symbol
> >  # table and layout of the linked DSO. With ld --just-symbols we can then
> >
> > base-commit: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
> > --
> > 2.29.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201108203737.94270-1-natechancellor%40gmail.com.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
