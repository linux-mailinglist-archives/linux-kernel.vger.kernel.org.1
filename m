Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DB1B3995
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVIGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgDVIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:06:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E226C03C1A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:06:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 198so870222lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEZIDpjrA4Byv+o6rKG8EfK4lArv5Q0+XiEhKNnlXLI=;
        b=piq02+4Lm8IkqtgEdUddp51ekLNm+Y2LSTs2iaye5o4u20Cm4LJenW0fh57JJ7IPvi
         OT0qKEHpycmOhF8l0+4uvWdZxkiMhoZBbVCLaUjyqpC0OmXl4F7fulUNEZv5xIEh3aAn
         4FWZbcEOSC0PXhztBHogogh5KDUMCJSCFN8tkaejkz35S2jmHltntmfmTbZMKSHzWsC0
         cFIQ5zt6rVjyNZVnAp2chW2f1i58dfNNHEPZsaVEkNybzdZ6KIh8yprOPUCzKtTxePau
         82XNuO9RngO9J8lndLNccDoIlra7pzZwhTkOOnZ7SCOYcNq6hylCoe8lU4KrdaHKRQ1h
         wVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEZIDpjrA4Byv+o6rKG8EfK4lArv5Q0+XiEhKNnlXLI=;
        b=SGeSUCOKIanYrYG5xTrqXCQ/vXrN+V0NN8WM/2xico+PLzH7ddqOAWlPcsy2qs/kPg
         ZE/4VCePuTETZAPr9ElYc4zTYmdpFBdrY2U5BsWxx3AhrOrpNyFbbNRnyH+Zp1CPKkOb
         K1BHr4VMi3g4RxDCin3As0gpv7iNslzUAS4/Hsz+vBIojbM+VuUlD1SZTGZgJK9RD6EH
         wzqMo7twsbgr6EHi0MidDgbdOEnbWVCQEaCvnHQz7z9ZWSgu0GWUTkoj4D0ahks/FupM
         8HRNg6bWLW3cDg7xGY14LM8lyi9uNNXpbDuWNu6QUXujpPOrtP4UWXm7KfgruOlmFGmN
         383A==
X-Gm-Message-State: AGi0Puao0ccCNKQ7JtdF7lgJk18g/7uYlV+fx3Rg64/1nwhSja1obIIj
        g8uw58wlW0goz5etVaao+J8Jv52HBbzmKsf5wuGICQ==
X-Google-Smtp-Source: APiQypL0HFsogpEBuECdthW7Q4KmhEMNxg+4kGdsqP7hqJi9hEpSTaBjeEL0m5d/vfh2zAv50vtVSIhWI6T9R7wQi9Q=
X-Received: by 2002:ac2:58d7:: with SMTP id u23mr16482250lfo.182.1587542788616;
 Wed, 22 Apr 2020 01:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-5-maco@android.com>
 <20200422061919.GA22819@lst.de>
In-Reply-To: <20200422061919.GA22819@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 22 Apr 2020 10:06:17 +0200
Message-ID: <CAB0TPYHCHytLouWSpwKvi3qpZCzAYhuEot9y+ssnE8vDGgtQpg@mail.gmail.com>
Subject: Re: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 8:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Apr 20, 2020 at 10:04:09AM +0200, Martijn Coenen wrote:
> > This allows userspace to completely setup a loop device with a single
> > ioctl, removing the in-between state where the device can be partially
> > configured - eg the loop device has a backing file associated with it,
> > but is reading from the wrong offset.
> >
> > Besides removing the intermediate state, another big benefit of this
> > ioctl is that LOOP_SET_STATUS can be slow; the main reason for this
> > slowness is that LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to
> > freeze the associated queue; this requires waiting for RCU
> > synchronization, which I've measured can take about 15-20ms on this
> > device on average.
> >
> > Here's setting up ~70 regular loop devices with an offset on an x86
> > Android device, using LOOP_SET_FD and LOOP_SET_STATUS:
> >
> > vsoc_x86:/system/apex # time for i in `seq 30 100`;
> > do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
> >     0m03.40s real     0m00.02s user     0m00.03s system
> >
> > Here's configuring ~70 devices in the same way, but using a modified
> > losetup that uses the new LOOP_SET_FD_AND_STATUS ioctl:
> >
> > vsoc_x86:/system/apex # time for i in `seq 30 100`;
> > do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
> >     0m01.94s real     0m00.01s user     0m00.01s system
> >
> > Signed-off-by: Martijn Coenen <maco@android.com>
> > ---
> >  drivers/block/loop.c      | 47 ++++++++++++++++++++++++++++++---------
> >  include/uapi/linux/loop.h |  6 +++++
> >  2 files changed, 42 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 6e656390b285..e1dbd70d6d6e 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1065,8 +1065,9 @@ loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
> >       return 0;
> >  }
> >
> > -static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> > -                    struct block_device *bdev, unsigned int arg)
> > +static int loop_set_fd_and_status(struct loop_device *lo, fmode_t mode,
> > +                               struct block_device *bdev, unsigned int fd,
> > +                               const struct loop_info64 *info)
> >  {
> >       struct file     *file;
> >       struct inode    *inode;
> > @@ -1081,7 +1082,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> >       __module_get(THIS_MODULE);
> >
> >       error = -EBADF;
> > -     file = fget(arg);
> > +     file = fget(fd);
> >       if (!file)
> >               goto out;
> >
> > @@ -1090,7 +1091,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> >        * here to avoid changing device under exclusive owner.
> >        */
> >       if (!(mode & FMODE_EXCL)) {
> > -             claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
> > +             claimed_bdev = bd_start_claiming(bdev, loop_set_fd_and_status);
> >               if (IS_ERR(claimed_bdev)) {
> >                       error = PTR_ERR(claimed_bdev);
> >                       goto out_putf;
> > @@ -1117,9 +1118,24 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> >               lo_flags |= LO_FLAGS_READ_ONLY;
> >
> >       error = -EFBIG;
> > -     size = get_loop_size(lo, file);
> > +     if (info)
> > +             size = get_size(info->lo_offset, info->lo_sizelimit,
> > +                             file);
> > +     else
> > +             size = get_loop_size(lo, file);
> >       if ((loff_t)(sector_t)size != size)
> >               goto out_unlock;
> > +
> > +     if (info) {
> > +             error = loop_set_from_status(lo, info);
> > +             if (error)
> > +                     goto out_unlock;
> > +     } else {
> > +             lo->transfer = NULL;
> > +             lo->ioctl = NULL;
> > +             lo->lo_sizelimit = 0;
> > +             lo->lo_offset = 0;
> > +     }
>
> Just curious:  Can't we just pass in an on-stack info for the legacy
> case and avoid all these conditionals?

Yeah, that is actually much nicer. I will rework it to that.

> Can you throw in another prep patch that adds a:
>
>         void __user *argp = (void __user *)arg;
>
> line at the top of lo_compat_ioctl, and switches the LOOP_SET_STATUS
> and LOOP_GET_STATUS case to it?

Did you mean in regular lo_ioctl()? eg something like this:

@@ -1671,6 +1671,7 @@ static int lo_ioctl(struct block_device *bdev,
fmode_t mode,
        unsigned int cmd, unsigned long arg)
 {
        struct loop_device *lo = bdev->bd_disk->private_data;
+       void __user *argp = (void __user *) arg;
        int err;

        switch (cmd) {
@@ -1694,21 +1695,19 @@ static int lo_ioctl(struct block_device *bdev,
fmode_t mode,
        case LOOP_SET_STATUS:
                err = -EPERM;
                if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-                       err = loop_set_status_old(lo,
-                                       (struct loop_info __user *)arg);
+                       err = loop_set_status_old(lo, argp);
                }
                break;
        case LOOP_GET_STATUS:
-               return loop_get_status_old(lo, (struct loop_info __user *) arg);
+               return loop_get_status_old(lo, argp);
        case LOOP_SET_STATUS64:
                err = -EPERM;
                if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-                       err = loop_set_status64(lo,
-                                       (struct loop_info64 __user *) arg);
+                       err = loop_set_status64(lo, argp);
                }
                break;
        case LOOP_GET_STATUS64:
-               return loop_get_status64(lo, (struct loop_info64 __user *) arg);
+               return loop_get_status64(lo, argp);


> > +struct loop_fd_and_status {
> > +     struct loop_info64      info;
> > +     __u32                   fd;
>
> This should grow a
>
>         __u32   __pad;
>
> to avoid different struct sizes on x86-32 vs x86-64.

will do, thanks!
