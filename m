Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D862728F963
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391524AbgJOT05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 15:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391516AbgJOT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 15:26:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDBC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:26:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so235301ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dW1tg7L5BntD7reoiX2N8eTRkAHKZdUfapCZZ+Vs1s=;
        b=ItWEqgS7kvOBWeDbXhkzGD4l2aEEChwnpVr6yeLSzC0/z3waEHc5tlrO43e1m665EZ
         i/hT/raaQQ+AgteFThMAcIzzgcKaOxBJP7LnVCsqs2psdy0ZKRNn8DMHNNcG3KUMvsXS
         TaFZDhPxxAG3w2CFiOKTcYOLYa4aL+hfqGqhHLSozymYszOU/sxrlfaCQQSzJZJ+mn0o
         +LFt5tWt7IQc3Ofto4KGqStUyBd0o1Gk4dHVtMQ7K1gbmxoBAZpZZbBNub/b2xgwK6Bj
         nd8olALXtauuU5srFc/dx4ipv8ExVDHQgChXs2K1sHW/l08DdKgkLjUQ3BTVKtLo+6o8
         0k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dW1tg7L5BntD7reoiX2N8eTRkAHKZdUfapCZZ+Vs1s=;
        b=BNuWLBXP+61XCrurevLl8fbCc+UKuoUVoIAA1/VVUH68hCWoPBpRFhoTv7/jztfAXM
         esm4R12ZScdeqHW5Y/JV+ifADKiT43H6Xj0ul+TIvgBhxkxofV9mXkEBiO79zrILS0ln
         ej2bKT3LG9L4soZG0l0qFe7ftGGQT0ivrLw8EBxtHpGizzp37MZNDxMalkp7KRMDxXoH
         hrHD8aARGUlFwZJL/1/JAJnaDCbFJHzVtt7jADmBT0QTmZzW88gHq6cS2YaewAXTWFQp
         fK8SkB1SGDic06v9T1PfsnRpDeCrgMbQdN+x5VpyepNqpo7mz7fMq5RlPh2HSF+Hzrnp
         /J4A==
X-Gm-Message-State: AOAM533eIEFO9enJSnKKDgSx07zPAhJ8cNZgA1zgIRr2cT+v70yUKGdy
        xKqdbJMlSwSdDcNBxxfEb0Vrnu+RPd9GSScY8R4=
X-Google-Smtp-Source: ABdhPJxcOWjUA0HcRSZpELeNr/fHwfLQRa14qubApbgCQzZpAze5mJVWqHn5bUOyAaajeggeeJc2zPu50+57luDUa+M=
X-Received: by 2002:a02:8b:: with SMTP id 133mr4663255jaa.46.1602790016267;
 Thu, 15 Oct 2020 12:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-2-david@redhat.com>
In-Reply-To: <20201012125323.17509-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 15 Oct 2020 21:26:45 +0200
Message-ID: <CAM9Jb+hh9yHUc9_5XFQbrXEgbTkfy4dP+u=4u_mo5DHgJwV1pA@mail.gmail.com>
Subject: Re: [PATCH v1 01/29] virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
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

> Let's determine the target nid only once in case we have none specified -
> usually, we'll end up with node 0 either way.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index ba4de598f663..a1f5bf7a571a 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -70,7 +70,7 @@ struct virtio_mem {
>
>         /* The device block size (for communicating with the device). */
>         uint64_t device_block_size;
> -       /* The translated node id. NUMA_NO_NODE in case not specified. */
> +       /* The determined node id for all memory of the device. */
>         int nid;
>         /* Physical start address of the memory region. */
>         uint64_t addr;
> @@ -406,10 +406,6 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
>  static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>  {
>         const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
> -       int nid = vm->nid;
> -
> -       if (nid == NUMA_NO_NODE)
> -               nid = memory_add_physaddr_to_nid(addr);
>
>         /*
>          * When force-unloading the driver and we still have memory added to
> @@ -423,7 +419,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>         }
>
>         dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
> -       return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> +       return add_memory_driver_managed(vm->nid, addr,
> +                                        memory_block_size_bytes(),
>                                          vm->resource_name,
>                                          MEMHP_MERGE_RESOURCE);
>  }
> @@ -440,13 +437,9 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>  static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
>  {
>         const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
> -       int nid = vm->nid;
> -
> -       if (nid == NUMA_NO_NODE)
> -               nid = memory_add_physaddr_to_nid(addr);
>
>         dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
> -       return remove_memory(nid, addr, memory_block_size_bytes());
> +       return remove_memory(vm->nid, addr, memory_block_size_bytes());
>  }
>
>  /*
> @@ -461,14 +454,11 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
>                                             unsigned long mb_id)
>  {
>         const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
> -       int nid = vm->nid;
> -
> -       if (nid == NUMA_NO_NODE)
> -               nid = memory_add_physaddr_to_nid(addr);
>
>         dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
>                 mb_id);
> -       return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
> +       return offline_and_remove_memory(vm->nid, addr,
> +                                        memory_block_size_bytes());
>  }
>
>  /*
> @@ -1659,6 +1649,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
>         virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
>                         &vm->region_size);
>
> +       /* Determine the nid for the device based on the lowest address. */
> +       if (vm->nid == NUMA_NO_NODE)
> +               vm->nid = memory_add_physaddr_to_nid(vm->addr);
> +
>         /*
>          * We always hotplug memory in memory block granularity. This way,
>          * we have to wait for exactly one memory block to online.
> @@ -1707,7 +1701,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
>                  memory_block_size_bytes());
>         dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
>                  (unsigned long long)vm->subblock_size);
> -       if (vm->nid != NUMA_NO_NODE)
> +       if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
>                 dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
>
>         return 0;

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
