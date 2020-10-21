Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC49294FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502416AbgJUPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502394AbgJUPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:20:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82FEC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:20:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so3535307lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLcG8lvZq4hgK/VaoRnkMULOJQjO5EInk9g+zvCqUnE=;
        b=MAl/r4jqE+KR+6HrB1QvElLmxWwwM0yeVDZmh9oL+39m6yRG4uAWO4X987YERTSAEz
         DXHAHUB/vqvig4pg86f5KMONuMrmAJHRqiAWA+i5ROD/Wskva+HM3Z1wuYKyF8EjZPLe
         nGu8JDvSKQRU/5I6kzv9LGVKkG5z0lYl8Ored5bfoQdh2QVWZaDVhD5KMVDqIP2WZNMD
         Gj+vj8rkYilmwuzbB3mT3x/SfQO/zG2pmiISKdzTq1wZ7Mek8YBgInt3ITLhz5tYT1I7
         Rc8Cr/J7e28upXDXhRqLDSOaohbtS/zs7MPDhkOd9kQL/EFGT4fLwPG537iuMY1aiGr3
         R8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLcG8lvZq4hgK/VaoRnkMULOJQjO5EInk9g+zvCqUnE=;
        b=X6nyGvefk9E7F/bOAoB5ths1F1lpa4C8+HhdSil6jGXCU8Dlxd99O5uZxJCCUHJVk+
         1kGL2qenp225yOPDnuj0DPdU4qIQNWo6I3ARuEML0WwPe4Zb54U1SMqNEAxkMgV0aSkF
         Dsxd3M06r2zgIQCV0GmjXXgRtVkafyPAgklsqnKffA6ZKn2vv+hAQLLSd3R3axerDhla
         QG6J4blS7PHOstBX6HXUbIcxWw1aZ2Yph06boVEDp/ytMvCvkcibsCNEu9oRh6mjpJRr
         ODZdqUC80GkobAkjhVkLsZJWzVLzY2dGIJMCKphMOXtRJime/AB+cthsmCCo16g3ilps
         MUpw==
X-Gm-Message-State: AOAM531IUvktGLxda6W5tiO6JMjMomV0yWu98PfS/8pxqwks/L7uHcnt
        kIHRRkZLuOEsERGJpWi1NQK40Oj9oq7Y/ker90q7cg==
X-Google-Smtp-Source: ABdhPJxh45xMUoIAO1fqQeMLB7+/MFKy1enZ2D42K2i4BqZ+QN2XbRGLVllTzusQVEaBm3qaw/c//PjEv9Sc9wiFOuI=
X-Received: by 2002:a19:d10:: with SMTP id 16mr1375520lfn.385.1603293604386;
 Wed, 21 Oct 2020 08:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de> <20201021122532.GA30733@vingu-book>
 <20201021124700.GE32041@suse.de> <alpine.DEB.2.22.394.2010211452100.8475@hadrien>
 <20201021131827.GF32041@suse.de> <alpine.DEB.2.22.394.2010211522340.57356@hadrien>
 <20201021150800.GG32041@suse.de>
In-Reply-To: <20201021150800.GG32041@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Oct 2020 17:19:53 +0200
Message-ID: <CAKfTPtDs1t6mt7fPgoGg+fT-JKmaqWybNVBN3kZhag6M4+8RUg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: check for idle core
To:     Mel Gorman <mgorman@suse.de>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 at 17:08, Mel Gorman <mgorman@suse.de> wrote:
>
> On Wed, Oct 21, 2020 at 03:24:48PM +0200, Julia Lawall wrote:
> > > I worry it's overkill because prev is always used if it is idle even
> > > if it is on a node remote to the waker. It cuts off the option of a
> > > wakee moving to a CPU local to the waker which is not equivalent to the
> > > original behaviour.
> >
> > But it is equal to the original behavior in the idle prev case if you go
> > back to the runnable load average days...
> >
>
> It is similar but it misses the sync treatment and sd->imbalance_pct part of
> wake_affine_weight which has unpredictable consequences. The data
> available is only on the fully utilised case.

In fact It's the same because runnable_load_avg was null when cpu is idle, so
if prev_cpu was idle, we were selecting prev_idle

>
> > The problem seems impossible to solve, because there is no way to know by
> > looking only at prev and this whether the thread would prefer to stay
> > where it was or go to the waker.
> >
>
> Yes, this is definitely true. Looking at prev_cpu and this_cpu is a
> crude approximation and the path is heavily limited in terms of how
> clever it can be.
>
> --
> Mel Gorman
> SUSE Labs
