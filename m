Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE107274591
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIVPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:41:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0DCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:41:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q4so17725308ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PICW45X2iQWdtbXa7gacJOqYVJoHuDx6Nq+BthDfr08=;
        b=cUWkNllNiT01w6KswNUIrMY0Ct2ce+aDlWti5eWIA0GThp85hQmKbgPojFrqQVoF7X
         qrlLif2XyP0gCtEhA+weYIx7wDPiX7wpEuggUdNyPHPFg4zjyS/ICP1p8vo+5UawBDRv
         vZXp2VYviRupP+rze4FG74KuBSzlDK+e1fqID+LmtlXapwhZv3TVcjau5VUyeO06oGw6
         ltKr/rn6ZTvhpMWANx3G0iDJ59c/EDoj+gIcntoDiRuN67odfu/1fjtqD5kFAz7hzgMX
         f1aYnYmPG4kDMnH3HrJsKMapMTmpkXUwsspyaK464J9eW2AXhGMR36Myv86RCmBjydeG
         BFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PICW45X2iQWdtbXa7gacJOqYVJoHuDx6Nq+BthDfr08=;
        b=aDuzTbV3Jq46d5IFwoUTV7+mG7Bb+s+pZC3V3jm2OPJVQoeCW0FTyLyb+3xyb2eX8R
         l+kXSlzFMuyNpLcWHSfYtIxUookUmsPa6z7j7rq9iCznuxX6LhN1f+G7bbn7AqlIUEbQ
         4dCa/wJcwCEs2oak4E+jDpnH8tESfPOL1UwVaYOr3v7plcCcpZOLUNNKY0JKhVRUNmPn
         wqX5k9kU0+rmobnTysqWH9K/5VUf+LHEpm1xIS2yhbTZb7pNA2Fh4piUl15N0qMojCgz
         aP7MKfL4GhqiQ6Ls3h4B7xSfvbM2kCAhknxtm1+tshJs0nanW7BR59Q8VAWDZ3sYe+x+
         a02A==
X-Gm-Message-State: AOAM533oUjDUuHHxJaWhyVJ9pvnhMtFHG/V1Uzp2wipcfIdDduw9obBc
        MWvinZlIDqQkZJvD8vGq7lI38p1SY4bgtBrZBvU=
X-Google-Smtp-Source: ABdhPJw6NV2OLpOjxnlDuvVs4PRyGAuozfr94GsaYzpcXqGEVxRWzcos8yTKxdBFVCriWw5f9l0B1WN9LxK4cXGgNp4=
X-Received: by 2002:a92:aa01:: with SMTP id j1mr5068011ili.301.1600789267967;
 Tue, 22 Sep 2020 08:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com> <20200922135956.GA23437@lst.de>
In-Reply-To: <20200922135956.GA23437@lst.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 22 Sep 2020 11:40:56 -0400
Message-ID: <CAA5qM4DvFdQ_yvkGERyNjar7EJkcRmR5ry9BiuPaZkEzzO=Mug@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Christoph.
I will do some testing with my setup and let you know.
- Tong

On Tue, Sep 22, 2020 at 9:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Tong,
>
> can you test this patch?
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 99c64641c3148c..6473ae703789e4 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -836,6 +836,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>          * so that it sticks around as long as @disk is there.
>          */
>         WARN_ON_ONCE(!blk_get_queue(disk->queue));
> +       disk->flags |= GENHD_FL_QUEUE_REF;
>
>         disk_add_events(disk);
>         blk_integrity_add(disk);
> @@ -1567,7 +1568,7 @@ static void disk_release(struct device *dev)
>         kfree(disk->random);
>         disk_replace_part_tbl(disk, NULL);
>         hd_free_part(&disk->part0);
> -       if (disk->queue)
> +       if (disk->flags & GENHD_FL_QUEUE_REF)
>                 blk_put_queue(disk->queue);
>         kfree(disk);
>  }
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 4ab853461dff25..9441077ee10329 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -135,6 +135,7 @@ struct hd_struct {
>  #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE    0x0100
>  #define GENHD_FL_NO_PART_SCAN                  0x0200
>  #define GENHD_FL_HIDDEN                                0x0400
> +#define GENHD_FL_QUEUE_REF                     0x0800
>
>  enum {
>         DISK_EVENT_MEDIA_CHANGE                 = 1 << 0, /* media changed */
