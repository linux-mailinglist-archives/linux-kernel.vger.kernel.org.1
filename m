Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297952744B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgIVOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgIVOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:51:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D107C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:51:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so14386301ljo.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bzR1gxnRoZXjib0y+EllAgb8353tQk04gCemc3kID8w=;
        b=Zy8iW9TQcugkIzEGW/pU5DvFHSWArgwWW5vg1vSaanKjEpSMvnoljwAIo9Pu44WJKy
         OIoRVAgmFjK8qGjrEHgenNyFUqGf1IQROkUhyLmm3Ba7ddEv7hz2PRAEyYSTDjzNt+xG
         tu5RLsuel0ENBLwXk8A2yFHVAavL0BH7T6JiXwgzxMFhkJMVYquQc18lQhmbwjH8Awcb
         rH0cnwkrxpxui9pgGiz9pGkG10OF1SSpzfMzB5zrz4MEfaetf4yi+GJv/dKacSGIf0GF
         9RK9n80GHWdYuBN6iooSVgsSHbrifpli/ZWXsBIvpUTxGWvDhxU86W5gnQtoK5Iyvg+K
         VEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bzR1gxnRoZXjib0y+EllAgb8353tQk04gCemc3kID8w=;
        b=CUtpIlm6xAcn7VD7pzYCQzgyDbFSh56vJx/+pvsaC50fdTpTQppgwuflzivGIEXLW9
         FwRfqPP44JJvQr4rlRKFQXm23+0vhUqxdjaA5CwkSp/Bas1fMn96NuXu1+Z8AaGFVnML
         7wX5Z0+pgHb0DQVDZOc5eGxQO+HEgPePEAoXnB8LyaSMNT05M3XjB5jMkE77FNhv1T0C
         kS62OurHJroj+PH72ARI7qa4CkbRJD4SWxuzLElB1piV1fLWSIS31NEy3h5I2C7XUxPw
         gyy4Nax8NIQ2v6moN8peS/0n10b/axe1UHg8sDa/UQ78LIl/gMKx+jTUMMjIqz43DBI1
         awSw==
X-Gm-Message-State: AOAM532k+FuHFoaIcT2H7zEK27iecatZDkEifa57jRzC4STyFVWY3n1f
        Q93dtvNg7dITcsAgGc8HFE31LRu7lfgF6nGsVgTTfA==
X-Google-Smtp-Source: ABdhPJzKH8OQ0ibiB5TcLvCcwuehtiNBqqIIuvG+ZJlWITOsxvhm5s/+BLFL6uh/wql70FfMyu1bYxOEWOl2C3HREcI=
X-Received: by 2002:a05:651c:552:: with SMTP id q18mr1591731ljp.248.1600786315624;
 Tue, 22 Sep 2020 07:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <1600761208-45229-1-git-send-email-zou_wei@huawei.com> <16d720b7-9bf3-ad3a-0785-76f21c87c9e1@amd.com>
In-Reply-To: <16d720b7-9bf3-ad3a-0785-76f21c87c9e1@amd.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 22 Sep 2020 20:21:42 +0530
Message-ID: <CAO_48GHVUnHm38nPSc3zYU7ZoFmZDTZdc7Du5pyrVbz6ytwgEA@mail.gmail.com>
Subject: Re: [PATCH -next] dma-buf: heaps: Remove unused variable ret
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Zou Wei <zou_wei@huawei.com>, "Andrew F. Davis" <afd@ti.com>,
        "(Exiting) Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zou,

On Tue, 22 Sep 2020 at 18:12, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 22.09.20 um 09:53 schrieb Zou Wei:
> > This patch fixes below warnings reported by coccicheck
> >
> > ./drivers/dma-buf/heaps/heap-helpers.c:202:5-8: Unneeded variable: "ret=
". Return "0" on line 215
> >
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Going to pick this up for drm-misc-next.
Thanks Christian!
Fwiw, feel free to add my
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> > ---
> >   drivers/dma-buf/heaps/heap-helpers.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/hea=
ps/heap-helpers.c
> > index d0696cf..7969510 100644
> > --- a/drivers/dma-buf/heaps/heap-helpers.c
> > +++ b/drivers/dma-buf/heaps/heap-helpers.c
> > @@ -199,7 +199,6 @@ static int dma_heap_dma_buf_begin_cpu_access(struct=
 dma_buf *dmabuf,
> >   {
> >       struct heap_helper_buffer *buffer =3D dmabuf->priv;
> >       struct dma_heaps_attachment *a;
> > -     int ret =3D 0;
> >
> >       mutex_lock(&buffer->lock);
> >
> > @@ -212,7 +211,7 @@ static int dma_heap_dma_buf_begin_cpu_access(struct=
 dma_buf *dmabuf,
> >       }
> >       mutex_unlock(&buffer->lock);
> >
> > -     return ret;
> > +     return 0;
> >   }
> >
> >   static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>

Best,
Sumit.
