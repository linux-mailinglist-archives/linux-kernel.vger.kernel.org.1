Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E847F26A1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIOJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:11:21 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242A8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:11:20 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a3so3077604oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZ2fuXwvtEurQKAt+nYzsoseQxdibBoC9LJBPLlnUjM=;
        b=dT59auUkAf3fXnvPDrmv8mgOLSdtkq4DpzpQzwNby4xzvgwjE2SJMPs801jzvFj5+7
         OttO4eEy2IfkguxU70AFqCnX0IipJ9jFbJwPSptYl0BwGESo5/YPM4AY0D7hAoOV+b30
         BWvSetMWr2QrtbqSyYy4n3yrw5FeTUANxWq5JJNnlN6vR/EvE9iVK1h3UEBemoARaWIe
         OP57frMu/yttrBzoX5oD7e5SMnjHLT7/UjVc9o5iOW1gJ5S8Gs/VEyT8k7/ydXEUGXmv
         WSinYH964Uf5mPm5jINDqxgtLHInsWkMVt8YuEa+A89kgp7jAenpIe3ZIHED27HO8ftC
         E6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZ2fuXwvtEurQKAt+nYzsoseQxdibBoC9LJBPLlnUjM=;
        b=diEY1kboT9pdroIiOUa8K9ssvfPBO+lxRPICrHzLPUaBmS3keTXR4ow2ASi4Nh8B5y
         SW5iOOsWEi7mt2/P+hEFHndcRCUFLB/0eKdEiCAr3/5VUXmRCTZoDue3kHMNF6O/1Px7
         FzhAOT2efAIQuYC39SlGWCeYeQBgbzgqcRGEHyuj/ZykoLaYQV3sQZUdN5lzxJIyCoOo
         7glg01lueIA4ZUQk1HNnt4ZJvksBIRAi1R8Nj3na1GFS8HanHTmcnKABGb0O6qp1y9l8
         UU6S+nlp5t/o5v65ddL/2SBqeDSBUCUlewkaGczJ3W71Psgf3FB5bzEt2PujZ/0051K4
         OD6Q==
X-Gm-Message-State: AOAM532sEkSF6CaWAcOHpQj3RnbV1WBJH6Uy3G2likAba/0FUdZKFcc8
        HQlpvKo70Y8Lz0cZ4EoIssihsVD30q2jjCdIiVY=
X-Google-Smtp-Source: ABdhPJx8TWU3CPIVdiGuzIdBp2Cpma5uEr0hEMgLGory95+uWx9byEtbMC3zvqQ+upch6wMqAXsv9qUL6E3/y19qiyg=
X-Received: by 2002:aca:3708:: with SMTP id e8mr2531991oia.101.1600161079428;
 Tue, 15 Sep 2020 02:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org> <20200914100340.17608-5-vincent.guittot@linaro.org>
In-Reply-To: <20200914100340.17608-5-vincent.guittot@linaro.org>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 15 Sep 2020 17:11:08 +0800
Message-ID: <CAPJCdBmNK2ZbvsOkzx=6TnzSD=EN28MjD=4ZsmnWjb907MC41g@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: reduce busy load balance interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vincent

On Mon, 14 Sep 2020 at 18:07, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> The busy_factor, which increases load balance interval when a cpu is busy,
> is set to 32 by default. This value generates some huge LB interval on
> large system like the THX2 made of 2 node x 28 cores x 4 threads.
> For such system, the interval increases from 112ms to 3584ms at MC level.
> And from 228ms to 7168ms at NUMA level.
Agreed that the interval is too big for that case.
But would it be too small for an AMD environment(like ROME) with 8cpu
at MC level(CCX), if we reduce busy_factor?
For that case, the interval could be reduced from 256ms to 128ms.
Or should we define an MIN_INTERVAL for MC level to avoid too small interval?

Thx.
Regards,
Jiang

>
> Even on smaller system, a lower busy factor has shown improvement on the
> fair distribution of the running time so let reduce it for all.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 1a84b778755d..a8477c9e8569 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1336,7 +1336,7 @@ sd_init(struct sched_domain_topology_level *tl,
>         *sd = (struct sched_domain){
>                 .min_interval           = sd_weight,
>                 .max_interval           = 2*sd_weight,
> -               .busy_factor            = 32,
> +               .busy_factor            = 16,
>                 .imbalance_pct          = 117,
>
>                 .cache_nice_tries       = 0,
> --
> 2.17.1
>
