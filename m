Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338D529FA57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJ3BKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3BKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:10:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB29C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:10:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so4694224wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9i6lk3TYqfGUdm9PO4T1rlImvMUiba/YlG3WJ1BweQ=;
        b=crZw32JHYixfVAt359edNQio02UAn6wKrrXEqf7ld9XYE0NmvJLF7arKDGnkkieGz/
         62f5wJnILOU9GpShZ91PedmGtCtD5sPucenHPZytLGdS7QDxnsUFy2zYBc6z2XUyeGio
         Za52NfsI4XsXZd4D89CoYG/f4eTIhoiOVYRkK0di+2+uY46X5Jn+EuocPPwKvze/2pgs
         1s8NvUlR9C31qGPy9c7Rw6NsyScP6gHXdhOrMbnNaXJx0Q2p6sA2zQKfMxccBqqC0B4C
         9ZE+aRqXQj7PjrNAVK/lppuazheYIdnjdUWWG63Hl+zDm3kLlFDZjRhpLSUg9Dl+bO3O
         rF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9i6lk3TYqfGUdm9PO4T1rlImvMUiba/YlG3WJ1BweQ=;
        b=lYGQ8Tij0EnQd9o32DUozjSX4+jg440QrwMVKRVMrSffnSpHq1Hr0QHx4HmUkT0PHN
         6ha+snO6XBoYQSh/LOKVuNEYAe4LugGyG2x83sOpkmpVPhej/0nw8tDRmDb5/mBJ3PQK
         HqH39TR2XjZ9bpmVhg76ZpL3NlbwWQEPQ7Ug1kE7MXPOv9Vd7IZNUCcxZ/xMTOj47Pvw
         lnsGrW+ZK80P+Cng00lAJlpApfLYJs4aHH35Phw4E6vjasBHxewOD1gptXgrytEoSMsj
         6eN/hyHh1/SVFBu5flalSUd2OCuJtdvjcRF2kQVvXXS6WUo1z4iLuUR6GUFRbIkTMEjR
         PeyQ==
X-Gm-Message-State: AOAM5335ATjTIqwkBgcCMiIK//u9j+1H4zZYV6ybzMTMgAhABW9WM5UQ
        eFuWXUzfdTh/Ptbwd05P70Edy/gKHDaHb+Vq+dhYuA==
X-Google-Smtp-Source: ABdhPJwHRPilbPmSPJswg9AWtVETltQPUikx0txwPCgSCtQ9mXBkDyOk5QH6sYykn76TgLWaufENoxo5x733JAtckAg=
X-Received: by 2002:adf:9e08:: with SMTP id u8mr8711648wre.282.1604020251690;
 Thu, 29 Oct 2020 18:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201028063813.8562-1-leo.yan@linaro.org> <20201028063813.8562-10-leo.yan@linaro.org>
In-Reply-To: <20201028063813.8562-10-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 29 Oct 2020 18:10:40 -0700
Message-ID: <CAP-5=fUi47JWsAbzPtKjpgopzDOt4FGkXW2sitnbM+sBgcodPg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] perf mem: Document event type 'ldst'
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:39 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> The event type 'ldst' is added for recording both load and store memory
> operations, this patch documents for the new event type.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/Documentation/perf-mem.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index 199ea0f0a6c0..c50ef37dba72 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -38,7 +38,11 @@ OPTIONS
>
>  -t::
>  --type=<type>::
> -       Select the memory operation type: load or store (default: load,store)
> +       Select the memory operation type: load, store, ldst (default: load,store).
> +       The type 'ldst' means the single event can record both for load and store
> +       operations; Intel and PowerPC support the types 'load' and 'store' but
> +       'ldst' cannot be used; on Arm64, it uses Arm SPE as memory events and
> +       user needs to specify one of these three types.

Naive question, could the type remain load,store for mem record and
the tool internally change it to ldst for ARM SPE?

Thanks,
Ian

>  -D::
>  --dump-raw-samples::

> --
> 2.17.1
>
