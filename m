Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681812B050C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgKLMjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:39:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A584C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:38:59 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so5142184wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmXXhcCIZu4jFQzqQB3QfkIDFS4lZhtswR4XI6KwvqY=;
        b=omnyfRB6n5XXMe+K958toSAR/WyxL0s/RfMKGOqhS9uwDa4Qt4fFschIseHiOXBOY3
         4tvNNS+NgygdrMEmPUffVw6iY7F8SnICgnQ9PXNLwBGR/CNufguXy9K/YcHT5yaWRuoG
         dPxIfsEqV22tR76OChAakmNr/cs9rxoepaB6XgkXanaiOMAYDDpijyY20VaufvSdHQEQ
         OuM7wQNSuo2huNkT/+7Z1tLvD7V7YxMDTl5B9tYxZmcBazKWyBtG7X1pqxrw4lH4WxFe
         1o0UN8UL/kPxkRmU/YTNCiq8A7prF5DBOwozp+IzoaBG1pcPnI3APDb71LG9rlE6aKzU
         vOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmXXhcCIZu4jFQzqQB3QfkIDFS4lZhtswR4XI6KwvqY=;
        b=Dw31cQitHwodAFzGZ2yAUNdd10rTg1mmeP4KhMQkzA1Al1aaK9IATpAqVHsAVys5DZ
         zf7aYS0F/MDvtKow9ygkgnCqyRCz6LEi7Uf+5gpcT70Sx1qkN+eVH7Qf1YVe/NKRHwOJ
         Rf8UqcWzEK27upagmZyknTSx+zlV45AAywHSyDDUQsHUBIwxpr7J4LMV0G/Cvh21OIhz
         rLoypeJ8KT2hBfNHVON4NnPguwoTskvbLMkvSFNWZbqkiLI580jOFIKINWeDpUsC+rK4
         Amehxdtg8FUGHdFpIMNi3thw09+T4MS99jQ4Ej9bCcNpHU3+yf3xx9z6Kfo89svO1Awx
         x4SQ==
X-Gm-Message-State: AOAM531eiT9ev80ZPcSSU9RmP0oXnkaVAMpulygEGKx58r1jL4Fe83AA
        8CqZskfNHaJWbUltyIkJ7Lo6vA==
X-Google-Smtp-Source: ABdhPJxwMjNtIQ+opFCW3OuF3lyY3beqiK2SWhF7YVL9/ADvn+y6G9kQw5+NLT68pfoiFJkiwSfhMw==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr8754019wmg.5.1605184738158;
        Thu, 12 Nov 2020 04:38:58 -0800 (PST)
Received: from google.com ([100.120.9.192])
        by smtp.gmail.com with ESMTPSA id b1sm6716667wmd.43.2020.11.12.04.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:38:57 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:38:54 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Rick Yiu <rickyiu@google.com>
Subject: Re: [PATCH] sched/fair: Fix overutilized update in
 enqueue_task_fair()
Message-ID: <20201112123854.GA2222462@google.com>
References: <20201112111201.2081902-1-qperret@google.com>
 <jhjh7puyczc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjh7puyczc.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 Nov 2020 at 12:29:59 (+0000), Valentin Schneider wrote:
> Alternatively: how much does not updating the overutilized status here help
> us? The next tick will unconditionally update it, which for arm64 is
> anywhere in the next ]0, 4]ms. That "fake" fork-time util_avg should already
> be accounted in the rq util_avg, and even if the new task was running the
> entire time, 4ms doesn't buy us much decay.

Yes, this is arguably a dodgy hack, which will not save us in a number
of cases. The only situation where this helps is for short-lived tasks
that will run only once. And this is a sadly common programming pattern.

So yeah, this is not the prettiest thing in the world, but it doesn't
cost us much and helps some real-world workloads, so ...

Thanks,
Quentin
