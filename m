Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8525E28B590
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbgJLNKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388684AbgJLNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:10:08 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3876C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:10:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d20so17576763iop.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XlKFYoGp/9Yp1zRFm8Sy327KOHtLJ5llMoPdKvcscA=;
        b=jAGHmTf5Nduq/fQUv+4nxjuTCU+LwWMr13IeDChxgwAclrtAvqi8ibY6kOF/HkeCAy
         LJ0Dtm0wZ5876fZRWreg6cYHCGlR3RjiSEIme4jwJt2JykPyxOmQAYETSMpdJMVE7s6J
         Dnw2y5HbsWr6nN3fpKAG3nzdiPtIo4eWlKF91vunAMAir8/dsVHdavzNYX3znB14XWdr
         JNAJnFXxXoDy3fXAI/pQeEMcSk5ozcgC5wiXd0136HcmPZNk4V483t43ETquo8uAQ8SB
         sLn/T521yuk7OPnqBI6DIHN4cnZFk/JwexylrdOYCsXwrVuaVLh2rI4XJ3TcakJtH3cu
         E7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XlKFYoGp/9Yp1zRFm8Sy327KOHtLJ5llMoPdKvcscA=;
        b=kCDP6lYpt76n9hhL2pV26PY4Zv90oI1LBPthRIcCPfH6C3oFesro/zl2KeFp+gSo9+
         S55MDywzqRIZlTHpFpjGx3/xzf+5xoycA4m/lTaZfuHXmxWWi4tHU4umWtP8Zllbb1gY
         aLCB/hbZxtVT51+2Omv24YFGX9beSGOlZ+6++Pkt/lcHKgLY9bZI5voNkepFydBXM5hZ
         z53BYR1s7u0OcIPr3jP7FUEm4n2mT9F163Gy194HveYaluq4DtbZG94Ew0JlQPsk1O7j
         RyXfaBlzUkiBmJ9mePMoQvI0UhheSE+oSBTaQHQWZw/V9bXqVPb0A5QSSTYc2MmSeYdr
         MLcg==
X-Gm-Message-State: AOAM533P4BpyZlWBPH49C718c5AvNAXYnJQ+zvNc5lRCcjb9ltbdZlsZ
        nH3uI64bsiRKCJLqYhkS8/zxmI5ouNiqxeMYpoM=
X-Google-Smtp-Source: ABdhPJyQX7B4TigMLUeL1CeyT+6EMpdx6Rpju+B9FjFdQ94a5CEIxfd6w/uYgD7lIAfCV9OVGN8pV8heZnZB3F9w6h8=
X-Received: by 2002:a5d:8b4c:: with SMTP id c12mr16754244iot.167.1602508207125;
 Mon, 12 Oct 2020 06:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-5-david@redhat.com>
In-Reply-To: <20201012125323.17509-5-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 12 Oct 2020 15:09:55 +0200
Message-ID: <CAM9Jb+jf3DJiXmS-fnkZ6cfdw7AhPsusWiYM=XMwBD0L=yephA@mail.gmail.com>
Subject: Re: [PATCH v1 04/29] virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 78c2fbcddcf8..b3eebac7191f 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1072,7 +1072,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
>                                       uint64_t *nb_sb)
>  {
>         const int count = min_t(int, *nb_sb, vm->nb_sb_per_mb);
> -       int rc, rc2;
> +       int rc;
>
>         if (WARN_ON_ONCE(!count))
>                 return -EINVAL;
> @@ -1103,13 +1103,12 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
>
>                 dev_err(&vm->vdev->dev,
>                         "adding memory block %lu failed with %d\n", mb_id, rc);
> -               rc2 = virtio_mem_mb_unplug_sb(vm, mb_id, 0, count);
>
>                 /*
>                  * TODO: Linux MM does not properly clean up yet in all cases
>                  * where adding of memory failed - especially on -ENOMEM.
>                  */
> -               if (rc2)
> +               if (virtio_mem_mb_unplug_sb(vm, mb_id, 0, count))
>                         new_state = VIRTIO_MEM_MB_STATE_PLUGGED;
>                 virtio_mem_mb_set_state(vm, mb_id, new_state);
>                 return rc;

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
