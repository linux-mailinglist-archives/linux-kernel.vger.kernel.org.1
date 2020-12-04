Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8C2CE6AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLDDoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgLDDoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:44:16 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78CC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 19:43:36 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so5839451lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 19:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gWJppt1udYQQeW4uGML9hDSCvSJGKtR5Pb4awjBzTJU=;
        b=OHeL8X1iRMBjDf9NetzGmz04p+DWn5SewE3USyr9SoLDIh+/sFp0OP6SoHCVWWCN3x
         ag4ejFQHAZl6qgzphD6qz0IjKLddUxjw6Y5INYTIMmsWELd75BdVo3Ra5Do6dp+HC+kQ
         hQZ1lrFhaMZvUbeijh45WWT1HYl6u5/cxtpqHpdyyDbYGUTQQM1cVdESjD9DaY+UcUJe
         3BEzigJCAY/QjDcusWZtvHGWUfqs+LSB4cXSsKTZDgZ5msfB0mk3QJICyU4KsPJ9yZAo
         WBVLnPhcou31Fi6hlVu3JSMLwqelcDfNOrB8LALFK1hFEbx5yKlX05Hw9umwwIaMqPDe
         ipNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gWJppt1udYQQeW4uGML9hDSCvSJGKtR5Pb4awjBzTJU=;
        b=UxFdnez3MyFIRnamMOOoccKIfbZkM8OtfNL5uJKdQb05rFDLt5j8MAoy9LNsJ/+8Tf
         OnDBeHmrZT3v4DmcG3Vqk6BpswV9mhxwQ6s2dkQWK6JHms6vg8Mgezz5WfANwSqwwDQ8
         DosgkxodEO9N3uD3pvVCa+kdpNwV9RRHeBBvTaFmEkDnyoh9o4APCG/cMdaxPj7PSABN
         IBw38bKxxIQLTcJthgEqa5OBb14WUWpSF1LBpnFqoUr4/ZwUDGQvHzQIvC6h967hwRVu
         13En/9tY0Lk5/RsOlPQRiHV4221oHtvU79Gf5dgUSXs6Qc0p45NZMPTmUSMWOeGuz4JW
         q2Cg==
X-Gm-Message-State: AOAM533cm+HW+zq3DY8l0SBpZ0nJ9ekpA5IAOSIlmK1OVhBgVF/c+g2d
        MWzMjaQq12TNUgcJvAYuuJ9JNl1s9L8VsUbEfpA=
X-Google-Smtp-Source: ABdhPJyoICtH1jPOqijPSZsG9CLRcNKMeQFZsKF/5yrs1eYz2Eb9dPPjHpUYM2VYDExFyu+Wdyr9OeNA2wQ18aNrjC0=
X-Received: by 2002:a19:7dc4:: with SMTP id y187mr2514294lfc.326.1607053414500;
 Thu, 03 Dec 2020 19:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com> <X8msy1T8uqZ4Z/iR@sol.localdomain>
In-Reply-To: <X8msy1T8uqZ4Z/iR@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 4 Dec 2020 12:43:23 +0900
Message-ID: <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in decompression
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STEP_VERITY is enabled by f2fs_need_verity() and the function is like below=
.
We already know the second condition (idx < DIV_ROUND_UP...) is
satisfied when invoking f2fs_alloc_dic().

static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
{
        return fsverity_active(inode) &&
               idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
}

2020=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:28, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Dec 04, 2020 at 09:58:47AM +0900, Daeho Jeong wrote:
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 87090da8693d..cdf72e153da0 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -803,8 +803,6 @@ void f2fs_decompress_pages(struct bio *bio, struct =
page *page, bool verity)
> >       if (cops->destroy_decompress_ctx)
> >               cops->destroy_decompress_ctx(dic);
> >  out_free_dic:
> > -     if (verity)
> > -             atomic_set(&dic->pending_pages, dic->nr_cpages);
> >       if (!verity)
> >               f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
> >                                                               ret, fals=
e);
> > @@ -1498,6 +1496,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct c=
ompress_ctx *cc)
> >       dic->magic =3D F2FS_COMPRESSED_PAGE_MAGIC;
> >       dic->inode =3D cc->inode;
> >       atomic_set(&dic->pending_pages, cc->nr_cpages);
> > +     if (fsverity_active(cc->inode))
> > +             atomic_set(&dic->verity_pages, cc->nr_cpages);
> >       dic->cluster_idx =3D cc->cluster_idx;
> >       dic->cluster_size =3D cc->cluster_size;
> >       dic->log_cluster_size =3D cc->log_cluster_size;
>
> The check for fsverity_active() is wrong.  It looks like you need to know
> whether the bio needs to go through the fs-verity data verification.  The
> correct way to determine that is to check whether STEP_VERITY is enabled =
in the
> bio's bio_post_read_ctx.  It's set by f2fs_grab_read_bio() when needed.
>
> - Eric
