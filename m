Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305DC251CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHYPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:52:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:52:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so14367116ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHSFQrjZHAaK6c2r2wcs6JOsgCtrTLBeAvyy7LBBQW4=;
        b=NooWtfxjikEFUBZ0gKwgvN1NRpBmGRbeeNzrO/+tkaSRBCJ0vKgjh4rx0jE1c+5a+l
         6fFTRPm4m0oRNEbmMXCe2V8KLIhgRZbp4ZshbJ4NZLAnoxfemb/RfQKjX13N+cA3n0To
         CCM6JQp9tVXhvphsqCogPbsliHDRjyD4cOIhCJSDSo0oJXCJrXYWEh5qtP4V0bDQYu5C
         tHllRcZygSRpM1I7/YhhlObAWR4miqPgA9eNca5noAHD0TgnpZqSmP/jFKASuibRMsbq
         i+5KZOARgzhTjIFdVCs3BVNCTMezrlhuFVICrBvKrYVde/QrA+u6ZO1+ZymVmS6c6MiH
         Zq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHSFQrjZHAaK6c2r2wcs6JOsgCtrTLBeAvyy7LBBQW4=;
        b=pfUzho3CRm4/40Ztkh75yWtNUeKreINkcMzZ6bcT3lG/HerUO66FApYjko3pGAj/8C
         2x7uzf4/C9VQTVFcm1r+NXt0eyIKOH3p0PChdSJLdqQH47WPzOGg8uzAS7heahjD41rh
         wMtVQiAMN1RGNPqDwTYHFkZkQUcvFY7ao46AMHQcUDc+aYlJgI/Mh6bz/ZfZblqShqqX
         Uwl/tTzv+/w/DJMqvrac1Xd5Oort1ar/ulsuRfCmrQlaqybaW1PIvCGtUteFK3mfnmHh
         gRvi9pB2ab4FCu+Cj1jkhQsZHNVpTNZZ6C4ZdsORx2ONjUssqjzFUM1uBkf8jpAARoya
         k1+A==
X-Gm-Message-State: AOAM53146dhNsDcqbIhBYvFF8or0Os8IHWKbAACj2iqWzNzVMG6+9ju2
        Pl9fBcdBdvG1zPfEAnbYfeb2fEqgTJTfkjJviURiPQSDEeY=
X-Google-Smtp-Source: ABdhPJwdAb40aUYvsW3uCcBqK7XgBG/A3oSnYmuI/jvqjdbNSI2GdjS0lVAW1jrJVTYlb35qTwua+vVISbVNeS26kEQ=
X-Received: by 2002:a2e:b045:: with SMTP id d5mr5474069ljl.111.1598370769636;
 Tue, 25 Aug 2020 08:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200825121818.30260-1-vincent.guittot@linaro.org> <20200825135841.GC3033@suse.de>
In-Reply-To: <20200825135841.GC3033@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Aug 2020 17:52:38 +0200
Message-ID: <CAKfTPtBfb25L4J2tF-XOXVJSu8-N-dzU3mBdTPVxAtCnUZNfLA@mail.gmail.com>
Subject: Re: [PATCH] sched/numa: use runnable_avg to classify node
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 at 15:58, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Aug 25, 2020 at 02:18:18PM +0200, Vincent Guittot wrote:
> > Use runnable_avg to classify numa node state similarly to what is done for
> > normal load balancer. This helps to ensure that numa and normal balancers
> > use the same view of the state of the system.
> >
> > - large arm64system: 2 nodes / 224 CPUs
> > hackbench -l (256000/#grp) -g #grp
> >
> > grp    tip/sched/core         +patchset              improvement
> > 1      14,008(+/- 4,99 %)     13,800(+/- 3.88 %)     1,48 %
> > 4       4,340(+/- 5.35 %)      4.283(+/- 4.85 %)     1,33 %
> > 16      3,357(+/- 0.55 %)      3.359(+/- 0.54 %)    -0,06 %
> > 32      3,050(+/- 0.94 %)      3.039(+/- 1,06 %)     0,38 %
> > 64      2.968(+/- 1,85 %)      3.006(+/- 2.92 %)    -1.27 %
> > 128     3,290(+/-12.61 %)      3,108(+/- 5.97 %)     5.51 %
> > 256     3.235(+/- 3.95 %)      3,188(+/- 2.83 %)     1.45 %
> >
>
> Intuitively the patch makes sense but I'm not a fan of using hackbench
> for evaluating NUMA balancing. The tasks are too short-lived and it's
> not sensitive enough to data placement because of the small footprint
> and because hackbench tends to saturate a machine.
>
> As predicting NUMA balancing behaviour in your head can be difficult, I've
> queued up a battery of tests on a few different NUMA machines and will see
> what falls out. It'll take a few days as some of the tests are long-lived.

Thanks for testing Mel

>
> Baseline will be 5.9-rc2 as I haven't looked at the topology rework in
> tip/sched/core and this patch should not be related to it.

looks fine to me

>
> --
> Mel Gorman
> SUSE Labs
