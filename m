Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866C01FC46A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 05:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgFQDDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 23:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgFQDDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:03:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19088C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:03:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so970503lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RnSVVEnBBsu4D/UiZN7uiJr3tgDhgWeBzkH6jHbetY=;
        b=Z43V3rGplsGrRdtlpzG+sdV/9AWhyCvWfxGJQ+G3L1HmgWOze77eH6d7/xzS9+T1Ph
         gC+wUnaIb4jsER8lC++pKCCZBgIbF6c3UAmMbAxHkdBRI9FuCYf5wTyhEOMi0InlRXsr
         XaXL82y9JcCwIlb3kuiUI/yi7/cq8n3rEQo7WbMrmOpp/7TDIeHqZ/VeE39O/LaRjnvD
         e48t4+xGJRRDWsvoXb8lljGAJeYsLqoitld4NM4VJfFNN6jOfvDi2YfJI2zSprzBuN+A
         8C7v4Pv8BTjB6GUEHv3Myx8BUZHFfxv0djymKr4BXvzVphg6y49l7STRyVJdOqETZoem
         cIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RnSVVEnBBsu4D/UiZN7uiJr3tgDhgWeBzkH6jHbetY=;
        b=s7gAiKOFGAz70Kw5SX6O2uC10M+jgGuraOFe8kUO7LcKYTLr5nKlZ2iy9ZpV+tEdLk
         M1SQr+UV1mWxJpTzeTjma+FesJoAr4Xt5DeKW40lOIyhu5vCbOiokm13eKWh/1Vif9NK
         29crjlAEb/+ufNV9m8Z5DaG1RnjOmZqPlUPiHfGb9Y6GpWkVIdd0S9woFE0Lfw1GhDIm
         33pPXCGlkY6REu4aR5rcjS3NV1mxle8hbVK/9eNobDx527kxoPuKj7n7+Rkhx2oGn/EC
         ybxyil0BlAHAPy1wFIgHzPGa2P8YjsX6u3Kg7J9Ph7NWlMcDo7kJ4EKDiF0L48JpUcRM
         VELg==
X-Gm-Message-State: AOAM5313ot3ZwAtmP9lBSCF0oBDGHsHQNCHgqHSvde7BOlWoyHlQhQJe
        Kpudac4CDkaQDc0ASohr0gxzKQVY9Gu7ZYae5tp8GQ==
X-Google-Smtp-Source: ABdhPJxJlE0jNp92WgtycAxCuUj8SatZ+DUjVgrym603dBI9GYvoelsNyekA9VCNasLnULWjYOAOXfnGrPnXNQW5LGA=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr2956941ljj.270.1592362998332;
 Tue, 16 Jun 2020 20:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-4-guro@fb.com>
In-Reply-To: <20200608230654.828134-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 20:03:07 -0700
Message-ID: <CALvZod4B6wmn8jJM-61Nt_oYRdXFZGRenDCm1uUu_RxJTfuwpA@mail.gmail.com>
Subject: Re: [PATCH v6 03/19] mm: memcg: convert vmstat slab counters to bytes
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> In order to prepare for per-object slab memory accounting, convert
> NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.
>
> To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
> NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).
>
> Internally global and per-node counters are stored in pages,
> however memcg and lruvec counters are stored in bytes.
> This scheme may look weird, but only for now. As soon as slab
> pages will be shared between multiple cgroups, global and
> node counters will reflect the total number of slab pages.
> However memcg and lruvec counters will be used for per-memcg
> slab memory tracking, which will take separate kernel objects
> in the account. Keeping global and node counters in pages helps
> to avoid additional overhead.
>
> The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> so it will fit into atomic_long_t we use for vmstats.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
