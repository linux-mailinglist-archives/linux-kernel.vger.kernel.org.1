Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AEE28D2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgJMQxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:53:20 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39140 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgJMQxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:53:20 -0400
Received: by mail-ej1-f65.google.com with SMTP id lw21so760607ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 09:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=E5dq2k/kyKUZ06hCnaaoTuCwfc83kyj6EFYwzSuOeXk=;
        b=B1qtbOd9DbQw6UZUbgLYr6Yk/3Dcvw8k3zM9KGA7aXEJwUH+zzP1ICGh5UOAKWib/s
         UBJmjVyqJ8ETzblhk4oQucf1dMj4SD7yhDKdu6e9hTmE0f/iVPiaOdN6aTfCYmtYLhm6
         M4Wbk/vraapCJ4zop3clmIbDCbYhhMPcKdFZElVj7L1c+4xtIZAOAU9EFoC6940tiiDS
         CGz+g8whKNte7gWfJkr8JYp8993DU7xRFYSTC8Vh3Oow9piuqbQfcK08qGq6ediZMfew
         z8CFXZw3nGfUS9EH/zbsQrTT9OMVAYbgpJq8hKFI8uwce10cM+erpYX1446a/h2bVVYt
         FgtA==
X-Gm-Message-State: AOAM531+rArq8GgUP2HBw1v32Ltl0/eKWPdOg9WxyJa7nUWaxB5K3Ydr
        TUq0ftVO9YS+Be1PXSxYQ4V7r+MW/Y/dO6tt
X-Google-Smtp-Source: ABdhPJwopx3Is1xqbuu7+GazOyrxcECqDe6yintbboXqp8cdX7DG42fRhHTegI4+o9yo5wyCM5+Sug==
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr694333eja.216.1602607997748;
        Tue, 13 Oct 2020 09:53:17 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id zk17sm256341ejb.125.2020.10.13.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:53:16 -0700 (PDT)
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <87blh6iljc.derkling@matbug.net>
 <20201013102951.orcr6m4q2cb7y6zx@e107158-lin>
 <875z7eic14.derkling@matbug.net>
 <20201013133246.cjomufo5q7qsocrn@e107158-lin>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, dietmar.eggemann@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
In-reply-to: <20201013133246.cjomufo5q7qsocrn@e107158-lin>
Message-ID: <87362ihxvw.derkling@matbug.net>
Date:   Tue, 13 Oct 2020 18:52:03 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 13, 2020 at 15:32:46 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> On 10/13/20 13:46, Patrick Bellasi wrote:
>> > So IMO you just need a single SCHED_FLAG_UTIL_CLAMP_RESET that if set in the
>> > attr, you just execute that loop in __setscheduler_uclamp() + reset
>> > uc_se->user_defined.
>> >
>> > It should be invalid to pass the SCHED_FLAG_UTIL_CLAMP_RESET with
>> > SCHED_FLAG_UTIL_CLAMP_MIN/MAX. Both have contradictory meaning IMO.
>> > If user passes both we should return an EINVAL error.
>> 
>> Passing in  _CLAMP_RESET|_CLAMP_MIN will mean reset the min value while
>> keeping the max at whatever it is. I think there could be cases where
>> this support could be on hand.
>
> I am not convinced personally. I'm anxious about what this fine grained control
> means and how it should be used. I think less is more in this case and we can
> always relax the restriction (appropriately) later if it's *really* required.
>
> Particularly the fact that this user_defined is per uclamp_se and that it
> affects the cgroup behavior is implementation details this API shouldn't rely
> on.

The user_defined flag is an implementation details: true, but since the
beginning uclamp _always_ allowed a task to set only one of its clamp
values.

That's why we have UTIL_CLAMP_{MIN,MAX} as separate flags and all the
logic in place to set only one of the two.


> A generic RESET my uclamp settings makes more sense for me as a long term
> API to maintain.
>
> Actually maybe we should even go for a more explicit
> SCHED_FLAG_UTIL_CLAMP_INHERIT_CGROUP flag instead. If we decide to abandon the
> support for this feature in the future, at least we can make it return an error
> without affecting other functionality because of the implicit nature of
> SCHED_FLAG_UTIL_CLAMP_RESET means inherit cgroup value too.

That's not true and it's an even worst implementation detail what you
want to expose.

A task without a task specific clamp _always_ inherits the system
defaults. Resetting a task specific clamp already makes sense also
_without_ cgroups. It means: just do whatever the system allows you to
do.

Only if you are running with CGRoups enabled and the task happens to be
_not_ in the root group, the "CGroups inheritance" happens.
But that's exactly an internal detail a task should not care about.


> That being said, I am not strongly against the fine grained approach if that's
> what Yun wants now or what you both prefer.

It's not a fine grained approach, it's just adding a reset mechanism for
what uclamp already allows to do: setting min and max clamps
independently.

Regarding use cases, I also believe we have many more use cases of tasks
interested in setting/resetting just one clamp than tasks interested in
"fine grain" controlling both clamps at the same time.


> I just think the name of the flag needs to change to be more explicit
> too then.

I don't agree on that and, again, I see much more fine grained details and
internals exposure in what you propose compared to a single generic
_RESET flag.

> It'd be good to hear what others think.

I agree on that ;)

