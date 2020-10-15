Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8515E28FA15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbgJOUYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgJOUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:24:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:24:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o4so466995iov.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SR4Lqdjut/KlVIBcf/RdwLPa9YcULCR07wpUSCL+oM=;
        b=E5FfS1A5g5Knjlpbx0bxzA3qScT0sfq1tgZ9/Ipw2jL8k5jp7RvqcJ+dNTPb79eo0Q
         jtkLYnyXE/FXIzQHm8yLOpbTNdcNJETmjfdgXRzoqJjxYP1rfxdTGMkmgR5zYzRjUxL9
         ghVbTu+o++PqbSpudWwILS/u01A6UnXhk9rjdTeLoo+p/kM2O5vCcxHpImnPpo4DMvAL
         p9EpYv6icfzU5XzyTcgaKj0KZrGaRDVaZMh8GFhSry3yIOCFi/SBT3323pup18cW0fH0
         NdC6VyhU4Sguqo3NODmEpMX528Z9fslYVk3hWXBV82gNH6tmoOj+g2dF2DrSYZrr5it/
         Kysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SR4Lqdjut/KlVIBcf/RdwLPa9YcULCR07wpUSCL+oM=;
        b=c9FQKSe2GP8tRUnsITF+NddFmlf37Og319hJkhBN4mi45YjlA6lPgux8nzml6XD6+0
         cRPaIhbo3UTDR7hV4SrDElG4Sx8plZBLyayiB7NqUx9enskj9C/7IHhfW3KFVJOUArNJ
         tnX7vsJKeW2Pd+SH9OyJdbNwf6fKGW2dSXwDSklFObEFS24zL2T2OfXdU5Wb2dg6IVRA
         qBE/FnGcwVSjkAzEEufpfD96HBs4dutMZMieteltITkNBR71QMPIBBaTdtf5wa2f5kYe
         j6UhZ41CgWUxBx9Uu/ctXpH9gvklBF3KrQ4hFo/R0SlUORXjJiBGVVlz4pKaszoC88om
         3ZQg==
X-Gm-Message-State: AOAM5305+vw1SwqB83RH07PSlNrlAf+nA3SEZGRkp8dhpt9CI6Pak9N+
        24LnR0eZERcJTAKeZKmm2ow+wCikBgXkW4L/RaY=
X-Google-Smtp-Source: ABdhPJzuxOtEzSLiNkioEZoZNH73fhonS1xlV9hEdJOfdW3KkS0dliJZII1/RYAYMK1tJcPP1jUgGp8NWJ4BeZsvjQw=
X-Received: by 2002:a02:94cd:: with SMTP id x71mr119834jah.124.1602793477776;
 Thu, 15 Oct 2020 13:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-3-david@redhat.com>
In-Reply-To: <20201012125323.17509-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 15 Oct 2020 22:24:26 +0200
Message-ID: <CAM9Jb+h=2Wg3qAggjAfBf7yyvL9HU6xns7_giJfw6smkCAJ6SQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/29] virtio-mem: simplify calculation in virtio_mem_mb_state_prepare_next_mb()
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

> We actually need one byte less (next_mb_id is exclusive, first_mb_id is
> inclusive). Simplify.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index a1f5bf7a571a..670b3faf412d 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -257,8 +257,8 @@ static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
>   */
>  static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
>  {
> -       unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id + 1;
> -       unsigned long new_bytes = vm->next_mb_id - vm->first_mb_id + 2;
> +       unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
> +       unsigned long new_bytes = old_bytes + 1;

Maybe we can avoid new_bytes & old_bytes variables, instead use single
variable. Can later be used with PFN_UP/PFN_DOWN.

>         int old_pages = PFN_UP(old_bytes);
>         int new_pages = PFN_UP(new_bytes);
>         uint8_t *new_mb_state;
