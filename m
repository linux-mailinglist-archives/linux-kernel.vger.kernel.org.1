Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1282A2F5976
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbhANDkF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jan 2021 22:40:05 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45425 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbhANDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:04 -0500
Received: by mail-lj1-f179.google.com with SMTP id f17so4911527ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=imP8QpHnYZxdbOIe6A3BWijpgdJCiEsPa2n4Ea9zakQ=;
        b=dQhcoyWtclIfva+wx8IcpF7rwa1mWEdIzAKNPr4jOuQ9wKg90U0+YRRfpYRnPgxGTo
         ZCg5QSoo0vzvKTaoZCv/8BLuw0EUhvbyQB4tq8gEmlas/76VHhdICnxX671u6xbMuMfW
         zDfggXJCCN0vtYMR/61yn6RWqruqK81r/ntKyIX6/Onsk1H/Y2phqhyzePlBx2xsvbds
         ziEbIDWhW2cC14LNyglfO5/HxkWNcz22ekr0zt+5MsdMtlN3n2BnXYb9BTJlapwNLbMu
         zZMI6x14aaMmQU0An9M3NMNs/XJZX8Z41Jm9aDo96WCIArlPYDCyYADOdkabkGfaJisD
         HeUQ==
X-Gm-Message-State: AOAM531JmXTHt/umel6UXXJEdLOZ1IYIih+nGZ8pVAYBnv2g5PSE/PHA
        r9lUcn6wD/hreK/AuUvqspR0Zpn1aLmppVFBjoe8WhqcVrM=
X-Google-Smtp-Source: ABdhPJxtq5X52eD/vjSEr52Vf4hP8+m+15v3/b0raKX/5w0osQkqKLja2Jf6nI7lcKWvvcwijr3NHAkidCBGNXxzElk=
X-Received: by 2002:a2e:96da:: with SMTP id d26mr2101147ljj.233.1610595562514;
 Wed, 13 Jan 2021 19:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
 <20201223130320.3930-6-alexander.antonov@linux.intel.com> <CAM9d7cgQC7ap6sDympEoNAtFxNy_ibtW3phMDLh-VmzSDB7FXQ@mail.gmail.com>
 <358dd76f-c6ec-b894-14be-659df0802c87@linux.intel.com>
In-Reply-To: <358dd76f-c6ec-b894-14be-659df0802c87@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Jan 2021 12:39:11 +0900
Message-ID: <CAM9d7cjuX8AHpL6hs5AHObOPCjExLg1_GHN-vDdi4hYQmrC5dQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 9:08 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
>
> On 1/6/2021 12:02 PM, Namhyung Kim wrote:
> > On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
> > <alexander.antonov@linux.intel.com> wrote:
> >> This functionality is based on recently introduced sysfs attributes
> >> for Intel® Xeon® Scalable processor family (code name Skylake-SP):
> >> Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
> >> IIO PMON mapping")
> >>
> >> Mode is intended to provide four I/O performance metrics in MB per each
> >> IIO stack:
> >>   - Inbound Read: I/O devices below IIO stack read from the host memory
> >>   - Inbound Write: I/O devices below IIO stack write to the host memory
> >>   - Outbound Read: CPU reads from I/O devices below IIO stack
> >>   - Outbound Write: CPU writes to I/O devices below IIO stack
> >>
> >> Each metric requiries only one IIO event which increments at every 4B
> >> transfer in corresponding direction. The formulas to compute metrics
> >> are generic:
> >>      #EventCount * 4B / (1024 * 1024)
> > Hmm.. maybe we can do this with JSON metrics, no?
> Do you mean to add metrics to *-metrics.json file?
> Looks like it's possible but in this case JSON file should be updated
> for each
> new enabled platform and calculations will be the same.
> I would prefer to leave it as is because perf will work without changing of
> userspace part once IIO sysfs attributes are added for new platforms.

OK.

> >
> >> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> >> ---

[SNIP]
> >> diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
> >> new file mode 100644
> >> index 000000000000..2c5168d2550b
> >> --- /dev/null
> >> +++ b/tools/perf/perf-iiostat.sh
> >> @@ -0,0 +1,12 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# perf iiostat
> >> +# Alexander Antonov <alexander.antonov@linux.intel.com>
> >> +
> >> +if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
> >> +        DELIMITER="="
> >> +else
> >> +        DELIMITER=" "
> >> +fi
> >> +
> >> +perf stat --iiostat$DELIMITER$*
> > Why is this needed?
> >
> > Thanks,
> > Namhyung
> Arnaldo raised question relates to format of 'perf stat --iiostat'
> subcommand
> and explained how it can be changed to 'perf iiostat' through the aliases
> mechanism in perf.

Yeah, I know that.  What I'm asking is the DELIMITER part.

Thanks,
Namhyung
