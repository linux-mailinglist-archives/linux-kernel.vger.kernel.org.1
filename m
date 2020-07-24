Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F622C07B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGXIMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:12:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C296C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:12:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so7455619wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6m8MPunnWnimoI8Tr90cXlgJie5/8V6P4spqo5yR3oA=;
        b=rYN++5sI6uFsZ4lzSC5kXiJ2bIlfMMhlKCn6cNHsZsqhNTEctNRB3jXApCdZkY+Iga
         Aska2E6Dps0wUimqz4oyvDlKCvIv1eVON8R/sE6g1l5ULQqaFiCOcxrCVeJYU4pKNH5y
         dWjELZvKV1fakMBy0HsVzJ5w0RXquLc7JtpoW30NhYZRE26n37TFgE5FXNlkBQBNOhLK
         Lvk9FalQRsObfPi7+p65qFzEY/8K5nm+6Isx+F9+wsR5M3H6YGLl2CsmWPqSrDrJ6AlP
         Uf+xWmn4VnyRKITODbECoAoOzhYoYLzjpsvdGloKED79RF635kyqghHwHMbK8lo+P2fv
         yAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6m8MPunnWnimoI8Tr90cXlgJie5/8V6P4spqo5yR3oA=;
        b=oOLSDbE9rjCTrDs75wjVTyKaxfog+IcIela/YNjxgCstymfSzPYk9IeWWQoXivS3J7
         0quTbN4+ueIYz+Rrs13WeWgAfhwAPv6kd4s8AmAePi7iHA/ysyAoWvDSdxKsJDoO64t6
         6pzD3jYKy4u2lJROYKZNM8WVXVNOmpp1QJbLhm2RX4CC+bVqO8BuNpywyNzMChyf++Mq
         sC/xnsjdKEgTZepP4qf9UOGK8QUgAeMW8l+XcpjXBn2b4eLLQ+bHxJ2P+g7rBMExGgWk
         ulqPYsOL854s2e1zzXDdKKwSrOzMsr3vzo+eK5WRuoJWHy9PRktupIKUSfGp7uN2DCmh
         b4fw==
X-Gm-Message-State: AOAM531JuBj2xhsrTk7MNsCkD8IDTEljecEWfPGIQQU30xXrbFs5AEOe
        6Y/zUw04eyBNy7GVRc7ECFyjACI9RAJ+1vLrZLA=
X-Google-Smtp-Source: ABdhPJzmgBbim0+iQSTRtt3i8djYhE1SSkUXosg01WNCYrXcBmOWUTUgNIEZX6Xfv9R29wIEQKd4ExZpFGIodr0Y8js=
X-Received: by 2002:a1c:28a:: with SMTP id 132mr7496150wmc.109.1595578366312;
 Fri, 24 Jul 2020 01:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200723233853.48815-1-humjb_1983@163.com> <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
In-Reply-To: <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Fri, 24 Jul 2020 16:12:35 +0800
Message-ID: <CAPJCdBnv4W5+u6OZ4vbAdJ2U8ubhfAU7+Zt0JUFjfxKEDuGJSw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: consider sched-idle CPU when selecting idle core
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Jiang Biao <humjb_1983@163.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 15:24, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 24 Jul 2020 at 01:39, Jiang Biao <humjb_1983@163.com> wrote:
> >
> > From: Jiang Biao <benbjiang@tencent.com>
> >
> > Sched-idle CPU has been considered in select_idle_cpu and
> > select_idle_smt, it also needs to be considered in select_idle_core to
> > be consistent and keep the same *idle* policy.
>
> In the case of select_idle_core, we are looking for a core that is
> fully idle but if one CPU of the core is running a sched_idle task,
> the core will not be idle and we might end up having  the wakeup task
> on a CPU and a sched_idle task on another CPU of the core which is not
> what we want
Got it. sched_idle task may interfere its sibling, which brings me
another question,
If there's a core with smt1 running sched_idle task and smt2 idle,
selecting smt1
rather than smt2 should be more helpful for wakee task, because wakee task
could suppress the sched_idle task without neighbour interfering.
And there seems to be no consideration about that currently.
Is it worth improving that?

Thanks a lot.

Regards,
Jiang
