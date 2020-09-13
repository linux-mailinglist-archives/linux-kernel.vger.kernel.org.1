Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB62680C8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIMSkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 14:40:02 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33500C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:40:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so14889345qkj.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8ubMUZDeeKR9nMv2dJn/qnSOG8J0zmmqr6tWo71S1Q=;
        b=uWpnYqMmRwbT1cbVOA3uSB9aiNhLiGNKSfR3OmWJcSe8xYfTNqrg3yQuC1EAwDbIm4
         w5fNm4PE54LRJAiukAQfvQBQrJt65BaE3Ln0IXBFDHeObOtA3VV66Mg1HIcBWPbcELgC
         j1tnmKy5qoVvw3X6G3q1fbGQy9+DYHfBDC+dR+7QTHEor8srv/dX5Wj3pb2gSgVT0VfD
         5dVnmunz7B/UB4yuQEoZ7R/qbSWyQL4blWohA62Mg7Q/EadasHPqofXJra4txBDLyykm
         Jf+ZVM/4XFqTjdYXSVBhxmP1eKBxj4al8g2Gv0uvM/48rxHMTOLiyTOo5f+z9m51vH9A
         TU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8ubMUZDeeKR9nMv2dJn/qnSOG8J0zmmqr6tWo71S1Q=;
        b=RN5hj5/GcFCmfndapjkBANa1R07YS0HBwBqNWK7ELLDOM/61huELnN6+eRF2CpB0OL
         vcSDPx3ebnrTytMbeMsvlslJKmhNe5LV1nntjYU4ZeahltGL//Kzq+i3UyA5nqgSw8gz
         Aut+uNsu6Xk4ipEtUDuOeT7iuTPFvwkPGUTq1Pl6lfL8nK7ev00bv1hTU5mna4SmEZ5T
         rvn1YWwRf8jQuIzo+o++p3ArCblFYCKHbJYUdDQzXsFOK6cqvvFiiZxg2/XM7pi8mnwL
         6IGnCl+zEdCVzyQypMUNZSdb9bXRKNB3Wk6AQ0sh6hlCddXlmZ0dBBwflYnb6czyamtK
         MTxA==
X-Gm-Message-State: AOAM5332IRjGqu8AKLTn1lK84Y+tVZFCJrBj1uWDoM2Q4oh8IJ9a4LUJ
        oaGp2KAT2aaYe2jIXvdV7Wt4pXV900KA7OdhOFc=
X-Google-Smtp-Source: ABdhPJz2nR8dyQeiqPb44/9pqa7J3ZE9ait6L7YKmea4APll3PekOjSXhvIRmzdXDOVHVAjs7Px8QpYXm2d9bR8AMc4=
X-Received: by 2002:a37:474c:: with SMTP id u73mr10364919qka.45.1600022401427;
 Sun, 13 Sep 2020 11:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200828033250.910168-1-chengzhihao1@huawei.com> <CAFLxGvwzTiDDLaN3Q5BSa2+7cwxBooeJuHSrgNPaM9=ONBLTkg@mail.gmail.com>
In-Reply-To: <CAFLxGvwzTiDDLaN3Q5BSa2+7cwxBooeJuHSrgNPaM9=ONBLTkg@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 13 Sep 2020 20:39:50 +0200
Message-ID: <CAFLxGvx1a7wGWJGhNvW5w3acGysEnuYbpJ_v=wOLpubB47=BKA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: setflags: Don't show error message when
 vfs_ioc_setflags_prepare() fails
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 9:23 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Fri, Aug 28, 2020 at 5:33 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> >
> > Following process will trigger ubifs_err:
> >   1. useradd -m freg                                        (Under root)
> >   2. cd /home/freg && mkdir mp                              (Under freg)
> >   3. mount -t ubifs /dev/ubi0_0 /home/freg/mp               (Under root)
> >   4. cd /home/freg && echo 123 > mp/a                       (Under root)
> >   5. cd mp && chown freg a && chgrp freg a && chmod 777 a   (Under root)
> >   6. chattr +i a                                            (Under freg)
> >
> > UBIFS error (ubi0:0 pid 1723): ubifs_ioctl [ubifs]: can't modify inode
> > 65 attributes
> > chattr: Operation not permitted while setting flags on a
> >
> > This is not an UBIFS problem, it was caused by task priviliage checking
> > on file operations. Remove error message printing from kernel just like
> > other filesystems (eg. ext4), since we already have enough information
> > from userspace tools.
> >
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > ---
> >  fs/ubifs/ioctl.c | 1 -
> >  1 file changed, 1 deletion(-)
>
> Makes sense, thanks for fixing!

Applied to fixes.

-- 
Thanks,
//richard
