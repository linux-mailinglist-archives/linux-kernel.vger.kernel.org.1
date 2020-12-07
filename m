Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDB2D1E93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgLGXwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLGXwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:52:38 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E7C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:51:57 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id b8so13904397ila.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fnG2AFxrvUAG48qSs+ORV96koVoU7dohtORWA8eYiDk=;
        b=Ughv+eTB+6CuVvlGH79ocSVBjB4gPWmssmuyaKpJ2qfgkMtfAyPaLMqTSAFN9yOGdu
         dpzgZ5o7p+SrOaS3Mj/2MUgsAxUwKJFZOgyCUFR6eygIh5bJIIbnD8VqQJjL8PyeHDMV
         qrRLMHMp/STAYg/6V5od7l4+4bnnOEHkmQS16adp/WHbcubTjfg8Gtbwr90Wj1eCcSXf
         L47NOmdJDzFS8VsjbUNPrMyh96Nup7wl04myoem01BhADl3oC1g86Lcu3j+SRpbfWdiW
         JfUQvXZrH3Ei4YL/ldcUH/cIi9Ay0X+9DXireg8VEAovzgYhgvtUEXzcbcJ8JwZpGe0s
         6B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fnG2AFxrvUAG48qSs+ORV96koVoU7dohtORWA8eYiDk=;
        b=Bsr1o9wawp+xvrJFWfafbpOsp9cZQnWI+ChVrGZApDCo7/NhCvcf9IZRa+DNa5Ii9F
         GGccUUFNUlUsKeovMdeKkatvWbol/PmDGr0eH50BVaZ+NdJpDWJiWr0aNnl7Kda9at1n
         BSK+CSDJBqpaXiC6M4iGOwZYDc8mg9Di7vNYUWzV+JrVhycjCsdNyqZFBVXVTlK42JH/
         fy1D0aZNzKcx4S6jIvJu8kzJ61gK9uSZHr/8qG5TQ5oLearroLs9LoxXaJ7BA6dT0Xkr
         TZDW8lLCufAO0GK+MMoJbGYUb9KRwFEZNxdtyS2eMLxaVFjJx0pSorAaRsGXpcIEy8Ak
         c7UA==
X-Gm-Message-State: AOAM532uwBeSJT/y8PCsBe8qTwV9loVUT/PBVTnitCl5dDL8REK2QRUc
        AgbsK+gsGl4tFna9WpEkSgpJ9ZYhOaVoyz4sGKI=
X-Google-Smtp-Source: ABdhPJzkjLxuK1omK8MXQpuuZDcqC9/kUdhw8LI+0WymyLmBnla/1il257Ygorq7EJCqBj9Bzbt8/V5eqyjY0oFgr7A=
X-Received: by 2002:a92:d9cd:: with SMTP id n13mr22632494ilq.96.1607385117001;
 Mon, 07 Dec 2020 15:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20201205042626.1113600-1-daeho43@gmail.com> <X86RJdLhOVRm28Eu@gmail.com>
In-Reply-To: <X86RJdLhOVRm28Eu@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 8 Dec 2020 08:51:45 +0900
Message-ID: <CACOAw_yp0LU-vcT2+NTF3ipibF6GvqfaQ4V=957CDPQLbes92Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in decompression
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao, Jaegeuk,

Thanks. I'll update it as your comments. :)

Eric,

Decompression and verity can be executed in different thread contexts
in different timing, so we need separate counts for each.

We already use STEP_VERITY for non-compression case, so I think using
this flag in here looks more making sense.

Thanks,

2020=EB=85=84 12=EC=9B=94 8=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 5:31, E=
ric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Dec 05, 2020 at 01:26:26PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > I found out f2fs_free_dic() is invoked in a wrong timing, but
> > f2fs_verify_bio() still needed the dic info and it triggered the
> > below kernel panic. It has been caused by the race condition of
> > pending_pages value between decompression and verity logic, when
> > the same compression cluster had been split in different bios.
> > By split bios, f2fs_verify_bio() ended up with decreasing
> > pending_pages value before it is reset to nr_cpages by
> > f2fs_decompress_pages() and caused the kernel panic.
> >
> > [ 4416.564763] Unable to handle kernel NULL pointer dereference
> >                at virtual address 0000000000000000
> > ...
> > [ 4416.896016] Workqueue: fsverity_read_queue f2fs_verity_work
> > [ 4416.908515] pc : fsverity_verify_page+0x20/0x78
> > [ 4416.913721] lr : f2fs_verify_bio+0x11c/0x29c
> > [ 4416.913722] sp : ffffffc019533cd0
> > [ 4416.913723] x29: ffffffc019533cd0 x28: 0000000000000402
> > [ 4416.913724] x27: 0000000000000001 x26: 0000000000000100
> > [ 4416.913726] x25: 0000000000000001 x24: 0000000000000004
> > [ 4416.913727] x23: 0000000000001000 x22: 0000000000000000
> > [ 4416.913728] x21: 0000000000000000 x20: ffffffff2076f9c0
> > [ 4416.913729] x19: ffffffff2076f9c0 x18: ffffff8a32380c30
> > [ 4416.913731] x17: ffffffc01f966d97 x16: 0000000000000298
> > [ 4416.913732] x15: 0000000000000000 x14: 0000000000000000
> > [ 4416.913733] x13: f074faec89ffffff x12: 0000000000000000
> > [ 4416.913734] x11: 0000000000001000 x10: 0000000000001000
> > [ 4416.929176] x9 : ffffffff20d1f5c7 x8 : 0000000000000000
> > [ 4416.929178] x7 : 626d7464ff286b6b x6 : ffffffc019533ade
> > [ 4416.929179] x5 : 000000008049000e x4 : ffffffff2793e9e0
> > [ 4416.929180] x3 : 000000008049000e x2 : ffffff89ecfa74d0
> > [ 4416.929181] x1 : 0000000000000c40 x0 : ffffffff2076f9c0
> > [ 4416.929184] Call trace:
> > [ 4416.929187]  fsverity_verify_page+0x20/0x78
> > [ 4416.929189]  f2fs_verify_bio+0x11c/0x29c
> > [ 4416.929192]  f2fs_verity_work+0x58/0x84
> > [ 4417.050667]  process_one_work+0x270/0x47c
> > [ 4417.055354]  worker_thread+0x27c/0x4d8
> > [ 4417.059784]  kthread+0x13c/0x320
> > [ 4417.063693]  ret_from_fork+0x10/0x18
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v3: back to v1 and enabled verity in a unit of cluster
> > v2: merged verity_pages with pending_pages, and increased the
> >     pending_pages count only if STEP_VERITY is set on bio
>
> I am trying to review this but it is very hard, as the f2fs compression c=
ode is
> very hard to understand.
>
> It looks like a 'struct decompress_io_ctx' represents the work to decompr=
ess a
> particular cluster.  Since the compressed data of the cluster can be read=
 using
> multiple bios, there is a reference count of how many pages are remaining=
 to be
> read before all the cluster's pages have been read and decompression can =
start.
>
> What I don't understand is why that reference counting needs to work diff=
erently
> depending on whether verity is enabled or not.  Shouldn't it be exactly t=
he
> same?
>
> There also seems to be some confusion about the scope of STEP_VERITY.  Be=
fore
> f2fs compression was added, it was a per-bio thing.  But now in a compres=
sed
> file, it's really a per-cluster thing, since all decompressed pages in a
> compressed cluster are verified (or not verified) at once.
>
> Wouldn't it make a lot more sense to, when a cluster needs both compressi=
on and
> verity, *not* set STEP_VERITY on the bios, but rather set a similar flag =
in the
> decompress_io_ctx?
>
> - Eric
