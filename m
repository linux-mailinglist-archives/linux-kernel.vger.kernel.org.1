Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97E2DAE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgLONvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:51:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35184 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgLONux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:50:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id a9so39495248lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCVaoJFKEtI7Btpypz1Lyb8fOWukXtArgLnLgeKjRr0=;
        b=Uk3NSzsXKnursyDjV7JY81ItOuHjMH0LHFcX8psXcegaYlTBNJnzoDQMafBAvHmO8+
         59IycVJgNdH+KUPWW98ss9JeSbffRjK392vzLT7Xxfigb6fO2gBFQsOgKixNyyp+ZAoz
         Wponr9UKun2cqLRP/So/umQhYleFWy/eiTfkKeVcf7/YqYz69DPVJms7B24D2a/LGu5M
         zakkCEEIwWeekRfV8amhHHNnSwCgz9Nnw0q5tmH72FmgwnYxagHL9ogChNOGunUS+WN0
         VcCaultugf1S0WnDIfegGUj28zG6Cs2b2UglGUnZyU6k+WawSNy8Kh3/zLk/Fgya+WjU
         S3Mw==
X-Gm-Message-State: AOAM531MS8iddsmgLY519rmcgXcPv9nAIPi9etglsHZ20QPfYGgM3koU
        oydmQ/54QmYpq0tc2vR36WIAwMAYme+pJ3uMQuh5PifN
X-Google-Smtp-Source: ABdhPJyIkEcLpcR50ld+Qzx6yGLoJGSl76WmdOZRMpcoMAilWdvJLDFwidd0ZGeMKqgHHtgeJmevUeMXDdpsr3XRXSk=
X-Received: by 2002:a19:cc10:: with SMTP id c16mr11048202lfg.112.1608040210893;
 Tue, 15 Dec 2020 05:50:10 -0800 (PST)
MIME-Version: 1.0
References: <1607996131-9340-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1607996131-9340-1-git-send-email-yangtiezhu@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Dec 2020 22:49:59 +0900
Message-ID: <CAM9d7chMkKBschy=abDqyOBg8_jxXBXhSN30k2m+MhPca_g2ig@mail.gmail.com>
Subject: Re: [PATCH v2] perf callchain: Return directly when use '--call-graph
 dwarf' under !HAVE_DWARF_SUPPORT
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 15, 2020 at 10:35 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> DWARF register mappings have not been defined for some architectures,
> at least for mips, so we can print an error message and then return
> directly when use '--call-graph dwarf'.
>
> E.g. without this patch:
>
> [root@linux perf]# ./perf record --call-graph dwarf cd
> Error:
> The sys_perf_event_open() syscall returned with 89 (Function not implemented) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
>
> With this patch:
>
> [root@linux perf]# ./perf record --call-graph dwarf cd
> DWARF is not supported for architecture mips64
>
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>         --call-graph <record_mode[,record_size]>
>                           setup and enables call-graph (stack chain/backtrace):
>
>                                 record_mode:    call graph recording mode (fp|dwarf|lbr)
>                                 record_size:    if record_mode is 'dwarf', max size of stack recording (<bytes>)
>                                                 default: 8192 (bytes)
>
>                                 Default: fp
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2: Use HAVE_DWARF_SUPPORT to check

I'm not sure whether this is because of lack of dwarf library or kernel support.
Based on the error message, I guess it's from the kernel.  Then I think this
patch won't be sufficient..

Thanks,
Namhyung


>
>  tools/perf/util/callchain.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1b60985..ad08554 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -18,6 +18,7 @@
>  #include <math.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> +#include <sys/utsname.h>
>
>  #include "asm/bug.h"
>
> @@ -276,6 +277,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>
>                 /* Dwarf style */
>                 } else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
> +#ifdef HAVE_DWARF_SUPPORT
>                         const unsigned long default_stack_dump_size = 8192;
>
>                         ret = 0;
> @@ -290,6 +292,15 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>                                 ret = get_stack_size(tok, &size);
>                                 param->dump_size = size;
>                         }
> +#else
> +                       struct utsname uts;
> +
> +                       ret = uname(&uts);
> +                       pr_err("DWARF is not supported for architecture %s\n",
> +                               ret ? "unknown" : uts.machine);
> +
> +                       return -ENOTSUP;
> +#endif
>                 } else if (!strncmp(name, "lbr", sizeof("lbr"))) {
>                         if (!strtok_r(NULL, ",", &saveptr)) {
>                                 param->record_mode = CALLCHAIN_LBR;
> --
> 2.1.0
>
