Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C53298F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781386AbgJZOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:25:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780854AbgJZOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:25:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id y12so12799580wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g4Ny0lpZa+kqvC7NOSadrSZ1jZmqq4LSsWHBJuF2KCg=;
        b=nG53+jQkO9eSJdSWrOiCBCMs+eLZn+NjnP03o5a9eOSFgKSR5u4QwgS098BPhw+OmY
         Op6MiexN51LbN8DfX66z0+cihcbKkUvSAr4+2+JC3vhAtw1QDg4pYW6otWCrU4RKCrEg
         ZNqdE35DX+9vXInrgY9crI/Pa9motrhyjMQntvyzaV4uA0P9ctrGR4nYOWGJRudjiRkG
         zkfZd8qJogyVUIlbnAgDAGpr169AZRaBPw275Wv3pRcbFU1F/bdACd/gE0xlXri59m6O
         nJllOOkf/FITpl1sIIunHG2yeQ9flmLF0u53YdhCWzYSC5m//8MsYa6Fg/KJRvvDR/xW
         80UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g4Ny0lpZa+kqvC7NOSadrSZ1jZmqq4LSsWHBJuF2KCg=;
        b=mvy5RHpxBBqMW0B/ThjZBFZnp5NI0rV/2tCzUWwKNRGiLWsKXxXiknIX6ATlxVjea6
         ebHWD1k07U7O0FgS4nWLzN2Q4j83gmwwgQU6Jq1orjUTEo0xm9pdNVnIqGDFAGo7sVYI
         rXsyG3hNxPog/zb8UXSLe6SGAXg40AQ+IL9Rq96vSSJa78kwW0UxcPC7RYuje5EooMIq
         GKDafYcGPN+B2bI7Xq9a4DpSDfVuVI2chPph1sq0fMbv+SKbugLiuE87zyIgayvI3DUu
         PnTFV4zj00DyobHxMQq+ZPG2TiZjSZKj1Mp4J5HsiR3i6KBuOT4ULkuwRkQIXBg4LegP
         U1xA==
X-Gm-Message-State: AOAM533CTf53gA93OmablPjpMJYmGkDV/aSG/pbffIgdJMndbM6VupFI
        z8G87uaNRrHMF6sfah2yhkitmIO1dwN2eg==
X-Google-Smtp-Source: ABdhPJye4UkrgpjJJzwCmeVUBBnbH9z8xGQYdjDHGs4lYUElP/TshVLFvTDVV4WQDrQsRh5M4BDJBQ==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr18029625wro.273.1603722298588;
        Mon, 26 Oct 2020 07:24:58 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:e42d:d75b:ee18:e5c7])
        by smtp.gmail.com with ESMTPSA id k203sm23402687wmb.37.2020.10.26.07.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 07:24:57 -0700 (PDT)
Date:   Mon, 26 Oct 2020 15:24:55 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Chris Mason <clm@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Message-ID: <20201026142455.GA13495@vingu-book>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 26 oct. 2020 à 08:45:27 (-0400), Chris Mason a écrit :
> On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
> 
> > Hi Chris
> > 
> > On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
> > > 
> > > Hi everyone,
> > > 
> > > We’re validating a new kernel in the fleet, and compared with v5.2,
> > 
> > Which version are you using ?
> > several improvements have been added since v5.5 and the rework of
> > load_balance
> 
> We’re validating v5.6, but all of the numbers referenced in this patch are
> against v5.9.  I usually try to back port my way to victory on this kind of
> thing, but mainline seems to behave exactly the same as 0b0695f2b34a wrt
> this benchmark.

ok. Thanks for the confirmation

I have been able to reproduce the problem on my setup.

Could you try the fix below ?

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9049,7 +9049,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
         * emptying busiest.
         */
        if (local->group_type == group_has_spare) {
-               if (busiest->group_type > group_fully_busy) {
+               if ((busiest->group_type > group_fully_busy) &&
+                   (busiest->group_weight > 1)) {
                        /*
                         * If busiest is overloaded, try to fill spare
                         * capacity. This might end up creating spare capacity


When we calculate an imbalance at te smallest level, ie between CPUs (group_weight == 1),
we should try to spread tasks on cpus instead of trying to fill spare capacity.


> 
> > 
> > > performance is ~2-3% lower for some of our workloads.  After some
> > > digging, Johannes found that our involuntary context switch rate was
> > > ~2x
> > > higher, and we were leaving a CPU idle a higher percentage of the
> > > time,
> > > even though the workload was trying to saturate the system.
> > > 
> > > We were able to reproduce the problem with schbench, and Johannes
> > > bisected down to:
> > > 
> > > commit 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
> > > Author: Vincent Guittot <vincent.guittot@linaro.org>
> > > Date:   Fri Oct 18 15:26:31 2019 +0200
> > > 
> > >      sched/fair: Rework load_balance()
> > > 
> > > Our working theory is the load balancing changes are leaving
> > > processes
> > > behind busy CPUs instead of moving them onto idle ones.  I made a few
> > > schbench modifications to make this easier to demonstrate:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git/
> > > 
> > > My VM has 40 cpus (20 cores, 2 threads per core), and my schbench
> > > command line is:
> > 
> > What is the topology ? are they all part of the same LLC ?
> 
> We’ve seen the regression on both single socket and dual socket bare metal
> intel systems.  On the VM I reproduced with, I saw similar latencies with
> and without siblings configured into the topology.
> 
> -chris
