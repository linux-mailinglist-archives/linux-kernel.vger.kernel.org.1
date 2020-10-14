Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A028E2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgJNPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgJNPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:00:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:00:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o9so1896444plx.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2kzmCVx4VWztvXiKETRt1cVPZxhXoBdxox4zWFJThBs=;
        b=T4slwHczcFuXifvMfDF8fdTo8/QHabfkz4YSN7Yk/SeT9TE3AaTHcLFtkE89zJlBSf
         um6058lqvGe+fmgKvJXSs37Qf8cDtx7Ekzp7EheWEZ3RcvE6jQPugOMCbnFTC0q5wHx9
         kkQWAI/rtQh3sto9PmV1q6sdDcDixrDtDh48Tu3VU0nbErwp7Fv+RhfnHp1gOF8ZpRiQ
         Hzjoba1tu+RFR/9V/NdfDCHFrY+Kt+PWlLFkYPijApigoSKU1ZzIfpSNix689Hw4OinM
         fw2Nq+XR5IrdS3jYTqoniQMxGjoQnBRJIjUX3j6AoBimw2fPhs1T2kiQIu/aZvJH+OTS
         kJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kzmCVx4VWztvXiKETRt1cVPZxhXoBdxox4zWFJThBs=;
        b=A5bOuIDGTby4j+Wvx4RV6qtPFHKH525GT8QWdqXDINnK9h31aTGKwy0Vyeq5lV9el2
         GR98aM5ZQzASSoWi2M5T5nOm5RaNz5ukpO9bxPpkSzLpnaZO1oZFaDOqYZ54hdtS6Q22
         1FWSEXjD5wXD5HH+/4arFPoyGqjhty91IOT1Wt06zmfLnmj4pEtdQ0KoWxMHhE3SKhul
         A4rFO2nDoHr7ENj/PAuyzQztWVp4yB4zrRnFZh6Flky5EiXeMFmKlJNYc+prA6ryCM1O
         rzxRDLAr91sXHbRqgU/SnIM6YkhWzBbZMCVOWlGU8PotmF+h+aysdyZAyiwLdskQyop7
         do9w==
X-Gm-Message-State: AOAM533C+H7CKgbQC+NykNcHCyyh/i3GwSaqMSpt0m48HrYm9nMye2W6
        wjYQsnFAyN0qcWeLgeKmC48=
X-Google-Smtp-Source: ABdhPJy4Bu51yweaOnZzgDdfOWya41cxDDUVKKSQVx2Wqdrf8aCb0VWLQlfQ+v9SpgYRs95bEDJOHQ==
X-Received: by 2002:a17:902:7c0d:b029:d3:de09:a3 with SMTP id x13-20020a1709027c0db02900d3de0900a3mr4555636pll.52.1602687642379;
        Wed, 14 Oct 2020 08:00:42 -0700 (PDT)
Received: from ubuntu (1-171-246-157.dynamic-ip.hinet.net. [1.171.246.157])
        by smtp.gmail.com with ESMTPSA id e16sm3852061pfh.45.2020.10.14.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:00:41 -0700 (PDT)
Date:   Wed, 14 Oct 2020 23:00:34 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201014150034.GA502296@ubuntu>
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:25:48PM +0200, Dietmar Eggemann wrote:
> Hi Yun,
> 
> On 12/10/2020 18:31, Yun Hsiang wrote:
> > If the user wants to stop controlling uclamp and let the task inherit
> > the value from the group, we need a method to reset.
> > 
> > Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> > sched_setattr syscall.
> 
> before we decide on how to implement the 'uclamp user_defined reset'
> feature, could we come back to your use case in
> https://lkml.kernel.org/r/20201002053812.GA176142@ubuntu ?
> 
> Lets just consider uclamp min for now. We have:
> 
> (1) system-wide:
> 
> # cat /proc/sys/kernel/sched_util_clamp_min
> 
> 1024
> 
> (2) tg (hierarchy) with top-app's cpu.uclamp.min to ~200 (20% of 1024):
> 
> # cat /sys/fs/cgroup/cpu/top-app/cpu.uclamp.min
> 20
> 
> (3) and 2 cfs tasks A and B in top-app:
> 
> # cat /sys/fs/cgroup/cpu/top-app/tasks
> 
> pid_A
> pid_B
> 
> Then you set A and B's uclamp min to 100. A and B are now user_defined.
> A and B's effective uclamp min value is 100.
> 
> Since the task uclamp min values (3) are less than (1) and (2), their
> uclamp min value is not affected by (1) or (2).
> 
> If A doesn't want to control itself anymore, it can set its uclamp min
> to e.g. 300. Now A's effective uclamp min value is ~200, i.e. controlled
> by (2), the one of B stays 100.

The tg uclamp value may also change. If top-app's cpu.uclamp.min change
to 50 (~500), then task A's effective uclamp min value is 300 not ~500.
We can set task A's uclamp to 1024, it will be restricted by the tg.
But when task A move to root group, it's effective uclamp min value
will be 1024 not 0. If a task is in root group and it doesn't want to
control it's uclamp, the effective uclamp min value of that task should be 0.
So I think reset functionality is needed.

> 
> So the policy is:
> 
> (a) If the user_defined task wants to control it's uclamp, use task
>     uclamp value less than the tg (hierarchy) (and the system-wide)
>     value.
> 
> (b) If the user_defined task doesn't want to control it's uclamp
>     anymore, use a uclamp value greater than or equal the tg (hierarchy)
>     (and the system-wide) value.
> 
> So where exactly is the use case which would require a 'uclamp
> user_defined reset' functionality?
