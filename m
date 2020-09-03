Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3625B860
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgICBnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 21:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICBna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:43:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0380C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 18:43:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so1521844lja.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EuV0L5t7mB5+5riElQeb8xzfc5Npx6k/HWZuEKsybhc=;
        b=O2Ty0h73G0IdiZgy6mGyi/Wrh5o+cv/NaPfbJv+uIl+oKeNBbVo0luGrQq5cMW8Eos
         2WxBcBIx111bdbQ5NpUv2ebZUTcZE/MpBntD8khtgI6ViIFV4i6/aGE2/YLnnxUSpdF4
         lAkEiINYupTVXRQS+vVtWSeeWR6LezFykdJ9zMeZAnNOV8ODLuF8hDKeNFAevv0ZCQK8
         V/7D+EktmjZ7a+1eCfM8xeyyMijyTzwhmqKP7w4WKBFTNkU6TSNmGVNkm/m26daQ6jPg
         AI1D520SBg3jo7hIKhe+Oyz1BzdPfL7t8jomr3PrMM8BBY/K4HJfxPKjr3uFNKKeNcAm
         pR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EuV0L5t7mB5+5riElQeb8xzfc5Npx6k/HWZuEKsybhc=;
        b=hmzO4AQ1PRSJ5mRErfOPT4nd2waOjFT7WsOSX4N16n2q8FR4rbJ8NqgCE2te6tSFq+
         dWhDYsm2U/fT6LKgAITm6B3PluCcTFRz++C3K+NaFTe1ObsOtwqkYwSP0bz4sCUVY4VF
         bstr3D0QSX7i6X7eW2sJMk4E254HG8mQMhJ9yhdzQayj21XIseOyQ+DH56kZ/7O7VWDM
         PemKHZbtkfADhHj0PnXwQwWRxXdLU8wvT+tWc8cjHg/m5bdKDq/FlBvD+GcKL+n7A251
         sm1J+5x7wCOclX4sGoxcdXRcx4AMnP+4QXUPSRS8QXviJcvCgv0GsmmLyUVrGoPoU1KQ
         NU+Q==
X-Gm-Message-State: AOAM533DUNl0L/ILc6Hb+pKYMKe3rmFKUxRfetPfA/nr5Ghd6zaH9JxK
        CkD3bJ1VKA4emhXEuTZmH+j66vFEjRq3IZ/SyFw=
X-Google-Smtp-Source: ABdhPJxz/4XJDy41a+Bl5C0hx58MhZL11Y9KvK94/cpbPVQlO6UkdoMwgDbQEHpYf82erWy9VcTxCkUFhlLbNnpo/PI=
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr342692ljh.335.1599097405044;
 Wed, 02 Sep 2020 18:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200902062910.4061083-1-daeho43@gmail.com> <822bd3b7-4354-1c61-07c4-6a57b3616ea8@huawei.com>
In-Reply-To: <822bd3b7-4354-1c61-07c4-6a57b3616ea8@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 3 Sep 2020 10:43:14 +0900
Message-ID: <CACOAw_w2t8PWSkBLHMbjDQA2EhNujatuAd-WFha0Q=ZNMwi44Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change i_compr_blocks of inode to atomic value
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And how about this atomic64 to just atomic?
As you mentioned before, we don't need a 64bit value for
i_compr_blocks of inode.

2020=EB=85=84 9=EC=9B=94 3=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:08, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/9/2 14:29, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > writepages() can be concurrently invoked for the same file by different
> > threads such as a thread fsyncing the file and a kworker kernel thread.
> > So, changing i_compr_blocks without protection is racy and we need to
> > protect it by changing it with atomic type value.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/f2fs.h  | 15 +++++++++------
> >   fs/f2fs/file.c  | 18 ++++++++++--------
> >   fs/f2fs/inode.c | 11 +++++++----
> >   fs/f2fs/super.c |  1 +
> >   4 files changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index f60414805e05..633957e14944 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -801,7 +801,7 @@ struct f2fs_inode_info {
> >       struct timespec64 i_disk_time[4];/* inode disk times */
> >
> >       /* for file compress */
> > -     u64 i_compr_blocks;                     /* # of compressed blocks=
 */
> > +     atomic64_t i_compr_blocks;              /* # of compressed blocks=
 */
> >       unsigned char i_compress_algorithm;     /* algorithm type */
> >       unsigned char i_log_cluster_size;       /* log of cluster size */
> >       unsigned int i_cluster_size;            /* cluster size */
> > @@ -3933,14 +3933,16 @@ static inline void set_compress_context(struct =
inode *inode)
> >   static inline u64 f2fs_disable_compressed_file(struct inode *inode)
> >   {
> >       struct f2fs_inode_info *fi =3D F2FS_I(inode);
> > +     u64 i_compr_blocks;
> >
> >       if (!f2fs_compressed_file(inode))
> >               return 0;
> >       if (S_ISREG(inode->i_mode)) {
> >               if (get_dirty_pages(inode))
> >                       return 1;
> > -             if (fi->i_compr_blocks)
> > -                     return fi->i_compr_blocks;
> Caller doesn't care how many compr_blocks this inode has saved, so we can=
 just
> return 1 here.
>
> > +             i_compr_blocks =3D atomic64_read(&fi->i_compr_blocks);
> > +             if (i_compr_blocks)
> > +                     return i_compr_blocks;
> >       }
> >
> >       fi->i_flags &=3D ~F2FS_COMPR_FL;
> > @@ -4057,16 +4059,17 @@ static inline void f2fs_i_compr_blocks_update(s=
truct inode *inode,
> >                                               u64 blocks, bool add)
> >   {
> >       int diff =3D F2FS_I(inode)->i_cluster_size - blocks;
> > +     struct f2fs_inode_info *fi =3D F2FS_I(inode);
> >
> >       /* don't update i_compr_blocks if saved blocks were released */
> > -     if (!add && !F2FS_I(inode)->i_compr_blocks)
> > +     if (!add && !atomic64_read(&fi->i_compr_blocks))
> >               return;
> >
> >       if (add) {
> > -             F2FS_I(inode)->i_compr_blocks +=3D diff;
> > +             atomic64_add(diff, &fi->i_compr_blocks);
> >               stat_add_compr_blocks(inode, diff);
> >       } else {
> > -             F2FS_I(inode)->i_compr_blocks -=3D diff;
> > +             atomic64_sub(diff, &fi->i_compr_blocks);
> >               stat_sub_compr_blocks(inode, diff);
> >       }
> >       f2fs_mark_inode_dirty_sync(inode, true);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index cc7f5670390f..4e4e369b97e5 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -564,7 +564,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_o=
f_data *dn, int count)
> >       bool compressed_cluster =3D false;
> >       int cluster_index =3D 0, valid_blocks =3D 0;
> >       int cluster_size =3D F2FS_I(dn->inode)->i_cluster_size;
> > -     bool released =3D !F2FS_I(dn->inode)->i_compr_blocks;
> > +     bool released =3D !atomic64_read(&F2FS_I(dn->inode)->i_compr_bloc=
ks);
> >
> >       if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
> >               base =3D get_extra_isize(dn->inode);
> > @@ -3436,7 +3436,7 @@ static int f2fs_get_compress_blocks(struct file *=
filp, unsigned long arg)
> >       if (!f2fs_compressed_file(inode))
> >               return -EINVAL;
> >
> > -     blocks =3D F2FS_I(inode)->i_compr_blocks;
> > +     blocks =3D atomic64_read(&F2FS_I(inode)->i_compr_blocks);
> >       return put_user(blocks, (u64 __user *)arg);
> >   }
> >
> > @@ -3535,7 +3535,7 @@ static int f2fs_release_compress_blocks(struct fi=
le *filp, unsigned long arg)
> >       if (ret)
> >               goto out;
> >
> > -     if (!F2FS_I(inode)->i_compr_blocks)
> > +     if (!atomic64_read(&F2FS_I(inode)->i_compr_blocks))
> >               goto out;
> >
> >       F2FS_I(inode)->i_flags |=3D F2FS_IMMUTABLE_FL;
> > @@ -3588,14 +3588,15 @@ static int f2fs_release_compress_blocks(struct =
file *filp, unsigned long arg)
> >
> >       if (ret >=3D 0) {
> >               ret =3D put_user(released_blocks, (u64 __user *)arg);
> > -     } else if (released_blocks && F2FS_I(inode)->i_compr_blocks) {
> > +     } else if (released_blocks &&
> > +                     atomic64_read(&F2FS_I(inode)->i_compr_blocks)) {
> >               set_sbi_flag(sbi, SBI_NEED_FSCK);
> >               f2fs_warn(sbi, "%s: partial blocks were released i_ino=3D=
%lx "
> >                       "iblocks=3D%llu, released=3D%u, compr_blocks=3D%l=
lu, "
> >                       "run fsck to fix.",
> >                       __func__, inode->i_ino, inode->i_blocks,
> >                       released_blocks,
> > -                     F2FS_I(inode)->i_compr_blocks);
> > +                     atomic64_read(&F2FS_I(inode)->i_compr_blocks));
> >       }
> >
> >       return ret;
> > @@ -3683,7 +3684,7 @@ static int f2fs_reserve_compress_blocks(struct fi=
le *filp, unsigned long arg)
> >       if (ret)
> >               return ret;
> >
> > -     if (F2FS_I(inode)->i_compr_blocks)
> > +     if (atomic64_read(&F2FS_I(inode)->i_compr_blocks))
> >               goto out;
> >
> >       f2fs_balance_fs(F2FS_I_SB(inode), true);
> > @@ -3747,14 +3748,15 @@ static int f2fs_reserve_compress_blocks(struct =
file *filp, unsigned long arg)
> >
> >       if (ret >=3D 0) {
> >               ret =3D put_user(reserved_blocks, (u64 __user *)arg);
> > -     } else if (reserved_blocks && F2FS_I(inode)->i_compr_blocks) {
> > +     } else if (reserved_blocks &&
> > +                     atomic64_read(&F2FS_I(inode)->i_compr_blocks)) {
> >               set_sbi_flag(sbi, SBI_NEED_FSCK);
> >               f2fs_warn(sbi, "%s: partial blocks were released i_ino=3D=
%lx "
> >                       "iblocks=3D%llu, reserved=3D%u, compr_blocks=3D%l=
lu, "
> >                       "run fsck to fix.",
> >                       __func__, inode->i_ino, inode->i_blocks,
> >                       reserved_blocks,
> > -                     F2FS_I(inode)->i_compr_blocks);
> > +                     atomic64_read(&F2FS_I(inode)->i_compr_blocks));
> >       }
> >
> >       return ret;
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 66969ae852b9..e86857af9699 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -442,7 +442,8 @@ static int do_read_inode(struct inode *inode)
> >                                       (fi->i_flags & F2FS_COMPR_FL)) {
> >               if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
> >                                       i_log_cluster_size)) {
> > -                     fi->i_compr_blocks =3D le64_to_cpu(ri->i_compr_bl=
ocks);
> > +                     atomic64_set(&fi->i_compr_blocks,
> > +                                     le64_to_cpu(ri->i_compr_blocks));
> >                       fi->i_compress_algorithm =3D ri->i_compress_algor=
ithm;
> >                       fi->i_log_cluster_size =3D ri->i_log_cluster_size=
;
> >                       fi->i_cluster_size =3D 1 << fi->i_log_cluster_siz=
e;
> > @@ -460,7 +461,7 @@ static int do_read_inode(struct inode *inode)
> >       stat_inc_inline_inode(inode);
> >       stat_inc_inline_dir(inode);
> >       stat_inc_compr_inode(inode);
> > -     stat_add_compr_blocks(inode, F2FS_I(inode)->i_compr_blocks);
> > +     stat_add_compr_blocks(inode, atomic64_read(&fi->i_compr_blocks));
> >
> >       return 0;
> >   }
> > @@ -619,7 +620,8 @@ void f2fs_update_inode(struct inode *inode, struct =
page *node_page)
> >                       F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isi=
ze,
> >                                                       i_log_cluster_siz=
e)) {
> >                       ri->i_compr_blocks =3D
> > -                             cpu_to_le64(F2FS_I(inode)->i_compr_blocks=
);
> > +                             cpu_to_le64(atomic64_read(
> > +                                     &F2FS_I(inode)->i_compr_blocks));
> >                       ri->i_compress_algorithm =3D
> >                               F2FS_I(inode)->i_compress_algorithm;
> >                       ri->i_log_cluster_size =3D
> > @@ -768,7 +770,8 @@ void f2fs_evict_inode(struct inode *inode)
> >       stat_dec_inline_dir(inode);
> >       stat_dec_inline_inode(inode);
> >       stat_dec_compr_inode(inode);
> > -     stat_sub_compr_blocks(inode, F2FS_I(inode)->i_compr_blocks);
> > +     stat_sub_compr_blocks(inode,
> > +                     atomic64_read(&F2FS_I(inode)->i_compr_blocks));
> >
> >       if (likely(!f2fs_cp_error(sbi) &&
> >                               !is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 83bf9a02f83f..65613500e1ab 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1011,6 +1011,7 @@ static struct inode *f2fs_alloc_inode(struct supe=
r_block *sb)
> >
> >       /* Initialize f2fs-specific inode info */
> >       atomic_set(&fi->dirty_pages, 0);
> > +     atomic64_set(&fi->i_compr_blocks, 0);
> >       init_rwsem(&fi->i_sem);
> >       spin_lock_init(&fi->i_size_lock);
> >       INIT_LIST_HEAD(&fi->dirty_list);
> >
