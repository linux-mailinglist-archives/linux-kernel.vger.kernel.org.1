Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5134B26BE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIPHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:40:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726159AbgIPHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600242012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bynr/6OHkCm8o3a9mK4QimRwvSQuwNFxIu11+mv4kUY=;
        b=V8UPNpzrHumPy8+2wUb579m2fiYfeDvqm+yvO5Y5Q4uNMmm9y+tLlPRbW/ElmBY99FBwz7
        ftC5E80gxaKQ37OitNXZRNvfBOIEKve0HRZZ6MPg/1Fnknw/aa9EL7c3qv/nDiRJaJf6n7
        E+O31GX3eTi4u7G9NPpAXZeqybw/tNI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-lyH32SjtNLiuvabGpYYFEQ-1; Wed, 16 Sep 2020 03:40:10 -0400
X-MC-Unique: lyH32SjtNLiuvabGpYYFEQ-1
Received: by mail-qk1-f200.google.com with SMTP id y17so5486441qky.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bynr/6OHkCm8o3a9mK4QimRwvSQuwNFxIu11+mv4kUY=;
        b=L0AYL4jD5KmE3Z1xZUQru7HRq4DS2MeK5EMvxcgK0LK7L5tDZn7wK3QOyNi/Fcr4Oc
         bzAiqdy5nYU7pUSi94xSXcUplWPQdGNMBFE8QlcqC3tMVjge93nivQRkATEOy8GtZjkp
         8+Lr/81ey45VP46vLJi5Hf8or7GUvTbSaZk7ffVqFELK67u0JQrZB+wpAWh/s9wtIlAu
         yzF7MnjC857b9yzk7YxglXso8DGvy8l3SDhL7OXKSZpGiRN9pG2gTGPu9bPzKPqF3h6d
         ATArZrcfFud977iJSEVJicV8shz7yYbj0rEgqmwTb5dYLa3Ct6eKTSIddxrMJQ72/q69
         YbVw==
X-Gm-Message-State: AOAM533FdjWqkzkO3KC7dUUcp8AthBe43FaepPXjfQWlsvYikYV4OU2X
        PS+puvL5wuh9010724JufhcjDBz9mvNtm4g+Qt6M2ZrJKovsQdftSdTWhOSGSCsyLc4HJTVvngP
        6T9/PEsFNlhJRo58TOjqFg6PE
X-Received: by 2002:a37:30d:: with SMTP id 13mr21526933qkd.44.1600242010084;
        Wed, 16 Sep 2020 00:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw8F+RddDND/p2tqIgCb9R42vEJoeGV2bG64kjxPcWy5M18XMsjwuhCb9lgu6tV1dXbXnyJg==
X-Received: by 2002:a37:30d:: with SMTP id 13mr21526914qkd.44.1600242009816;
        Wed, 16 Sep 2020 00:40:09 -0700 (PDT)
Received: from x1.bristot.me (host-79-46-196-168.retail.telecomitalia.it. [79.46.196.168])
        by smtp.gmail.com with ESMTPSA id z6sm18403764qkl.39.2020.09.16.00.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 00:40:09 -0700 (PDT)
Subject: Re: [PATCH] sched/deadline: Fix stale throttling on de-/boosted tasks
To:     peterz@infradead.org, Juri Lelli <juri.lelli@redhat.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
References: <20200831110719.2126930-1-l.stach@pengutronix.de>
 <20200902060024.GK16601@localhost.localdomain>
 <20200902094339.GZ1362448@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <bbcd9183-5a48-b3b1-516c-041db8e2f5aa@redhat.com>
Date:   Wed, 16 Sep 2020 09:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902094339.GZ1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 11:43 AM, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 08:00:24AM +0200, Juri Lelli wrote:
>> On 31/08/20 13:07, Lucas Stach wrote:
>>> When a boosted task gets throttled, what normally happens is that it's
>>> immediately enqueued again with ENQUEUE_REPLENISH, which replenishes the
>>> runtime and clears the dl_throttled flag. There is a special case however:
>>> if the throttling happened on sched-out and the task has been deboosted in
>>> the meantime, the replenish is skipped as the task will return to its
>>> normal scheduling class. This leaves the task with the dl_throttled flag
>>> set.
>>>
>>> Now if the task gets boosted up to the deadline scheduling class again
>>> while it is sleeping, it's still in the throttled state. The normal wakeup
>>> however will enqueue the task with ENQUEUE_REPLENISH not set, so we don't
>>> actually place it on the rq. Thus we end up with a task that is runnable,
>>> but not actually on the rq and neither a immediate replenishment happens,
>>> nor is the replenishment timer set up, so the task is stuck in
>>> forever-throttled limbo.
>>>
>>> Clear the dl_throttled flag before dropping back to the normal scheduling
>>> class to fix this issue.
>>>
>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
>> Acked-by: Juri Lelli <juri.lelli@redhat.com>

I faced a similar issue, but involving DL tasks (not !DL):
  https://lore.kernel.org/lkml/5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com/

While debugging that problem, I reviewed and tested this patch,
and we need it. So:

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel


> Thanks!
> 

