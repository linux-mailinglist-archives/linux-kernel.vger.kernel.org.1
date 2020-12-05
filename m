Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2672CF934
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 04:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgLEDl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 22:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgLEDl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 22:41:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2840C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 19:40:46 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so8808213ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LJTsl6c44Uxv31c8hslGbnFgaJEY6UyCSOPJO2t5yoo=;
        b=KIrUEQP+BXrrXPpbpyNG2Xfn2lUBRkqUCKMNo6BBt/EgLZuQMkbCYknfzy1u84/aZX
         ryRQ7IViUu3sZWA+htQoajbDRHzaV4geUTkkO4xcNaYhNT4/SAR8DyW/x7q0kyLrr9Gc
         12LgfTiB0SYF0smdnJE5vA7BZC9q26tbje3hnVZAl692JwVufnNM3HzRUdUpD4HJHOUM
         g6u6Xnr1bl7XG6fpK0IuG5YjYo/W4YBh7IaSN73x/0SGSMRIePjH0K4WmSHAzMokgDXC
         sEQ6i9OMX2Bviwrf3BsZ2vRgxKD5G7/oBLkpseTA7jt6rwvw4iYE7Qhq8hv1WQ/cBlG6
         PBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LJTsl6c44Uxv31c8hslGbnFgaJEY6UyCSOPJO2t5yoo=;
        b=Dwh7IJ5qNiFZ7iJdI8FQRKbZcerpOnG+aUiDI+x5ZjKHEwMqT7tVKt66XdyTMt7sng
         S/HYc+LprgO4wNwPTW0oBppRmo0g6YL6e29+N3pJRfgmTfgyReDBB6YxcX76IJOaDDK2
         RdKU8awoKQ3AaNA/+XA4rJt8U1WQezHDvbh/An5r2Rjbtzb9x/YPApDT10wp8zuqmrT2
         Tv+o/Aer71vAvQUSPFMBNNmXykiA6wO8ar6S+L4w7em0zX4nCD1MncT0g7my+xuj0rS3
         DbEfPpyVJ0+lAU4v99PSCLvaUgms3B5ftRi1bSden3uF4qAp6G6sXivM/+KTLEajIyGS
         DyeQ==
X-Gm-Message-State: AOAM531aHonV6wAZ+CWRDstw3a/3vReXsjeHTrw3zcfcWDG/ZZjkTyTa
        USWFZcKRpK6SWZDKr0Lq+07eCxqLWV+ZIFqZA/k=
X-Google-Smtp-Source: ABdhPJyBdEvkKtHgTZxwCTMXwrvSsF+JtmZbMz5bBu4+wF/aQexrIzUgLjMQslIhX2qFPX2sVdjFoO0DeXtDwSsF6yw=
X-Received: by 2002:a2e:9707:: with SMTP id r7mr4417251lji.265.1607139645307;
 Fri, 04 Dec 2020 19:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com> <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain> <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
 <X8nAParf9GW9LaGV@sol.localdomain> <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
 <X8nGvfEeTDTLa6FL@sol.localdomain> <CACOAw_wfew8xER-CibUtddRKVtcr3k_iGzjQ-bVYxqRUuEVCcw@mail.gmail.com>
 <X8qAAiRah/zmowZB@google.com>
In-Reply-To: <X8qAAiRah/zmowZB@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Sat, 5 Dec 2020 12:40:34 +0900
Message-ID: <CACOAw_yfbkF_BYxt57AuHtobdz4T5tfON8vGcjYGc5OaXGLRVg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in decompression
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, we need to come back to v1 and enable verity in a unit of cluster.
Plus, as I told you, I'll prevent newly verity enalbed pages from
being merged with verity disabled bio.

Thanks,

2020=EB=85=84 12=EC=9B=94 5=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 3:29, J=
aegeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 12/04, Daeho Jeong wrote:
> > Thanks for the explanation about verity.
> > I got your point. Thanks~
>
> Possible fix can be like this?
>
> ---
>  fs/f2fs/compress.c |  2 --
>  fs/f2fs/data.c     | 19 +++++++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 89f73a7c8667..c5fee4d7ea72 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1491,8 +1491,6 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct com=
press_ctx *cc)
>         dic->magic =3D F2FS_COMPRESSED_PAGE_MAGIC;
>         dic->inode =3D cc->inode;
>         atomic_set(&dic->pending_pages, cc->nr_cpages);
> -       if (fsverity_active(cc->inode))
> -               atomic_set(&dic->verity_pages, cc->nr_cpages);
>         dic->cluster_idx =3D cc->cluster_idx;
>         dic->cluster_size =3D cc->cluster_size;
>         dic->log_cluster_size =3D cc->log_cluster_size;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e3168f32f943..657fb562d7d4 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1035,7 +1035,8 @@ static inline bool f2fs_need_verity(const struct in=
ode *inode, pgoff_t idx)
>
>  static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkad=
dr,
>                                       unsigned nr_pages, unsigned op_flag=
,
> -                                     pgoff_t first_idx, bool for_write)
> +                                     pgoff_t first_idx, bool for_write,
> +                                     bool for_verity)
>  {
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         struct bio *bio;
> @@ -1057,7 +1058,7 @@ static struct bio *f2fs_grab_read_bio(struct inode =
*inode, block_t blkaddr,
>                 post_read_steps |=3D 1 << STEP_DECRYPT;
>         if (f2fs_compressed_file(inode))
>                 post_read_steps |=3D 1 << STEP_DECOMPRESS_NOWQ;
> -       if (f2fs_need_verity(inode, first_idx))
> +       if (for_verity && f2fs_need_verity(inode, first_idx))
>                 post_read_steps |=3D 1 << STEP_VERITY;
>
>         if (post_read_steps) {
> @@ -1087,7 +1088,7 @@ static int f2fs_submit_page_read(struct inode *inod=
e, struct page *page,
>         struct bio *bio;
>
>         bio =3D f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
> -                                       page->index, for_write);
> +                                       page->index, for_write, true);
>         if (IS_ERR(bio))
>                 return PTR_ERR(bio);
>
> @@ -2141,7 +2142,7 @@ static int f2fs_read_single_page(struct inode *inod=
e, struct page *page,
>         if (bio =3D=3D NULL) {
>                 bio =3D f2fs_grab_read_bio(inode, block_nr, nr_pages,
>                                 is_readahead ? REQ_RAHEAD : 0, page->inde=
x,
> -                               false);
> +                               false, true);
>                 if (IS_ERR(bio)) {
>                         ret =3D PTR_ERR(bio);
>                         bio =3D NULL;
> @@ -2188,6 +2189,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, =
struct bio **bio_ret,
>         const unsigned blkbits =3D inode->i_blkbits;
>         const unsigned blocksize =3D 1 << blkbits;
>         struct decompress_io_ctx *dic =3D NULL;
> +       bool for_verity =3D false;
>         int i;
>         int ret =3D 0;
>
> @@ -2253,6 +2255,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc,=
 struct bio **bio_ret,
>                 goto out_put_dnode;
>         }
>
> +       if (fsverity_active(cc->inode)) {
> +               atomic_set(&dic->verity_pages, cc->nr_cpages);
> +               for_verity =3D true;
> +       }
> +
>         for (i =3D 0; i < dic->nr_cpages; i++) {
>                 struct page *page =3D dic->cpages[i];
>                 block_t blkaddr;
> @@ -2272,7 +2279,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, =
struct bio **bio_ret,
>                 if (!bio) {
>                         bio =3D f2fs_grab_read_bio(inode, blkaddr, nr_pag=
es,
>                                         is_readahead ? REQ_RAHEAD : 0,
> -                                       page->index, for_write);
> +                                       page->index, for_write, for_verit=
y);
>                         if (IS_ERR(bio)) {
>                                 unsigned int remained =3D dic->nr_cpages =
- i;
>                                 bool release =3D false;
> @@ -2280,7 +2287,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, =
struct bio **bio_ret,
>                                 ret =3D PTR_ERR(bio);
>                                 dic->failed =3D true;
>
> -                               if (fsverity_active(inode)) {
> +                               if (for_verity) {
>                                         if (!atomic_sub_return(remained,
>                                                 &dic->verity_pages))
>                                                 release =3D true;
> --
> 2.29.2.576.ga3fc446d84-goog
>
