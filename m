Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF92CCEFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgLCGFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgLCGFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:05:24 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58613C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:04:38 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so1063930lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3ZfoIQ82MnzqWNj21WEZs0AiTW/X3VKZYL9qOBzRgs=;
        b=YFgtOCqB2A6PtCxXfCh6M5QEOENLm7BfWm2Nyefdv9JxgPtXzsoXlNpNv46ac+EPMq
         6J6RCQMObMO0ialqdGVwmkTKY1DzPHhuNzYZk8qh/FN7Cjh+rg8Zqi6JrB+6T4H/cXoq
         ICB5NWH1AsoMUv6ziWP1RKxQp+E+MWLy6+c+MkB/071xyR/IQfkCshhJZEmOVc8+AlcX
         Pk275wS4+JscXIxjyCmskZGskPdOPBRWn3MxwUBRLoQjxpKdQolavH9+nkoYj3JjBTL6
         dMVPZk/Q+rkMoqjMKsQTVWXFa1wf08p4oSREK0+2b83ksO7nJWHBw2QivtyByl2K6ZWK
         Vu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3ZfoIQ82MnzqWNj21WEZs0AiTW/X3VKZYL9qOBzRgs=;
        b=nb0ITTtlZMyfuFfbBfsCxzwpXUe0uabwaW2duP1lvNRw96vTw0e/n/CJEVtdJKgMjC
         9z2njkUKfbm9NrCzWKnOPlegCNCKU997Oses+SzEL3SsY+GjtQyl6hZ4wEqntYIATNVN
         a94lgx/xkfx+1y/DDh8mS2lApQhJGr6FnVQlSNND9gLWBjdhJ8Szg0YxrxgYL6WS5dRK
         CQ8SUqch4u3HUHYdYD/h9TDcMxik6h2vjS/QN5zo3Yy1ck3LeRSKw+KFru5IRAjOLWnv
         LfOBdNPqdx2/z5YwTvpJ9Eluo77KhCwv0Sj5HpaWkrdYOBCtBb1Csw7xzXy/M62JCPeC
         JEZg==
X-Gm-Message-State: AOAM530SEmSDUzbo/W64MPMcqGJpnhcQ0h291TFi8ktlEOnsVHw0XrOR
        tCIEQghmQoBMVVw1yx93rp2GJyRXMOaIv/xGFZcL0NEE6qo=
X-Google-Smtp-Source: ABdhPJzTaUsBKOp4Vl/7vi4gI+xBxp+p7JXFHLnQNo+zcr0STYerwcGp1HIU8c64plJToP1OFW8hByGcJ61lk9SSvhM=
X-Received: by 2002:ac2:550d:: with SMTP id j13mr652596lfk.301.1606975476894;
 Wed, 02 Dec 2020 22:04:36 -0800 (PST)
MIME-Version: 1.0
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com> <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
In-Reply-To: <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 3 Dec 2020 06:04:25 +0000
Message-ID: <CAJwJo6YmF+tW2_it2BLCP6fLBrUR6kfx7jG0hsNy6uYG203Jfw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To:     Will Deacon <will@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        robin.murphy@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, xiyou.wangcong@gmail.com,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 21:50, Will Deacon <will@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:25:30 +0800, John Garry wrote:
> > This series contains a patch to solve the longterm IOVA issue which
> > leizhen originally tried to address at [0].
> >
> > A sieved kernel log is at the following, showing periodic dumps of IOVA
> > sizes, per CPU and per depot bin, per IOVA size granule:
> > https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
> >
> > [...]
>
> Applied the final patch to arm64 (for-next/iommu/iova), thanks!
>
> [4/4] iommu: avoid taking iova_rbtree_lock twice
>       https://git.kernel.org/arm64/c/3a651b3a27a1

Glad it made in next, 2 years ago I couldn't convince iommu maintainer
it's worth it (but with a different justification):
https://lore.kernel.org/linux-iommu/20180621180823.805-3-dima@arista.com/

Thanks,
             Dmitry
