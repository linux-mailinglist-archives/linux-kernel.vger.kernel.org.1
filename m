Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D012F2557
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbhALBOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbhALBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:14:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68436C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:13:28 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b3so34075pft.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HBFcgr7mqP/yUXgSBi8GFn5zsqPJPXchhuWrxzHcH2k=;
        b=L52GfF0s+c3vIx6mADc2ITWKCVCYJBTFkYEX02bNjrWMbVQ52MfghgOhXhhF81lU1H
         WnGWarj0DcfZQGPtMiNzKjIQf+t8K88c2F4MrOhB1J+CsM+m6BRU6OAsg9IQ1PIueFpB
         kw0ZsH0KIDx2UPRPmwl8NnnWA74/yeHPSaZRWGwBDuS7fxrqv0WBiO0LYm0XGfSHodjq
         +nkgPrjWqgRLYd9djRDpyeG53HTbWRlKAevCwFkGGdIPwMd7WFhAzEYF6dnmXbUxGlIS
         m1yggJTqWiAnNs61fmzEQc/jrQzf38JCBruzGkO3LVmgBuwz/3WNHyRaKTfvaHgWfoGU
         GFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HBFcgr7mqP/yUXgSBi8GFn5zsqPJPXchhuWrxzHcH2k=;
        b=MueD7ORhWLvwKiACeyiuyI62OgA508KnppgVuQrOdriuJIRWnA+zUK0DykP6jWaSJm
         Izz4fw/qox0Lvh+p7dT5YvXT5ss2nAR/9THfz4S9ihXsdnAJ99Pjf3B8eXtpLAEzafCW
         OWnCzP0Z6Sr0cHkRuLhEuHZ+/rNCClA6SBCEZ0tGwBjmBDuLQR32mWSREn44k4YlUbN4
         yWsIubzDVCphWMC1tMI4k9VtEH8ntJayAUtuWn2m6MBq35yIWF8ozHVNO4phYYdRSFHh
         VEunlaSFya3cHkHmIJMGuwxPy8MW7STWIuLa9d0L6zGVDnp8qknbntAxzg/dxc6g7mCl
         Duqw==
X-Gm-Message-State: AOAM533oWlx8d4dZxWwT+w9DNbuhyS9LAuG3Lp0MyrdXW6lzXvFfwgu6
        b4l1mljh3anM1wfygKRexqZIEnDz4aPMisDUaQYZNA==
X-Google-Smtp-Source: ABdhPJyv7vzDUXz8ehlXple2zdRS0rlSsfOylEesQRWsv5FmfXkFKZM3OpzT3gViV4AJIIw/8D9p0JWMtSlmrx702Mc=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr2064741pfy.15.1610414007725; Mon, 11
 Jan 2021 17:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20210106015810.5p6crnh7jqtmjtv4@treble> <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210112003839.GL25645@zn.tnic> <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
 <20210112010010.GA8239@zn.tnic>
In-Reply-To: <20210112010010.GA8239@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Jan 2021 17:13:16 -0800
Message-ID: <CAKwvOdmGS97e4Rj_oW+RnkYAMjycTFQiiPJAfCvKTdxgv2KfEA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 5:00 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 11, 2021 at 04:41:52PM -0800, F=C4=81ng-ru=C3=AC S=C3=B2ng wr=
ote:
> > To be fair: we cannot use
>
> Who's "we"?
>
> > .L-prefixed local because of the objtool limitation.
>
> What objtool limitation? I thought clang's assembler removes .text which
> objtool uses. It worked fine with GNU as so far.

I don't think we need to completely stop using .L prefixes in the
kernel, just this one location since tracking the control flow seems a
little tricky for objtool. Maybe Josh can clarify more if needed?

>
> > The LLVM integrated assembler behavior is a good one
>
> Please explain what "good one" means in that particular context.
>
> > and binutils global maintainers have agreed so H.J. went ahead and
> > implemented it for GNU as x86.
>
> But they don't break old behavior, do they? Or are they removing .text
> unconditionally now too?

Unconditionally. See
https://sourceware.org/pipermail/binutils/2021-January/114700.html
where that flag was rejected and the optimization was adopted as the
optimization was obvious to GNU binutils developers. So I suspect this
will become a problem for GNU binutils users as well after the latest
release that contains
https://sourceware.org/pipermail/binutils/attachments/20210105/75dd4a9d/att=
achment-0001.bin.

> > --generate-unused-section-symbols=3D[yes|no] as an assembler option has
> > been rejected.
>
> Meaning what exactly? There's no way for clang's integrated assembler to
> even get a cmdline option to not strip .text?

I can clean that up in v5; The section symbols were not generated then
stripped; they were simply never generated.
--=20
Thanks,
~Nick Desaulniers
