Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850C295686
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895220AbgJVCxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895213AbgJVCxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:53:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C518FC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 19:53:32 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so301356lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 19:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qg0FA381j6jxElnzXtOOWyYAwcDaYrU3Fm/GnZyYlts=;
        b=q3pxVs4HLo3It1DamBzUhxNl+Kr3z/DfHRs9Qe9zrcIHMC9Wc3mtoT3jotFAW8ks34
         Tg/jgufeADd3hRvrNeJfWY85lLl2kn8SDthL2WrSWAKIFaMvHu6J/2VleTbIwmi6ef9o
         JpAP41UHW1p9bYwMsNrjRFy1VdiqcZWsWWiBsGj0PlPBbsOjYS8T05cwcHCs6IqN5Wwm
         VaNEUZNPxG45J7cZR8HXFCCkhk36kyF1u0rSwt2H06gJMK196RlVjR43hRumS9gT+5l+
         3TJs7xk1gKJYZUQAhLjNQEkgoAVQP4OIrOZ0n4gM+fnh+opw0mUJusF9QpsUIGSbT0v2
         XfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qg0FA381j6jxElnzXtOOWyYAwcDaYrU3Fm/GnZyYlts=;
        b=SvM0+Rx1zJXRpooWKAj0AUk8mRretlqh43xzvcjgYb0HjX8H+URBPpjQ6yiRcKyFpp
         k6UCgI/wmtsQs4abF6wbkSqpB66tWa6jSL/lOQoDaRDoe53TNv9XOMgoiPQwH3+HGEEK
         kLI+69XOzSxd/aGDme655THUS8t9sOXur57uix4BT2EPyIz8UC2GvBOk7eL+Kdk9q3+v
         izbiqMgimHG1TB/sRWgJcfg1wpL5la9huOxsJEyIJzB/gMLi/gPhgcW99dKoE/km4F71
         U6U6IpDkQmJiH/kvg0hvPbJGnWBSxCDcT0j2uCNJGNeqaIM2ivNHZJKjzycl9IHIocwX
         hcZg==
X-Gm-Message-State: AOAM532sWq4tp1G6wQBAueJwnj4Jj5JBU29hgjQ4Wh8ejdUJYhAX5Zh+
        qroBxXRJzdwnDmt4SB3n2UEsNRoqeUd7Q9J8r0M=
X-Google-Smtp-Source: ABdhPJwkif7+CgTkcWtQA7UrO+FvhG2jWLZ+UJgZ+yjf0SBRaZC09VHIH6R9re8wydzUYYTSnf3Oh8vR8monjRi9AOE=
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr89758lfe.343.1603335211187;
 Wed, 21 Oct 2020 19:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201016051455.1913795-1-daeho43@gmail.com> <f8359dde-7e0c-b2fc-451f-2984c50fa552@huawei.com>
In-Reply-To: <f8359dde-7e0c-b2fc-451f-2984c50fa552@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 22 Oct 2020 11:53:20 +0900
Message-ID: <CACOAw_wrTSZ3DWBUJA=ePe=fDRgEgqCfsbSqKmE6+ACW8A-RQg@mail.gmail.com>
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

Yep, It sounds good to me.

2020=EB=85=84 10=EC=9B=94 21=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:08, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/10/16 13:14, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added compr_inode to show compressed inode count and compr_blocks to
> > show compressed block count in sysfs.
>
> As there are so many entries in ../f2fs/<disk>/ directory, it looks a mes=
s
> there, I suggest that we can add a new directory 'stats' in ../f2fs/<disk=
>/,
> in where we can store all readonly stats related entries there later.
>
> How do you think?
>
> Thanks,
>
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
> >   fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
> >   2 files changed, 27 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index 834d0becae6d..a01c26484c69 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -350,3 +350,13 @@ Date:            April 2020
> >   Contact:    "Daeho Jeong" <daehojeong@google.com>
> >   Description:        Give a way to change iostat_period time. 3secs by=
 default.
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
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 94c98e412aa1..7139a29a00d3 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -223,6 +223,19 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *=
a,
> >       f2fs_update_sit_info(sbi);
> >       return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vblock=
s));
> >   }
> > +
> > +static ssize_t compr_inode_show(struct f2fs_attr *a,
> > +                             struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +     return sprintf(buf, "%u\n", atomic_read(&sbi->compr_inode));
> > +}
> > +
> > +static ssize_t compr_blocks_show(struct f2fs_attr *a,
> > +                             struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +     return sprintf(buf, "%llu\n", atomic64_read(&sbi->compr_blocks));
> > +}
> > +
> >   #endif
> >
> >   static ssize_t main_blkaddr_show(struct f2fs_attr *a,
> > @@ -591,6 +604,8 @@ F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_backgr=
ound_calls, bg_gc);
> >   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> >   F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
> >   F2FS_GENERAL_RO_ATTR(avg_vblocks);
> > +F2FS_GENERAL_RO_ATTR(compr_inode);
> > +F2FS_GENERAL_RO_ATTR(compr_blocks);
> >   #endif
> >
> >   #ifdef CONFIG_FS_ENCRYPTION
> > @@ -675,6 +690,8 @@ static struct attribute *f2fs_attrs[] =3D {
> >       ATTR_LIST(moved_blocks_foreground),
> >       ATTR_LIST(moved_blocks_background),
> >       ATTR_LIST(avg_vblocks),
> > +     ATTR_LIST(compr_inode),
> > +     ATTR_LIST(compr_blocks),
> >   #endif
> >       NULL,
> >   };
> >
