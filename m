Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9472D145F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgLGPFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLGPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:05:41 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E0C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:04:55 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so15290001ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hH3HH1W/RdGqCEOBZUdis54iFut/lRLRcuUST7BctN4=;
        b=nmqDfxGjl4uCmTqkR6aOZDk0yp/hvoy0PCUbM16UMMElqTWeHunwHNKk9NHaVPHazV
         51FsVp6diC8OT5WV7GpfcetvX+3g3icgH+AyeuxcPIxuA5oWp7QHVfoQdSpgV0+mjNPL
         9fZG5u6i9U+a6i+C5UuZrGGwwPUx+7Hl2EqwZuTkK0z0jhLtsLcUKFED0GQGToe51bzl
         C5TDGBgRFrtS/DLiiPDLiNKE9VCbgYojGMmYwyLcwDjAVRuLBYBk64iwnBAkW4fYuoZ/
         nS0k+4W57UJn14s92/+CNXiifU2e5+Df6Pyywin1pYmVpQjEmQGvTK5GSOKhBmKtB/MZ
         QFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hH3HH1W/RdGqCEOBZUdis54iFut/lRLRcuUST7BctN4=;
        b=YkESZJGXxU2iDwL/xXeOVWNbAiUXePPgU7xBtoKB7e354zwVH0m56fmRQnjL8b0Lno
         7LxABgRBEKaeTCECfF2RIk29ROwECMBYrBWHek7wi0DOnDUOiQ5DEZIXs2uKM4wCdL72
         L6NWwHxwI229CaLWb9jZ4IYnNaSxcPKEsWS1AT85TzWspxqXHB/g4qS9FJNVx8r8naGz
         dndkKWhQuaWM0byqVzYoqQqgYl/9R4JosyzQlcLO9fOeH/DL9jIq/PCYG4EFyHWmqCeS
         r8pJJ1nAsVsv163pt2a1mGfFNdnm64MfFm3C7aY53HJWjAbh/wsrhKhDKBNLBi8Wi50o
         5bCQ==
X-Gm-Message-State: AOAM531TxXbcJxcKoCV2fo/beDk4lPzjYChGaqUqUwvkWuh483D3A3ls
        8y+QYjRAEaSgVU/qt6dxsC9tEj7ug4DhW922MTh2iw==
X-Google-Smtp-Source: ABdhPJwAZmBEgjXUg/vVei+pbotwoNHAJnvhFOkL0tEDVpvez1cAY8vT6OmhpM3R37fAqhs8ncgEVzNomifjRCmxuao=
X-Received: by 2002:a2e:800e:: with SMTP id j14mr8744290ljg.226.1607353493834;
 Mon, 07 Dec 2020 07:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net>
In-Reply-To: <20201207091516.24683-1-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Dec 2020 16:04:41 +0100
Message-ID: <CAKfTPtC9At0Oej+u6-mtBdV6_vhFiNJGPQ-BFQc7RpUtDDixVA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Reduce worst-case scanning of runqueues in select_idle_sibling
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 10:15, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> This is a minimal series to reduce the amount of runqueue scanning in
> select_idle_sibling in the worst case.
>
> Patch 1 removes SIS_AVG_CPU because it's unused.
>
> Patch 2 improves the hit rate of p->recent_used_cpu to reduce the amount
>         of scanning. It should be relatively uncontroversial
>
> Patch 3-4 scans the runqueues in a single pass for select_idle_core()
>         and select_idle_cpu() so runqueues are not scanned twice. It's
>         a tradeoff because it benefits deep scans but introduces overhead
>         for shallow scans.
>
> Even if patch 3-4 is rejected to allow more time for Aubrey's idle cpu mask

patch 3 looks fine and doesn't collide with Aubrey's work. But I don't
like patch 4  which manipulates different cpumask including
load_balance_mask out of LB and I prefer to wait for v6 of Aubrey's
patchset which should fix the problem of possibly  scanning twice busy
cpus in select_idle_core and select_idle_cpu



> approach to stand on its own, patches 1-2 should be fine. The main decision
> with patch 4 is whether select_idle_core() should do a full scan when searching
> for an idle core, whether it should be throttled in some other fashion or
> whether it should be just left alone.
>
> --
> 2.26.2
>
