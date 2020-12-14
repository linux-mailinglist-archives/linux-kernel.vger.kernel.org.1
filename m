Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A68D2D9910
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406378AbgLNNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbgLNNkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:40:20 -0500
Date:   Mon, 14 Dec 2020 10:39:50 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607953179;
        bh=AMC5CQEhi9XfiB5U/3SFE1EIz5yjn0jMNgojfbpGWuE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RirpLR0LlxsoiOlfC0vwwnESoVQuUHbw3Q60GM2BiN28bWyLbUuEdPczV68sZASo2
         UMz0PcaLhePvnhwmNz9zRo3go4+64iQOmcfxBekW67U5fIeEdQ6stAgpSe5NzcKLKv
         /MjSOidCthsI6+i55uDyU5Jl66utYAHmLiN46CXAzNbh/n0PmytQZR6BQ7iloS4xCY
         0Gow2uw2sVB5zxGESjH8uJH6VFTW0Fy8q9qORg52tsdAfefhRixcgqEMznHgh2h+yy
         ZyTWHkoA7u/OuFzy/+m9HZsWtH1jG0hiQdCaHlWV05yCJBUKK2Sq7vpEg0jTM+Iow9
         P5kLSlR1eFIiQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] perf callchain: Return directly when use '--call-graph
 dwarf' under !CONFIG_DWARF
Message-ID: <20201214133950.GE238399@kernel.org>
References: <1607950615-11825-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607950615-11825-1-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 08:56:55PM +0800, Tiezhu Yang escreveu:
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

Good improvement on the message! But that .config-detected file isn't
available at run time, take a look if this isn't a better alternative:

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1b60985690bba313..125178fd17482513 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -276,6 +276,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 
 		/* Dwarf style */
 		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
+#ifdef HAVE_DWARF_SUPPORT
 			const unsigned long default_stack_dump_size = 8192;
 
 			ret = 0;
@@ -290,6 +291,15 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 				ret = get_stack_size(tok, &size);
 				param->dump_size = size;
 			}
+#else
+			struct utsname uts;
+
+			ret = uname(&uts);
+			pr_err("DWARF is not supported for architecture %s\n",
+				ret ? "unknown" : uts.machine);
+
+			return -ENOTSUP;
+#endif
 		} else if (!strncmp(name, "lbr", sizeof("lbr"))) {
 			if (!strtok_r(NULL, ",", &saveptr)) {
 				param->record_mode = CALLCHAIN_LBR;

 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>         --call-graph <record_mode[,record_size]>
>                           setup and enables call-graph (stack chain/backtrace):
> 
> 				record_mode:	call graph recording mode (fp|dwarf|lbr)
> 				record_size:	if record_mode is 'dwarf', max size of stack recording (<bytes>)
> 						default: 8192 (bytes)
> 
> 				Default: fp
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/perf/util/callchain.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1b60985..a8cf456 100644
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
> @@ -278,6 +279,16 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>  		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
>  			const unsigned long default_stack_dump_size = 8192;
>  
> +			if (system("grep -q 'CONFIG_DWARF=y' .config-detected") != 0) {
> +				struct utsname uts;
> +
> +				ret = uname(&uts);
> +				pr_err("DWARF is not supported for architecture %s\n",
> +					ret ? "unknown" : uts.machine);
> +
> +				return -ENOTSUP;
> +			}
> +
>  			ret = 0;
>  			param->record_mode = CALLCHAIN_DWARF;
>  			param->dump_size = default_stack_dump_size;
> -- 
> 2.1.0
> 

-- 

- Arnaldo
