Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DADB2F8BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAPGB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 01:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbhAPGBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 01:01:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 22:00:45 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d13so19309450ioy.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 22:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/i5c7iiXT13Sgad6jMJ5Ur1nvJoRX/QGmNKBPRcwnm0=;
        b=Xtr6XxaFi0Y1IdhBZU5acTMyys0BX6tztb+GP/uoNxlWckXsYcTu/wZfQMrgS+md8K
         P5R4zU6iYDKrnZA846WU8KZHGEStR47ieo9QAzJ5rGEj/OT4+pEyn9WO8LGl2UgT5D1J
         bpbozkW+FV0G8OfK6F2y64p+pG0BLgj/g0pc3nHrnaw58BV4yLD9Qa2+kWHLZfuCrTUl
         VohCMG//9gbWH7sHFaxpccjcJRrvGFPJosVk5sFhvezfM42XP4zp2KpovAOUDc2DaMS+
         lUqRHGbQvfTFd6pmFPOmihvHVpAdDj6WjfPID29CSDd9qal3nnM0AJvPkBaQtRdoo+2I
         wbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i5c7iiXT13Sgad6jMJ5Ur1nvJoRX/QGmNKBPRcwnm0=;
        b=EO/Kd/nChVXLzciHPLFw+mcjbAwgnMp9dv8Jz7t3m9SwzHTuvtIFwHHXIgXLGiV8ul
         lvioZMyf5tNC+9+YzYr3lYPqOuA/gizjEKxK9Suwu2MWzmz7gmNN7PK+EYCaS4ltS/x7
         Eo3zFPBqQnVYz3pYaa4KdB09SQbhbFq+HQ020KU2Ij3Z/FVaex45Y6RYXXSRHjsr/B0X
         ZrL84z8Kc4hOVXl4uiJjA+yUV+2O0Lwl6Qkb3yAxjCERtu/dRnVxmt62c3C8gnDBD1u2
         YfJoJ/hvbma5eitgWCD1ZcY7otZf21/cobdsSfu/HYD6cDjia6ztonbEWLPcQwuJJ6fH
         3IlQ==
X-Gm-Message-State: AOAM531wQ9BNk/WVAA3G9evZSnnCKdzALndsknkaW+qtb+dCWbcDQlVk
        oFK1DD3wLYFE5zEjg3Y65BC937hqL//ayHxYj24=
X-Google-Smtp-Source: ABdhPJwZE/i/7v4ZaYfnwQ69/5MT53wkX2TgxTOYWYcS6RZJeGZDcdw/6qg1yJlk/UK/Urg+D6LyZU18dnbg36M+yXg=
X-Received: by 2002:a92:49cf:: with SMTP id k76mr3507903ilg.52.1610776844760;
 Fri, 15 Jan 2021 22:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net> <20210111180907.GE2743@paulmck-ThinkPad-P72>
 <20210111215052.GA19589@paulmck-ThinkPad-P72> <20210112171411.GA22823@paulmck-ThinkPad-P72>
 <20210112235324.GA17895@paulmck-ThinkPad-P72> <YAFcVy9wIezTa2mM@hirez.programming.kicks-ass.net>
 <YAGS2mulIw6o+sY5@hirez.programming.kicks-ass.net>
In-Reply-To: <YAGS2mulIw6o+sY5@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 16 Jan 2021 14:00:33 +0800
Message-ID: <CAJhGHyAC59=iohLdDFD56UGTeqEz8-U880emOMDS2UWMr+rJ6g@mail.gmail.com>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 9:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 15, 2021 at 10:11:51AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 12, 2021 at 03:53:24PM -0800, Paul E. McKenney wrote:
> > > An SRCU-P run on the new series reproduced the warning below.  Repeat-by:
> > >
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "112*SRCU-P" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutree.softirq=0" --trust-make
> >
> > Lemme go wake up an EX ;-)
>
> Whee, rescuer thread goes wobbly... took a few hours but there you have
> it.
>
> All I've got so far is fugly, gotta think harder.

Hello,

With the help of this patch, you can solve the problem.

https://lore.kernel.org/lkml/20210116065753.2163-1-jiangshanlai@gmail.com/
