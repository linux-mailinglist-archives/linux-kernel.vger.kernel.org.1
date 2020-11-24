Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18CC2C3250
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgKXVGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgKXVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:06:38 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B085C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:06:38 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so302652pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eby60DJAqSFbj9w7/gp/DIlQjeWe9iOSzRhm+P8blY8=;
        b=YwZlzwgIRBAYTLlEHx+dtCUWgBfQKC7F1jnK0GN7GswgUFA09tMIP3DnKW3vgiN14O
         tOrZnz9pEbcSzmLK/eWonTVX1ZvY4h35QTF62qfYsJSoacMuEB+N1VYR/CcQvrmguYb5
         +C3c6Q8HMyB5FK20RmCrAwChK2AePHgrqldfUCfu2yEw9nmK4iTzPuKAB/veKc40QNFg
         tI40ZZPZWCPQYu3LjM4iz7xx0TrlDAo2FQMoWs5qy4YPtlzwWCCtK0mnt/s5/FmTzX1h
         tMdkFZJsrr9geolP88O0iB8MVSKddpSINAJEqnyar3G8OZrT006BGxmnkmDzn5MqorYp
         VtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eby60DJAqSFbj9w7/gp/DIlQjeWe9iOSzRhm+P8blY8=;
        b=mDS9eTOO8Eg8bxh9Jd7MtHv1LWazQrXVEwr/uTsUgfitHjVd7eJTvxaYqxspACHMm6
         YPHEHOsVG0BrS1DC6sHUml0H+BfPeQ+2kvQNih9ddXPW1A0CGGNPu71fmb58BSCYtSoE
         4vmt3DGhhB22YDN+kw+HUCqAayZpOb9ks9ye7vYxFQbW/xT1kH+MOeHpyM2g40J76RBA
         faRBcwR/rA9MBFp2p7WXE3LRFaAEIVa6v/2vBJlGXz4GGQ61E5Bd63Gxkww0gmN4Kw+w
         FA6NiHLEGt8+xEbA7Aqh4DT5iAmgIuevQ17PvmwJ0vsvhXbTrFceLUcAmOCWHZkvhY/R
         sNyg==
X-Gm-Message-State: AOAM531q/3PLWCX4a8WJQoH6QNbtqQC0lO8jxv5IituNVKfbaoglOIMb
        eHphNHpjcpWkCrVFJjv95w8Vzn15FS+tFH1dxuvuxQ==
X-Google-Smtp-Source: ABdhPJwpotkX67QsIXT73JsIPnJIWmRmoNO5ExaiapiPtEkmaaC7YbeCBlK9K3izQq5RmIKowNmZGEpQp5pT41R+T6M=
X-Received: by 2002:a17:90a:dc16:: with SMTP id i22mr142244pjv.32.1606251997276;
 Tue, 24 Nov 2020 13:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com> <20201123181602.GA2637357@ubuntu-m3-large-x86>
 <20201124074211.GA26157@penyung-VirtualBox> <CAC5oF3W+RkcO-dSiKXGxVvhBGb0n7fQ-KvdjbPNJJVadv6qNBw@mail.gmail.com>
In-Reply-To: <CAC5oF3W+RkcO-dSiKXGxVvhBGb0n7fQ-KvdjbPNJJVadv6qNBw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Nov 2020 13:06:26 -0800
Message-ID: <CAKwvOdkE5-OBWjmGwc8qUkj5wuqZTmtYxaMD3sz+4+aNiC2vLg@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Antony Yu <swpenim@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, it probably was not fun to debug. I'll take a
closer look at this after the Thanksgiving holiday.

On Tue, Nov 24, 2020 at 2:14 AM Antony Yu <swpenim@gmail.com> wrote:
>
> Antony Yu <swpenim@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:43=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, Nov 23, 2020 at 11:16:02AM -0700, Nathan Chancellor wrote:
> > > On Mon, Nov 23, 2020 at 03:36:32PM +0800, Antony Yu wrote:
> > > > __do_div64 clobbers the input register r0 in little endian system.
> > > > According to the inline assembly document, if an input operand is
> > > > modified, it should be tied to a output operand. This patch can
> > > > prevent compilers from reusing r0 register after asm statements.
> > > >
> > > > Signed-off-by: Antony Yu <swpenim@gmail.com>
> > > > ---
> > > >  arch/arm/include/asm/div64.h | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/di=
v64.h
> > > > index 898e9c78a7e7..809efc51e90f 100644
> > > > --- a/arch/arm/include/asm/div64.h
> > > > +++ b/arch/arm/include/asm/div64.h
> > > > @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, u=
int32_t base)
> > > >     asm(    __asmeq("%0", __xh)
> > > >             __asmeq("%1", "r2")
> > > >             __asmeq("%2", "r0")
> > > > -           __asmeq("%3", "r4")
> > > > +           __asmeq("%3", "r0")
> > > > +           __asmeq("%4", "r4")
> > > >             "bl     __do_div64"
> > > > -           : "=3Dr" (__rem), "=3Dr" (__res)
> > > > +           : "=3Dr" (__rem), "=3Dr" (__res), "=3Dr" (__n)
> > > >             : "r" (__n), "r" (__base)
> > > >             : "ip", "lr", "cc");
> > > >     *n =3D __res;
> > > > --
> > > > 2.23.0
> > > >
> > >
> > > I am not sure that I am qualified to review this (my assembly knowled=
ge
> > > is not the best) but your commit title mentions an error when compili=
ng
> > > with clang. What is the exact error, what configuration generates it,
> > > and what version of clang? We have done fairly decent testing for
> > > 32-bit ARM, I would like to know what we are missing.
> > >
> > > Cheers,
> > > Nathan
> >
> > We have run fail on android R vts vts_libsnapshot_test with kernel 4.14=
.
> > This bug is triggered accidently by a workaround patch in our code base=
.
> > It is fine on a pure clean 4.14 branch since __do_div64 may not be
> > executed in skip_metadata.
> >
> > The attachment are .i and generated .s file. .s file can be reproduced
> > with clang -target arm-linux-eabi -march=3Darmv8.2-a -O2.
> >
> > In function skip_metadata, it loads some value to r0, calls __do_div64,
> > adds 1 to r0 and stores it to [r5]. It gets wrong value since __do_div6=
4
> > clobbers r0 register.
> >
> > We have tried clang-10, clang-11 and android prebuilt clang-r383902b. A=
ll
> > of them have the same problem.
>
> Sorry for the large attachment.
> I put .i and .s files on
> https://gist.github.com/penyung/274b0c697062a1c776994bb40243cfff
>
> Antony Yu



--=20
Thanks,
~Nick Desaulniers
