Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9A29C8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829957AbgJ0T3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:29:07 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35696 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829502AbgJ0T12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:27:28 -0400
Received: by mail-il1-f193.google.com with SMTP id k6so2582200ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uMHQm9Zj0sEkoS6Rr93mq6AqZWAc0hBnYALeQZc8SR8=;
        b=sMvWeqw9uDJerISI38cWDMK6+1fGIt5+HIP8LRMqSfWLSRNSHmDbesWP8Qr3Wun2B1
         gOiNckYl6yTMhNdGVRalh1yAjw1CH7nYU8c323ERynKe0qDwxs/3Y8pvuyJopL1VYUyp
         uuZRvaoCraf3TXl5mpVkObuHjTzzaT5W2gB8HObOoiAD1T3K8GS03hiM98GIYPajH6j0
         sNn0vfUJLoGyRdyRGHdoi6uZuOKVo3aEaOYrISOnggqY9PwJ8gWypHIiSumt7uY4Eonc
         9ZVtWZ8CH/dKIYpBrQ4XJSjasUtO1w+0hztx1XKbqCVrp2ZP8Gc34WvdYzaHHs54BUOq
         buqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uMHQm9Zj0sEkoS6Rr93mq6AqZWAc0hBnYALeQZc8SR8=;
        b=jNr+JhwqjtCjCIhc47QsTNibYWfCZk+JbxCYMdeKBr6gwGQi+lDHre6l2PlGKo3LuU
         b0CLJotmhE8OlVU2Z/6OhhPbwx0jXdIG818T2v/wVvT5TkIv/E4xhhEYiQBoH1dXGoGf
         KxFgzeIB+TcJN6omJ5cYgacy4nuqvTR/dkj9o2Q3ZERn/58U0xm58XtZmtno2Y/T6p+M
         SWatMmv4FTRkCS7duSZPDsoXl11RtwO+YQnnTwf1rS0y0+Z1z5PRdDajNkpINucUSbdZ
         mrqsvOkSHAVTrBGImyphmrfx2KIrn/YXtHZVe60/XRkoSEDfpm7zjsUFv66shQxo2X+5
         GCpQ==
X-Gm-Message-State: AOAM531ZTfikAo6eSuCyMb4sfyFRArKBofZ2jKRuGTXnpMtGw5+7iauT
        R7prGtIjcD0wJTbqdRoGKwvP2xMWxeMMAA2w78/8vgZOjTDhfilQ
X-Google-Smtp-Source: ABdhPJz09VLBWTiN24dn1ZUuSdhzKlTwr6AcRw/i0rxSfFBe6kkr2pCi2ACXJkQlBfUoFeT/wbhlXqnnjT/4EJzVt3U=
X-Received: by 2002:a05:6e02:106c:: with SMTP id q12mr2980085ilj.81.1603826846351;
 Tue, 27 Oct 2020 12:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk> <20201027191920.GA262123@centos.familie-tometzki.de>
In-Reply-To: <20201027191920.GA262123@centos.familie-tometzki.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Oct 2020 00:57:14 +0530
Message-ID: <CA+G9fYs7n-XF0xoWJMUtwdc9p95-_53ZpyQrQ1xEsot1vmwAvQ@mail.gmail.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
Cc:     lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 at 00:49, damian
<damian.tometzki@familie-tometzki.de> wrote:
>
> On Mo, 26. Okt 18:03, Jens Axboe wrote:
> > The removal of compat_process_vm_{readv,writev} didn't change
> > process_vm_rw(), which always assumes it's not doing a compat syscall.
> > Instead of passing in 'false' unconditionally for 'compat', make it
> > conditional on in_compat_syscall().
> >
> > Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
> > Reported-by: Kyle Huey <me@kylehuey.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >
> > ---
> >
> > diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> > index fd12da80b6f2..05676722d9cd 100644
> > --- a/mm/process_vm_access.c
> > +++ b/mm/process_vm_access.c
> > @@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
> >               return rc;
> >       if (!iov_iter_count(&iter))
> >               goto free_iov_l;
> > -     iov_r =3D iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,=
 false);
> > +     iov_r =3D iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
> > +                             in_compat_syscall());
> >       if (IS_ERR(iov_r)) {
> >               rc =3D PTR_ERR(iov_r);
> >               goto free_iov_l;
> >
> > --
> > Jens Axboe
> >
> Hello Jens,
>
> i got the following error when i try to build.
>
> m/process_vm_access.c: In Funktion =C2=BBprocess_vm_rw=C2=AB:
> mm/process_vm_access.c:277:5: Fehler: Implizite Deklaration der Funktion =
=C2=BBin_compat_syscall=C2=AB; meinten Sie =C2=BBin_ia32_syscall=C2=AB? [-W=
error=3Dimplicit-function-declaration]
>   277 |     in_compat_syscall());
>       |     ^~~~~~~~~~~~~~~~~
>       |     in_ia32_syscall
>

I have also noticed this build failure on Linus's mainline master branch.

x86_64 : FAILED
i386: FAILED
arm: FAILED

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dx86 HOSTCC=3Dgcc
CC=3D"sccache gcc" O=3Dbuild

50../mm/process_vm_access.c: In function =E2=80=98process_vm_rw=E2=80=99:
51../mm/process_vm_access.c:277:5: error: implicit declaration of
function =E2=80=98in_compat_syscall=E2=80=99; did you mean =E2=80=98in_ia32=
_syscall=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
52 277 | in_compat_syscall());
53 | ^~~~~~~~~~~~~~~~~
54 | in_ia32_syscall
55cc1: some warnings being treated as errors


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

full test build log:
https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/jobs/81520=
2967


--=20
Linaro LKFT
https://lkft.linaro.org
