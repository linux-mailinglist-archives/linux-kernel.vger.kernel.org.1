Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C1278A80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgIYOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:12:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05902C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:12:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so2611249ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3EHYGO+Bk2YmEykFKBXqgnpGOmXC25sDRNG2CxcX0k=;
        b=wLZOEWU0r/DdQeM7DbsimwS6gE5Xs8/HVtNDa1iG0oa3mVTzXa/qFAJY8BuVEFwkwA
         bTr0ZZF49k5O5Qwg7RoQzfhB4SvqhdJBeixSQk4YNMwiIGD45JLSWSYNWKhav8LDrNYw
         p2F3sj54TxRIjoej1NY3LwPwx/1BoPFx1el+csul39BR4EmKkVG7vmihyXBc1ytHDaIn
         KCuAJtsnroBkiHdYUvR/a6w6grHxNTjcyuaMsgs5ucf22Up8FHGGnBBOWXpjFLYy3+5t
         9btdRYvCQIIjUaAaEakcIeIvC609YCFc3fJ6d0V4Yc53kRKlPrJM9qZvANtOCKQLnS9J
         VfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3EHYGO+Bk2YmEykFKBXqgnpGOmXC25sDRNG2CxcX0k=;
        b=G3BV1wOWY4aP62PsdpbOfYPq1QiiJ8qDs7HIlCDoiWXyHtIOyT//SUFIssA3O7ROFR
         ydE4SDf0zc84M8QWb+/YEm0Fe29EAvwwrPcyJeDz0wiPUpD6Nw3QAz6qOruhhlH0lzH0
         DNOkFI5q3wkm/cxg2b1OumdYENZNYyq9jtw+Sm81zwnS+frQAjXU7QL2tKrOUvscoyrG
         +J9upiUMKd/uWOFObNRpGPAlLiTwp/YhzpMWaovzPUDyoIxfU/Dnj8FA0Zjyc/RPs9no
         vGhtaeiheOKZhX15ljdOZNsipj1YViv5ujMKEcpgEcsvKvhLKWcK9Te2qWNdt5vGg+X7
         bDGw==
X-Gm-Message-State: AOAM5305jWy/NSwCJ32l77lgQ0JcVhYe3vQYHvaNpvDH3GflpmE2cdP8
        Rjow91vzBAhv1e2IG76Jc86jHupOl/uBa2OAlAMbcA==
X-Google-Smtp-Source: ABdhPJwcOOBtNVvUdwFFz/RaMuSGMFKh16Qs9u5bJAqbN0gOlEMYwneQJQh6x1KWmGeUVb6rf6Bj8jdv0pb9NVMvn2w=
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr1537601ljp.177.1601043134426;
 Fri, 25 Sep 2020 07:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200922132410.48440-1-yuehaibing@huawei.com>
In-Reply-To: <20200922132410.48440-1-yuehaibing@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Sep 2020 16:12:01 +0200
Message-ID: <CAKfTPtBxrZUYsPsBrzNa4c5DF4X7gHknPTn_uZezkUtQoJZRCw@mail.gmail.com>
Subject: Re: [PATCH -next] sched: Remove unused inline function uclamp_bucket_base_value()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 at 15:24, YueHaibing <yuehaibing@huawei.com> wrote:
>
> There is no caller in tree, so can remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..1b06b952dbbe 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -940,11 +940,6 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
>         return clamp_value / UCLAMP_BUCKET_DELTA;
>  }
>
> -static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
> -{
> -       return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> -}
> -
>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
>  {
>         if (clamp_id == UCLAMP_MIN)
> --
> 2.17.1
>
