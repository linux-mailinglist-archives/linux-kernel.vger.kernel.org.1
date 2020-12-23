Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9C2E13A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgLWCcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 21:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgLWCc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:32:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93364C0613D3;
        Tue, 22 Dec 2020 18:31:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw4so20834386ejb.12;
        Tue, 22 Dec 2020 18:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hJYV9T0G3B5sqaHuZ67qRHqaOvktDx25o29o6SPVfkM=;
        b=IYyycRcoGYOP/KTETWj/vmhg9C2RGMb/P3JuA4pRuUW+wTLsd4j+sbJVNZaoq/HFsW
         y903BXueXgsFDIJawkPdEAj6Zi8tRpLp17vvYB1L5zx0NitBG17XFdyRhl4qMz1Wms84
         kczQbYle8rJRw9jLY7MpqGjC61nPY4vNhno+U6jbqhaiqaf7Yfif+2S/QRLVV7Nk2hcM
         fz1OUEHC/vKjdJ0o5oNmLGZ0iwMjGalO60W1QDSPp5JnvEaTf4d6efMk/YzbY4t5z+MA
         KotriduRqDYzYBozzgMRonapm8XqO6IfVYMlEqpVvhbPgwRJ8LBWG8ViphBp5ULQAYWs
         Nnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hJYV9T0G3B5sqaHuZ67qRHqaOvktDx25o29o6SPVfkM=;
        b=gNVyRWQoxAQHVFoJ9jxkVqVaREc8eT4vMer3T66vVmHlGYlGDoQ8fMlEV/fHBPilyV
         89fzDsCD200X7+qzdKZP9zel3J91pUecN03jVMC+UC4Wx6Ope9v/eDfKBTLC1ZQB3PL7
         dxj4L3TulU9tPT9DHhGIXqX2Qob7R/4GlI0F+4Y3f/3fBiw8VdRjYTDcb3Um+DHVa+xx
         poYNnPV+T1Df4lWtpF5Uea5E0qETgj9nV1Ub38AVzUe6189onYuM3FBnC1u0SASTVBUW
         8TNw2FqgNTh5q3Yrk3aiZUb1a+DfnYFtJkg4qwg1PdQALqpxfRAwpl7K+gEa2KErJm7M
         oDaQ==
X-Gm-Message-State: AOAM532PTKQk2wEeh2sWUQ3YzdgzxJoLnUOljR0J10mARbaciNPmVMuD
        OftXdMazQAry9Ge3pGdUzsTgp4W98/n7T9+vQIs=
X-Google-Smtp-Source: ABdhPJz1B0KpAS61G37ZhvZ08Ft6rExhgmEqLff3Wbv30JgnF2UmY5AaWsrOOU4FM1RUZAcu5wJxN79JH90GdCJzjrA=
X-Received: by 2002:a17:906:2681:: with SMTP id t1mr22464503ejc.29.1608690705392;
 Tue, 22 Dec 2020 18:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk> <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
 <20200923002315.GC3421308@ZenIV.linux.org.uk> <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
 <20200923045231.GH3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200923045231.GH3421308@ZenIV.linux.org.uk>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 23 Dec 2020 10:31:34 +0800
Message-ID: <CAFH1YnNwqrK+kHbLKH684AwPWM0TfOxKC37TfJe5FYZ4_AXRvA@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 23, 2020 at 10:37:31AM +0800, Guo Ren wrote:
>
> > > What's going on there?  The mapping is really weird - assuming
> > > you had v0..v31 in the first 32 elements of regs->vr[], you
> > > end up with
> > >
> > > v0 v1 v2 v3 v2 v3 v6 v7 v4 v5 v10 v11 v6 v7 v14 v15
> > > v8 v9 v18 v19 v10 v11 v22 v23 v12 v13 v26 v27 v14 v15 v30 v31
> > >
> > > in the beginning of the output.  Assuming it is the intended
> > > behaviour, it's probably worth some comments...
> > FPU & VDSP use the same regs. 32 FPU regs' width is 64b and 16 VDSP
> > regs' width is 128b.
> >
> > vr[0], vr[1] =3D fp[0] & vr[0] vr[1], vr[2], vr[3] =3D vdsp reg[0]
> > ...
> > vr[60], vr[61] =3D fp[15] & vr[60] vr[61], vr[62], vr[63] =3D vdsp reg[=
15]
> > vr[64], vr[65] =3D fp[16]
> > vr[66], vr[67] =3D fp[17]
> > ...
> > vr[94], vr[95] =3D fp[31]
> >
> > Yeah, this is confusing and I'll add a comment later.
>
> Umm...  It would help if you described these 3 layouts:
>         1) kernel-side with VDSP
>         2) userland (identical to (1)?)
>         3) kernel-side without VDSP
> Still confused...
>
> PS: my apologies re commit message - I left a note to myself when doing
> that series and then forgot about it ;-/
>
> Anyway, which tree should it go through?  In any case, that fix is
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> and I can take it through vfs.git or you guys can pick in csky tree;
> up to you.

Hi Al, Guo

Seems this patch is still pending=EF=BC=8C could you help check it=EF=BC=9F=
Thanks

Zhenzhong
