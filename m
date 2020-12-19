Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D222DF014
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 15:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgLSOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgLSOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 09:53:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C5C0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 06:52:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o17so13061815lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkBp5rL+/PBfutbbHdSYx1lnDR8/zByqi7yQkfcPe1o=;
        b=HN+UdUBj9NXIiZAnUQ34XuJb6foZDGPXhnJPot3VVZNe56moaQWWYWurL9UOP65fsj
         jWUE/N314RrMCk4Uuzm7hH5cTbD3XHdqK9cc4NKBblF2/em+Z59basBk+Aciv1VNOzpH
         UA24ZgSve4KLiFOZzoulY6YALNp5N3sK+7wuk4ZeGRNlRNY+BQyr2TZ3WlUn5neD/Qqb
         hST9npECGvU24DUPLOYCVUclxK297UzijrCYX7hgTraUXPzPx5m5p3XjqyoCOyCNi87X
         d2Ao5S4Pluworbamnc8d85+J/75KeVFu9tRdUgjRqO66yEN18fg6ub3KExqnJa4rC3Ei
         YhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkBp5rL+/PBfutbbHdSYx1lnDR8/zByqi7yQkfcPe1o=;
        b=Rmj6ffWi7lTjdpcWMp1hjZxGijCbNCHGCRh+K2Pn9Cb7QRJZ68brl2jnI0mBlur5wX
         V119WsdpbCJoNLDH6S2q8p5qAUEcM2H2+vrYJ1n/Vh2r4ozkAiXGvv+eZP9D0oYnXlEX
         pXPaak/mWqWfdom5XG5nOBO74B9GbalZDQ3AXL6ZcTl4YdZKWoG92irmokQZF/sajWdO
         BpeNlmPSxGO8HvExIswmVE+tizrs4QMCynadiwUq62powzzBmE+02mmNgRiRdjXTpFxJ
         LgZAqLYN9rKA8dm2oXYJ/VshfWEJFuzZL7lu7xaFDkHyau+mpWEEITEWVIKapvZeans7
         6TnQ==
X-Gm-Message-State: AOAM5317EDmlK883GQG19vOv7ntdPe3RSc7wTsaJ2nJ7t5Yta1s7VsAM
        AV1y1JQPpOJz9cttpIql/2HGHVkHD6nN/wkr5U0=
X-Google-Smtp-Source: ABdhPJzVbhChsjIwnE4Hx8mzlhh4rVkU/LQbglZ6N2SzfsKNZFzAYIXhfRsM09eQ6m4RL6vjpBre2GprOjZTlBg5HZ8=
X-Received: by 2002:a19:5f59:: with SMTP id a25mr3551727lfj.310.1608389549662;
 Sat, 19 Dec 2020 06:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20201217201214.3414100-1-guro@fb.com> <20201217201214.3414100-2-guro@fb.com>
In-Reply-To: <20201217201214.3414100-2-guro@fb.com>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Sat, 19 Dec 2020 23:52:19 +0900
Message-ID: <CAEcHRTqcrEdXcr02OZnSTgxwQ0Por7y4gAXn6uM=Dp=TVq_5kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with kernel_end
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Fri, Dec 18, 2020 at 5:12 AM Roman Gushchin <guro@fb.com> wrote:
>
> With kaslr the kernel image is placed at a random place, so starting
> the bottom-up allocation with the kernel_end can result in an
> allocation failure and a warning like this one:
>
> [    0.002920] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> [    0.002921] ------------[ cut here ]------------
> [    0.002922] memblock: bottom-up allocation failed, memory hotremove may be affected
> [    0.002937] WARNING: CPU: 0 PID: 0 at mm/memblock.c:332 memblock_find_in_range_node+0x178/0x25a
> [    0.002956] Call Trace:
> [    0.002961]  ? memblock_alloc_range_nid+0x8d/0x11e
> [    0.002963]  ? cma_declare_contiguous_nid+0x2c4/0x38c
> [    0.002964]  ? hugetlb_cma_reserve+0xdc/0x128
> [    0.002968]  ? flush_tlb_one_kernel+0xc/0x20
> [    0.002969]  ? native_set_fixmap+0x82/0xd0
> [    0.002971]  ? flat_get_apic_id+0x5/0x10
> [    0.002973]  ? register_lapic_address+0x8e/0x97
> [    0.002975]  ? setup_arch+0x8a5/0xc3f
> [    0.002978]  ? start_kernel+0x66/0x547
> [    0.002980]  ? load_ucode_bsp+0x4c/0xcd
> [    0.002982]  ? secondary_startup_64_no_verify+0xb0/0xbb
> [    0.002986] random: get_random_bytes called from __warn+0xab/0x110 with crng_init=0
>
> At the same time, the kernel image is protected with memblock_reserve(),
> so we can just start searching at PAGE_SIZE. In this case the
> bottom-up allocation has the same chances to success as a top-down
> allocation, so there is no reason to fallback in the case of a
> failure. All together it simplifies the logic.

I figure out that it was introduced by
commit 79442ed189acb ("memblock.c: introduce bottom-up allocation mode")

According to this commit, The purpose of bottom up allocation is to
allocate memory from the unhotpluggable node.
