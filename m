Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D598C28FA20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbgJOUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgJOUaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:30:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:30:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y16so6260465ila.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jxSiXUFHPKoVWvB4Kho7bLX6BXoNLesB/In+yGJN0M=;
        b=m6ii6kwgw2MTT+gIs1qNafQgE+1wC+HcGAAG5DVQ5N3c3MvWoIXwbtkLrgEcdSgU0l
         cSfpLzmsmliwsAlSTufVFgaFTuvLQUpxLV4emLR/kOzjLAQ5hmhKZOeJsXwwdxtXlOgS
         0TkZmDN3hxDZfKMgysOzQzhim1wrGGbaPvEhOtFYO4Ty6Orh+Ze0lHxl7/XoSWBSs1HY
         +2vxlJbtwJUYtT2unuAe5so9kivgiAD0exdzlHNc9wcNnlv8K+3adk5y7C1N0sUz2yM3
         Fgodn3vHy8t6uW/pyIjWMYNgGM11tmEJ2q4iTfDBaeS7izoo39dvGzZSqBJ4vlOjlLeQ
         8/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jxSiXUFHPKoVWvB4Kho7bLX6BXoNLesB/In+yGJN0M=;
        b=qbVkzB2Tc6k+9NJQNoq6aGbf8J/y9Oqaa9FN4WJW2MRAtn/t0bFgbkjHXWPPKSzdpI
         unqkQQP6EwQyd+ZCci10qagAPrLJ5NAJumi3lzlr5/UvLzfSr5JStOaHADyjbR6cbY9P
         25bYmFODo1PfiS5M66x8KuF9FPFjdoMsv/vFAE4eYWmuuQT/PY+FZsWGF0gZPt/P8cDL
         LY7c//hUQ404IUX3wdkJy0GbmFqI9TosQtxdYQ8CeQDhU4SPg43LfWHqhB1oFBO887NB
         e595anj9j5tV/Af7Ys0NTiz6c7kWNlCPkZedruuGjNQb35V8qM1Vpp0kpY6qDIgNY26r
         EYyA==
X-Gm-Message-State: AOAM5335bvWrNOAV9d9YKKy1NRCUmYDN4q47P8zlyiTKPbCu4eQl3XHH
        OgPemeYBJ90IEClgIGPlJLo3RQhswdsEScvRaYs=
X-Google-Smtp-Source: ABdhPJxrvvur8NSNW89vwNQf2R2zgjfbt7aEEQH/uFDV4MhjdyOqjUYvpc8A3zFlbMc353x3cPkxpQ8F04dofE3zYAQ=
X-Received: by 2002:a92:874a:: with SMTP id d10mr274971ilm.163.1602793820977;
 Thu, 15 Oct 2020 13:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-7-david@redhat.com>
In-Reply-To: <20201012125323.17509-7-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 15 Oct 2020 22:30:09 +0200
Message-ID: <CAM9Jb+jY-kzPbbqTaYY=i1tjo=fEH0w_8kik17h90gH6ROso_w@mail.gmail.com>
Subject: Re: [PATCH v1 06/29] virtio-mem: generalize virtio_mem_owned_mb()
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

> Avoid using memory block ids. Rename it to virtio_mem_contains_range().
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 6bbd1cfd10d3..821143db14fe 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -500,12 +500,13 @@ static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
>  }
>
>  /*
> - * Test if a virtio-mem device owns a memory block. Can be called from
> + * Test if a virtio-mem device contains a given range. Can be called from
>   * (notifier) callbacks lockless.
>   */
> -static bool virtio_mem_owned_mb(struct virtio_mem *vm, unsigned long mb_id)
> +static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
> +                                     uint64_t size)
>  {
> -       return mb_id >= vm->first_mb_id && mb_id <= vm->last_mb_id;
> +       return start >= vm->addr && start + size <= vm->addr + vm->region_size;
>  }
>
>  static int virtio_mem_notify_going_online(struct virtio_mem *vm,
> @@ -800,7 +801,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
>          */
>         rcu_read_lock();
>         list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
> -               if (!virtio_mem_owned_mb(vm, mb_id))
> +               if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
>                         continue;
>
>                 sb_id = virtio_mem_phys_to_sb_id(vm, addr);

Looks good.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
