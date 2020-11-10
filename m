Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DD2AE3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgKJWyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJWyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:54:25 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B27C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:54:25 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so9104589qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZBhzUj2Y7GYazkoiwLmVUtJfQQKiQzBUyUc3hTXKBs=;
        b=iiVm82Cd9Nb9mgxHysJirFSlnXFSG+3OU7srYM6Zi/SeuY+Xa39DFgPcoddZkrTjaA
         mx0EUy3XE8ksqqtbLfBCui90R0edogGe3JBug119KsiPtXwP0eXpyYzVt1hhTDNrM4B7
         fuaShuePti5tyt4uK/2c0wuMbx8rDF4kP9hUarytlc+88nKF+uM12mTuD6rOOI2a5nZ+
         wJ5kgQ2/T3wEEDIRKUcVKxeXZjlQ4qknJPXD1qrW3HXfYaDOUmrIN6r9PYaMx41lpkNX
         ooUWv4T/fu0Y7ncrL9aMtdHSPSjaPYjNyx2y0jdwxcGz9o9/Ez5aPXnGhYGo+bd4wptT
         W3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kZBhzUj2Y7GYazkoiwLmVUtJfQQKiQzBUyUc3hTXKBs=;
        b=myGm9vgRdaKXPZebk0ftExr1dw+VzxrBgFr5UlmKxyii1+sM/RLJ59QDPqtQfdJzbk
         zLOKv/igwA0SztEdet8idC1ZRVO8uiT+hQgoX5Q+LIuOMDZyKOJzmtVvv4/SFm8CyI76
         lnz/W+RE66AUZ3FOOYnXGYlSVlyJdNFQtct7pIQO/LpmYMFlBPEXEctvhrWGsbdHn/cJ
         wYGbSZ21+vvwYQtddL/d/d8pntvl6vpqrjnrFHmYHfDFt6Z2ip2etG702KIrWa/nukG5
         f3tERO6yXJuPvOG5r5DMYhjDRFWPUEswbjAP49Qpj4O3vmJPy5uTWfW9Cej3EkZsvlM9
         Y2ZA==
X-Gm-Message-State: AOAM5336/tJo1g7ZUQ/l9GmM2RZvmXdm3two5N0uFOlWQx4ztHDNjTbu
        jPtQAox3bI6841k7hrj6dLY=
X-Google-Smtp-Source: ABdhPJwVU9WNoKx/aQtlS6gxOQd5cEUuaTMxYDwIy86/L71QTkYZxeqs4NhS8KmLIU5g16VeJK14wA==
X-Received: by 2002:a37:9f14:: with SMTP id i20mr4165418qke.137.1605048864135;
        Tue, 10 Nov 2020 14:54:24 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y82sm218959qkb.129.2020.11.10.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 14:54:23 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 10 Nov 2020 17:54:21 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201110225421.GA29900@rani.riverdale.lan>
References: <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
 <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
 <20201110221511.GA1373528@rani.riverdale.lan>
 <CAKwvOd=NQ==umC+N_Sgji5HCCFTRARh4jWiB3DaBfV6jDd5cRg@mail.gmail.com>
 <CAKwvOdmsCY8Hb6t8t9jW5DKCZKbja27bGufO=tw3+-UuTTFBOQ@mail.gmail.com>
 <CAKwvOd=6nPUvUY6XJULmkZywHJG2kfu46h7=Zm18j9O30ovdpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=6nPUvUY6XJULmkZywHJG2kfu46h7=Zm18j9O30ovdpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:39:59PM -0800, Nick Desaulniers wrote:
> On Tue, Nov 10, 2020 at 2:39 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 2:36 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 2:15 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Nov 10, 2020 at 01:41:17PM -0800, Nick Desaulniers wrote:
> > > > > On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > > > >
> > > > > > On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> > > > > > wrote:
> > > > > > > +#pragma clang loop vectorize(enable)
> > > > > > >         do {
> > > > > > >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^=
> > > > > > >                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> > > > > > > ``` seems to generate the vectorized code.
> > > > > > >
> > > > > > > Why don't we find a way to make those pragma's more toolchain
> > > > > > > portable, rather than open coding them like I have above rather
> > > > > > > than this series?
> > > > > >
> > > > > > Hi again Nick,
> > > > > >
> > > > > > How did you verify the above pragmas generate correct vectorized
> > > > > > code?  Have you tested this specific use case?
> > > > >
> > > > > I read the disassembly before and after my suggested use of pragmas;
> > > > > look for vld/vstr.  You can also add -Rpass-missed=loop-vectorize to
> > > > > CFLAGS_xor-neon.o in arch/arm/lib/Makefile and rebuild
> > > > > arch/arm/lib/xor-neon.o with CONFIG_BTRFS enabled.
> > > > >
> > > >
> > > > https://godbolt.org/z/1oo9M6
> > > >
> > > > With the __restrict__ keywords added, clang seems to vectorize the loop,
> > > > but still reports that vectorization wasn't beneficial -- any idea
> > > > what's going on?
> >
> > Anyways, it's not safe to make that change in the kernel unless you
> > can guarantee that callers of these routines do not alias or overlap.
> 
> s/callers/parameters passed by callers/
> 

Yep, but that seems likely, it doesn't seem like the function would do
anything useful if the destination overlapped one of the sources. The
kernel just doesn't seem to make use of the restrict keyword.
