Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391322937ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392766AbgJTJW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391402AbgJTJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:22:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:22:56 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g7so1282134ilr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWmw1NV7gbWNc2BoUTFwu8FGKZUBcJpPXw0NA4jr4Bk=;
        b=EDKxuR4EF785e5FhWc5bAAo35H3YMcr75neMvBR5SA6OpTLU2UxaqTvB+dzjheFuUY
         nSSCIdMUg7u2EmPyHfEHbo/cPxAuyDUZs7GJXMkSjGh4pj4RIw3jnWZ1v2vGeFS9PYpQ
         qHvuMAe2n+UHlnsZCBRMqLyqlrP4Lfu8fcUNdFoB5VwXEooCom3oAO5jcYK9PwS8lCNk
         L3U2o6TFqod2uOs9IcWezcd1bB78LvJKEllgAHnBtVQFJV2qwIMtwANCOJ4AXlnyqxHI
         i2XJSXhDYZAG08oos6LHJxlMq29f+GB+Wn7Z+ydeeGurwT6JunzkwQ4f8ANe0qwONtpV
         9FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWmw1NV7gbWNc2BoUTFwu8FGKZUBcJpPXw0NA4jr4Bk=;
        b=hsACK/R2tLvYLk6gE7h4gbzj9g937Ss7fYsiFufmRKliTwN/5PdougUEMDyMjTwLrD
         KwN8L+LnpbvxfgccBmXdzVJRN+1+rhvHijiIcNkItfcXPTlx8URcf3A4anT/qmuPvSAs
         S11DJ5slXshK515t51NOXGN1xYed533MZZXhvsB/Gae5eATZxttpYu8XLpDu5SF4EdDb
         e45YpxWAqv0q09n1pAJOSN9UqkoYgy8nDMP3YNRzmONYhO1SKf168goAPKIUdnfy/EMw
         FzN2tfvIaFlV9XTaVthXCRnFNS0uOPWYESms9yKXYaXXa01s725keFufVzbCAsorY7IV
         wo3w==
X-Gm-Message-State: AOAM532v9F/zoQnlCiDTArcMWRXHUG7xtjPuvJ664sDPUQKnbL6o/kpd
        uLREW15ZpxlBnpNZ0in//8/H1EfAxWRdcNbp0EY=
X-Google-Smtp-Source: ABdhPJxC+ot7T75FkO1+J7+MSBrDulfWIWZX0EZ1N+ymQwTAx7MbhOvrWo8aFRRXyJXXAYSqJ7JWigVNX8dWGt9hUYo=
X-Received: by 2002:a92:180b:: with SMTP id 11mr1207045ily.89.1603185775910;
 Tue, 20 Oct 2020 02:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-8-david@redhat.com>
In-Reply-To: <20201012125323.17509-8-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 20 Oct 2020 11:22:45 +0200
Message-ID: <CAM9Jb+iiLy-7BB7J3S2yiEhWpn1VxKG_VuwGK82gq0+=8QvQKw@mail.gmail.com>
Subject: Re: [PATCH v1 07/29] virtio-mem: generalize virtio_mem_overlaps_range()
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

> Avoid using memory block ids. While at it, use uint64_t for
> address/size.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 821143db14fe..37a0e338ae4a 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -489,14 +489,10 @@ static int virtio_mem_translate_node_id(struct virtio_mem *vm, uint16_t node_id)
>   * Test if a virtio-mem device overlaps with the given range. Can be called
>   * from (notifier) callbacks lockless.
>   */
> -static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
> -                                     unsigned long start, unsigned long size)
> +static bool virtio_mem_overlaps_range(struct virtio_mem *vm, uint64_t start,
> +                                     uint64_t size)
>  {
> -       unsigned long dev_start = virtio_mem_mb_id_to_phys(vm->first_mb_id);
> -       unsigned long dev_end = virtio_mem_mb_id_to_phys(vm->last_mb_id) +
> -                               memory_block_size_bytes();
> -
> -       return start < dev_end && dev_start < start + size;
> +       return start < vm->addr + vm->region_size && vm->addr < start + size;
>  }

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
