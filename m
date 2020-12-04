Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB172CEB7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLDJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLDJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:55:38 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:54:58 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v14so6858340lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W8F7nIfHFD15zJgSTuCi/95RE+49mBFthLKoPhgIDHs=;
        b=qkg6snpedeMoymtyfHbpiDsdqKa7nJNpDSOvGRpY+Y/GVyYl++EGpkXUiLXanBjGNz
         aVibN6cRp6dzCEJ3eAJQTKjyBMcJ6nLl3xm7PvTe44EDDfyVkGBgZMdTo70leGOA6OXb
         siOtGlpDOfIGpLMsSMPLivA9SpC7Qs98cHVgZ1feOziNyNKKShlfUgNP8XCx0rbyGTaP
         xJXNqfiP7uleOFyEW9ps7RExMevcNyTKwEt5AWL/tTd1IuabbBnNW1447XEEP+DIpwbH
         tpaO5WdVufB6Wm5w03dRIQXQPSJ0yUqZDIlTZMuygupHb12SyJ1oWpGiJl/L7P60Y8QP
         wsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W8F7nIfHFD15zJgSTuCi/95RE+49mBFthLKoPhgIDHs=;
        b=r9prkrsWdMML1h+zZw8REOE7Z4x6EdTjv/MMDIOSm77j9m51coVkG1bg3cid1svGYe
         jdGWimonywRS5uaHbrKO3aF+77LXmIiZKjMCFmgiUg1jQHP/7l5Sv6zMd0+t+Tn6oyma
         +PC8zjxSRsm/eMTR/uLzts1jqVSWthyIquT3LQYTDe0FzSY9fEB8/syN4F8M2/+Oriwc
         OF5v06eklFBUuyZEcdfJP8mSBGUTGQULcSBDBYYkEimEd3wb2rMS0OYb8ENnxFriYcba
         TylN7rqws/Y7uVqd8tCBdxyFm9bFTePrdqVyMETvPZUKyvtbWDif9muJD7p9FY6M6IIj
         YFsQ==
X-Gm-Message-State: AOAM531IQ8YzRtILtotOdRBtRtMIu8olpgJ9er+g/QRZoWhrPgkI0uvz
        APjDuqvWbgz0nVdxRl9njcJU2Eclj/MhsYm8amU=
X-Google-Smtp-Source: ABdhPJxyb0vgnPCgHJj/qixMeERnq7+hyRY2JeOEI4o7On1lpvw0+hWUFGNtcpBcx0qSL7yXY6iUX7ahPVKdchIDnfI=
X-Received: by 2002:a05:6512:3a6:: with SMTP id v6mr2825989lfp.90.1607075696750;
 Fri, 04 Dec 2020 01:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20201204072802.795397-1-daeho43@gmail.com> <680c5cbe-d570-b20d-f478-28acbefd8ef5@huawei.com>
 <CACOAw_xiW7ui-2g5LP8yR9kzUSg=MhGcFQ_09Aj-fYuOGZU4sA@mail.gmail.com>
In-Reply-To: <CACOAw_xiW7ui-2g5LP8yR9kzUSg=MhGcFQ_09Aj-fYuOGZU4sA@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 4 Dec 2020 18:54:45 +0900
Message-ID: <CACOAw_xbVdYcjbOT176qLvQrUvGDhBd4J4Dh0v+G18OWkbdWrA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix race of pending_pages in decompression
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I told, this patch has a bug. Ignore this one. So, I'm implementing
another one. :(

2020=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:50, D=
aeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> As I told, this patch has a bug. Ignore this one. So, I'm implementing an=
other one. :(
>
>
> 2020=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 5:04,=
 Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On 2020/12/4 15:28, Daeho Jeong wrote:
>> > From: Daeho Jeong <daehojeong@google.com>
>> >
>> > I found out f2fs_free_dic() is invoked in a wrong timing, but
>> > f2fs_verify_bio() still needed the dic info and it triggered the
>> > below kernel panic. It has been caused by the race condition of
>> > pending_pages value between decompression and verity logic, when
>> > the same compression cluster had been split in different bios.
>> > By split bios, f2fs_verify_bio() ended up with decreasing
>> > pending_pages value before it is reset to nr_cpages by
>> > f2fs_decompress_pages() and caused the kernel panic.
>> >
>> > [ 4416.564763] Unable to handle kernel NULL pointer dereference
>> >                 at virtual address 0000000000000000
>> > ...
>> > [ 4416.896016] Workqueue: fsverity_read_queue f2fs_verity_work
>> > [ 4416.908515] pc : fsverity_verify_page+0x20/0x78
>> > [ 4416.913721] lr : f2fs_verify_bio+0x11c/0x29c
>> > [ 4416.913722] sp : ffffffc019533cd0
>> > [ 4416.913723] x29: ffffffc019533cd0 x28: 0000000000000402
>> > [ 4416.913724] x27: 0000000000000001 x26: 0000000000000100
>> > [ 4416.913726] x25: 0000000000000001 x24: 0000000000000004
>> > [ 4416.913727] x23: 0000000000001000 x22: 0000000000000000
>> > [ 4416.913728] x21: 0000000000000000 x20: ffffffff2076f9c0
>> > [ 4416.913729] x19: ffffffff2076f9c0 x18: ffffff8a32380c30
>> > [ 4416.913731] x17: ffffffc01f966d97 x16: 0000000000000298
>> > [ 4416.913732] x15: 0000000000000000 x14: 0000000000000000
>> > [ 4416.913733] x13: f074faec89ffffff x12: 0000000000000000
>> > [ 4416.913734] x11: 0000000000001000 x10: 0000000000001000
>> > [ 4416.929176] x9 : ffffffff20d1f5c7 x8 : 0000000000000000
>> > [ 4416.929178] x7 : 626d7464ff286b6b x6 : ffffffc019533ade
>> > [ 4416.929179] x5 : 000000008049000e x4 : ffffffff2793e9e0
>> > [ 4416.929180] x3 : 000000008049000e x2 : ffffff89ecfa74d0
>> > [ 4416.929181] x1 : 0000000000000c40 x0 : ffffffff2076f9c0
>> > [ 4416.929184] Call trace:
>> > [ 4416.929187]  fsverity_verify_page+0x20/0x78
>> > [ 4416.929189]  f2fs_verify_bio+0x11c/0x29c
>> > [ 4416.929192]  f2fs_verity_work+0x58/0x84
>> > [ 4417.050667]  process_one_work+0x270/0x47c
>> > [ 4417.055354]  worker_thread+0x27c/0x4d8
>> > [ 4417.059784]  kthread+0x13c/0x320
>> > [ 4417.063693]  ret_from_fork+0x10/0x18
>> >
>> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
>> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> > ---
>> > v2: merged verity_pages with pending_pages, and increased the
>> >      pending_pages count only if STEP_VERITY is set on bio
>> > ---
>> >   fs/f2fs/compress.c | 2 --
>> >   fs/f2fs/data.c     | 2 ++
>> >   fs/f2fs/f2fs.h     | 2 +-
>> >   3 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> > index 87090da8693d..832b19986caf 100644
>> > --- a/fs/f2fs/compress.c
>> > +++ b/fs/f2fs/compress.c
>> > @@ -803,8 +803,6 @@ void f2fs_decompress_pages(struct bio *bio, struct=
 page *page, bool verity)
>> >       if (cops->destroy_decompress_ctx)
>> >               cops->destroy_decompress_ctx(dic);
>> >   out_free_dic:
>> > -     if (verity)
>> > -             atomic_set(&dic->pending_pages, dic->nr_cpages);
>> >       if (!verity)
>> >               f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
>> >                                                               ret, fal=
se);
>> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> > index 42254d3859c7..b825d63cabdd 100644
>> > --- a/fs/f2fs/data.c
>> > +++ b/fs/f2fs/data.c
>> > @@ -2290,6 +2290,8 @@ int f2fs_read_multi_pages(struct compress_ctx *c=
c, struct bio **bio_ret,
>> >               ctx =3D bio->bi_private;
>> >               if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
>> >                       ctx->enabled_steps |=3D 1 << STEP_DECOMPRESS;
>> > +             if (ctx->enabled_steps & (1 << STEP_VERITY))
>> > +                     atomic_inc(&dic->pending_pages);
>>
>> Hmm.. have a glance at this, then f2fs_decompress_pages() will always re=
turn due
>> to atomic_dec_return() is true? then f2fs_do_decompress_pages() will nev=
er be
>> called?
>>
>> atomic_inc(dic->verity_pages) here and atomic_dec(dic->verity_pages) in
>> f2fs_verify_bio()?
>>
>>         if (atomic_dec_return(dic->verity_pages))
>>                 continue;
>>
>> Thanks,
>>
>> >
>> >               inc_page_count(sbi, F2FS_RD_DATA);
>> >               f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
>> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> > index 94d16bde5e24..a9ee7921c7ec 100644
>> > --- a/fs/f2fs/f2fs.h
>> > +++ b/fs/f2fs/f2fs.h
>> > @@ -1340,7 +1340,7 @@ struct decompress_io_ctx {
>> >       struct compress_data *cbuf;     /* virtual mapped address on cpa=
ges */
>> >       size_t rlen;                    /* valid data length in rbuf */
>> >       size_t clen;                    /* valid data length in cbuf */
>> > -     atomic_t pending_pages;         /* in-flight compressed page cou=
nt */
>> > +     atomic_t pending_pages;         /* in-flight compressed + verity=
 page count */
>> >       bool failed;                    /* indicate IO error during deco=
mpression */
>> >       void *private;                  /* payload buffer for specified =
decompression algorithm */
>> >       void *private2;                 /* extra payload buffer */
>> >
