Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8F19EB2F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDEMUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 08:20:23 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42240 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgDEMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 08:20:23 -0400
Received: by mail-il1-f194.google.com with SMTP id f16so11980983ilj.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R6JUIvjpzPlO/CylALh6d2qFwDqIcytW6i19TRALkUw=;
        b=hgkewgwLG+H40zBE8TrLlml5d9v64hptp8pavEYfiMxq6a/6kqYkyiVxlzmw3HZw9k
         zTWyZzc5NtpPhlcLBfMK6PRjmRz5yR+lEiM9vvozLtynIKeKT06jd/WcmO9alx2pCzNy
         JE8GlVEL+zjdnQVFXcJ19LBxJZq0gtaHXoE2V8eezi3ySQQMPZ8N0G7pjIog92OFV2jY
         qi9y8dsUiejPx1qI4f/Qg7Xt2MBnHv4YGMRS8Vn+B23PazoWmHUjMDCQwgwl4SpMMFTW
         m8GJJBG4Yur7QL2rf11keafpd4l1G4UWy/8S1+PYA2bXjeNRr542b1QxO6PhSVSm7A+I
         mwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R6JUIvjpzPlO/CylALh6d2qFwDqIcytW6i19TRALkUw=;
        b=E8+u7h1uuWTJeTecby+F4BqT1R1LNP8mo2YmQZI+BLgUxxfUi6q6GciUDmsbp4R2qe
         vOtgPUnuplHJ45flhMEhn3KLPztW5lskmbiei2FfWIIiD12QEWl/vSIbYbRTgRzdYDH/
         Nukrc7YKsguR06GBRmtM5dDagRdFggo2ih1j0P4gCpd7smZISoEKMEZEhZ+VSGQDjpxf
         mL54mo5SD/dI3V4h119Hwy9xPs7StIGhdbFZvn7V+rQtNhOKpWTwmV4TyvNyD3v6E4gz
         zneYrpKDFAfY3qLmIDMjDIrFXmf6zAFL+3W5QS1ouf6r/lDZLRc8rkT1l+stCVBO5ZoN
         BKHw==
X-Gm-Message-State: AGi0PuZPjIIGXiyF/i4RbImqU1o8+Y3K3DtsrRSwWKaYDUeH2gltQuiZ
        07LzcA4PRTRA3A90xJ0qq51nrs4za3GFNe7PKkA=
X-Google-Smtp-Source: APiQypJxN49bx9bhG9DkL+BaHxpQ/iMyogY64Cv5xyge7/7qq+hv/NYDU9NjXe/FGaofmwPvrwaq8cdwew8sAvptrXk=
X-Received: by 2002:a92:83ca:: with SMTP id p71mr15793373ilk.278.1586089222451;
 Sun, 05 Apr 2020 05:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200405103059.30769-1-hqjagain@gmail.com> <46e9dd45-c590-36c3-a60e-55750cde8935@c-s.fr>
In-Reply-To: <46e9dd45-c590-36c3-a60e-55750cde8935@c-s.fr>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sun, 5 Apr 2020 20:20:10 +0800
Message-ID: <CAJRQjocOZCqSq+R01ryCVASwdoE0z9+oCn0VupMeWfBiH-sZHw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: add NULL check after kzalloc in opal_add_one_export
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 8:12 PM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>
>
>
> Le 05/04/2020 =C3=A0 12:30, Qiujun Huang a =C3=A9crit :
> > Here needs a NULL check.
> >
> > Issue found by coccinelle.
> >
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >   arch/powerpc/platforms/powernv/opal.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platf=
orms/powernv/opal.c
> > index 2b3dfd0b6cdd..5b98c98817aa 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -808,9 +808,12 @@ static int opal_add_one_export(struct kobject *par=
ent, const char *export_name,
> >
> >       rc =3D of_property_read_u64_array(np, prop_name, &vals[0], 2);
> >       if (rc)
> > -             goto out;
> > +             return rc;
>
> Nice you changed that too.
>
> Then there is no need the initialise attr and name to NULL in their
> declaration, as they won't be used before they are assigned.

So that's it.

>
> >
> >       attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
> > +     if (!attr)
> > +             return -ENOMEM;
> > +
> >       name =3D kstrdup(export_name, GFP_KERNEL);
> >       if (!name) {
> >               rc =3D -ENOMEM;
> >
>
> Christophe
