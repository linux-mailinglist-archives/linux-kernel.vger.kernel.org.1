Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D52BA61B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgKTJ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgKTJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:27:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A45C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:27:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 23so9279263wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ETHeYbN6hBpTG62cbJNz0JDBf9vI0VaNEPAJRWU9xC0=;
        b=lEfJ1DDqui1+HfYPrsT0dk46sBjS8FTGqAl7VV2pCRfosbO/VdvtXDKsDcqKCCdhbn
         N545BqEmmJtVMEO61BrL6zHc87uhHuX7MGufM6xFyip8oeKjUo8rL8uxQrpaVv7L2ERw
         2MQKBA0lHfVfOa85YwhxPmhdVuISu1vIgNpN7nmDk3pBrP8SLXRgLCsrJ90eQmEMgavR
         FqrzcYPqXu0sJF2ZkffAJBbvaYncDN7SGt2SlxaTpy9MMz73yGPGG+qK0lPxS0Y6tzx3
         mPzlzA3+bZvrBUO4Nt+xy+VIH3SmL0DqlssAqwSkYKJPBWbfLNTUsCuyoPWM/22DqiOM
         cCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ETHeYbN6hBpTG62cbJNz0JDBf9vI0VaNEPAJRWU9xC0=;
        b=LYvCqIoXqrT3YB3CmZKqI08c1untZHZKcRzrLoyK3TPBj35XTgoqt5o7thGD+nJlsB
         6XVApWVoij5SSb+2ecNQ0FgmSaAOpYFQfaeiVlsCa1TaE5hzm+z0HltPMcK5HttiFPrA
         9xdM9aJUrpzL/coSoRxTPaRqhUDaSJbzM9hJx8NRXeqdqtiDegghKIeAAzaSFJWAmxoh
         Bvry8IkbuDUzt4IdyTpgSBABjxyIDT7beSzBSibNHhFW2n+k90tlSj+XapXC2BXMBSZt
         gB3EYFKwwaZlbyyiJfhNqgmFmz52ZtE7upMGY22Ar5vHcumIk8YbxKpeH3A76E6mLYXd
         j9Ng==
X-Gm-Message-State: AOAM532MDCKhXUN4ySIKW/bLfKl23qI4gCOOh5pJocCk7KBv0heXLAPN
        e/VdE/aPZBuxtFlqZuk3/qenCA==
X-Google-Smtp-Source: ABdhPJwFzel9kSZkOmP6r8U5b51jx3UJiaUzkIxD3haslzkIVE8CtmMY4yN939lxl+JNFkDui6j6cA==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr14845723wrt.348.1605864448213;
        Fri, 20 Nov 2020 01:27:28 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id c5sm4291172wrb.64.2020.11.20.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:27:27 -0800 (PST)
Date:   Fri, 20 Nov 2020 09:27:24 +0000
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201120092724.GB2653684@google.com>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201120085653.GA3092@hirez.programming.kicks-ass.net>
 <20201120091356.GA2653684@google.com>
 <20201120091904.6zvovj2yxjxtnq2x@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120091904.6zvovj2yxjxtnq2x@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 Nov 2020 at 14:49:04 (+0530), Viresh Kumar wrote:
>     This is unlikely to be an issue on systems where cpufreq policies are
>     shared between multiple CPUs, because in those cases the policy
>     utilization is computed as the maximum of the CPU utilization values
>     over the whole policy and if that turns out to be low, reducing the
>     frequency for the policy most likely is a good idea anyway.

Hmm, I'm not sure I agree with this actually. We may be migrating the
task to a different policy altogether. And even if we migrate to another
CPU in the current policy, the task util_avg may be small just because
it was packed with other tasks on a rq, which means it may not increase
the util of the destination rq by much.

ISTR Douglas' EM-based schedutil boosting series was addressing that at
some point, I'll go have a look back at that discussion...
