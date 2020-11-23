Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5852C192B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgKWXD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgKWXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:03:59 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:03:58 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id m9so19927473iox.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WJDR7q4xZx9dSoLzieIGiWyC6I1HarpZQYL3DEjKNzY=;
        b=X9fPdSLiQwi3gnTRdk9SYUai8we5jG1eFdz6ooUJOj1os3Vv1+e82I21OisQ1flfLV
         /PSC0QnyL9vQMBlXEzXhI+ecs4zHHrjihBBp0n7Im3BebTkW3MEnYO0BS6perBRHHlcX
         zzpfHpwwC+QOYx4/3x5krzY1rA9yAJJt+I1fwx/fu0igbCk0TO8srvBfmIsJ1TnLGp0d
         vvT+v3np4CTh02gUfgHe1lmR/GNa3dUSD8o1VD0oregn6S2IS7YCtC6WSxxHDAql/Go2
         dD9N4HzvROaYPi6s0nppjGknGrnGH37Ok+9lBAXY2RdJlozPYOy0CAmHqCv7W1horwsc
         RIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WJDR7q4xZx9dSoLzieIGiWyC6I1HarpZQYL3DEjKNzY=;
        b=lJpQsvn14rPbFUqJSB5FH+nBgbOka6wqWMflyrjqcxzSCruXgy1ha5oh6kcJZlSVbL
         L7ovAvS6EeVA4MZGqCSoyRZ7NeipSJP7Mh+gPI4Q28ZYjIXUXQcIAaMPyV/+kb1lUvWi
         lWfHswZzXSw9YY69gITbyCoDAhr4Fk+aivZNFY3Hz0nSERMxLpiazxjAjO8xbRQzqaUP
         tQPP+rBJ36S9ypHpK+BafmgKpMQlLcSQ97m46xYDluGZ8wjib9SR5lvLYspLa/4o+jZi
         Nx3hN7YUQziBiQHVPsuUMbJSzI9I7H9T41fVWho4MqjIg9LG5BX/OfUIu1ny64JBDFOv
         AUWg==
X-Gm-Message-State: AOAM531ag0iPg0Rk4KnckNZtH2IMGiB0vOsnEBzXj/z1YuLMqLlfxpLt
        ctfb1i5t+ucfnBQUoJLdhtMfh5H8EptqmxNxF00=
X-Google-Smtp-Source: ABdhPJzgcswkbY0gMNO8Q2hi6FpyLEqKmba7x60uymw9kr1D5eTLIDYdt/+//qV+YctOJWoHdTjNy1QiuyMvTnFyZjM=
X-Received: by 2002:a5d:8ad6:: with SMTP id e22mr1757787iot.154.1606172638121;
 Mon, 23 Nov 2020 15:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123184647.GA3694916@gmail.com>
In-Reply-To: <20201123184647.GA3694916@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 24 Nov 2020 08:03:47 +0900
Message-ID: <CACOAw_yCXj6UAgkAaggaDhPQ0B=y_6pKG54CFL4W8eWhjZA9+A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add compress_mode mount option
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Got it.

Eric,

Yep.

2020=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 3:46, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Nov 23, 2020 at 12:17:50PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We will add a new "compress_mode" mount option to control file
> > compression mode. This supports "fs-based" and "user-based".
> > In "fs-based" mode (default), f2fs does automatic compression on
> > the compression enabled files. In "user-based" mode, f2fs disables
> > the automaic compression and gives the user discretion of choosing
> > the target file and the timing. It means the user can do manual
> > compression/decompression on the compression enabled files using ioctls=
.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  Documentation/filesystems/f2fs.rst |  7 +++++++
> >  fs/f2fs/data.c                     | 10 +++++-----
> >  fs/f2fs/f2fs.h                     | 30 ++++++++++++++++++++++++++++++
> >  fs/f2fs/segment.c                  |  2 +-
> >  fs/f2fs/super.c                    | 23 +++++++++++++++++++++++
> >  5 files changed, 66 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesys=
tems/f2fs.rst
> > index b8ee761c9922..0679c53d5012 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -260,6 +260,13 @@ compress_extension=3D%s     Support adding specifi=
ed extension, so that f2fs can enab
> >                        For other files, we can still enable compression=
 via ioctl.
> >                        Note that, there is one reserved special extensi=
on '*', it
> >                        can be set to enable compression for all files.
> > +compress_mode=3D%s      Control file compression mode. This supports "=
fs-based" and
> > +                      "user-based". In "fs-based" mode (default), f2fs=
 does
> > +                      automatic compression on the compression enabled=
 files.
> > +                      In "user-based" mode, f2fs disables the automaic=
 compression
> > +                      and gives the user discretion of choosing the ta=
rget file and
> > +                      the timing. The user can do manual compression/d=
ecompression
> > +                      on the compression enabled files using ioctls.
>
> Please clarify in the documentation what it means for compression-enabled=
 files
> to not be compressed.  It is not obvious.
>
> - Eric
