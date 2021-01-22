Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFFC2FF9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbhAVB2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbhAVB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:28:41 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:28:00 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id q9so3436467qkn.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/xXBGr2e6Li76TbLQQvAhOhGapKpqBz9Y95NmoOL9I=;
        b=M0onMKTUNEyXO3uXqn/e4UfuDOygc01YV43XKoHEYnoq9NdhILT5ySmfAYch7Tyt+3
         yBh9IVoeGkdfVTtagJVeFJJLsknPfXzy8fEBnjwhmVxdgf+ieZr93ZZfO5HvHkvvl2n2
         unIKevc6+DQABqm+yV0reaSg2dZ/tEsywE4JyJNzqxUSM6cN42t5tMJnwD8oODoGvCRI
         nvi785S4a6LzuG4Qh3WBSC+Y+8Na1ltAdR2PDv0oRYJqjf+9+CCxG84atm79+tp78ajy
         W1bvRJnRVWNC/ygpPYwezlTLp/QCYbXZ57M+TWlx1X9D+/o6xgtZuTDb5CmsauKVC97H
         07Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/xXBGr2e6Li76TbLQQvAhOhGapKpqBz9Y95NmoOL9I=;
        b=gObxO3viL2mX5dW1EGWKaHa8WrZC2giA6LwFubPOB+1SCaD/iOCtbsewekg97qz2iB
         i0Ek6Nye/qPsJYQVcxXDucXUyNtaiSY51dK3aKjhH3J7wP/Y/Izxa2EKiKY7dTT0/CMO
         J3FrxMa8QxQ2L+P3CsK+Q/xVM+ubJcl6cagItQBbt6fC299QQdSazAmyG8D7Eso+H54a
         M4ZlIeIXL9Hm2xPgTp/l/o5LUmruSz9Yn8Mh1rWiiNPYF+UhW6UhEvfxhqEnVTqg30cu
         6/pa8J3atsOCt6twW2hIzwioYxssSpaiJpPOP0lQaH0WJJ7hP1KozNNJrWcoQ9UBxLUB
         1h+g==
X-Gm-Message-State: AOAM53195n4jFTqsYGmZOtPs8o3j5wdXr2z0W+6CBD1wE80URgMxUu41
        lEaoMXKk3P2hw+X+p/nRUV6EtvcgZpQ1Uj6ncmuhPK6RO6xwxI5H
X-Google-Smtp-Source: ABdhPJwki7zdKt7IMswZ7tLQBRp3jc1REoy6p3B20cXQqHQaqA0Rfoqe/XEugSQkB3gTypitTutDLye6pkRrBfsd2IM=
X-Received: by 2002:a37:a796:: with SMTP id q144mr2842350qke.38.1611278879884;
 Thu, 21 Jan 2021 17:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20210120064415.16977-1-yejune.deng@gmail.com> <20210120102238.GA825@zn.tnic>
In-Reply-To: <20210120102238.GA825@zn.tnic>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Fri, 22 Jan 2021 09:27:48 +0800
Message-ID: <CABWKuGUw_fz6vfcUB=u9Uk2EnM_GNZ06BZE=j33o8dUJbwm-GQ@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu/xstate: calculate the number by sizeof and offsetof
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, yu-cheng.yu@intel.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        kan.liang@linux.intel.com, viro@zeniv.linux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your suggestion=EF=BC=81

On Wed, Jan 20, 2021 at 6:22 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 20, 2021 at 02:44:15PM +0800, Yejune Deng wrote:
> > In fpstate_sanitize_xstate(), use memset and offsetof instead of '=3D 0=
',
> > and use sizeof instead of a constant.
> >
> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> > ---
> >  arch/x86/kernel/fpu/xstate.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.=
c
> > index 5d8047441a0a..2e75630c86e9 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -161,20 +161,16 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
> >        * FP is in init state
> >        */
> >       if (!(xfeatures & XFEATURE_MASK_FP)) {
> > +             memset(fx, 0, offsetof(struct fxregs_state, mxcsr));
>
> I'd prefer the explicit zeroing instead of having to look at
> fxregs_state and where the offset of mxcsr is.
>
> > +             memset(fx->st_space, 0, sizeof(fx->st_space));
>
> This is ok I guess.
>
> >               fx->cwd =3D 0x37f;
> > -             fx->swd =3D 0;
> > -             fx->twd =3D 0;
> > -             fx->fop =3D 0;
> > -             fx->rip =3D 0;
> > -             fx->rdp =3D 0;
> > -             memset(&fx->st_space[0], 0, 128);
> >       }
> >
> >       /*
> >        * SSE is in init state
> >        */
> >       if (!(xfeatures & XFEATURE_MASK_SSE))
> > -             memset(&fx->xmm_space[0], 0, 256);
> > +             memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
>
> This too.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
