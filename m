Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2883026A8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgIOPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:20:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgIOOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:51:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id k15so3627012wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScEzOicQhZHRQe3GX8Ad88ihCQg+83EKj9SS+tMXjbE=;
        b=bMcdV1ffiNIsg3aOYxHmQa+6RxNePsrevI1dnfxmazc+PwAZcUOjRN6Xi8pvvuOuTF
         V3AAVJ8Ret3zPKYRIS07rH8L1cj9pss3kCCjdiBkkyVoQDReCWase//WYB3osH8vVewy
         wlgdN0ofj9nb4onH1aiFBChvOKKeP9chhSY7CLD0r6BYpq4hb64LeHaT+ekZ83AAwsQ2
         Z/A9TxWQk1lixsmsniXxrS1Goj/BMc/yhEWsZJ7wFbIEdO0LweczPi9CJt7FV9eH4o6j
         T+WMgafUo3wPeSqA7IKzLnwwEpUThl1Q+18OeThwHxLqtuEF7FPXQa0r8hlkpDLtnOXQ
         SJrA==
X-Gm-Message-State: AOAM5333k018h1bO+kPUPC49j6m6MW5vGINvAbsmho3JJ3b0+htJWy9g
        01rQmrEW2sxDOfm/OwGh8bMnDOFmaYBRgPzW2UGZzLgUh+M=
X-Google-Smtp-Source: ABdhPJxcCUSlOQwqbpFQAWsKv/oIZYpN6A3Abt+Re3PX3fKmT9dh2zQizI53nrKJs0RjknxGgEbhSCknGbufFOyKKmw=
X-Received: by 2002:adf:a418:: with SMTP id d24mr14046208wra.80.1600181493570;
 Tue, 15 Sep 2020 07:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200915081541.41004-1-yuehaibing@huawei.com>
In-Reply-To: <20200915081541.41004-1-yuehaibing@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 23:51:22 +0900
Message-ID: <CAM9d7cjzPHR4wB3KA_3MfyhwH+PAwF5ucjwWe=xeSL7SHPch+A@mail.gmail.com>
Subject: Re: [PATCH -next] perf metric: Remove duplicate include
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 15, 2020 at 5:16 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/tests/parse-metric.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 23db8acc492d..b344decfb91b 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -11,8 +11,6 @@
>  #include "debug.h"
>  #include "expr.h"
>  #include "stat.h"
> -#include <perf/cpumap.h>
> -#include <perf/evlist.h>
>
>  static struct pmu_event pme_test[] = {
>  {
> --
> 2.17.1
>
>
