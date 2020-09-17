Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA526D878
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIQKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:09:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:09:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so893360pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8QBNk7jtOrsUWbDdv+lNZw0GVbMmzNIo7UoVlpNTYQ=;
        b=CMFWaNdxsj6ae/xoCBeTz6XAGngTrAmDcJF6Nff/KRHsbP/5H8jJqq61eiZEYRB8hN
         EsVN6ltWGziYwfkGx5BirQulEjHlb1gJGzttetabrsiPE6sLkr3j4/ejY89YM3UEOb2v
         9ZISYJyCf+RzOEAtOwBuDsiQ0CF9LkpN0S93iP6kcLMsPQQkBjDVIU0qNtYq4JT0v43a
         vnJ4ESpemzf3cj5IV2IAHvnrF/oQTKyazZL2jEAG6Nk8LV/dqsSK7qIdN/xb71UTJvGN
         P5t3BB1V9B5+kRigV7bxSMA/MLJWNcFGRGtUbYPn0FI1q2wG6pw8L2MUXhxSVzmcnOBX
         No/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8QBNk7jtOrsUWbDdv+lNZw0GVbMmzNIo7UoVlpNTYQ=;
        b=bQUxdnw+7xqwDfsXta38But4gWyDQ6tVjk/6YvhILaKWq9jA3tVjFNuRNvXGlW0Na9
         c7bP+k06C7lsDkFv+Q+T44m6Nk+v7OV9BaQ35bX16VNW3pmX7in+Gtu4jd7aRPbWkN8C
         Ck8y8Rt38+7bAtfHlVKWFU1YqD+u0Kjkbpoi75nzJIZ47rGVUyIYQTFWLOLJUg+9RsPl
         f22asaBQDX6AqEIoc6EMgJPF7r0+700H959A+ZsWkiJXc28K4Glqha5XMWvwVQk+/j97
         78zaHbVyUw9r62RNY3cX+jSzKhGt3/SEHYbPXugy6fAs1C5x2MmLZOr2N0b00VqtBkU6
         N9Yw==
X-Gm-Message-State: AOAM531QuoC1d8YsFY9BAI8mDpEZMvTc+iX62zhVHmLRFFjn3MGEJ/CU
        sP9YJG5wBqT/DA00xmgrlC8IlQ==
X-Google-Smtp-Source: ABdhPJy5LpIsXaVb4XJKNIGClo+wrTgEj/6PZDB6lJsJ/2rYsDFr1/Bgb9kKhf/A3N4i0MayrkvUNQ==
X-Received: by 2002:a63:7841:: with SMTP id t62mr21433065pgc.183.1600337398053;
        Thu, 17 Sep 2020 03:09:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x5sm17064456pgf.65.2020.09.17.03.09.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 03:09:57 -0700 (PDT)
Date:   Thu, 17 Sep 2020 18:09:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200917100950.GC12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ + Marc ]

On Thu, Sep 17, 2020 at 09:36:45AM +0900, Sergey Senozhatsky wrote:

[...]

> diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
> new file mode 100644
> index 000000000000..32e58576f186
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/kvm-stat.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <memory.h>
> +#include "../../util/evsel.h"
> +#include "../../util/kvm-stat.h"
> +#include "arm64_exception_types.h"
> +#include "debug.h"
> +
> +define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
> +define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
> +
> +const char *kvm_trap_exit_reason = "esr_ec";
> +const char *vcpu_id_str = "id";

On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
or field "vcpu_id", thus it always reads out the "id" is 0 and it is
recorded into Perf's structure vcpu_event_record::vcpu_id and assigned
to perf thread's private data "thread::private".

With current code, it will not mess up different vcpus' samples because
now the samples are analyzed based on thread context, but since all
threads' "vcpu_id" is zero, thus all samples are accounted for
"vcpu_id=0" and cannot print out correct result with option "--vcpu":


  $ perf kvm stat report --vcpu 4

  Analyze events for all VMs, VCPU 4:

             VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

  Total Samples:0, Total events handled time:0.00us.


This is an issue I observed, if we want to support option "--vcpu",
seems we need to change ftrace event for "kvm_entry", but this will
break ABI.

Essentially, this issue is caused by different archs using different
format for ftrace event "kvm_entry", on x86 it contains feild
"vcpu_id" but arm64 only just records "vcpu_pc".

@Marc, @Will, do you have any suggestion for this?  Do you think it's
feasible to add a new field "vcpu_id" into the tracepoint "kvm_entry"
for Arm64's version?

Thanks,
Leo
