Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722322EBB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbhAFIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:45:14 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34614 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAFIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:45:14 -0500
Received: by mail-lf1-f44.google.com with SMTP id o19so4940992lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzmZroybDYaR2TEgT7o7uY7RVN2KQlmldEoUSdIFWj0=;
        b=XXi01Y851aHvnZ5a9aQEeXeqFCyEJy+8Sddwy7JJ+RLRxLeg+6+HwSfl0W1UZOt06b
         LyGSR2S4Q/PhJJhMpIwI0RQFBkRN/GqC1+4XwLL3zsvfyJf/jTHs4aREr39kULJ288yk
         R+UISi7f3oWvLeKr+Cj2t1Hl+0Lm/nz3bHpJnivNFixXZLfkUW7mvlboAmPLVEXACtlQ
         EZmpa2WsMNspv/Sm69ZesdzGhSG7yEj2QTUOlnQ8PVTpVDCU8JZNx/sS3QS0NTn+JuA+
         NZ3pEumy3xtiu0W/kF9wT1lcfHqPOSobieUfjDUKxTGlCWtwqyMjnz/HtOR45VPqXXuQ
         kihQ==
X-Gm-Message-State: AOAM532YjO7dkD4HrPcMP9bhGEfYTsLKbNl1S0ul9Oc0OZPSOo/30gKx
        0N4ijTp1xHYkLpk0w8GNhOVYXjk1jc0l519mhzM=
X-Google-Smtp-Source: ABdhPJz+GxCgRDdCWLe61Aa1FeRoZEpupjL7Ia8ZcEESf2MDf0f/nvK2ZF0sLmRHC2X/qcTQ+Nn3+YdxKgKSgsp8GuI=
X-Received: by 2002:a2e:96da:: with SMTP id d26mr1524157ljj.233.1609922672442;
 Wed, 06 Jan 2021 00:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com> <20201223130320.3930-3-alexander.antonov@linux.intel.com>
In-Reply-To: <20201223130320.3930-3-alexander.antonov@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 17:44:21 +0900
Message-ID: <CAM9d7cikD68d0iAiFQ2A6J5tDqM-jphqQUjLAV0vQZqH7Mi37A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] perf evsel: Introduce an observed performance device
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
> Adding evsel::perf_device void pointer.
>
> For performance monitoring purposes, an evsel can have a related device.
> These changes allow to attribute, for example, I/O performance metrics
> to IIO stack.
>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> ---
>  tools/perf/util/evsel.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 79a860d8e3ee..c346920f477a 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -127,6 +127,7 @@ struct evsel {
>          * See also evsel__has_callchain().
>          */
>         __u64                   synth_sample_type;
> +       void                    *perf_device;

Maybe we can use the existing 'priv' field.

Thanks,
Namhyung


>  };
>
>  struct perf_missing_features {
> --
> 2.19.1
>
