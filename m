Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050FE29388E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbgJTJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731257AbgJTJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:54:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:54:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k1so1383859ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2YVxQUooGjefycOceNjXTvB1SnQYJ59Lep/Gb++HfM=;
        b=ROPAeudlSMVn55zYCqIvdrsw25G1KccM4GEFUA5WNdLBlIs7qv5oZBptimpBW5U9Iw
         n7YxR1ITUvzVZsK9VYrhv8G2fykIsSIK49O22LNMWcpL3mImvMzlDcedAL3rS+6v4xD+
         x9WDsv//ZJokaqE+gIUuAYwqhfnlBudgAzWTM56QXeHx+KrPdSQZx3fm20ZQittm27E5
         X0BTDvqOCKg9OwD4Im5+3DCYyU+/Dn1aYLGqiEUi8tBaZ12Bk5GWzgz33gV8/8i/T1XO
         DgGWD+FfDwMiL4QRLmLTT77SLWHtJHDvZIuJkXtQ/vtCSLLfRfJQh3iJLZroOnbxqXxH
         /HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2YVxQUooGjefycOceNjXTvB1SnQYJ59Lep/Gb++HfM=;
        b=MGnFM4hgYw+maW6gYJz3i1sAfditlgUSNTyg43qhNBvfRSteJRaktMojHhqwwljzyS
         2tEu9oJAvFPuLZI7GEResorzPau9+3mAUnWxnZdeHqWx86c5LOJaLWWDw8+Y9bbtC6nP
         HoNoE1tkSOLWmGC/t619ymLM0cyVR5eHBw5VCMHOcK/UAsCmy8F18zuwosuG6YWCOWT8
         +w/LQnkq4f9lN/icS1gywIdxXpHMjMllw6HnalJStOBBlrD4a7bF/KKp+OwM0dogBaeM
         Achy7387eTJkerLEUXacaXbcjmW6EtEwgGpw71nTLQESw9gv9Oj1EAzg8gIssNj/kMIM
         HzPg==
X-Gm-Message-State: AOAM530U/vEwOs2haYVq6oU85ZdwyjA7PdNfFx7fVBWUEZp16iuubbM7
        nrnVceNR23qWGLVfVhe2/VFaeN41BKoTptx9+Rs+OBzCKOFBbA==
X-Google-Smtp-Source: ABdhPJylqlP9dnQnY0SwR2fKTUmQIJvW6qtO353H2pbZ7P29PJYWUOaPj69yy5M5Sz2AXJaiSXi4knRItVu9Q18WaAc=
X-Received: by 2002:a92:180b:: with SMTP id 11mr1270450ily.89.1603187687165;
 Tue, 20 Oct 2020 02:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-18-david@redhat.com>
In-Reply-To: <20201012125323.17509-18-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 20 Oct 2020 11:54:36 +0200
Message-ID: <CAM9Jb+gz6CpDWsjOddH9JTMBGutkoZdfjxiQRgrd4SrDtLUT1g@mail.gmail.com>
Subject: Re: [PATCH v1 17/29] virito-mem: subblock states are specific to Sub
 Block Mode (SBM)
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

> Let's rename and move accordingly. While at it, rename sb_bitmap to
> "sb_states".
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 118 +++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index e76d6f769aa5..2cc497ad8298 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -137,17 +137,23 @@ struct virtio_mem {
>                  * memory in one 4 KiB page.
>                  */
>                 uint8_t *mb_states;
> -       } sbm;
>
> -       /*
> -        * $nb_sb_per_mb bit per memory block. Handled similar to sbm.mb_states.
> -        *
> -        * With 4MB subblocks, we manage 128GB of memory in one page.
> -        */
> -       unsigned long *sb_bitmap;
> +               /*
> +                * Bitmap: one bit per subblock. Allocated similar to
> +                * sbm.mb_states.
> +                *
> +                * A set bit means the corresponding subblock is plugged,
> +                * otherwise it's unblocked.
> +                *
> +                * With 4 MiB subblocks, we manage 128 GiB of memory in one
> +                * 4 KiB page.
> +                */
> +               unsigned long *sb_states;
> +       } sbm;
>
>         /*
> -        * Mutex that protects the sbm.mb_count, sbm.mb_states, and sb_bitmap.
> +        * Mutex that protects the sbm.mb_count, sbm.mb_states, and
> +        * sbm.sb_states.
>          *
>          * When this lock is held the pointers can't change, ONLINE and
>          * OFFLINE blocks can't change the state and no subblocks will get
> @@ -326,13 +332,13 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>   *
>   * Will not modify the state of the memory block.
>   */
> -static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
> -                                        unsigned long mb_id, int sb_id,
> -                                        int count)
> +static void virtio_mem_sbm_set_sb_plugged(struct virtio_mem *vm,
> +                                         unsigned long mb_id, int sb_id,
> +                                         int count)
>  {
>         const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>
> -       __bitmap_set(vm->sb_bitmap, bit, count);
> +       __bitmap_set(vm->sbm.sb_states, bit, count);
>  }
>
>  /*
> @@ -340,86 +346,87 @@ static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
>   *
>   * Will not modify the state of the memory block.
>   */
> -static void virtio_mem_mb_set_sb_unplugged(struct virtio_mem *vm,
> -                                          unsigned long mb_id, int sb_id,
> -                                          int count)
> +static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
> +                                           unsigned long mb_id, int sb_id,
> +                                           int count)
>  {
>         const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>
> -       __bitmap_clear(vm->sb_bitmap, bit, count);
> +       __bitmap_clear(vm->sbm.sb_states, bit, count);
>  }
>
>  /*
>   * Test if all selected subblocks are plugged.
>   */
> -static bool virtio_mem_mb_test_sb_plugged(struct virtio_mem *vm,
> -                                         unsigned long mb_id, int sb_id,
> -                                         int count)
> +static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
> +                                          unsigned long mb_id, int sb_id,
> +                                          int count)
>  {
>         const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>
>         if (count == 1)
> -               return test_bit(bit, vm->sb_bitmap);
> +               return test_bit(bit, vm->sbm.sb_states);
>
>         /* TODO: Helper similar to bitmap_set() */
> -       return find_next_zero_bit(vm->sb_bitmap, bit + count, bit) >=
> +       return find_next_zero_bit(vm->sbm.sb_states, bit + count, bit) >=
>                bit + count;
>  }
>
>  /*
>   * Test if all selected subblocks are unplugged.
>   */
> -static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
> -                                           unsigned long mb_id, int sb_id,
> -                                           int count)
> +static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
> +                                            unsigned long mb_id, int sb_id,
> +                                            int count)
>  {
>         const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>
>         /* TODO: Helper similar to bitmap_set() */
> -       return find_next_bit(vm->sb_bitmap, bit + count, bit) >= bit + count;
> +       return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
> +              bit + count;
>  }
>
>  /*
>   * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case there is
>   * none.
>   */
> -static int virtio_mem_mb_first_unplugged_sb(struct virtio_mem *vm,
> +static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
>                                             unsigned long mb_id)
>  {
>         const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
>
> -       return find_next_zero_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) -
> -              bit;
> +       return find_next_zero_bit(vm->sbm.sb_states,
> +                                 bit + vm->nb_sb_per_mb, bit) - bit;
>  }
>
>  /*
>   * Prepare the subblock bitmap for the next memory block.
>   */
> -static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
> +static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
>  {
>         const unsigned long old_nb_mb = vm->next_mb_id - vm->first_mb_id;
>         const unsigned long old_nb_bits = old_nb_mb * vm->nb_sb_per_mb;
>         const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->nb_sb_per_mb;
>         int old_pages = PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
>         int new_pages = PFN_UP(BITS_TO_LONGS(new_nb_bits) * sizeof(long));
> -       unsigned long *new_sb_bitmap, *old_sb_bitmap;
> +       unsigned long *new_bitmap, *old_bitmap;
>
> -       if (vm->sb_bitmap && old_pages == new_pages)
> +       if (vm->sbm.sb_states && old_pages == new_pages)
>                 return 0;
>
> -       new_sb_bitmap = vzalloc(new_pages * PAGE_SIZE);
> -       if (!new_sb_bitmap)
> +       new_bitmap = vzalloc(new_pages * PAGE_SIZE);
> +       if (!new_bitmap)
>                 return -ENOMEM;
>
>         mutex_lock(&vm->hotplug_mutex);
> -       if (new_sb_bitmap)
> -               memcpy(new_sb_bitmap, vm->sb_bitmap, old_pages * PAGE_SIZE);
> +       if (new_bitmap)
> +               memcpy(new_bitmap, vm->sbm.sb_states, old_pages * PAGE_SIZE);
>
> -       old_sb_bitmap = vm->sb_bitmap;
> -       vm->sb_bitmap = new_sb_bitmap;
> +       old_bitmap = vm->sbm.sb_states;
> +       vm->sbm.sb_states = new_bitmap;
>         mutex_unlock(&vm->hotplug_mutex);
>
> -       vfree(old_sb_bitmap);
> +       vfree(old_bitmap);
>         return 0;
>  }
>
> @@ -630,7 +637,7 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
>         int sb_id;
>
>         for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
> -               if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> +               if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
>                         continue;
>                 pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>                                sb_id * vm->subblock_size);
> @@ -646,7 +653,7 @@ static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
>         int sb_id;
>
>         for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
> -               if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> +               if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
>                         continue;
>                 pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>                                sb_id * vm->subblock_size);
> @@ -936,7 +943,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
>                  * If plugged, online the pages, otherwise, set them fake
>                  * offline (PageOffline).
>                  */
> -               if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> +               if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
>                         generic_online_page(page, order);
>                 else
>                         virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
> @@ -1071,7 +1078,7 @@ static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
>
>         rc = virtio_mem_send_plug_request(vm, addr, size);
>         if (!rc)
> -               virtio_mem_mb_set_sb_plugged(vm, mb_id, sb_id, count);
> +               virtio_mem_sbm_set_sb_plugged(vm, mb_id, sb_id, count);
>         return rc;
>  }
>
> @@ -1092,7 +1099,7 @@ static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
>
>         rc = virtio_mem_send_unplug_request(vm, addr, size);
>         if (!rc)
> -               virtio_mem_mb_set_sb_unplugged(vm, mb_id, sb_id, count);
> +               virtio_mem_sbm_set_sb_unplugged(vm, mb_id, sb_id, count);
>         return rc;
>  }
>
> @@ -1115,14 +1122,14 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
>         while (*nb_sb) {
>                 /* Find the next candidate subblock */
>                 while (sb_id >= 0 &&
> -                      virtio_mem_mb_test_sb_unplugged(vm, mb_id, sb_id, 1))
> +                      virtio_mem_sbm_test_sb_unplugged(vm, mb_id, sb_id, 1))
>                         sb_id--;
>                 if (sb_id < 0)
>                         break;
>                 /* Try to unplug multiple subblocks at a time */
>                 count = 1;
>                 while (count < *nb_sb && sb_id > 0 &&
> -                      virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
> +                      virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
>                         count++;
>                         sb_id--;
>                 }
> @@ -1168,7 +1175,7 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
>                 return rc;
>
>         /* Resize the subblock bitmap if required. */
> -       rc = virtio_mem_sb_bitmap_prepare_next_mb(vm);
> +       rc = virtio_mem_sbm_sb_states_prepare_next_mb(vm);
>         if (rc)
>                 return rc;
>
> @@ -1253,14 +1260,13 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
>                 return -EINVAL;
>
>         while (*nb_sb) {
> -               sb_id = virtio_mem_mb_first_unplugged_sb(vm, mb_id);
> +               sb_id = virtio_mem_sbm_first_unplugged_sb(vm, mb_id);
>                 if (sb_id >= vm->nb_sb_per_mb)
>                         break;
>                 count = 1;
>                 while (count < *nb_sb &&
>                        sb_id + count < vm->nb_sb_per_mb &&
> -                      !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
> -                                                     1))
> +                      !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id + count, 1))
>                         count++;
>
>                 rc = virtio_mem_mb_plug_sb(vm, mb_id, sb_id, count);
> @@ -1277,7 +1283,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
>                 virtio_mem_fake_online(pfn, nr_pages);
>         }
>
> -       if (virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
> +       if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>                 if (online)
>                         virtio_mem_sbm_set_mb_state(vm, mb_id,
>                                                     VIRTIO_MEM_SBM_MB_ONLINE);
> @@ -1377,13 +1383,13 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
>         rc = virtio_mem_mb_unplug_any_sb(vm, mb_id, nb_sb);
>
>         /* some subblocks might have been unplugged even on failure */
> -       if (!virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
> +       if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
>                 virtio_mem_sbm_set_mb_state(vm, mb_id,
>                                             VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
>         if (rc)
>                 return rc;
>
> -       if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
> +       if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>                 /*
>                  * Remove the block from Linux - this should never fail.
>                  * Hinder the block from getting onlined by marking it
> @@ -1452,7 +1458,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
>
>         /* If possible, try to unplug the complete block in one shot. */
>         if (*nb_sb >= vm->nb_sb_per_mb &&
> -           virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
> +           virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>                 rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, 0,
>                                                     vm->nb_sb_per_mb);
>                 if (!rc) {
> @@ -1466,7 +1472,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
>         for (sb_id = vm->nb_sb_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
>                 /* Find the next candidate subblock */
>                 while (sb_id >= 0 &&
> -                      !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> +                      !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
>                         sb_id--;
>                 if (sb_id < 0)
>                         break;
> @@ -1485,7 +1491,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
>          * remove it. This will usually not fail, as no memory is in use
>          * anymore - however some other notifiers might NACK the request.
>          */
> -       if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
> +       if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>                 mutex_unlock(&vm->hotplug_mutex);
>                 rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
>                 mutex_lock(&vm->hotplug_mutex);
> @@ -2007,7 +2013,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>
>         /* remove all tracking data - no locking needed */
>         vfree(vm->sbm.mb_states);
> -       vfree(vm->sb_bitmap);
> +       vfree(vm->sbm.sb_states);
>
>         /* reset the device and cleanup the queues */
>         vdev->config->reset(vdev);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
