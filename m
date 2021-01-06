Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E22EBB7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbhAFJDd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 04:03:33 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34338 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:03:32 -0500
Received: by mail-lf1-f50.google.com with SMTP id o19so5040536lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pz9IWR0xtHV1MsLF68GdWI8x6p9wPFsptEuXV3QvYCY=;
        b=itzyR9JvcZToYsUWynpy6nifoFrKJcpXK50Z7JJUHd8cWdL9wodXo7J4A/UM5l5UNw
         t6RmouK0fMserPXUW1dCQPomJyqtq8+2I0x+43jjrPVeTL5KPTml/d3ObPnlxYnozL7H
         3RM+sYOAAySQCkTnNPmSQ2d5VlKYGetynJu181WOZXxmnR05LRjmp+OvzHTNSE1/NZRS
         tlKOzvX3yIeTMgZm663cgBElOWZ6sqz1dGBoojzXteDALinEaPdAAW+YYZ+D9fHteVzT
         Avo7+P4aDIQQo0tteuXuW7R4dv56fnx7/AMSXmkfAnCBuiXP1gizd1/ToNJ8sF8uFfai
         YZPw==
X-Gm-Message-State: AOAM532VsRAXFYAepvckU4jnUEY7k35es4nFhI/f+5bmgJQPpEymjDWB
        qHkFqw/l+qpKBNamoqyYABapCXvdjQOqsntrs08=
X-Google-Smtp-Source: ABdhPJwRsP2WSpkA0vzSiOOWPdKPmsx3VCMUXywnQwQcyWW0h3DfvflPIFPmlm/B+9sXK0y31aSKDDvG3OgGMxj5qeU=
X-Received: by 2002:a19:6459:: with SMTP id b25mr1383385lfj.635.1609923769097;
 Wed, 06 Jan 2021 01:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com> <20201223130320.3930-6-alexander.antonov@linux.intel.com>
In-Reply-To: <20201223130320.3930-6-alexander.antonov@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 18:02:37 +0900
Message-ID: <CAM9d7cgQC7ap6sDympEoNAtFxNy_ibtW3phMDLh-VmzSDB7FXQ@mail.gmail.com>
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

On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
> This functionality is based on recently introduced sysfs attributes
> for Intel® Xeon® Scalable processor family (code name Skylake-SP):
> Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
> IIO PMON mapping")
>
> Mode is intended to provide four I/O performance metrics in MB per each
> IIO stack:
>  - Inbound Read: I/O devices below IIO stack read from the host memory
>  - Inbound Write: I/O devices below IIO stack write to the host memory
>  - Outbound Read: CPU reads from I/O devices below IIO stack
>  - Outbound Write: CPU writes to I/O devices below IIO stack
>
> Each metric requiries only one IIO event which increments at every 4B
> transfer in corresponding direction. The formulas to compute metrics
> are generic:
>     #EventCount * 4B / (1024 * 1024)

Hmm.. maybe we can do this with JSON metrics, no?

>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-iiostat.txt |  89 ++++++
>  tools/perf/Makefile.perf                  |   5 +-
>  tools/perf/arch/x86/util/Build            |   1 +
>  tools/perf/arch/x86/util/iiostat.c        | 337 ++++++++++++++++++++++
>  tools/perf/command-list.txt               |   1 +
>  tools/perf/perf-iiostat.sh                |  12 +
>  6 files changed, 444 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/Documentation/perf-iiostat.txt
>  create mode 100644 tools/perf/perf-iiostat.sh
>
> diff --git a/tools/perf/Documentation/perf-iiostat.txt b/tools/perf/Documentation/perf-iiostat.txt
> new file mode 100644
> index 000000000000..38b5697b0d85
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-iiostat.txt
> @@ -0,0 +1,89 @@
> +perf-iiostat(1)
> +===============
> +
> +NAME
> +----
> +perf-iiostat - Show I/O performance metrics
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf iiostat' show
> +'perf iiostat' <ports> -- <command> [<options>]
> +
> +DESCRIPTION
> +-----------
> +Mode is intended to provide four I/O performance metrics per each IIO
> +stack (PCIe root port):
> +
> +- Inbound Read   - I/O devices below IIO stack read from the host memory, in MB
> +
> +- Inbound Write  - I/O devices below IIO stack write to the host memory, in MB
> +
> +- Outbound Read  - CPU reads from I/O devices below IIO stack, in MB
> +
> +- Outbound Write - CPU writes to I/O devices below IIO stack, in MB
> +
> +OPTIONS
> +-------
> +<command>...::
> +       Any command you can specify in a shell.
> +
> +show::
> +       List all IIO stacks.

I'd prefer 'list' for this, but not a strong opinion..

> +
> +<ports>::
> +       Select the root ports for monitoring. Comma-separated list is supported.
> +
> +EXAMPLES
> +--------
> +
> +1. List all IIO stacks (example for 2-S platform):
> +
> +   $ perf iiostat show
> +   S0-uncore_iio_0<0000:00>
> +   S1-uncore_iio_0<0000:80>
> +   S0-uncore_iio_1<0000:17>
> +   S1-uncore_iio_1<0000:85>
> +   S0-uncore_iio_2<0000:3a>
> +   S1-uncore_iio_2<0000:ae>
> +   S0-uncore_iio_3<0000:5d>
> +   S1-uncore_iio_3<0000:d7>
> +
> +2. Collect metrics for all I/O stacks:
> +
> +   $ perf iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
> +   357708+0 records in
> +   357707+0 records out
> +   375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
> +
> +    Performance counter stats for 'system wide':
> +
> +      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
> +   0000:00                    1                    0                    2                    3
> +   0000:80                    0                    0                    0                    0
> +   0000:17               352552                   43                    0                   21
> +   0000:85                    0                    0                    0                    0
> +   0000:3a                    3                    0                    0                    0
> +   0000:ae                    0                    0                    0                    0
> +   0000:5d                    0                    0                    0                    0
> +   0000:d7                    0                    0                    0                    0
> +
> +3. Collect metrics for comma-separated list of I/O stacks:
> +
> +   $ perf iiostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
> +   357708+0 records in
> +   357707+0 records out
> +   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
> +
> +    Performance counter stats for 'system wide':
> +
> +      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
> +   0000:17               358559                   44                    0                   22
> +   0000:3a                    3                    2                    0                    0
> +
> +        197.081983474 seconds time elapsed
> +
> +SEE ALSO
> +--------
> +linkperf:perf-stat[1]
> \ No newline at end of file

[SNIP]
> diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
> new file mode 100644
> index 000000000000..2c5168d2550b
> --- /dev/null
> +++ b/tools/perf/perf-iiostat.sh
> @@ -0,0 +1,12 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# perf iiostat
> +# Alexander Antonov <alexander.antonov@linux.intel.com>
> +
> +if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
> +        DELIMITER="="
> +else
> +        DELIMITER=" "
> +fi
> +
> +perf stat --iiostat$DELIMITER$*

Why is this needed?

Thanks,
Namhyung


> \ No newline at end of file
> --
> 2.19.1
>
