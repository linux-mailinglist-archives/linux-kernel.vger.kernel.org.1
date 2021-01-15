Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991DA2F73BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbhAOHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:34:34 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:46193 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbhAOHed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:34:33 -0500
Received: by mail-qk1-f177.google.com with SMTP id d14so10844870qkc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9UhJeIAP+EngKocS/zCFbSC4TCvXsJ8kqGSBlPi5Ow=;
        b=sl5fAQWXESxkZuL48PZxVbhtPTCceQiNCMC+6AH/gwPdFaj1mFNZKsrEf+ilQbjYoi
         LTq3NG6TCzwybJ7lt58bpzf9XZP32UYnWPRNAB15urrRBSAl/kYbIvNFnoi2vIces+le
         10Cu6pb8LFCYYqnKONgtkW3q1LDGZxDiP6RoZJfQ/ZcbyZ/3IwQbH6/HkOZf/d4v3o08
         EQgbm1JZ/zVMSGiwyy2psHjOKbC7U/6COm/X1/NmjtmYueLkQ10o7rVtRdjl5d2xd4R9
         RdIHfERo0dbG79nGQCsTfCP/Q/qsMn135n3eppOw9hxMpsTFKVHC02ht77mRWONFBQq6
         kieQ==
X-Gm-Message-State: AOAM530fKVKz7tYVSgyi7QE/XoTpYCHe/iH8qTIPLIF/FZ2xtheC9O/2
        +srDm4NSm7mWuHxC5POqdQUjG/mRd+CHeQBzYHc=
X-Google-Smtp-Source: ABdhPJx5gz2Fj1LtPCnLajkJStNyVR+tBWgSu7637o5asROBp9ZKcd+48Tu7hFl2/pp9fbRhwIEsbCWtPn7d10KBuN0=
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr11092398qka.278.1610696032470;
 Thu, 14 Jan 2021 23:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
 <20201223130320.3930-6-alexander.antonov@linux.intel.com> <CAM9d7cgQC7ap6sDympEoNAtFxNy_ibtW3phMDLh-VmzSDB7FXQ@mail.gmail.com>
 <358dd76f-c6ec-b894-14be-659df0802c87@linux.intel.com> <CAM9d7cjuX8AHpL6hs5AHObOPCjExLg1_GHN-vDdi4hYQmrC5dQ@mail.gmail.com>
 <20f98862-9087-0368-7124-19a8f2b54db9@linux.intel.com>
In-Reply-To: <20f98862-9087-0368-7124-19a8f2b54db9@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 15 Jan 2021 16:33:41 +0900
Message-ID: <CAM9d7cjueVS_MJZxuADi-xw=EWXgncZ++jGDewamxZF8CkvhRw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] perf stat: Enable iiostat mode for x86 platforms
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

On Fri, Jan 15, 2021 at 1:41 AM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
> On 1/14/2021 6:39 AM, Namhyung Kim wrote:
> > On Wed, Jan 13, 2021 at 9:08 PM Alexander Antonov
> > <alexander.antonov@linux.intel.com> wrote:
> >>
> >> On 1/6/2021 12:02 PM, Namhyung Kim wrote:
> >>> On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
> >>>> diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
> >>>> new file mode 100644
> >>>> index 000000000000..2c5168d2550b
> >>>> --- /dev/null
> >>>> +++ b/tools/perf/perf-iiostat.sh
> >>>> @@ -0,0 +1,12 @@
> >>>> +#!/bin/bash
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +# perf iiostat
> >>>> +# Alexander Antonov <alexander.antonov@linux.intel.com>
> >>>> +
> >>>> +if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
> >>>> +        DELIMITER="="
> >>>> +else
> >>>> +        DELIMITER=" "
> >>>> +fi
> >>>> +
> >>>> +perf stat --iiostat$DELIMITER$*
> >>> Why is this needed?
> >>>
> >>> Thanks,
> >>> Namhyung
> >> Arnaldo raised question relates to format of 'perf stat --iiostat'
> >> subcommand
> >> and explained how it can be changed to 'perf iiostat' through the aliases
> >> mechanism in perf.
> > Yeah, I know that.  What I'm asking is the DELIMITER part.
> >
> > Thanks,
> > Namhyung
> I'm using DELIMITER to resolve two different cases for format of iiostat
> command:
> The first one is the command with an option for iiostat mode, for example:
> 'perf iiostat show' which should be converted to 'perf stat
> --iiostat=show' or
> 'perf iiostat 0000:ae,0000:5d' to 'perf stat --iiostat=0000:ae,0000:5d'.
> The second is the command without any option for iiostat: 'perf iiostat
> -I 1000'
> should be converted to 'perf stat --iiostat -I 1000'.

Can't we simply use a whitespace ?

Thanks,
Namhyung
