Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFF028F6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbgJOQdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389826AbgJOQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602779599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPCx6ZX+v0aW1qWNyvmKfIJa6GlSsQRVtNwvNS3h79w=;
        b=Hs3pIWrU1dtTqVTLAPQmv6Zcu1zYMMVdpggh6XyEf0jes2V00rVHDDcgALVFdJeN9nlK4x
        QyKI10UCIahCrdltUP8OLyfH7j9TpXp6O+pu9f3uRJMgG0z+9KH0rgiOHT3tweEOwfAO0T
        2KFnVe86UtU7C6BAXv3ucqQxh0hJVUs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-4sT4v9_CMpSVOt62KX4A-w-1; Thu, 15 Oct 2020 12:33:11 -0400
X-MC-Unique: 4sT4v9_CMpSVOt62KX4A-w-1
Received: by mail-qk1-f197.google.com with SMTP id g184so2464111qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPCx6ZX+v0aW1qWNyvmKfIJa6GlSsQRVtNwvNS3h79w=;
        b=p6te2/0qruXZBNrdmgfQGpw08n6kEy0jSFQwFOoZ63X5qAJI6imXt985x62EE2FgSp
         UInzC0HEgnnXfneZdj5+oaAsgkjJIHCGUF+Z/fGNz4tqJpwRshVMLfP5zaOLeS9x1sIe
         kP1bdF6TCRsMIwqno5KJBHsTREQyp4TwE1aPrehGoD9klXDOnrv6Q5KDc+AGCzIVMlez
         2qYEAP31/z1t0skD5CArUv06NUOgDH7Wm5Ibtkgvt4MyP/OHKC1sV8qZq/aCdS/X3fiO
         fEnOkOMvkHJsyblBL8vrSB/jDgZSxEncWevneyfGrVr7s6wAK6mAThb6BVNEsL93195x
         1oFg==
X-Gm-Message-State: AOAM533EiV0ibzn8V6/OU5luuq4PP0ru/FeycXb3g0Qw0BDks31cfpKc
        PrBccrvjiCr+evBqi6cDDk/jzpAW7jiAtuzsjqX1UysXQV/DUypRLTH8KMCnUwNsRcMMfY1q9ia
        GoQoArtlySZEEYpLROUzKXL8hiuTuSnps9kFZn8rA
X-Received: by 2002:a05:620a:1668:: with SMTP id d8mr4948591qko.192.1602779590052;
        Thu, 15 Oct 2020 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhPovKkyv2797cvRQtgT8s/gshA8t417emP2EmAJofXJvWtB9m/PLkl5wGjr16oTzG1Y3NTcB1101aJZ9i6ZY=
X-Received: by 2002:a05:620a:1668:: with SMTP id d8mr4948568qko.192.1602779589751;
 Thu, 15 Oct 2020 09:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201014075419.19974-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
In-Reply-To: <20201014075419.19974-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Oct 2020 18:32:58 +0200
Message-ID: <CACO55ttZCVZM2v1oWRq7mzZy3DVDe3h1fH80D6RNFM3xR4VjuQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH RFC] drm/nouveau: fix memory leak in nvkm_iccsense_oneinit
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     takafumi@sslab.ics.keio.ac.jp, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, I think this is like the 5th patch tackling this issue, I think
we should merge one of those.

On Thu, Oct 15, 2020 at 6:23 AM Keita Suzuki
<keitasuzuki.park@sslab.ics.keio.ac.jp> wrote:
>
> struct pw_rail_t is allocated as an array in function nvios_iccsense_parse,
> and stored to a struct member of local variable. However, the array is not
> freed when the local variable becomes invalid, and the reference is not
> passed on, leading to a memory leak.
>
> Fix this by freeing struct pw_rail_t when exiting nvkm_iccsense_oneinit.
>
> Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> index fecfa6afcf54..8ba8d8e3f52a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> @@ -280,8 +280,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
>                         }
>
>                         rail = kmalloc(sizeof(*rail), GFP_KERNEL);
> -                       if (!rail)
> +                       if (!rail) {
> +                               kfree(stbl.rail);
>                                 return -ENOMEM;
> +                       }
>
>                         rail->read = read;
>                         rail->sensor = sensor;
> @@ -291,6 +293,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
>                         list_add_tail(&rail->head, &iccsense->rails);
>                 }
>         }
> +       kfree(stbl.rail);
>         return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

