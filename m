Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501A92EBAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAFHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:43:52 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36972 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:43:52 -0500
Received: by mail-lf1-f42.google.com with SMTP id o17so4586154lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7joZOEV5tEggBQcxQYFcqrG1vJ2WO+0SJXQMNdqmnM=;
        b=rK/8bVUgQCILzmVUDyiGQFgrQw7UMhAli32YzPUeUH4SaK3fqIMPNMgb9m4iBP0Yvm
         hYASgZdaMwsxGyFuRrHEHxXHWTPeMgKKbpPXBUhRd/79yCRoTKwE4u2G3Bdbnba/F7Gk
         Wm3E8ttYgFVkehsNgbcyWPo710w0T6TSc8ZXF0EmMe75VGpr2x8na7/eJO2C83kBwR/q
         1hsdWNo5EQz5GsATcWRnKleDdU4U8WklT2MjK8vvl0Y0Y6L10ckkc+/Slwbt5j7h9FMK
         EckRjVFwpN1m1fdbP4DiiGbhCX4VKbKE94pxCMKR4cMXdwgqRQ+T1BaIRTZLnaucB6kd
         HSIw==
X-Gm-Message-State: AOAM532/rnBU2NBQFjqv/l/Upjytw+GbykquOckzcnvWD6Ps9ULARE29
        C+sJL/JKShbnvlvtvX/FVYDd71mETn9ToNVSDWs=
X-Google-Smtp-Source: ABdhPJxINjWnoqewn3kGgDrr8vDiKP0tw8X1bdQ9Yt9XbFjfj0+Ele1Re8iBx7fReoudkJwCyLt13ZM7xGhZ/4fz7mk=
X-Received: by 2002:a05:651c:301:: with SMTP id a1mr1480387ljp.275.1609918990464;
 Tue, 05 Jan 2021 23:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-4-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-4-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:42:59 +0900
Message-ID: <CAM9d7cjOkSZRZz6JJW-eCD0Dx5E6rGzfmvU3deQyEr2RLUgzGA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] perf c2c: Add dimensions for load miss
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> Add dimensions for load miss and its percentage calculation, which is to
> be displayed in the single cache line output.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 107 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 00014e3d81fa..27745340c14a 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -624,6 +624,10 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>          (stats)->rmt_hitm +            \
>          (stats)->rmt_hit)
>
> +#define TOT_LD_MISS(stats)             \
> +       ((stats)->lcl_dram +            \
> +        (stats)->rmt_dram)
> +

Is this true always?  I'm not sure if there's a case where stores can go to DRAM
directly.. maybe like a kind of uncached accesses.

Also it can be a static function..

Thanks,
Namhyung
