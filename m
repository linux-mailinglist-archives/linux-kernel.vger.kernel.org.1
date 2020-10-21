Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE899294794
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 06:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440290AbgJUEza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 00:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440269AbgJUEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:55:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6DC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 21:55:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so981775ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 21:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BMPwfS6F9RfkISbd/IVCeP6a9+iWHhWjZw8peN2d994=;
        b=c5A2MIHSXHXxMSgfiDOh6ehXeM5T+QGOlai8e90NTNfQwhzt8CiIZRrqeTiLjxs85a
         elA9zaXYfGqei208XaQ74moAy8bc00iwwrAtouIM5RpQOA2mI61hZb/qyuqJEP29Vxck
         7ux5oNT+nKbZEaS+OwN4akfyScn9U/OUnUFrjcbgM/AGfSe0x2ZuejKYq5l+KIzcYUhN
         evccciPuIwx00D9cWsGLrNVPl5T15fMXBYXy24wr7c1otFtHdvdHK8wjdM6L0zSgr2rf
         iDf9C3uqJbwQLOYZY9z64W9i01yauLMReYqFHLz8KzRR0LApStyhpUTV9uwHt79HtIn6
         dIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BMPwfS6F9RfkISbd/IVCeP6a9+iWHhWjZw8peN2d994=;
        b=QUPep4lsFukIzTTP4Q6FqZ7Q0Vi/XcMwJdHdTxmUbVHqQ42ncgI4SSjPiYkaFIDMrX
         02Lhho/ZJvz0E9ThXe8vLavGOU2JXpMKZL1gJrYcQxLCREdiwsOWIOoJhYISadJU5d29
         K+lk5BsCNwHzQrzkMkgKRShNNdYqEhXKtgn0ykLYC++bGgk5hl5IN9kZ2b4sd5zgfv9b
         DMYWWF6YEH5NTQovvVJ5CCJhM46znGiixJQP1IVIMhxla6qcmzOCw4kOISlC69cLQ1r8
         Pam+7IAlOnYYc9QzBaQFgVjJpy05tKabR2RFN378P41iKgS0xExnqfKdpJ/mawTVh2dO
         R7gw==
X-Gm-Message-State: AOAM533U6Jamsoi9hDkAOD1L+fPpjWvQjWXo4Kaccs1lu9QLzHEyO5uJ
        OZx32Z64ltGpuqzNSs2ql7gw6Emp2HbzhmIT0bc=
X-Google-Smtp-Source: ABdhPJzQhy4cKNyB5zBoB42+eWoKhA4C7mG0JqbircTCE3wFBq/suUYynfIX4sf2BY7qgULmQBPuq3bwZm4B+jf3sYg=
X-Received: by 2002:a2e:b61a:: with SMTP id r26mr582810ljn.166.1603256128177;
 Tue, 20 Oct 2020 21:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201016051455.1913795-1-daeho43@gmail.com> <20201021043620.GA3939@sol.localdomain>
In-Reply-To: <20201021043620.GA3939@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 21 Oct 2020 13:55:17 +0900
Message-ID: <CACOAw_xJ8yTT+PLjgvE_8M6rfuwLiR42EeCOt5xDm2xTDj2Aeg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add compr_inode and compr_blocks sysfs nodes
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both values are from memory values.

2020=EB=85=84 10=EC=9B=94 21=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 1:36, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> On Fri, Oct 16, 2020 at 02:14:55PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added compr_inode to show compressed inode count and compr_blocks to
> > show compressed block count in sysfs.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
> >  fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index 834d0becae6d..a01c26484c69 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -350,3 +350,13 @@ Date:            April 2020
> >  Contact:     "Daeho Jeong" <daehojeong@google.com>
> >  Description: Give a way to change iostat_period time. 3secs by default=
.
> >               The new iostat trace gives stats gap given the period.
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_inode
> > +Date:                October 2020
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show compressed inode count
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_blocks
> > +Date:                October 2020
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show compressed block count
>
> Is it the count in memory, or on disk?
>
> - Eric
