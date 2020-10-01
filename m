Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0814327FC98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgJAJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:45:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24055C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 02:45:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so7054069ejo.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZDdA2zY8D0de7pamktpQczyQ0hFmRGKGBWlU1/8ZIU=;
        b=GzaYPDdcHi7fM0Xb/kj1vWF/5NtJ3RfOuBsBs0TYwYGWmC2hF27bO/JVp+QoXI07Nv
         3wUVGBNHIMoAwly774K6sTazqDNKSOe22PcM4ilkykogaT4RRTvcpEnayrF6CHCMtOlE
         ixBTSnRZpIkfgQS5zzKXFjnO6aHUJdE9e86esmBNZ7RMajhTDNBwPBpUne+mOLfVdbzN
         zzMv5Cmjvnu/WqdWPmqzF9XQUmaG5ekpi3z4LS+3xUsVKJv8+VsigpU/dQ9uL1b6hsES
         XimI3RHnPb02uwh0EnTayw2n7b9mxWlyFywK7UEtV2GeYssOCJ6sxf3Rv6K1e3A82LYo
         q8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZDdA2zY8D0de7pamktpQczyQ0hFmRGKGBWlU1/8ZIU=;
        b=bj96ZToPJ/5HLp28VKqdcXaE63e+1IRzeuI5J9MOwjGoOf3yhQMuGWaTti/prVUhru
         RHsNqdOVan8MNLF1FvJCfBwixOPAMU4RpzEAn9Xor/GXKx0Vx9T/l5DnXwZ0D45gjtVK
         v9qJbg+d0BOKK4PUPbPt1ULlNFDxa9X+3qsS0iD4qYhHQ8B2g/s8wR7SHEL0LhthjtAH
         XIcU+K9So0dNFj0LcnAI8RDmTP+ttLSQMtgfyF22FhveoOii8YtaiM0BriAXnUvvOjvr
         dPB4KVQXTS2jlP6zydgHEDO0sAbXg7jTNvd4BoyNk5UE6acPdpt4hH3dUzjbLJBepl5t
         1isQ==
X-Gm-Message-State: AOAM531ss5aH9aDolcS56NWc77G+PTi/axaCHYPCqlc9Qh2mS85T5Bhh
        XRKG4OzWqcPSfS9sIwkCxgMgEr8jFvJnwEfuUdJHog==
X-Google-Smtp-Source: ABdhPJxzHjAb6ADjhe+rmmZGGPZFt3ViF0VwPxP2wF4EZ7eISGKdHfVNhtMH0g9LAbWAQhBJuAnvWjTdotqtXVaiQN4=
X-Received: by 2002:a17:906:9588:: with SMTP id r8mr6986248ejx.389.1601545532768;
 Thu, 01 Oct 2020 02:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201001072703.16256-1-gi-oh.kim@clous.ionos.com>
In-Reply-To: <20201001072703.16256-1-gi-oh.kim@clous.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 1 Oct 2020 11:45:21 +0200
Message-ID: <CAMGffE=EuoiGGmddFawWL1qm9kfqBDB+ttiQuC-sAze0_A+H2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA/rtrs: check before free
To:     Gioh Kim <gi-oh.kim@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 9:27 AM Gioh Kim <gi-oh.kim@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> If rtrs_iu_alloc failed to allocate buffer or map dma,
> there are some allocated addresses and some NULL addresses
> in the array. rtrs_iu_free should check data before free.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index 5163e662f86f..ca2d2d3e4192 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -61,8 +61,12 @@ void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
>
>         for (i = 0; i < queue_size; i++) {
>                 iu = &ius[i];
> -               ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
> -               kfree(iu->buf);
> +               if (iu->dma_addr) {
> +                       ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
> +               }
No need for bracket
> +               if (iu->buf) {
> +                       kfree(iu->buf);
> +               }
kfree checks NULL already.
>         }
>         kfree(ius);
>  }
> --
> 2.20.1
>
