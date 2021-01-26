Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC33E30405E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392770AbhAZOcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391938AbhAZOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:30:46 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD6C0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:30:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g1so19999327edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=US8a/kB/55AFjkFFf4UVOg+wWSaZCuyXBjpUsvs+feI=;
        b=lpn4V6P0eE+FY6dqw/ysEzqC/coXbO5OV+4q6B/Z9DSxXvvF6hCV9twibOZb1hb3IZ
         uW/yUXid/E3Rk1HIzRWfV2D7+/Xo2SUX0FegjPS8XW++udkKwsIBtDBkf1P7XwGo29w5
         c20hEJI7NzNoZDg6BZ+CjioEVbqz1EEd9wQzkq1112iJEvNEG2gusx7NH5JmQvppOaHf
         E0/rX+x3fA6eN98/fX4WqYDyYJ3UOmE3faZh3LO7XWLRQkXIac7Gv82w7Jwl+T5Xx9sn
         cT7VIwZ58SnAzZxfhQPpWrFsuBiY/NNoeoxP/9lDqnJbcRqiDXx1k293FX7j7G4IkYNz
         HngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=US8a/kB/55AFjkFFf4UVOg+wWSaZCuyXBjpUsvs+feI=;
        b=hoiiojjirZIYJ+0BQIQgOpYu/X3kfwyTWms2I5PKaswG509px8TeWlYY0yyaYs2Qei
         p8yVO+JS37/bFUi0zGLAXtS0ySPV7CZtMJYwuAoOL+whvBMRZfbUJWfnw0ylZyNMHMgs
         0Odq50g05rf2Or1Ix3oaMIwu0i1z8NCdgL2+SXwMKYDh8x5rIs2MvQERY4GtDqv+3dTC
         ldL7BoKabZjSEUfNGJiSK60HVgW5h2rxVxw3q+7adYhlUq7mm3EEBTidw257JMwlScVz
         GlerDq5dza6pw84qaAk7gtMdKicmPO1272JspS3OKa2qLAtlX2Ojzjgj8nB02lGSrbRW
         DbJg==
X-Gm-Message-State: AOAM532o6iC13XYvNVDMSEvVGW3zgvrXZtskJCnZSg63JqMtONHFuOGP
        W+g6M602CN1UFPIB7ihKJHA1gtDJrRMrnKheRrLVVg==
X-Google-Smtp-Source: ABdhPJz0ls97OG8+OSmc9t5sQKWLr7rZ0A9Jbf5tTkXRc1iBOLXK3fdIESF/F71aZUt8OTnFhumnht6dZlyx93lBEF4=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr4667824edq.153.1611671404169;
 Tue, 26 Jan 2021 06:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
 <20210125201156.1330164-2-pasha.tatashin@soleen.com> <BYAPR04MB4965A6FB4ED51882E326EC1A86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965A6FB4ED51882E326EC1A86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Jan 2021 09:29:28 -0500
Message-ID: <CA+CK2bAQcGPYtbGziyRpzTRQ8WCLsvM2DmFYLwDRMXMX6U38+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] loop: scale loop device by introducing per device lock
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "hch@lst.de" <hch@lst.de>, "pvorel@suse.cz" <pvorel@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "zhengbin13@huawei.com" <zhengbin13@huawei.com>,
        "maco@android.com" <maco@android.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 4:53 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 1/25/21 12:15 PM, Pavel Tatashin wrote:
> > Currently, loop device has only one global lock:
> > loop_ctl_mutex.
> Above line can be :-
> Currently, loop device has only one global lock: loop_ctl_mutex.

OK

>
> Also please provide a complete discretion what are the members it protects,
> i.e. how big the size of the current locking is, helps the reviewers &
> maintainer.

Sure

> > This becomes hot in scenarios where many loop devices are used.
> >
> > Scale it by introducing per-device lock: lo_mutex that protects the
> > fields in struct loop_device. Keep loop_ctl_mutex to protect global
> > data such as loop_index_idr, loop_lookup, loop_add.
> When it comes to scaling, lockstat data is more descriptive and useful along
> with thetotal time of execution which has contention numbers with increasing
> number of threads/devices/users on logarithmic scale, at-least that is
> how I've
> solved the some of file-systems scaling issues in the past.

I found this issue using perf that shows profiling. I've previously
used lockstat, it is indeed a good tool to work with lock contentions.

> >
> > Lock ordering: loop_ctl_mutex > lo_mutex.
> The above statement needs a in-detail commit log description. Usually >
> sort of statements are not a good practice for something as important as
> lock priority which was not present in the original code.

OK, I will expand this to clearly state that new lock ordering
requirement is that loop_ctl_mutex must be taken before lo_mutex.

> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/block/loop.c | 92 +++++++++++++++++++++++++-------------------
> >
> >
> >
> >       /*
> > -      * Need not hold loop_ctl_mutex to fput backing file.
> > -      * Calling fput holding loop_ctl_mutex triggers a circular
> > +      * Need not hold lo_mutex to fput backing file.
> > +      * Calling fput holding lo_mutex triggers a circular
> >        * lock dependency possibility warning as fput can take
> > -      * bd_mutex which is usually taken before loop_ctl_mutex.
> > +      * bd_mutex which is usually taken before lo_mutex.
> >        */
> This is not in your patch, but since you are touching this comment can you
> please consider this, it save an entire line and the wasted space:-

OK

>        /*
>         * Need not hold lo_mutex to fput backing file. Calling fput holding
>         * lo_mutex triggers a circular lock dependency possibility
> warning as
>         * fput can take bd_mutex which is usually take before lo_mutex.
>         */
>
> > @@ -1879,27 +1879,33 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
> >       struct loop_device *lo;
> >       int err;
> >
> > +     /*
> > +      * take loop_ctl_mutex to protect lo pointer from race with
> > +      * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce
> > +      * contention release it prior to updating lo->lo_refcnt.
> > +      */
>
> The above comment could be :-
>
>         /*
>          * Take loop_ctl_mutex to protect lo pointer from race with
>          * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce
> contention
>          * release it prior to updating lo->lo_refcnt.
>          */

OK

> >       err = mutex_lock_killable(&loop_ctl_mutex);
> >       if (err)

I will send an updated patch soon.

Thank you,
Pasha
