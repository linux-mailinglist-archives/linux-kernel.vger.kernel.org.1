Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963A12FE843
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbhAULAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbhAUK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:58:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:57:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v24so1901745lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TOcc6smGKrQ7ZrXNRSinoNICfIztx//2OX5jd0yU1no=;
        b=mss4EFQeqFKkwsXwSPbwNZwUgDfQKoZdj/HMsTafLIT7fJ75dCqGWBbB4sS58gRW9W
         h7Nfm29U1IGmAO4Gk1zmjxdwatxIsRd30acNBXKCeDeRq0zo2YfKm9lyRUxtWII8Utyb
         zmap8u8qqHEFBFjtQtte9p6F4U/VMYz+SyEb9xtkfjWJKmyRvpsJlE8jrQa14IGeSTAm
         0OnUAw8eEVchIhCwHoB2ggsoJvOw4j7ZV/qG5/irj6V/HG2nR2qI0OF3HpCgGWTP3Fem
         BPlTJ01vPZ6aICOvFH4oP1tYPQEQ76+y2/cI+hqGJZRMQ2st5mHfxXP9205g53AvIzRP
         XyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TOcc6smGKrQ7ZrXNRSinoNICfIztx//2OX5jd0yU1no=;
        b=GkQUMSGYN7O3zgLpzr46qfLHSJD53cy9pqPKJpWAIDY4SEYOWC1JACLdf/JN3v3Qqk
         tf6KM6+7iIxmyj9epjeqit8qzbre98BLafjpqByKrrPXhg23hpGry5M9JyxaQ53ouQao
         az3wa5yQB9pjD8JVYHVznYHdig8CAKj+OhzjFH4Ul3ZCZg7BbkPVWakOtRM7svty2kLD
         5gTzbgVuLUFyzwA974ouoOXg+tkQ1YK/i8h/PjTQ0+PAN2Le96kRsJyB6tUH4dSZZvev
         XO19VATL0zjVdnpctEfrffTSUbUcARVIwM5FfDGiGy/ljJEH+M7DniT5zcEQeMwuVkU1
         c7cg==
X-Gm-Message-State: AOAM533ytXxWvXU5iIOk6aphiIjTJABKhf133jX1osdkGVLdMVDEx1Th
        U9UojubPzUwWUEA1Ud7gycOejf/Ecqu+7pJepYc=
X-Google-Smtp-Source: ABdhPJy3wP8/k/AMEGsTc1qC6WhdFhqHnDhEZrBjupyYszXa/tZjzOqXIt9m8rUHQs3qwe3RQAvfy8lc0ejAB+prclU=
X-Received: by 2002:a19:5052:: with SMTP id z18mr4672874lfj.554.1611226671040;
 Thu, 21 Jan 2021 02:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20210114062302.3809664-1-daeho43@gmail.com> <20210114062302.3809664-2-daeho43@gmail.com>
 <d4c12d47-db33-7e76-b7ad-4d80ced1aba9@huawei.com>
In-Reply-To: <d4c12d47-db33-7e76-b7ad-4d80ced1aba9@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 21 Jan 2021 19:57:40 +0900
Message-ID: <CACOAw_xj-=scjMAF5Gzwe82p-roT0eTWhTuaFJFCHfrazpOA9A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: add ckpt_thread_ioprio sysfs node
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, it disappeared while versioning up...

2021=EB=85=84 1=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:30, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/1/14 14:23, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added "ckpt_thread_ioprio" sysfs node to give a way to change checkpoin=
t
> > merge daemon's io priority. Its default value is "be,3", which means
> > "BE" I/O class and I/O priority "3". We can select the class between "r=
t"
> > and "be", and set the I/O priority within valid range of it.
> > "," delimiter is necessary in between I/O class and priority number.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2:
> > - adapt to inlining ckpt_req_control of f2fs_sb_info
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
> >   fs/f2fs/checkpoint.c                    |  2 +-
> >   fs/f2fs/f2fs.h                          |  1 +
> >   fs/f2fs/sysfs.c                         | 51 ++++++++++++++++++++++++=
+
> >   4 files changed, 61 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index 3dfee94e0618..0c48b2e7dfd4 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -377,3 +377,11 @@ Description:     This gives a control to limit the=
 bio size in f2fs.
> >               Default is zero, which will follow underlying block layer=
 limit,
> >               whereas, if it has a certain bytes value, f2fs won't subm=
it a
> >               bio larger than that size.
> > +What:                /sys/fs/f2fs/<disk>/ckpt_thread_ioprio
> > +Date:                January 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Give a way to change checkpoint merge daemon's io priorit=
y.
> > +             Its default value is "be,3", which means "BE" I/O class a=
nd
> > +             I/O priority "3". We can select the class between "rt" an=
d "be",
> > +             and set the I/O priority within valid range of it. "," de=
limiter
> > +             is necessary in between I/O class and priority number.
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index e0668cec3b80..62bd6f449bb7 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1840,7 +1840,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *s=
bi)
> >       if (IS_ERR(cprc->f2fs_issue_ckpt))
> >               return PTR_ERR(cprc->f2fs_issue_ckpt);
> >
> > -     set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO)=
;
> > +     set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);
>
> Where do we set default value of cprc->ckpt_thread_ioprio? I guess it sho=
uld
> be f2fs_init_ckpt_req_control()?
>
> Thanks,
