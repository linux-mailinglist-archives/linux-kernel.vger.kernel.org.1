Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1865B29922F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785712AbgJZQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:20:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38473 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785690AbgJZQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:20:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id n18so13317959wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ui1aLnCpshOWPm9PKRyoRYJffTFHYk92mnNv32SvF6I=;
        b=IaPFxo/JrSzCZRBbrETqBMMlU+NZudHx/cgWA77cCJDTbJo5nySOiIm/uZGOnXgWr0
         ZXzHScUVst6vVgeVYwZQJG8o7erGxVEDaRpNAzT3ryH3ewnGATVDrIHBfBpj6B5TN6IG
         oHNQ863H0FUWgf9GNdWhecmEDC/cbsKl98oCOlhJ1A305lJ1Qhr5edSOozALEcfdpvkf
         2WHNDSB4rfFVe+5jQMBAqHxeFk+F53Pki5Kj/U64cmReiqCAPCZ3nrTmCvRRcen0q8Xt
         B8o2jBhhvufij78G0tS3INXvFDdupwvyS3RSmK+r1f2ZOH6YAC+JFleilK7+bwEc7Eip
         uiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ui1aLnCpshOWPm9PKRyoRYJffTFHYk92mnNv32SvF6I=;
        b=Nt4BQfbSgTTt6GRppJVSuI+N8YfGIOjIPt8HJlg6IdovRwvUkSJJYi0AaHhacKVzaA
         lEcekAdP35119tCnLElfaM+lSp7HTEixda+bTJX8/2jyXzUoR6FIKrcJczFOt+SxFsG3
         5XFCfSKMdcgty2SZJVCRGpV2rsXpMayoZ0Bdc+mNAqjCH43s1PbI0kPbLize7RNRh2j6
         9soQlxEsKtyzgtZnIYOZGpmAeXg7jLroZdsO/C9QX7B3b8DyXn2WeiZu5CAg/qD6Uvff
         0QFDIbgh8a5BMk3tCIOFj7MnuMtOaVTkwBkuxGdr71poa4YC3Ty1kuKol7kjBNwTc1TP
         hRFA==
X-Gm-Message-State: AOAM531JL8i9Qya45xERnSmwwwiPusI7lZs6TjW9j8r6MjvJ8CYo3U14
        VrOsR6LU8PwsCbXzcURDdWFc5w==
X-Google-Smtp-Source: ABdhPJztaGxzjHBgMxMa0RZSvubpscxJNFNDk2eB3t0HM9dpmdNPIv20XO9S7RrczThj1vCJokK1Fg==
X-Received: by 2002:a5d:6149:: with SMTP id y9mr19003675wrt.352.1603729232468;
        Mon, 26 Oct 2020 09:20:32 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:e42d:d75b:ee18:e5c7])
        by smtp.gmail.com with ESMTPSA id c18sm22610992wrq.5.2020.10.26.09.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 09:20:31 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:20:29 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Mason <clm@fb.com>, Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Message-ID: <20201026162029.GA11367@vingu-book>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
 <20201026142455.GA13495@vingu-book>
 <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
 <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
 <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
 <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
 <20201026120445.6a5dbbbe@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026120445.6a5dbbbe@imladris.surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 26 oct. 2020 à 12:04:45 (-0400), Rik van Riel a écrit :
> On Mon, 26 Oct 2020 16:42:14 +0100
> Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > On Mon, 26 Oct 2020 at 16:04, Rik van Riel <riel@surriel.com> wrote:
> 
> > > Could utilization estimates be off, either lagging or
> > > simply having a wrong estimate for a task, resulting
> > > in no task getting pulled sometimes, while doing a
> > > migrate_task imbalance always moves over something?  
> > 
> > task and cpu utilization are not always up to fully synced and may lag
> > a bit which explains that sometimes LB can fail to migrate for a small
> > diff
> 
> OK, running with this little snippet below, I see latencies
> improve back to near where they used to be:
> 
> Latency percentiles (usec) runtime 150 (s)
>         50.0th: 13
>         75.0th: 31
>         90.0th: 69
>         95.0th: 90
>         *99.0th: 761
>         99.5th: 2268
>         99.9th: 9104
>         min=1, max=16158
> 
> I suspect the right/cleaner approach might be to use
> migrate_task more in !CPU_NOT_IDLE cases?
> 
> Running a task to an idle CPU immediately, instead of refusing
> to have the load balancer move it, improves latencies for fairly
> obvious reasons.
> 
> I am not entirely clear on why the load balancer should need to
> be any more conservative about moving tasks than the wakeup
> path is in eg. select_idle_sibling.


what you are suggesting is something like:
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4978964e75e5..3b6fbf33abc2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9156,7 +9156,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
         * emptying busiest.
         */
        if (local->group_type == group_has_spare) {
-               if (busiest->group_type > group_fully_busy) {
+               if ((busiest->group_type > group_fully_busy) &&
+                   !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
                        /*
                         * If busiest is overloaded, try to fill spare
                         * capacity. This might end up creating spare capacity

which also fixes the problem for me and alignes LB with wakeup path regarding the migration
in the LLC

> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 35bdc0cccfa6..60acf71a2d39 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7415,7 +7415,7 @@ static int detach_tasks(struct lb_env *env)
>  		case migrate_util:
>  			util = task_util_est(p);
>  
> -			if (util > env->imbalance)
> +			if (util > env->imbalance && env->idle == CPU_NOT_IDLE)

we don't want to be so agressive outside LLC and such bypass will defeat the purpose of
using utilization instead of nr_running.


>  				goto next;
>  
>  			env->imbalance -= util;
