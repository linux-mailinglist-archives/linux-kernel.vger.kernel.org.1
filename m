Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADC216B83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGGLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:31:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DDC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:31:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so49426372ljv.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oU+zHS1dWLePXpv1roLop07qC5/+PHNWookUwJLe/zU=;
        b=HzqoVfv5RmJSiJec48Z3gyXEpw3X1xzcpa7yGskC4YP4FKDLYWnNwGMKx7bPp5Di7M
         tAPv4yoi7/blcmwpByoACwe0S74SDsfhbuSrSJbAMsKtYruaS6ia/LBd+13co+pkezkk
         7ED8pj13E7YmJr85IrN0MVKjFyHLI0G0TJ73UB9v7WnD2zN0X7ICOOtfjGUQ0J71cnjP
         iYWwsuoH7p9DXqBStWZvc8pwrz62bilvgWSXrlKpRzl7c1aLuLFkvFYxt82/FhaGmybv
         fSUho90IdiLmF9K8hKcl976CmHjAZzritDhMnDBdK/WDiwPviUgXcEseAddmE8iDGBHE
         TFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oU+zHS1dWLePXpv1roLop07qC5/+PHNWookUwJLe/zU=;
        b=QEJ4oEPPGTr2YGGWn2rpBYiowNupwJZGZA/4Rzc/9GVsWNsHC24McZLa+FZ/8lA25I
         vnqjsdNE+YdyitT2k7aafiuJturXKGhi0bhuBpPrTxwR0JjtEBrHoo12pyBQoKSLYVah
         jYNQTm03MIxscE4P+0TUswrO/7W/1k0SXEHs8uROYcgKNCaTr9BhbFbr0Uz0fR6+Wv4b
         4QkTvcBAJ0RuIL8xJeDk9IgvRH4hd4OjJ3dY739uYWPvPyIAkCRkCvlSRJUqlIVSJOHa
         RnvAh+xC9iuuCI8+cNeITD+279m2QR4B9y5V/QTzoXXG4q9g0vhGrLyQk5QHX9gXmCyu
         ClOg==
X-Gm-Message-State: AOAM5332O8CuGJewXZXuaFNPdAqaoozSATc0PBILVoOoBNSgN57ZGNUt
        HaCO0e9iwrrTkXWTI0FZZB88qph0+MXBXD9sl2g=
X-Google-Smtp-Source: ABdhPJwnwnMnJ0iADB+yNPtPOSoRhfTA8saUU2vq4vN7LszeEgrx/ZXEdYoZDO9/LdNXumlwQmvPr/VyPXzdTGQtYqA=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr28871025ljf.257.1594121461257;
 Tue, 07 Jul 2020 04:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
 <1594059372-15563-3-git-send-email-jrdr.linux@gmail.com> <8fdd8c77-27dd-2847-7929-b5d3098b1b45@suse.com>
In-Reply-To: <8fdd8c77-27dd-2847-7929-b5d3098b1b45@suse.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 7 Jul 2020 17:00:49 +0530
Message-ID: <CAFqt6zZRx3oDO+p2e6EiDig9fzKirME-t6fanzDRh6e7gWx+nA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] xen/privcmd: Mark pages as dirty
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 3:08 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrot=
e:
>
> On 06.07.20 20:16, Souptick Joarder wrote:
> > pages need to be marked as dirty before unpinned it in
> > unlock_pages() which was oversight. This is fixed now.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Suggested-by: John Hubbard <jhubbard@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Paul Durrant <xadimgnik@gmail.com>
> > ---
> >   drivers/xen/privcmd.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index 33677ea..f6c1543 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -612,8 +612,11 @@ static void unlock_pages(struct page *pages[], uns=
igned int nr_pages)
> >   {
> >       unsigned int i;
> >
> > -     for (i =3D 0; i < nr_pages; i++)
> > +     for (i =3D 0; i < nr_pages; i++) {
> > +             if (!PageDirty(pages[i]))
> > +                     set_page_dirty_lock(pages[i]);
>
> With put_page() directly following I think you should be able to use
> set_page_dirty() instead, as there is obviously a reference to the page
> existing.

Patch [3/3] will convert above codes to use unpin_user_pages_dirty_lock()
which internally do the same check. So I thought to keep linux-stable and
linux-next code in sync. John had a similar concern [1] and later agreed to=
 keep
this check.

Shall I keep this check ?  No ?

[1] https://lore.kernel.org/xen-devel/a750e5e5-fd5d-663b-c5fd-261d7c939ba7@=
nvidia.com/

>
> >               put_page(pages[i]);
> > +     }
> >   }
> >
> >   static long privcmd_ioctl_dm_op(struct file *file, void __user *udata=
)
> >
>
> Juergen
