Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A495F28FA24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgJOUc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgJOUc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:32:58 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:32:58 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so654600ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UuaZCG0RzTs04L19UEluVRlq/xv2kVQVGIWnW70Exw=;
        b=UNA3eGGdz9O8c35Ncwsge93DMvzAEgXk+yCzq/AMDwOyyRlbUsTz09fLF9bGomvjH9
         UMVTzTZkb/fix7hDLVfK2cJpbAMjBAMeqM/kh98L4S0ZU37aiZ0YGBNSroOlVNox1J7k
         a+vKRakG9WH0jonuHsC2Jp1cxXXrojDzm1PhQUgk1zaRiFDG8ouzyoWCD2nJXttn0Og0
         2mx7sAAXVUPBYzRRzDoAA9CrU0w9OUkR/xBvnBcYkti/IBWjcID8LCo9HrHEbeQTKl/c
         pBrJFRZyQHXe3A1RZKYW+/aR1TZAc8l5j0pnm3VYu/xRDUotXJmUDLVq99rD9IPic/P9
         AE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UuaZCG0RzTs04L19UEluVRlq/xv2kVQVGIWnW70Exw=;
        b=kJTNi2ehrhUM99f+J7JKD2nEj0CBjgXxF1EyNuGxspQzUEZ041gSzuFqw+MCD8jl0C
         wUjZkc5VMKRfORtSPiPYWlO0Gf/K02anCXu3QMDQMpLCKEtTGkuA3kVDgmq0MHI3gzgE
         jNw6BsOjTy6991juKa9tYzeQ26LSct5O8ENurSDA0Pplay234k8UPnWutWdU4AuJQITh
         jd6Hlb4ZvgA79qRvDrkREAS30dkAlfJVB/NGN9kyrmrmQ1Az1toIzZ9zWeKpytoMuGSn
         Gm1Lcer2BwqNZt/mW1k16KWEyA45/iXXbdP9S28Ryj+uDHx7S3m1NuEtZaDVZfTunZBL
         HNOg==
X-Gm-Message-State: AOAM530OgX+fqhLiWpKOAFi/KHZEmwYt3Pu2rucv5uIlekYJ8Vhd8Rau
        5cSGJQqJ2z9/fEDLKDGkJt6Mn+3lmuRJx/ppSrI=
X-Google-Smtp-Source: ABdhPJyUmqALg6nJxV0NgpZfeJh95CDs6oTknMh8p5x7vaYQV+8mAaDHPdzP7BYpxEF4rHkqjzPG2HBIY8vDCbPbHXw=
X-Received: by 2002:a02:94cd:: with SMTP id x71mr141770jah.124.1602793977745;
 Thu, 15 Oct 2020 13:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-9-david@redhat.com>
In-Reply-To: <20201012125323.17509-9-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 15 Oct 2020 22:32:46 +0200
Message-ID: <CAM9Jb+gFAJh95JtFPse-4rNjabY9nS_OaN2WjbnDixTFSvAX1g@mail.gmail.com>
Subject: Re: [PATCH v1 08/29] virtio-mem: drop last_mb_id
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

> No longer used, let's drop it.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 37a0e338ae4a..5c93f8a65eba 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -84,8 +84,6 @@ struct virtio_mem {
>
>         /* Id of the first memory block of this device. */
>         unsigned long first_mb_id;
> -       /* Id of the last memory block of this device. */
> -       unsigned long last_mb_id;
>         /* Id of the last usable memory block of this device. */
>         unsigned long last_usable_mb_id;
>         /* Id of the next memory bock to prepare when needed. */
> @@ -1689,8 +1687,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
>         vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
>                                                    memory_block_size_bytes());
>         vm->next_mb_id = vm->first_mb_id;
> -       vm->last_mb_id = virtio_mem_phys_to_mb_id(vm->addr +
> -                        vm->region_size) - 1;
>
>         dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>         dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
