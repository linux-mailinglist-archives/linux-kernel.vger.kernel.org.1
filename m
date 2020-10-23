Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9522973B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750628AbgJWQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371933AbgJWQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:28:52 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B161C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:28:52 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s17so961793qvr.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwXZ6YlKNW5FUdYgADLt3SCi+dhnvwWZ2Km5ctnW+fw=;
        b=NDfGDPy3ifEFbObWD0M4QIK6AcNVdMdNoQMO/IGUvvSlos022jgbYQqkM/kNiNvqW4
         6rlTwYEvXiUHULKvW352CXilNgQhseXWXsKo62P+DIiWmn8PCj5e4V8xKqOBVxF8fTja
         xxJw3OHO4z+3iCUG4aAV/G9i4km9LxG/NTfRzQvEGWlw9zK4ZUPZ8VJfqGkVRZTWgfsI
         JEbK2SB0I8x7wJwrRlHS999HsOc3iQIWbdqiUvrQgsmeAc53pZBONhQoqZtxD2ny06uo
         z87htzTaGkvxEhTly/gNNJqVbdn1jE2OQBkGsOvCmTteZyijGPEE3G7ZhzlIKqqA6XVM
         RzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwXZ6YlKNW5FUdYgADLt3SCi+dhnvwWZ2Km5ctnW+fw=;
        b=Q+kR2AkaVGQQBigVOIuzgl10KyNqyI8z/Nu2fdWv8VPH7v5rfGh2RrLk2QeYUvUH0M
         IxUOFGpSwEejBNow8A8DKkhrNhLSz/x2Kx0rNWW96ISNil9Vws1C3lejAx17fG5WszAC
         pKW1AqnoxTYAbNw5sS+eeDk14OWnosYJGl27+dDJhav968Q/VwHFVjyxtmY1zVHfyOjx
         PkNvuVDR1LFJXOToTOeYeFmT5DaZIfPcCBKIpqNWqw1zlFTphvMrMUKiX0AoESYyaHmf
         ymdm8Dm2Xj7Nm4mE6uxODpBglEr/WY2x6LGWRpozIF73B4fXI2azTHOBMRxcurDH+RH0
         Xggw==
X-Gm-Message-State: AOAM533YblTFOkLwUf3EBeqIGo5cBrOI1uHeQdekJ1dKRez//i9xTS6M
        Wp4HNnF3EUjpbjuLdbk2zA6xcBcg+d1aPBDbhS4=
X-Google-Smtp-Source: ABdhPJwgN9aFTRjjZp2c00RrZASPYDNUviyrNn5sMDzxrd1TJPhE1xyp31I+IThDJJDpQbeRUGCueBSYgUMC/e6aaa8=
X-Received: by 2002:a0c:b447:: with SMTP id e7mr3179463qvf.1.1603470531534;
 Fri, 23 Oct 2020 09:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sat, 24 Oct 2020 00:28:40 +0800
Message-ID: <CADjb_WSG-z78KYmS=f2cLYdYLeqi=eqmLw+Q=sMGOBEM7Bw2Ug@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: check for idle core
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 1:32 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
[cut]
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa4c6227cd6d..9b23dad883ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5804,6 +5804,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>         if (sync && cpu_rq(this_cpu)->nr_running == 1)
>                 return this_cpu;
>
> +       if (available_idle_cpu(prev_cpu))
How about also taking  sched_idle_cpu(prev_cpu) into consideration?
if (available_idle_cpu(prev_cpu) || sched_idle_cpu(prev_cpu))

Thanks,
Chenyu
