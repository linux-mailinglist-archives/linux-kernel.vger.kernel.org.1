Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16842EA335
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbhAECLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAECLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:11:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1571DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 18:11:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h22so69203719lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 18:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fKci/xz7+6EpLcrUh49o1pJib0PXFbl6FrFEVFhmoL4=;
        b=KuiRw5MSAIV5E+dfU2gQh0nJQ/BcNavLGP0fp5zUxbN9wSHOJUh/CK1yjJl7o5Ngi4
         T5YEmBTpaqFXj1yqLONJFiZ3dOuSuwn214NQtvBigLfC77Mvca3wqUCz95jLJxoL8vN6
         cU2T2jKBOeQpUloEHASD3AcGdwSEktv9a8OjmJlMp+kU4sFE/ks+TyDSXmd1vI1dUkd3
         +P128iDhjrXulpKgt1P1Rrk6BQElMmAuVvKhq/pT9CJiBXTMdjBSr56z9NALEEMKzvkk
         vsevEOO6lQjkXtdhCChOZJKcnRDCLH0wI+pJTX9dP0I4AoRwZPxknUJkvdPShTjBoY1v
         oiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fKci/xz7+6EpLcrUh49o1pJib0PXFbl6FrFEVFhmoL4=;
        b=O2AkwClLltYzuigOtczDwMZiwW/B+pxn9O7Fl3Vh3j3ppQKxGie827BViGROqV21VY
         bsYxSS9UJTjAsyQf9Qc9RthK/u6S+SCG9TJiJ4Ag86MPx5/FyH5PwdjoKBFQAUIUuIQ7
         +qLpI6s11Mc6M6ZbxOpGK96cxiedHOX2NOaxCywoED9Mdpq6nrEwZsVo0WM3CLqp7n9r
         3doMCK95auTUJ531xuk7i0JHp35s3BQFLZkSN0bTJi0GPQ5Jxv33eqktDeQlH0yA+LDz
         6Ld7n/PeQbwVVZR26+q66UMjBv6a67zB+Cm7uxQjfqPdjGW84650ruEXxiH9iSAL0zDZ
         fEBw==
X-Gm-Message-State: AOAM5330zAN+u8ScBlffzE5n7EI42wrPIKKEsQQgG/J6vue7SreCfo+U
        cvhRkxVIbFGuTEYt2APvpoaVKX3CSKvsSEKJJY4=
X-Google-Smtp-Source: ABdhPJzWJPWHizgOtsAUHajKlFTA/eA3J1t8aINbOPMSKBLeW58KxBH7kSquVLIIt9111/dxA9sXvdxOZufoiqkkFQo=
X-Received: by 2002:a2e:9bd6:: with SMTP id w22mr35513731ljj.335.1609812670485;
 Mon, 04 Jan 2021 18:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20210105012826.956800-1-daeho43@gmail.com> <904b7677-3655-2e81-52e0-48296cf1c0da@huawei.com>
In-Reply-To: <904b7677-3655-2e81-52e0-48296cf1c0da@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 5 Jan 2021 11:10:59 +0900
Message-ID: <CACOAw_xf9CFOSvU=s1yP4O74dropdc-ozcDOPhmCpBU3Oif4Bw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null page reference in redirty_blocks
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Colin Ian King <colin.king@canonical.com>,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it's better~ :)

2021=EB=85=84 1=EC=9B=94 5=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 10:44, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/1/5 9:28, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Fixed null page reference when find_lock_page() fails in
> > redirty_blocks().
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Reported-by: Colin Ian King <colin.king@canonical.com>
> > Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_C=
OMPRESS_FILE")
> > ---
> >   fs/f2fs/file.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 9e5275716be8..bf6682a52433 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, p=
goff_t page_idx, int len)
> >
> >       for (i =3D 0; i < page_len; i++, redirty_idx++) {
> >               page =3D find_lock_page(mapping, redirty_idx);
> > -             if (!page)
> > +             if (!page) {
> >                       ret =3D -ENOENT;
>
> ret =3D -ENOMEM;
>
> > +                     continue;
>
> How about breaking the loop for out-of-memory case, because in such condi=
tion
> we have less chance to dirty whole cluster due to no memory, and continue=
 to
> allocate pages for target file will make system suffer more memory pressu=
re,
> it will make many thing slower.
>
> Thnaks,
>
> > +             }
> >               set_page_dirty(page);
> >               f2fs_put_page(page, 1);
> >               f2fs_put_page(page, 0);
> >
