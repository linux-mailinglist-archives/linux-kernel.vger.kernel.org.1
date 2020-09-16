Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962CA26BD88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIPGxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgIPGxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:53:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:53:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so5710478lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C+Nk7T+vITgNqEYkt/umMt2Yjz3odf+MC/EzyDBXAQI=;
        b=pqGDWjzQ6lON2ewOoBOoVNQz1P4SBbfdNXCyPCmDM0dlQm5M7OpKIN4l1N0uqVG9BH
         fExAFWbSGmxfm1ecwiUDHHREZwIKb5agqnH7i39G9wN02r40IM84fx6CSJBiiJEBKe/a
         Z5GTFSkwAmpDm4t27zSOWuQBMRgrZ1Ul3CRsRUuS59FznJmfgH+F10vcOz+ITJoVKZN8
         uvX2Min8t2RAqgmZO3ssnUok5FygWJbdJqAk5ryWqe77EC/FGN+gPgCSrOZE5bHHdVHa
         ITJUEUB5HZV0so9n9/QFOnxwfPvB3F8XU9fngbqgjjFN9zZeRrM8QRLQPdx1fQTJSdKk
         lOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C+Nk7T+vITgNqEYkt/umMt2Yjz3odf+MC/EzyDBXAQI=;
        b=pMVZqn0PmXRZxQWcX6/W8LXEzDglNq6xLoBr5uXmogyjGgXef3g1YPqS2DYD34RCZ0
         SzjEWI3LQT63dsq5KNJoYyJ/9RVfmX65k7qgGvddqjXmD5rCrRb4i9+cT1fjx1YgJlW+
         QCtCzjz1MrpkuDRjbap2rRi6CA9iJkOBLqcH/1x8UNRsBs2xVM3zP8SEK2Tq5ELK3AYx
         KxJYk6y9xX2Kqdabg4U8Mtpfs7z8hIToYtgi2/jppsrzxfCDiNnLiXlcpJ9AueKbmfFT
         +fu3fLEr2zWNXCDNw1oTWHBlkxuCaHGN93BEp8BtH2aqz0ceeja2VPx8cEugaUPK0Otk
         aHrw==
X-Gm-Message-State: AOAM5317repX14TNqNbEtC39ymG95+I5aCbSRmoVaXGVJYYjNwFVgkR1
        /pJ//O1qsJAanOE2nok6Yu+nOQYgLPksRSIlRUv/HA==
X-Google-Smtp-Source: ABdhPJxagiTloaGlUG4JtyWd4Jd1ERoYnuJ/+sOAz4Xsj5l5+4IOZgJ2iyyCVDfyKfv1QqYN5v/YjnY9G5m1Ly9KrMQ=
X-Received: by 2002:a19:7006:: with SMTP id h6mr7040521lfc.83.1600239224273;
 Tue, 15 Sep 2020 23:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-3-vincent.guittot@linaro.org> <jhjimce6ev2.mognet@arm.com>
In-Reply-To: <jhjimce6ev2.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Sep 2020 08:53:32 +0200
Message-ID: <CAKfTPtC0Sf6SN+rqjQje-kXJiOaLzc0XnXqzS3hOF2FE=FscMA@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched/fair: reduce minimal imbalance threshold
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 21:04, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 14/09/20 11:03, Vincent Guittot wrote:
> > The 25% default imbalance threshold for DIE and NUMA domain is large
> > enough to generate significant unfairness between threads. A typical
> > example is the case of 11 threads running on 2x4 CPUs. The imbalance of
> > 20% between the 2 groups of 4 cores is just low enough to not trigger
> > the load balance between the 2 groups. We will have always the same 6
> > threads on one group of 4 CPUs and the other 5 threads on the other
> > group of CPUS. With a fair time sharing in each group, we ends up with
> > +20% running time for the group of 5 threads.
> >
>
> AIUI this is the culprit:
>
>                 if (100 * busiest->avg_load <=3D
>                                 env->sd->imbalance_pct * local->avg_load)
>                         goto out_balanced;
>
> As in your case imbalance_pct=3D120 becomes the tipping point.
>
> Now, ultimately this would need to scale based on the underlying topology=
,
> right? If you have a system with 2x32 cores running {33 threads, 34
> threads}, the tipping point becomes imbalance_pct=E2=89=88103; but then s=
ince you
> have this many more cores, it is somewhat questionable.

I wanted to stay conservative and to not trigger too much task
migration because of small imbalance so I decided to decrease the
default threshold to the same level as the MC groups but this can
still generate unfairness. With your example of 2x32 cores, if you end
up with 33 tasks in one group and 38 in the other one, the system is
overloaded so you use load and imbalance_pct but the imbalance will
stay below the new threshold and the 33 tasks will have 13% more
running time.

This new imbalance_pct seems a reasonable step to decrease the unfairness

>
> > Consider decreasing the imbalance threshold for overloaded case where w=
e
> > use the load to balance task and to ensure fair time sharing.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/topology.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9079d865a935..1a84b778755d 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1337,7 +1337,7 @@ sd_init(struct sched_domain_topology_level *tl,
> >               .min_interval           =3D sd_weight,
> >               .max_interval           =3D 2*sd_weight,
> >               .busy_factor            =3D 32,
> > -             .imbalance_pct          =3D 125,
> > +             .imbalance_pct          =3D 117,
> >
> >               .cache_nice_tries       =3D 0,
