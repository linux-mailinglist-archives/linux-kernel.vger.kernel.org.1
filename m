Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF332FFA09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbhAVBhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbhAVBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:37:52 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D16C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:37:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p13so4764386ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zSsmz7M3XSK6HCpP5SpXph6fwHlQF1RHiR3CvF0f+mQ=;
        b=kPdBhtV7sb5FmbpskgX47ayA3XzZpJ5sLr7ZfFQ16YmFKe3uuPeDHLlKAiKTyKbytn
         GpXdQKeYqValccp0PzOV9ES0Kap5PeiAXfaG0obsgUetZSHOd+NXcGxOELpamALCiUcw
         XmviFURFgWxBWx3eGtnH7nk9+4ttuO/h7NrKV3MDEXIKBo7dhcWlJPjTa188Y8ZSqFOv
         tVXuzdwmpaAI4wDpujmMWWMKYrzF1pjtjOhblEZdWogxYRUv4l4vsSL+mmC/HjSTyKWv
         alYQfPWGE0Ub4R36MSVmFI/V9PaBqNaftB/nmQO5/iRYAElHJwK+/+cUqfqG6ILw230T
         25LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zSsmz7M3XSK6HCpP5SpXph6fwHlQF1RHiR3CvF0f+mQ=;
        b=Vbb/RCkTACA8NRFvpXgOIW55hzhZQLVaytxD66mkdxLVbvAF2D9DJ6saMK2ey5UUKM
         QmEDlA6B/TqRJ+q4sjeTFXV+rFfvwZ1VhdIvPR0paS51IKH8eCRLuEI1TGd3BRKzM/2P
         tORNkGiEfzHUB+TdaibildZkdJZQ+Pvvhh4usIn9FNjOtiEbMXswuN9WJeNEYSEwDwLd
         q8pBQcZL/+rZxtzsU80beQDwKYSUgO4IM2QiH8557yqwV2BdKliEMk05AlWyZIIfeJNF
         27E6ld1AdO/e8gNM1INwdGxvis4zS4Yb8x5oF6SrS15RzOB8lAb3iILrmiCGudX2tC8a
         aNyA==
X-Gm-Message-State: AOAM533hpiG7h33a5hhYQhOPxAkS1jMxcADQGdptDAXuaVTCR/sBZbeF
        7OXLHY1V6MSg46K10bAa6krWvUvK8kmcOlYy8dB8H2WOtZs=
X-Google-Smtp-Source: ABdhPJzkG8y52oDdMWe+BHOq2aGa4/Niet2z6/DpC1s6GUzZ60Uy5fGhzwpqrcf8kVyaUzS7LNejFdcL8MHbUVpQxvo=
X-Received: by 2002:a2e:b8c5:: with SMTP id s5mr19875ljp.335.1611279429763;
 Thu, 21 Jan 2021 17:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20210121134529.1201249-1-daeho43@gmail.com> <6e4996f8-fdf0-93dd-8253-9e8f5e6fca06@huawei.com>
In-Reply-To: <6e4996f8-fdf0-93dd-8253-9e8f5e6fca06@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 22 Jan 2021 10:36:58 +0900
Message-ID: <CACOAw_yDYWw-3f2q_3EoHu8M196KEi=4aNsbbZqXYra=d7ebng@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: introduce checkpoint=merge mount option
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it~! :)

2021=EB=85=84 1=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:55, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> If there is no update in v5, it will be better to include my Reviewed-by
> tag, please note that. :)
>
> Thanks,
>
> On 2021/1/21 21:45, Daeho Jeong wrote:
> > From: Daeho Jeong<daehojeong@google.com>
> >
> > We've added a new mount option "checkpoint=3Dmerge", which creates a
> > kernel daemon and makes it to merge concurrent checkpoint requests as
> > much as possible to eliminate redundant checkpoint issues. Plus, we
> > can eliminate the sluggish issue caused by slow checkpoint operation
> > when the checkpoint is done in a process context in a cgroup having
> > low i/o budget and cpu shares. To make this do better, we set the
> > default i/o priority of the kernel daemon to "3", to give one higher
> > priority than other kernel threads. The below verification result
> > explains this.
> > The basic idea has come fromhttps://opensource.samsung.com.
> >
> > [Verification]
> > Android Pixel Device(ARM64, 7GB RAM, 256GB UFS)
> > Create two I/O cgroups (fg w/ weight 100, bg w/ wight 20)
> > Set "strict_guarantees" to "1" in BFQ tunables
> >
> > In "fg" cgroup,
> > - thread A =3D> trigger 1000 checkpoint operations
> >    "for i in `seq 1 1000`; do touch test_dir1/file; fsync test_dir1;
> >     done"
> > - thread B =3D> gererating async. I/O
> >    "fio --rw=3Dwrite --numjobs=3D1 --bs=3D128k --runtime=3D3600 --time_=
based=3D1
> >         --filename=3Dtest_img --name=3Dtest"
> >
> > In "bg" cgroup,
> > - thread C =3D> trigger repeated checkpoint operations
> >    "echo $$ > /dev/blkio/bg/tasks; while true; do touch test_dir2/file;
> >     fsync test_dir2; done"
> >
> > We've measured thread A's execution time.
> >
> > [ w/o patch ]
> > Elapsed Time: Avg. 68 seconds
> > [ w/  patch ]
> > Elapsed Time: Avg. 48 seconds
> >
> > Signed-off-by: Daeho Jeong<daehojeong@google.com>
> > Signed-off-by: Sungjong Seo<sj1557.seo@samsung.com>
