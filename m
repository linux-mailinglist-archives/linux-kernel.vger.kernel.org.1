Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819F2EFD96
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 04:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAIDpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 22:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAIDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 22:45:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 19:44:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 23so27728987lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 19:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HD/4viRtfwM399mGOKfKs0Gn3g0BoLDsv4d+I17dgcw=;
        b=WK8ARnKNiOzvrjlOgn3JOdaq1kaUecOF/7zvSZnDR6+k0sE+pM3XL/wX0NhL8y+LWR
         maEu4/DnDNd6Q2i9XurgxLiK0jbfmB9uFbCEoxVVeYb1zN1XL7wnDdadzZoU54KkrivG
         4PRSAlLJw7a+esJO5ppq5/CXBeqLV1eEbMZFZ1/Qw7KuM3+JQchcDZP2jKK7vLuI90zw
         PHydTkyuaL6mpwSaiNwxIufYaZfiLBkaku5FGAtTxrz6RrGqR1LhkdP58evQ3+y0vvyP
         Ls+yUy3ZjGBlGylO2bUghiCwYk5RLN4GVrYP3mmPGbZOcUrtSFNZW7vKYHpIUS823ySd
         F5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HD/4viRtfwM399mGOKfKs0Gn3g0BoLDsv4d+I17dgcw=;
        b=UFLtAhK85aftss4+XoN/q5kqNMIWCtfA0BnmlA7qFV3teRc1l57OkefnfsSpzyfM7J
         KI4wuSKI2vkVxqnCpl2VpS3Fm4DzTc+0oWEi5wdlUGisaqMDhZUos0ysglJ43LZJ3jAc
         zWY4Nqr5u3mvnYplsBHpn/k2SofXRLmp2xJctoNEhzHteqjwZsF3+jXl5nXguW7OheAd
         TT7DMOh5gnStQl3TZ7iWLmSh25t3ea+NX3mo1uVV0cJats78/WMOcbXehR5W3Kwg6WSA
         CLKfOwSE2/4r1r660B5n8/N9NJ1kPycfKV8wc1LO8hhERIqql9JUHRT54Gz9uv4iwOA/
         9l5g==
X-Gm-Message-State: AOAM530djhXp6QzlemGv+xZBD+E2wY3+clkTEX/vwpGsJKcM3sRRFeyX
        W2xJMbhIaS6Yc9MX4NO0FvthRCQDYDgVmL8cwmLEug==
X-Google-Smtp-Source: ABdhPJyZXQilDKeEMaUqBwDSsXwImGMNtYgnwmPGpRArK1E1OR4/l0JkRDIUv/vXuXgmte5xrqEJ1m1RX8xMyQEYtVs=
X-Received: by 2002:a05:6512:61:: with SMTP id i1mr2683474lfo.343.1610163866124;
 Fri, 08 Jan 2021 19:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20210107202616.75170-1-john.stultz@linaro.org>
In-Reply-To: <20210107202616.75170-1-john.stultz@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Sat, 9 Jan 2021 09:14:14 +0530
Message-ID: <CAO_48GGyAhz_sXe22H6aZSiJQ2sSEgJ=HpaAkOfi-DmVmwvNtw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: cma_heap: Fix memory leak in CMA heap
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Bing Song <bing.song@nxp.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, 8 Jan 2021 at 01:56, John Stultz <john.stultz@linaro.org> wrote:
>
> Bing Song noticed the CMA heap was leaking memory due to a flub
> I made in commit a5d2d29e24be ("dma-buf: heaps: Move heap-helper
> logic into the cma_heap implementation"), and provided this fix
> which ensures the pagelist is also freed on release.
Thanks for your patch.
>
> Cc: Bing Song <bing.song@nxp.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Laura Abbott <labbott@kernel.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Daniel Mentz <danielmentz@google.com>
> Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Cc: =C3=98rjan Eide <orjan.eide@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ezequiel Garcia <ezequiel@collabora.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: James Jones <jajones@nvidia.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Reported-by: Bing Song <bing.song@nxp.com>
> Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma=
_heap implementation")
> Signed-off-by: John Stultz <john.stultz@linaro.org>

I will queue it up so it gets in the v5.11 cycle.
> ---
>  drivers/dma-buf/heaps/cma_heap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> index 3c4e34301172..364fc2f3e499 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -251,6 +251,9 @@ static void cma_heap_dma_buf_release(struct dma_buf *=
dmabuf)
>                 buffer->vaddr =3D NULL;
>         }
>
> +       /* free page list */
> +       kfree(buffer->pages);
> +       /* release memory */
>         cma_release(cma_heap->cma, buffer->cma_pages, buffer->pagecount);
>         kfree(buffer);
>  }
> --
> 2.17.1
>
Best,
Sumit.
