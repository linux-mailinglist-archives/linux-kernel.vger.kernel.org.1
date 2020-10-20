Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE5293C94
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407136AbgJTNAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406897AbgJTNA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:00:26 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6B1224B1;
        Tue, 20 Oct 2020 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603198826;
        bh=YS3R/r9BSCkgWKpofPP6Fiv0wMZ19e5Knq/avoUuwK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDLMXNORO5HWkh80eVTzM6+5IT1LhcN6Qt/Xl5opCpSpPHIPhxHsByOByLOUhnUjS
         xZG49NtLH5VVgVgy2i5zPaFd5cT/TDMekdzkjTo9oMv8w82zgGcTlVR00Bcz1mKGFD
         2FNcdVTpsah+9F5+/Sk5COkS/L1aroHU8EPpXNpA=
Received: by mail-oi1-f181.google.com with SMTP id m128so2018524oig.7;
        Tue, 20 Oct 2020 06:00:26 -0700 (PDT)
X-Gm-Message-State: AOAM533bIca1Sz99JPaHnGyMUTnE5OJU8jKkILnxnfp5UzhK4GzoT2f4
        99c4XaPvVTgjMH3qI+gVOJHPQDNaBo7EWwzxFg==
X-Google-Smtp-Source: ABdhPJy0Ku6xoc9kTBx9LWUZiAIoYdi1fCvyVuReWiM5ER83AZZ5av795XiRzJJ4rxRqtx11QNdDfOgk5dCDJKNh/so=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr1771142oie.152.1603198825256;
 Tue, 20 Oct 2020 06:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073558.3582-1-vincent.whitchurch@axis.com>
In-Reply-To: <20201020073558.3582-1-vincent.whitchurch@axis.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Oct 2020 08:00:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=mpw9KxiYe_bMa+y4mU8ybrRnJ2LcO8jRco9C3N_n_w@mail.gmail.com>
Message-ID: <CAL_JsqL=mpw9KxiYe_bMa+y4mU8ybrRnJ2LcO8jRco9C3N_n_w@mail.gmail.com>
Subject: Re: [PATCH] of: Fix reserved-memory overlap detection
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, kernel@axis.com,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:36 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The reserved-memory overlap detection code fails to detect overlaps if
> either of the regions starts at address 0x0.  For some reason the code
> explicitly checks for and ignores such regions, but this check looks
> invalid.  Remove the check and fix this detection.

Wouldn't 'base' be 0 for nodes that have a 'size' and no address? The
base in those cases isn't set until later when
__reserved_mem_alloc_size() is called.

>
> For example, no overlap is currently reported for this case:
>
>         foo@0 {
>                 reg = <0x0000 0x2000>;
>         };
>
>         bar@1000 {
>                 reg = <0x1000 0x1000>;
>         };
>
> but it is after this patch:
>
>  OF: reserved mem: OVERLAP DETECTED!
>  foo@0 (0x00000000--0x00002000) overlaps with bar@1000 (0x00001000--0x00002000)
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/of/of_reserved_mem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 46b9371c8a33..1c5259e3e81f 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -217,8 +217,7 @@ static void __init __rmem_check_for_overlap(void)
>
>                 this = &reserved_mem[i];
>                 next = &reserved_mem[i + 1];
> -               if (!(this->base && next->base))
> -                       continue;
> +
>                 if (this->base + this->size > next->base) {
>                         phys_addr_t this_end, next_end;
>
> --
> 2.28.0
>
