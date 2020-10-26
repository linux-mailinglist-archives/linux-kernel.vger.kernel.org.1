Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE42990D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783626AbgJZPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:18:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783534AbgJZPSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:18:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id x7so13089870wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ei7riQ2CemaVaCr5xEQG1VVyzMpVuSgP8erxfF4qdy8=;
        b=mkZzAN6N8084VzBAc162j8/9u11rpcI8HYyZQvEmWrltBvBARy+4RObeGmMAKHDg1y
         CtP2GaMHN0zgkDFZCV2wpuWgfUODWz8/thpcMja8MOhtFChoyj4sKxODtLqgTr/HS2W0
         JnNcGDecs0qK6882qb2Gp9Ux3FffvLyQyQwxM7nxMduB9li8i6lel+rPPanJdXPkeCh/
         naMyo2x4mI4l8YwhRWFr8SUM/miHgXZD/IIOgPhPFWasngYWCvBh7PW7arPcYCgdBLgp
         1wH9Cz0zGmjrtfnqiq94/So19bZgjTTBVzprfatrFzEipCaib3qXKoHJ6fBMP8wAfHwq
         6F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ei7riQ2CemaVaCr5xEQG1VVyzMpVuSgP8erxfF4qdy8=;
        b=E1tVEu6a/I7vAcKWVI/MbKKk/2CUHBIddDmWdJ71of0L2dG8ErbJUYWerEg455Eolb
         lk+Howy76Da28O6KvFUosIsU839TMsaf65F3IrgYBrw5ujsxeg1J4dLKK3GBkEcBCJzh
         49Z0AUJE3ytvkSbHyzgLkVLnG22mbX8tcXQX0MJDuLXPDzq9xTZ1e1R+pddiYUiIiBVJ
         KKaMq+0n81MehP/uJCF1ZQN4FmPZ6Y/l8X3qn1iiVV5osmAdgOWcGQX+oTNskw02lUDY
         7XL5URI0rcP7ffEKkpgsDRt0TTu3y3ju+eDKKQRdJydpZp+y5zqjRPANdC4HJ6MurEo2
         hAaA==
X-Gm-Message-State: AOAM531VvJOG8aV+CRQrjvs5VyxoG4LrBbO5pE9YDWX0eCxKpf0Htqe5
        v7ZVOUWQH/+ipLvHZRl5iY3SQQ==
X-Google-Smtp-Source: ABdhPJxAbzYph2R8+vz6bYxUlhMmEftaozOM4W7Bj3+kF7EljLxAIo3UnQYVz+xWibdkdy9sGn+qtg==
X-Received: by 2002:adf:e885:: with SMTP id d5mr18535826wrm.100.1603725529347;
        Mon, 26 Oct 2020 08:18:49 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:e42d:d75b:ee18:e5c7])
        by smtp.gmail.com with ESMTPSA id y7sm21486745wmg.40.2020.10.26.08.18.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 08:18:48 -0700 (PDT)
Date:   Mon, 26 Oct 2020 16:18:46 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Chris Mason <clm@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Message-ID: <20201026151846.GA17073@vingu-book>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
 <20201026142455.GA13495@vingu-book>
 <83A9BEDF-20BB-4BAD-AABD-0EECB92BF8DF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83A9BEDF-20BB-4BAD-AABD-0EECB92BF8DF@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 26 oct. 2020 à 11:05:35 (-0400), Chris Mason a écrit :
> 
> 
> On 26 Oct 2020, at 10:24, Vincent Guittot wrote:
> 
> > Le lundi 26 oct. 2020 à 08:45:27 (-0400), Chris Mason a écrit :
> > > On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
> > > 
> > > > Hi Chris
> > > > 
> > > > On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
> > > > > 
> > > > > Hi everyone,
> > > > > 
> > > > > We’re validating a new kernel in the fleet, and compared
> > > > > with v5.2,
> > > > 
> > > > Which version are you using ?
> > > > several improvements have been added since v5.5 and the rework of
> > > > load_balance
> > > 
> > > We’re validating v5.6, but all of the numbers referenced in this
> > > patch are
> > > against v5.9.  I usually try to back port my way to victory on this
> > > kind of
> > > thing, but mainline seems to behave exactly the same as 0b0695f2b34a
> > > wrt
> > > this benchmark.
> > 
> > ok. Thanks for the confirmation
> > 
> > I have been able to reproduce the problem on my setup.
> 
> Thanks for taking a look!  Can I ask what parameters you used on schbench,
> and what kind of results you saw?  Mostly I’m trying to make sure it’s a
> useful tool, but also the patch didn’t change things here.
> 

with latest tip/sched/core on my dual quad cores:
schbench -t 4 -r 10 -c 1000000 -s 1000
Latency percentiles (usec)
50.0th: 16
75.0th: 23
90.0th: 32
95.0th: 41
*99.0th: 15120
99.5th: 15120
99.9th: 15120
min=0, max=15130

with the patch :
schbench -t 4 -r 10 -c 1000000 -s 1000 
Latency percentiles (usec)
50.0th: 28
75.0th: 32
90.0th: 36
95.0th: 56
*99.0th: 1310
99.5th: 1310
99.9th: 1310
min=0, max=1309

> > 
> > Could you try the fix below ?
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9049,7 +9049,8 @@ static inline void calculate_imbalance(struct
> > lb_env *env, struct sd_lb_stats *s
> >          * emptying busiest.
> >          */
> >         if (local->group_type == group_has_spare) {
> > -               if (busiest->group_type > group_fully_busy) {
> > +               if ((busiest->group_type > group_fully_busy) &&
> > +                   (busiest->group_weight > 1)) {
> >                         /*
> >                          * If busiest is overloaded, try to fill spare
> >                          * capacity. This might end up creating spare
> > capacity
> > 
> > 
> > When we calculate an imbalance at te smallest level, ie between CPUs
> > (group_weight == 1),
> > we should try to spread tasks on cpus instead of trying to fill spare
> > capacity.
> 
> With this patch on top of v5.9, my latencies are unchanged.  I’m building
> against current Linus now just in case I’m missing other fixes.
> 

I can't remember any changes in mainline that would make a difference

I had another way to fix it but it could impact more other UC and the improvement
was smaller

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebe15e36f336..415927885228 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7707,7 +7707,7 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);

-			if (util > env->imbalance)
+			if ((util >> env->sd->nr_balance_failed) > env->imbalance)
 				goto next;

 			env->imbalance -= util;
--


>
> -chris
