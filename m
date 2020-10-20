Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B56293806
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbgJTJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391608AbgJTJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:31:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2147C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:31:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so2149258iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1d+Zez1C7TJp2V/M7gloZZDa6B2Q1pBXGW4tp7F2Tc=;
        b=IILOe44hszLDN0gM1FvqvW8P36lRbz40j8nIat7HaRBwAf8cUIyfng7y0F5eqUSWv1
         KJQq2rNIPvXvWWCsspnwYavCyKJMs4Lh8z1bJcbTwXNYKO1Mgmh/a5MxLvRCE7EF0mq8
         i7mn/SppKUqyUFW2v4kSkOlU27lDGRiSZQCboda9b7XDRbs5NEXqx2avoKbgGf1pigvA
         WTGIIiJcWIlhM4LVwKmc2y+dCurkXx1Q0IurO0lfFxNWlp5B1ppswp3pVzw6UziVG8UR
         l8DxTkFlEgfdhOaMxUu7a1Co5M8nlG3A0vTi7c1OYWNCvdDEfh47xOTZKf3IvruWnVic
         Sttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1d+Zez1C7TJp2V/M7gloZZDa6B2Q1pBXGW4tp7F2Tc=;
        b=HtrADZGXkC7+sGUc6+TBS6WCqF4SZ5Y0SdYuJA/fNTJ86C0Zq9Nw9vLLVys/TEHeIW
         AOiXrVoEorZm9ijvHkdEqVIR681RFaUrnxyhIOyEw3Sbc4vP8iC84EIVGcXoo7/1hDg9
         LO7Rb0eLEBZ4hcSg6EQ1S4Qo0+S8R7f9RMjgEnDZ0cG/aUHIgbCEMgJANUy5w/hjAOq/
         Ubp5peBjO8T49497Qb7b5ZSQ1wQGUEZDHWxcJDTXVL99dC0Wr5IIKMRANjdZVQD9CgBB
         yMt9BU1MMEo+YH+DsLw+cnyDDIl7rdWdlhsCwqz1kLApo4t2DnytT0k9MKbg4V722MeC
         Z1cA==
X-Gm-Message-State: AOAM531483MlQd0ifhkdEs314H7m/O0fFjFxG8DxJUvUeiz0a+qiilRo
        ccA8tpBZVU8OFQHC98YP+WBeMr+LyItJ68D+Pbc=
X-Google-Smtp-Source: ABdhPJznLmmwvQYVlItbSscxu5FuYmgMkcVyecex17AQfgeclUxqq2jebYandzI0DeRpkyAu7yFJQJxOfgsdy8OcVys=
X-Received: by 2002:a02:6c07:: with SMTP id w7mr1271900jab.46.1603186293902;
 Tue, 20 Oct 2020 02:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-13-david@redhat.com>
In-Reply-To: <20201012125323.17509-13-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 20 Oct 2020 11:31:22 +0200
Message-ID: <CAM9Jb+gH=5HoCVNWS2njNT+aEK5tqEaTZtiTJsEh3ajLwKw9BA@mail.gmail.com>
Subject: Re: [PATCH v1 12/29] virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
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

> ... which now matches virtio_mem_fake_online(). We'll reuse this
> functionality soon.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 00d1cfca4713..d132bc54ef57 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -832,6 +832,27 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>         }
>  }
>
> +/*
> + * Try to allocate a range, marking pages fake-offline, effectively
> + * fake-offlining them.
> + */
> +static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
> +{
> +       int rc;
> +
> +       rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
> +                               GFP_KERNEL);
> +       if (rc == -ENOMEM)
> +               /* whoops, out of memory */
> +               return rc;
> +       if (rc)
> +               return -EBUSY;
> +
> +       virtio_mem_set_fake_offline(pfn, nr_pages, true);
> +       adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
> +       return 0;
> +}
> +
>  static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
>  {
>         const unsigned long addr = page_to_phys(page);
> @@ -1335,17 +1356,10 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
>
>         start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>                              sb_id * vm->subblock_size);
> -       rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
> -                               MIGRATE_MOVABLE, GFP_KERNEL);
> -       if (rc == -ENOMEM)
> -               /* whoops, out of memory */
> -               return rc;
> -       if (rc)
> -               return -EBUSY;
>
> -       /* Mark it as fake-offline before unplugging it */
> -       virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
> -       adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> +       rc = virtio_mem_fake_offline(start_pfn, nr_pages);
> +       if (rc)
> +               return rc;
>
>         /* Try to unplug the allocated memory */
>         rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
