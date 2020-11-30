Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140282C7CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgK3CDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3CDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:03:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38562C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 18:02:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s27so18099218lfp.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 18:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3TO1ey3aWGxK6ukP0NfOLDr7xuEoQlMHxFcRVvWIJ5s=;
        b=qwfKG2UhWCaxvPdtwP2BApBf3Kmr6PudiHv4/QikPOO6Lk9EmHruDCDAe/SEWOnrui
         MsTJm5mDpN94l6CrWtFFhtfdG8NT3s0O5e2+odH6Y0PS08TAzjMj6o+szLwYoUi56Ug1
         bk/x6PFI3d7UGOBh3ofpf5NGwrv/zM+Rp21M8WreQORYwHvVW8HyRgYpRct6TxBlVH6N
         ND86vaB8zwa9un6kWh5MUuKaAkhyqY4L5Fgn6Eoc4eMvCoq1CJ542BLb4Ue/7m/Ft1QM
         4nG3ysLwxvLne1gd326yhJvVSK3nGCah7IIYSWqQzHGo1SURnJbk5QgNCFXvMdlsOubI
         JYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3TO1ey3aWGxK6ukP0NfOLDr7xuEoQlMHxFcRVvWIJ5s=;
        b=Yl7IiY6Z2fsTJQMH/AYaSXqbEMjtkPYBuwVjOFcf3kv9YMbxKg6iRDepI1jNuRhovS
         Pfzr0JrJo9UFb2p5IPRkDLSJ6Rf+DvGVKnIqkFuWouPpocC/U/tpIIrbhYVVeZdhy9M8
         m2k59MDjM0EVS0W/r6zYilhznK6EVT8YxVcpFRZ36bqN7/5R9MUpqufNWb+hlS17w49/
         7EGc7sFTLE018711e6ml94Me7ygUTJectvaD8BNE5eXU7e43nWKVhSjWqvTLHyfKnncl
         TWI7rXFULoYp2zjaRoF0am1szn7flCD9RpOfc7YgZXlK3GkqLGgMKlVTDypFArXdFyja
         HAgw==
X-Gm-Message-State: AOAM532l1FiRUhl4qjMr8YTMPY/OqZ0NpHEJb2/9tcq5+PzwqqC4D/Ut
        J73T9V/A3kiLWyJ2vOYc15pzSy/zYS4RdOTE1lk=
X-Google-Smtp-Source: ABdhPJyZFfjdJpjvAvwZlBGOVGEd/wvu4ziTgCbdJkyJx5Znj4MmF/Xraqv7q3GPDc6DTVxwUmtG/fNDVUuQaNeYXyc=
X-Received: by 2002:a05:6512:3a6:: with SMTP id v6mr7471826lfp.90.1606701777492;
 Sun, 29 Nov 2020 18:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20201016051455.1913795-1-daeho43@gmail.com> <f8359dde-7e0c-b2fc-451f-2984c50fa552@huawei.com>
 <CACOAw_wrTSZ3DWBUJA=ePe=fDRgEgqCfsbSqKmE6+ACW8A-RQg@mail.gmail.com> <2d354bbe-9d1e-f3e0-b918-b9ec023a93ba@huawei.com>
In-Reply-To: <2d354bbe-9d1e-f3e0-b918-b9ec023a93ba@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 30 Nov 2020 11:02:46 +0900
Message-ID: <CACOAw_x1Zkn-yY-cmWwQUByHVg5mUDqYz86e+TFKWWuhas+_MA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add compr_inode and compr_blocks sysfs nodes
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, but I don't think we need to expose compr_inode and compr_block right=
 now.

2020=EB=85=84 11=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:44, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Daeho,
>
> How about updating this patch based on below patch?
>
>         f2fs: introduce a new per-sb directory in sysfs
>
> On 2020/10/22 10:53, Daeho Jeong wrote:
> > Yep, It sounds good to me.
> >
> > 2020=EB=85=84 10=EC=9B=94 21=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:=
08, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2020/10/16 13:14, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Added compr_inode to show compressed inode count and compr_blocks to
> >>> show compressed block count in sysfs.
> >>
> >> As there are so many entries in ../f2fs/<disk>/ directory, it looks a =
mess
> >> there, I suggest that we can add a new directory 'stats' in ../f2fs/<d=
isk>/,
> >> in where we can store all readonly stats related entries there later.
> >>
> >> How do you think?
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>>    Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
> >>>    fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
> >>>    2 files changed, 27 insertions(+)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/=
ABI/testing/sysfs-fs-f2fs
> >>> index 834d0becae6d..a01c26484c69 100644
> >>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> >>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> >>> @@ -350,3 +350,13 @@ Date:            April 2020
> >>>    Contact:    "Daeho Jeong" <daehojeong@google.com>
> >>>    Description:        Give a way to change iostat_period time. 3secs=
 by default.
> >>>                The new iostat trace gives stats gap given the period.
> >>> +
> >>> +What:                /sys/fs/f2fs/<disk>/compr_inode
> >>> +Date:                October 2020
> >>> +Contact:     "Daeho Jeong" <daehojeong@google.com>
> >>> +Description: Show compressed inode count
> >>> +
> >>> +What:                /sys/fs/f2fs/<disk>/compr_blocks
> >>> +Date:                October 2020
> >>> +Contact:     "Daeho Jeong" <daehojeong@google.com>
> >>> +Description: Show compressed block count
> >>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>> index 94c98e412aa1..7139a29a00d3 100644
> >>> --- a/fs/f2fs/sysfs.c
> >>> +++ b/fs/f2fs/sysfs.c
> >>> @@ -223,6 +223,19 @@ static ssize_t avg_vblocks_show(struct f2fs_attr=
 *a,
> >>>        f2fs_update_sit_info(sbi);
> >>>        return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vbl=
ocks));
> >>>    }
> >>> +
> >>> +static ssize_t compr_inode_show(struct f2fs_attr *a,
> >>> +                             struct f2fs_sb_info *sbi, char *buf)
> >>> +{
> >>> +     return sprintf(buf, "%u\n", atomic_read(&sbi->compr_inode));
> >>> +}
> >>> +
> >>> +static ssize_t compr_blocks_show(struct f2fs_attr *a,
> >>> +                             struct f2fs_sb_info *sbi, char *buf)
> >>> +{
> >>> +     return sprintf(buf, "%llu\n", atomic64_read(&sbi->compr_blocks)=
);
> >>> +}
> >>> +
> >>>    #endif
> >>>
> >>>    static ssize_t main_blkaddr_show(struct f2fs_attr *a,
> >>> @@ -591,6 +604,8 @@ F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_back=
ground_calls, bg_gc);
> >>>    F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> >>>    F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
> >>>    F2FS_GENERAL_RO_ATTR(avg_vblocks);
> >>> +F2FS_GENERAL_RO_ATTR(compr_inode);
> >>> +F2FS_GENERAL_RO_ATTR(compr_blocks);
> >>>    #endif
> >>>
> >>>    #ifdef CONFIG_FS_ENCRYPTION
> >>> @@ -675,6 +690,8 @@ static struct attribute *f2fs_attrs[] =3D {
> >>>        ATTR_LIST(moved_blocks_foreground),
> >>>        ATTR_LIST(moved_blocks_background),
> >>>        ATTR_LIST(avg_vblocks),
> >>> +     ATTR_LIST(compr_inode),
> >>> +     ATTR_LIST(compr_blocks),
> >>>    #endif
> >>>        NULL,
> >>>    };
> >>>
> > .
> >
