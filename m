Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E3269C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIOCtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:49:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32990 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOCtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:49:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id m6so1664744wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSR0thvhHSP/MxbY+SRaj7rE8lw1VEfUDd63lG7xHc0=;
        b=ilI+VO6PvqgJmGn3CJ+W38kOv/Qia2Te5ZfA03TODJWdC2dTwPlwIk+Ox0DtrX77HE
         CzjPtre85E5a9z92jn7u26p05O9/4kCMMUdxYx3WUUgxaUqczzQFvl3NDoG/CuQHU1uz
         7TZiBNMSEm3PoWSVm1nf0kkv7/eMw953WFSyNfnAMXojW/2t1SF03cBwno5wuxTFa8JF
         VxZIT3oYeB+/aKLb8Betvw33GeDuZy2ghF0NvukECjP3kCuFht6SuPo0z13KndKmFtCf
         4K+s/+Y8Ik9RuTX6gByrCmPyY6oVlpqrHJsLF8r717edCxTgHyDZqOKj/AbGr9mCp/xC
         5rXw==
X-Gm-Message-State: AOAM532KeSj4nkdNslVcG/xoasmYFhAkUG8zrYcN/CvWss2K+7csAsCB
        h8vtvlUobTr6l3Zl9fTylTA4Fhrq8Cf64uo+IZU=
X-Google-Smtp-Source: ABdhPJyMIj+LCOQ7n/PnKbFwUl0PmHYKI/+6D0T98rUhjTou+gL4FwWeSa4oStjZRnYIk/2cKmBEdt72aN9lAzKCpTw=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr18058810wrp.332.1600138178639;
 Mon, 14 Sep 2020 19:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200912041101.2123-1-henrywolfeburns@gmail.com> <20200915004125.971-1-henrywolfeburns@gmail.com>
In-Reply-To: <20200915004125.971-1-henrywolfeburns@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 11:49:26 +0900
Message-ID: <CAM9d7cjnYm8cBFJBVSkbnyfNw2-SApsAkm7xLdNkmnSOhJZOZw@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events amd: remove trailing commas
To:     Henry Burns <henrywolfeburns@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 15, 2020 at 9:41 AM Henry Burns <henrywolfeburns@gmail.com> wrote:
>
> amdzen2/core.json and amdzen/core.json have the occasional trailing
> comma. Since that goes against the JSON standard, lets remove it.
>
> Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/pmu-events/arch/x86/amdzen1/core.json | 2 +-
>  tools/perf/pmu-events/arch/x86/amdzen2/core.json | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
> index 7e1aa8273935..653b11b23399 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
> @@ -61,7 +61,7 @@
>    {
>      "EventName": "ex_ret_brn_ind_misp",
>      "EventCode": "0xca",
> -    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
> +    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted."
>    },
>    {
>      "EventName": "ex_ret_mmx_fp_instr.sse_instr",
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> index de89e5a44ff1..4b75183da94a 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> @@ -125,6 +125,6 @@
>    {
>      "EventName": "ex_ret_fus_brnch_inst",
>      "EventCode": "0x1d0",
> -    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8.",
> +    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8."
>    }
>  ]
> --
> 2.25.1
>
