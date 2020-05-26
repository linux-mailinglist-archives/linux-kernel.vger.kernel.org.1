Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259BA1B3999
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDVIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 04:07:56 -0400
Received: from verein.lst.de ([213.95.11.211]:50856 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVIH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:07:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F9E268C4E; Wed, 22 Apr 2020 10:07:53 +0200 (CEST)
Date:   Wed, 22 Apr 2020 10:07:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
Message-ID: <20200422080752.GA24916@lst.de>
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-5-maco@android.com> <20200422061919.GA22819@lst.de> <CAB0TPYHCHytLouWSpwKvi3qpZCzAYhuEot9y+ssnE8vDGgtQpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYHCHytLouWSpwKvi3qpZCzAYhuEot9y+ssnE8vDGgtQpg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:06:17AM +0200, Martijn Coenen wrote:
> > line at the top of lo_compat_ioctl, and switches the LOOP_SET_STATUS
> > and LOOP_GET_STATUS case to it?
> 
> Did you mean in regular lo_ioctl()?

Yes, sorry.

> eg something like this:
> 
> @@ -1671,6 +1671,7 @@ static int lo_ioctl(struct block_device *bdev,
> fmode_t mode,
>         unsigned int cmd, unsigned long arg)
>  {
>         struct loop_device *lo = bdev->bd_disk->private_data;
> +       void __user *argp = (void __user *) arg;
>         int err;
> 
>         switch (cmd) {
> @@ -1694,21 +1695,19 @@ static int lo_ioctl(struct block_device *bdev,
> fmode_t mode,
>         case LOOP_SET_STATUS:
>                 err = -EPERM;
>                 if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
> -                       err = loop_set_status_old(lo,
> -                                       (struct loop_info __user *)arg);
> +                       err = loop_set_status_old(lo, argp);
>                 }
>                 break;
>         case LOOP_GET_STATUS:
> -               return loop_get_status_old(lo, (struct loop_info __user *) arg);
> +               return loop_get_status_old(lo, argp);
>         case LOOP_SET_STATUS64:
>                 err = -EPERM;
>                 if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
> -                       err = loop_set_status64(lo,
> -                                       (struct loop_info64 __user *) arg);
> +                       err = loop_set_status64(lo, argp);
>                 }
>                 break;
>         case LOOP_GET_STATUS64:
> -               return loop_get_status64(lo, (struct loop_info64 __user *) arg);
> +               return loop_get_status64(lo, argp);

Exactly!
