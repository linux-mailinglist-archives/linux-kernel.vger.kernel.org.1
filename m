Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046131F16CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgFHKhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 06:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgFHKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:37:07 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C95C08C5C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 03:37:07 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di13so1975817qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 03:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37datdXl0TF4cHt39unBvjQQpavQ7FoeHgZeTkd6cVo=;
        b=jWuBi3gBOqpp71BpWC1WbZEGMxzH3MTotBqy+CTTW/ii1+t6JbNX14i+Didnl9fYdQ
         Lx0RoE/Q0B9pQPdESBuGWf8PRHudkFPbAcjQedMq516IZ67SaJAww/fKkHBB/Kvfcjck
         9dJZvpSfyrEnPN5YuRX7giecTXFlZnZXkJ1vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37datdXl0TF4cHt39unBvjQQpavQ7FoeHgZeTkd6cVo=;
        b=oxAwQNMJ36fukEqoR2TsSmOqnCbmfKIr3WyCwcMo3B0bxF0pgt0CMiR9XWkpKr4hT3
         jmatRguw4B8XNHEzNNYL/7w99dUfJ47Pm1gmh3FTLtYnDmGHFH+COK67gjBXFG65Thxu
         scr7deSJ26u025HKhFMY04ynNFio44i+oLm2zUFSvPPi7szhnLaC08CiUEwZnfEYUHGP
         IosUBI6upUsfsj92PK0a/qqjKenbm2rdPU3vuOFwz1wU++3RSIokkpEyX0Ub7uT70RXF
         /6VrJe6WdPk+VHAL2UJ85pLcp+BhOz3/fVo9fPZkcLYxsA0iZU3kW3yYK63Wad1YsOnq
         vDmQ==
X-Gm-Message-State: AOAM530uWEQWqAwMpfNfR/raH2JnqKkZYdYx8XkHbPVuHsnKmMlxCyxe
        +lxxbvBHuT2TvHIkVI83ipCsPmuY3iNZpoguKrmdtw==
X-Google-Smtp-Source: ABdhPJx0Js9UlOjOlvsu2+uMuuX1LzgiViihJEZNtsxnEp5BP9jZ39vgEHbdMa7JtxuwcBbI76XV/X/JfEUXZ0ddD1Q=
X-Received: by 2002:a0c:aed6:: with SMTP id n22mr1149105qvd.70.1591612626754;
 Mon, 08 Jun 2020 03:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org> <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
 <20200608054234-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200608054234-mutt-send-email-mst@kernel.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 8 Jun 2020 19:36:55 +0900
Message-ID: <CAD=HUj6kF2JFyC9c0CY5_f-cv6r97501Z2f8D9x0VhQpRen+bw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 6:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 04:26:15PM +0900, David Stevens wrote:
> > > > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > > > +             vgdev->has_resource_assign_uuid = true;
> > > > +     }
> > >
> > >
> > > Just a question: this relies on DMA bufs so I assume it is
> > > not really assumed to work when DMA API is bypassed, right?
> > > Rather than worry what does it mean, how about just
> > > disabling  this feature without PLATFORM_DMA for now?
> >
> > By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER?
>
> Sorry, no. I mean VIRTIO_F_IOMMU_PLATFORM which in the
> future will be renamed to VIRTIO_F_PLATFORM_ACCESS.

Shouldn't things work independent of whether or not that feature is
set? If a virtio driver properly uses the dma_buf APIs (which virtgpu
seems to), then that should take care of any mapping/synchronization
related to VIRTIO_F_IOMMU_PLATFORM. If anything, the case where
VIRTIO_F_IOMMU_PLATFORM isn't set is easier, since then we know that
the "the device has same access [sic] to memory addresses supplied to
it as the driver has", according to the specification.

-David
