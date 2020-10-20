Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7886B293E73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407979AbgJTORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407909AbgJTORk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:17:40 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9C92098B;
        Tue, 20 Oct 2020 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603203460;
        bh=7rH2oCmShidqtPeA4u5rqM8J73bTkhhLU52QiXSBT40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=loKa6NqWkAorw1V+jQUaedGQesUGpg8Ez9fJnm1t9IEMJ9eNUcaWAyTk1ZDfJTUFH
         /796j9czwnLAg57zLBoO0ALBSNgxfnM1XnNNQwquHJtCuymT8YvUH9assDv4ixZcz9
         DM9tMUmlifgD9y5kEG1Z7PT6qmEB21+Ejdb16j5c=
Received: by mail-oi1-f174.google.com with SMTP id l4so2265877oii.13;
        Tue, 20 Oct 2020 07:17:40 -0700 (PDT)
X-Gm-Message-State: AOAM530i+ZNcXtqD7JuSvPV0Tb7C8Sbif9KV/tEGsJXTHz4Bflq51xLs
        i6p99AEvomzkdKMWOWj2SIHt2LkpwoTlCpwpQQ==
X-Google-Smtp-Source: ABdhPJwwMbzoJNdkar6AQtqjXlAl0kh7cMIjxwLaKPuqf0iUgqDinvcoGFpo9atKoDl182fG0by5MQwBCpuMkdye1E0=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr2072666oia.147.1603203459435;
 Tue, 20 Oct 2020 07:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073558.3582-1-vincent.whitchurch@axis.com>
 <CAL_JsqL=mpw9KxiYe_bMa+y4mU8ybrRnJ2LcO8jRco9C3N_n_w@mail.gmail.com> <20201020134633.3vv7hyvodg4tbro2@axis.com>
In-Reply-To: <20201020134633.3vv7hyvodg4tbro2@axis.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Oct 2020 09:17:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrM4mS+tRDjipEQ8HBGgoevWHzGBWCiioMAFLnBRb63Q@mail.gmail.com>
Message-ID: <CAL_JsqJrM4mS+tRDjipEQ8HBGgoevWHzGBWCiioMAFLnBRb63Q@mail.gmail.com>
Subject: Re: [PATCH] of: Fix reserved-memory overlap detection
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 8:46 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Tue, Oct 20, 2020 at 03:00:14PM +0200, Rob Herring wrote:
> > On Tue, Oct 20, 2020 at 2:36 AM Vincent Whitchurch
> > <vincent.whitchurch@axis.com> wrote:
> > >
> > > The reserved-memory overlap detection code fails to detect overlaps if
> > > either of the regions starts at address 0x0.  For some reason the code
> > > explicitly checks for and ignores such regions, but this check looks
> > > invalid.  Remove the check and fix this detection.
> >
> > Wouldn't 'base' be 0 for nodes that have a 'size' and no address? The
> > base in those cases isn't set until later when
> > __reserved_mem_alloc_size() is called.
>
> Ah, yes, I guess that's why the check was there.  I see that those
> entries have both a zero address and a zero size, so this seems to work:

Yes, I think it should work.

>
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index 623246f37448..6627e71c7283 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -81,6 +81,18 @@ vram: vram@4c000000 {
>                         reg = <0x4c000000 0x00800000>;
>                         no-map;
>                 };
> +
> +               foo@0 {
> +                       reg = <0x0 0x2000>;
> +               };
> +
> +               bar@1000 {
> +                       reg = <0x0 0x1000>;

0x1000 base?

> +               };
> +
> +               baz {
> +                       size = <0x1000>;
> +               };
>         };
>
>         clcd@10020000 {
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 46b9371c8a33..fea9433d942a 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -200,6 +200,16 @@ static int __init __rmem_cmp(const void *a, const void *b)
>         if (ra->base > rb->base)
>                 return 1;
>
> +       /*
> +        * Put the dynamic allocations (address == 0, size == 0) before static
> +        * allocations at address 0x0 so that overlap detection works
> +        * correctly.
> +        */
> +       if (ra->size < rb->size)
> +               return -1;
> +       if (ra->size > rb->size)
> +               return 1;
> +
>         return 0;
>  }
>
> @@ -212,13 +222,19 @@ static void __init __rmem_check_for_overlap(void)
>
>         sort(reserved_mem, reserved_mem_count, sizeof(reserved_mem[0]),
>              __rmem_cmp, NULL);
> +
> +       for (i = 0; i < reserved_mem_count - 1; i++) {
> +               struct reserved_mem *this = &reserved_mem[i];
> +
> +               pr_info("i %d base %x size %x\n", i, this->base, this->size);
> +       }
> +
>         for (i = 0; i < reserved_mem_count - 1; i++) {
>                 struct reserved_mem *this, *next;
>
>                 this = &reserved_mem[i];
>                 next = &reserved_mem[i + 1];
> -               if (!(this->base && next->base))
> -                       continue;
> +
>                 if (this->base + this->size > next->base) {
>                         phys_addr_t this_end, next_end;
>
