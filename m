Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0027BD42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgI2GqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgI2GqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:46:15 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04324C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:46:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a4so2755712qth.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xEac7XYS7Ngt5MwOzy7ceKxpo4W5ekfGGC6+CP++DZg=;
        b=BXGARTTNhnDvN6+yx8fUbNfRk6oCA4PsGy8TrokK4PiImB02C9EbjuOTny9seKeMjX
         eh3Lt/1EuPp1XV16cUlcOntWTn5Y/u/KHjZrFIkliWL8KCRqKuz6e/XU5rHWZ6o/Dsl7
         iCGSgbmbHTMQ6n7NLTcleeNAEPxLZF1rVKVwMc1e8jeRfz4J1px72BDqpjrUSs1eSgRy
         nQA4WRgpYerKwSPL6D540VcDbyFMVN+IcNLokiB5eM3tihyTrDA5oHOTfSlPXZCIWX8i
         hJ0nrzXAaotnB1/1hQ3JRQBQaTDN0ze5cILwjzbSih1K5g8pKcZHng8udycm5FnP6ciK
         0bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEac7XYS7Ngt5MwOzy7ceKxpo4W5ekfGGC6+CP++DZg=;
        b=AbnP3rJVLqM9NTL59d708C0s+WulmFgs1ZnG9O6B+QSpCRHHzWnBVnYZggOY4MMN94
         E28sV6RtdGob0xaIJWI3OczQJkyc28VkLKwZSZb9KJCLfHTu0SYZYD7Kcst+Umsl39IT
         QzPIzBaWrxyK9e060+Jyse/uZ29yKTzyBKScQeyBLPYBhUSGMv7AgYzUK/GsogoYt3wT
         CWm8PvnwVWtRw1/wwdl6qqLBrni0L9BmU6Ahn46+E80RcUInCscGIqGgxoZiBCqqTRch
         CG2QxAQ2Oj0zhsaK8UnCZJgaqSdhCqJzqDzoqrWXLXttuEBrRqtYU2YjczsR3V0BRcU1
         TVxQ==
X-Gm-Message-State: AOAM532te2Scwz25dp3ZRorTt1VjwOkMQ/2IanHl5HYvrl8E2p9AnhJX
        kOQF6Qafmr8JtHRdJ2GXX3crPXOpgFTdFSTXkd7keG4UQ4s=
X-Google-Smtp-Source: ABdhPJxT9VWbqcYNBXPlkfDppcO4eI4dGwKQZVXZ5MTHHmZ6tMPPVtdFMicHPMDvZPBMHR+s/4hLY4BIQKwwGojDeT4=
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr1866068qto.36.1601361974096;
 Mon, 28 Sep 2020 23:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200928165215.f46924bfff9a109131048f81@linux-foundation.org>
 <CAAmzW4OY7z+bF=aFOsNuadc8M_f1Pb7jifuxzQo5AL6mCuO5Ng@mail.gmail.com> <20200928215055.02ff9b3ff5e0c392b2403411@linux-foundation.org>
In-Reply-To: <20200928215055.02ff9b3ff5e0c392b2403411@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 29 Sep 2020 15:46:02 +0900
Message-ID: <CAAmzW4NPv+mu5P9=jHf0XgcrPjbCKJZR1hQkUkPvcTHb-0q50g@mail.gmail.com>
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 1:50, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Tue, 29 Sep 2020 10:28:05 +0900 Joonsoo Kim <js1304@gmail.com> wrote:
>
> > > What about manually emptying the pcplists beforehand?
> >
> > It also increases the probability. schedule() or interrupt after emptyi=
ng but
> > before the allocation could invalidate the effect.
>
> Keep local interrupts disabled across the pcp drain and the allocation
> attempt.

As said before, it's an allocation context API and actual allocation
happens later.
Doing such things there is not an easy job.

> > > Or byassing the pcplists for this caller and calling __rmqueue() dire=
ctly?
> >
> > What this patch does is this one.
>
> I meant via a different function rather than by adding overhead to the
> existing commonly-used function.

Got it. One idea could be disabling/enabling pcp list on these APIs but
it's overhead would not be appropriate on these APIs. I don't have
another idea that doesn't touch the allocation path.

Thanks.
