Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13BF2EC650
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 23:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhAFWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 17:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbhAFWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:44:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D47C061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 14:43:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x20so10154056lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5q2q1v8aWCbVGUuPPTxlEH2d71b5wQBBCfsYvwAI+x8=;
        b=HJ7929hohlQbvvi7L6HMRSRo8laHWXYiEDoPBj1JQhVgE/sLXXY2UUsgT4ro33vMOd
         ocqXxQfYzs9zjKxobaY3tmJ9X9CcUDRi0A4oFIfI0CsyLQE/lPdPbWRrXDgw1tj5jP07
         Y0/mNhnnPWZMR3y2ts/g1NtteZZxRlpO1xq9CigHrnXEIlVJHZifMmQs33l3MbQcQNU7
         6x4au3cRJ5r+/c1runx/+oQwLhrpFORomvx5AChT0MCUyNOoefaIBQViC4F540IdfBWP
         Hz4jJIHYCxQQsQcAlvuHcaRU0FA4ru2kXgb5oUqKmVHJlKPuxU2ul+mQpiwTIfxNw40X
         Y8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5q2q1v8aWCbVGUuPPTxlEH2d71b5wQBBCfsYvwAI+x8=;
        b=tLfRTC21Ec8mX37OnUku2YVTVSDk520Ojtrx1O8TWXG+ZI6RRYnX1xyJB6eks+rjTc
         Xzbe7XaM5BzHTkN+ANFQ6tMnKLs5DUW6qjnmZKhkF4YVosq9DPoBCK0oKKkhMOanxcYp
         O5Y6ao/72JPADL1VKQeaeDxlWG1snCaIYCh/YWFNpxWetTxe552Eo7gVfKTI2Do7tFhK
         kyo8Dg2Vf4/MBIEdmqfDhNKcZJf4RG2Et0wT3fwwptj+rBq78Ys3OtkTxa519S9puVOh
         r/hQXrt7RW1ihnm+z4K4f7WrY7Ey2G/OwcBs5GCt1peFi0ga3IVHFzTXDtqdK3gF4HKl
         fT8w==
X-Gm-Message-State: AOAM533vaPPIw7poCX1FQTtuY3igDAGlG0uWTxwgem0Ybd8K3gXFmaRc
        nNvlediSY7dO40R2/CT1ckbtAamNWsZNNXcYtXTRQQ==
X-Google-Smtp-Source: ABdhPJzzmVI+UwAEAZHkra263hYeuUU7mgKQ2ot4agRohqk1cd0v1JTusCJ3TXaTnp89zZwj2fpbXf52e6YBTtzXZBI=
X-Received: by 2002:a19:2d10:: with SMTP id k16mr2590947lfj.161.1609973000253;
 Wed, 06 Jan 2021 14:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20210106200713.31840-1-alobakin@pm.me> <20210106200801.31993-1-alobakin@pm.me>
 <20210106200801.31993-2-alobakin@pm.me> <202101061400.8F83981AE@keescook>
In-Reply-To: <202101061400.8F83981AE@keescook>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Wed, 6 Jan 2021 14:43:08 -0800
Message-ID: <CAFP8O3LY=puWC7-O+HakE0mBuZwyWi01RHt7+tBGBj5WQiT5qA@mail.gmail.com>
Subject: Re: [PATCH v2 mips-next 2/4] MIPS: vmlinux.lds.S: add
 ".gnu.attributes" to DISCARDS
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 2:07 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jan 06, 2021 at 08:08:19PM +0000, Alexander Lobakin wrote:
> > Discard GNU attributes at link time as kernel doesn't use it at all.
> > Solves a dozen of the following ld warnings (one per every file):
> >
> > mips-alpine-linux-musl-ld: warning: orphan section `.gnu.attributes'
> > from `arch/mips/kernel/head.o' being placed in section
> > `.gnu.attributes'
> > mips-alpine-linux-musl-ld: warning: orphan section `.gnu.attributes'
> > from `init/main.o' being placed in section `.gnu.attributes'
> >
> > Misc: sort DISCARDS section entries alphabetically.
>
> Hmm, I wonder what is causing the appearance of .eh_frame? With help I
> tracked down all the causes of this on x86, arm, and arm64, so that's
> why it's not in the asm-generic DISCARDS section. I suspect this could
> be cleaned up for mips too?

On x86, 003602ad5516e59940de42e44c8d8033387bb363 "x86/*/Makefile: Use
-fno-asynchronous-unwind-tables to suppress .eh_frame sections"
noticed that some Makefiles
redefined KBUILD_CFLAGS and dropped -fno-asynchronous-unwind-tables.
Maybe mips has similar issues.

> Similarly for .gnu.attributes. What is generating that? (Or, more
> specifically, why is it both being generated AND discarded?)
>
> -Kees

gcc/config/mips/mips.c
https://github.com/gcc-mirror/gcc/blob/master/gcc/config/mips/mips.c#L9965
.gnu_attribute 4, 0 does not produce .gnu.attributes
(SHT_GNU_ATTRIBUTES) but there are likely code paths that
a non-zero value is used... So .gnu_attributes is likely needed to be exclu=
ded.

> >
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  arch/mips/kernel/vmlinux.lds.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.=
lds.S
> > index 83e27a181206..5d6563970ab2 100644
> > --- a/arch/mips/kernel/vmlinux.lds.S
> > +++ b/arch/mips/kernel/vmlinux.lds.S
> > @@ -221,9 +221,10 @@ SECTIONS
> >               /* ABI crap starts here */
> >               *(.MIPS.abiflags)
> >               *(.MIPS.options)
> > +             *(.eh_frame)
> > +             *(.gnu.attributes)
> >               *(.options)
> >               *(.pdr)
> >               *(.reginfo)
> > -             *(.eh_frame)
> >       }
> >  }
> > --
> > 2.30.0
> >
> >
>
> --
> Kees Cook



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
