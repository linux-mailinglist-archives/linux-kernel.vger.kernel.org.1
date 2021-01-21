Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16682FEDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbhAUPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbhAUN3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:29:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA358C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:29:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m22so2495683lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TCBmtAGF/p0qcpEu6dpC3LB6xwiWGvLiDJYZOK21eQg=;
        b=kso9808x4AKlVCLoDuCnsIu39a5rc+GdoErbN4v9A0LeyKqKlKZnQ1dZCtCi/0HC8w
         KnpoXw6adp5LSyaXaJqzK1+/d0XrFyt+6exKUKkPuXHFe6dn1pOpw630yXpyGwMieW0j
         T6KPRzXmXWmgk8S0am1TrBzX0lIsQL5iGtEEwTwKcJfen4UKw/mkoT/Whj00fjmxTOWW
         eNJ5E1psjb4UowIw3L/ze2bL8N1I12lKlDeGZOI6qWOSHemRUyNBu/cfHfl7YMRSREJf
         y85GfZVxzSHd0veFJ2SPwAvJmAw/Q7l8G1Mm9YmwoUiNIqbqr9FVssgzQyuO802KfYmR
         eBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TCBmtAGF/p0qcpEu6dpC3LB6xwiWGvLiDJYZOK21eQg=;
        b=rcp/86tQRUwRQw1V34TRJ3ECz+xwEI8ezuYwaLLAe4OpVyWwTXaQmp/qlMSU4EdOWE
         2zEknOMWvf83SLVrdcm5Wx+Bye4/G5vxLG0gaaOUKmgRe82xVALKX6JU9scWhwD/dtN9
         6Lx5rkVsA2UHTNLyU7U1q6B0TZD3QkXwzW+R9D6fodiiA2VMKOiUgSNLqmlK0j6dh3XM
         HNxruOlEFayLjTqynK51DTyvlfkoGaRNV90nneNPfZ5C/p/MenjQoPIvNVbYPmFt6kkK
         TTre35a4x2OfbDI+9lo6oDwX+8knA6a5fATBisvdnIS4v4bsLbc8Oqi2IwlBiHi5oK9O
         Zm+w==
X-Gm-Message-State: AOAM533naXxblCtKmW3LGGylCb6336mx9FV275O5euzvMYDrb0F20sD4
        C0bEaoJKpAFGN4zjeKQyvaaHhrVG7qlEemVyYQiIIA==
X-Google-Smtp-Source: ABdhPJxLYG8wma3X3iAjIq15alrm3ByQ9m1SEliYlbpIky8zpSJ6MErlEFnMHA3/JFYzicxGQZp2bcYAzKcs4eMeICU=
X-Received: by 2002:a19:7616:: with SMTP id c22mr4729640lff.550.1611235749239;
 Thu, 21 Jan 2021 05:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20210119204508.9256-1-john.stultz@linaro.org>
In-Reply-To: <20210119204508.9256-1-john.stultz@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 21 Jan 2021 18:58:57 +0530
Message-ID: <CAO_48GHfGPqcX8B7BC5tf0J3+RWrtjpgHpfnJ-+sVaNv3bxYiw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/3] dma-buf: system_heap: Make sure to return an
 error if we abort
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
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

On Wed, 20 Jan 2021 at 02:15, John Stultz <john.stultz@linaro.org> wrote:
>
> If we abort from the allocation due to a fatal_signal_pending(),
> be sure we report an error so any return code paths don't trip
> over the fact that the allocation didn't succeed.

Thanks for the patch; LGTM, will push into drm-misc-next.
>
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
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index 17e0e9a68baf..405351aad2a8 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -363,8 +363,10 @@ static int system_heap_allocate(struct dma_heap *hea=
p,
>                  * Avoid trying to allocate memory if the process
>                  * has been killed by SIGKILL
>                  */
> -               if (fatal_signal_pending(current))
> +               if (fatal_signal_pending(current)) {
> +                       ret =3D -EINTR;
>                         goto free_buffer;
> +               }
>
>                 page =3D alloc_largest_available(size_remaining, max_orde=
r);
>                 if (!page)
> --
> 2.17.1
>

Best,
Sumit.
