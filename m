Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999F22938AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405111AbgJTJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgJTJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:58:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:58:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so1435511ilh.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1j0UpJ+NDr3RGUiH7gR94EsyM7DtC9saAmws/S88+j8=;
        b=cc6zck/mbiSbr3ddNcZZA+m9F9s1qN+ilzux1YKettUfQKMIFHN02USvNLKPlJ2YbE
         7kM6Of7Rfz/E7rHthwSTmD2yfXOdpkOExfCdLf17KYR+UNVG26v/66PDH4V0DxR3Nusv
         Jwk7NDBFdWU3Mpi7X75lkG64b0MqnwaUNDwR2sAfEJW3YUDS9qwXg0xKAuW/cdDfIio1
         4iZI0Q6+tP/Yfeg4BiNj7wNpTxM382BYs6Np0V49g3QmIa4SPxlBnWgln9hUyKU6xfUo
         HJSa10q257qvFD/etGPyc2fCucBsRTVb2O5XkelaAHQtrZIKonE6DVRhpZV4wA0L4Nh/
         ffmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1j0UpJ+NDr3RGUiH7gR94EsyM7DtC9saAmws/S88+j8=;
        b=fy72B/ixtva1nuhtJUiP53vFZSiZ9rIM9/SnlsgiP3ojGCQnE0eg4CGNxnHX1HYX2v
         nhrzqgojo7xE8HPCUwrHIwVSbeoURtS9CTQn3lfIEAxJXe7kptI0PQ+4hIFBCDxAxTVG
         AazWxi5fWzLWpulo0+itwehF6naC0sGM0ZbO1j7Q0/Xkwn51Mky0VaauHtX6fqCSwXaX
         Q0li/LdyFIq+t886IUhLt62ABQsY8r5ks++YtSUmIWb50uA0rWjJjRtx12p7+ZoatYeP
         Nxn0N1IKtT5bL2I6UV07Ztb9L06e0Vvvl6V1jmDNKXaBIDSpaOU9+5hSJ2z7uWtbqpLJ
         OQKA==
X-Gm-Message-State: AOAM530EXp9oVQNQfzPIeS0oYmwAnBhBf7tkW3Gg2NcefviavnNVkoD0
        5LHDTuvoHJ0MbatSSzubwZRPgm17a+YTWuU4+Uc=
X-Google-Smtp-Source: ABdhPJx1nEJeB3X7ZxoTJdH5PijT9ZpeBawNTZ3TVTZ02vyDGDLI5kYvkoQ0gIQso1VRMzRTQCIpPfzKgKQBjjHsISM=
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr1127808ils.253.1603187935287;
 Tue, 20 Oct 2020 02:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-19-david@redhat.com>
In-Reply-To: <20201012125323.17509-19-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 20 Oct 2020 11:58:44 +0200
Message-ID: <CAM9Jb+i1TVVcY5Wm6PAtmzgh_KX0XW_XsHPRyt8KreFK9B-tWg@mail.gmail.com>
Subject: Re: [PATCH v1 18/29] virtio-mem: factor out calculation of the bit
 number within the sb_states bitmap
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

> The calculation is already complicated enough, let's limit it to one
> location.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 2cc497ad8298..73ff6e9ba839 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -327,6 +327,16 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>              _mb_id--) \
>                 if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
>
> +/*
> + * Calculate the bit number in the sb_states bitmap for the given subblock
> + * inside the given memory block.
> + */
> +static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
> +                                         unsigned long mb_id, int sb_id)
> +{
> +       return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
> +}
> +
>  /*
>   * Mark all selected subblocks plugged.
>   *
> @@ -336,7 +346,7 @@ static void virtio_mem_sbm_set_sb_plugged(struct virtio_mem *vm,
>                                           unsigned long mb_id, int sb_id,
>                                           int count)
>  {
> -       const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
> +       const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
>
>         __bitmap_set(vm->sbm.sb_states, bit, count);
>  }
> @@ -350,7 +360,7 @@ static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
>                                             unsigned long mb_id, int sb_id,
>                                             int count)
>  {
> -       const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
> +       const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
>
>         __bitmap_clear(vm->sbm.sb_states, bit, count);
>  }
> @@ -362,7 +372,7 @@ static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
>                                            unsigned long mb_id, int sb_id,
>                                            int count)
>  {
> -       const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
> +       const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
>
>         if (count == 1)
>                 return test_bit(bit, vm->sbm.sb_states);
> @@ -379,7 +389,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
>                                              unsigned long mb_id, int sb_id,
>                                              int count)
>  {
> -       const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
> +       const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
>
>         /* TODO: Helper similar to bitmap_set() */
>         return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
> @@ -393,7 +403,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
>  static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
>                                             unsigned long mb_id)
>  {
> -       const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
> +       const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
>
>         return find_next_zero_bit(vm->sbm.sb_states,
>                                   bit + vm->nb_sb_per_mb, bit) - bit;

Agree, there are alot of *b things, good to clean as much.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
