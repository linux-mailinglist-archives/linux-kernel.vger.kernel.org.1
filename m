Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAF2590C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgIAOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgIAOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:17:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A4C061249
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 07:17:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so677732pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KeS8GKVJq4T+CUgWiidHvzznWbWtkMB2WevyIbiUS5I=;
        b=XLzONATGaZUk6RmUTMF0GqUspbosIonDxdLp5n7lUSWgIaD9z1FySY8zCcjgDgdO9c
         UfwDEOX20gSkEu9ogQk1AmBfwiYDZAMyTtT+OQwliywIdq0yzqV5xju1jDq8CypTR7er
         AcudE8BiwbZkuQsOze0xqL/NtoOQdF5TsCWkedgUUBmTzuyg+2CZrBvq7hkqKwQVvtWZ
         mhkPySDERdy15+hmLSDJMq0rV3bsG+0B+YBokrPl2XrFYDExJFQrB3umYTmJPnKTIwJp
         15CukajAo9d9+K+gzOSNhPvM1zW6CcXg0x5QhowwfWHJR8hE1n9+0MQfFCi+HslBbPvJ
         ysrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KeS8GKVJq4T+CUgWiidHvzznWbWtkMB2WevyIbiUS5I=;
        b=l4t2O6woRMikGVOE5J38gDoa2+0po/X+VBq9laP3kdnOjdVvcj/t95PI9mif4T0ZWp
         yTtBQ7em8CWitqkmutlKfO/xN52m4pap6hpjW5G2LE7FyyKl3jgqOwfZ0IM1OQnjaeP5
         75OaIQGF4E2dwHPyiOf7rNEBCkXcPurcL0WSJq9NlX/cPpWCU5XiFUSBVl6ROpRn3DoO
         VLMjqU9r/bY2zooZOe7Iz8UIxM5ONQVSC/uk6SS+aO3rrC88Q4M0PFK9EMUBXgmfBYrT
         SpMT66HFM04SnWZ+AsiKUUw7gOjvGU2MseoLbUPDyexb/DTZO3qYOeKHZC0+2aFPDF+P
         Td4A==
X-Gm-Message-State: AOAM530rVw29d9Llx/O8j69M1/b46PcLgoeMw69rH6tkpH5ggyIvdyS7
        hKan3NYfRl1wmQDK7FhbqXJU2w==
X-Google-Smtp-Source: ABdhPJwTKTTtzYF2fDa2cowvfZektAF3tPSKAyVIQ88mb1mgNFiqoQOXUnIV/DKwOj3wmrEflZZYiA==
X-Received: by 2002:a17:902:ff12:: with SMTP id f18mr560148plj.118.1598969875941;
        Tue, 01 Sep 2020 07:17:55 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c8sm2041855pfc.203.2020.09.01.07.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:17:55 -0700 (PDT)
Subject: Re: [PATCH v2] io_wq: Make io_wqe::lock a raw_spinlock_t
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200819123758.6v45rj2gvojddsnn@linutronix.de>
 <20200819131507.GC2674@hirez.programming.kicks-ass.net>
 <f26205ac-9da9-253e-ea43-db2417714a94@kernel.dk>
 <20200819194443.eabkhlkocvkgifyh@linutronix.de>
 <20200901084146.4ttqrom2avcoatea@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dd494f20-40d3-1abd-697b-f69d3edbb406@kernel.dk>
Date:   Tue, 1 Sep 2020 08:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901084146.4ttqrom2avcoatea@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 2:41 AM, Sebastian Andrzej Siewior wrote:
> During a context switch the scheduler invokes wq_worker_sleeping() with
> disabled preemption. Disabling preemption is needed because it protects
> access to `worker->sleeping'. As an optimisation it avoids invoking
> schedule() within the schedule path as part of possible wake up (thus
> preempt_enable_no_resched() afterwards).
> 
> The io-wq has been added to the mix in the same section with disabled
> preemption. This breaks on PREEMPT_RT because io_wq_worker_sleeping()
> acquires a spinlock_t. Also within the schedule() the spinlock_t must be
> acquired after tsk_is_pi_blocked() otherwise it will block on the
> sleeping lock again while scheduling out.
> 
> While playing with `io_uring-bench' I didn't notice a significant
> latency spike after converting io_wqe::lock to a raw_spinlock_t. The
> latency was more or less the same.
> 
> In order to keep the spinlock_t it would have to be moved after the
> tsk_is_pi_blocked() check which would introduce a branch instruction
> into the hot path.
> 
> The lock is used to maintain the `work_list' and wakes one task up at
> most.
> Should io_wqe_cancel_pending_work() cause latency spikes, while
> searching for a specific item, then it would need to drop the lock
> during iterations.
> revert_creds() is also invoked under the lock. According to debug
> cred::non_rcu is 0. Otherwise it should be moved outside of the locked
> section because put_cred_rcu()->free_uid() acquires a sleeping lock.
> 
> Convert io_wqe::lock to a raw_spinlock_t.c

Thanks, I've applied this for 5.10.

-- 
Jens Axboe

