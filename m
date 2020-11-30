Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFC2C8619
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgK3OAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:00:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:23184 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgK3OAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:00:40 -0500
IronPort-SDR: EWJY4wKTkrIItShzM6loXnAbRuXmOO6hg6Ad1fUgJB27doSvlSyQrGIzwGus7KVPrS/+Nonf9A
 wpRlRWfzPHhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="172735950"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="172735950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 05:58:59 -0800
IronPort-SDR: PiCDwFJl/mtOd4vEmN2oCkWhCT2mjvFVyWzlpiAzoX6UqCLY2lbZGM8bIeHnCvhSQ16PbiPDJA
 h0hUrzm7YbNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="549106766"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2020 05:58:58 -0800
Received: from [10.255.228.66] (kliang2-MOBL.ccr.corp.intel.com [10.255.228.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A5CAB58067A;
        Mon, 30 Nov 2020 05:58:57 -0800 (PST)
Subject: Re: [PATCH 00/12] Add the page size in the perf record (user tools)
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
 <20201127202234.GA2790163@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f9937ddf-f323-6f44-930b-0b08876e38c5@linux.intel.com>
Date:   Mon, 30 Nov 2020 08:58:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127202234.GA2790163@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2020 3:22 PM, Jiri Olsa wrote:
> hi,
> I can't compile this on Fedora 32, check the log below
> 

The patch set was compiled with GCC 9. I will install a GCC 10 and fix 
all the warnings.

Thanks,
Kan

> jirka
> 
> 
> ---
> $ make JOBS=1
>    BUILD:   Doing 'make -j1' parallel build
> Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
> diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
>    CC       util/parse-events.o
>    CC       util/session.o
> util/session.c: In function ‘machines__deliver_event’:
> util/session.c:1278:37: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 10 [-Werror=format-truncation=]
>   1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
>        |                                     ^~~
> util/session.c:1278:36: note: directive argument in the range [1, 18446744073709551615]
>   1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
>        |                                    ^~~~~~~
> In file included from /usr/include/stdio.h:867,
>                   from /home/jolsa/kernel/linux-perf/tools/lib/perf/include/perf/cpumap.h:6,
>                   from util/session.c:13:
> /usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 3 and 22 bytes into a destination of size 10
>     67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     68 |        __bos (__s), __fmt, __va_arg_pack ());
>        |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/session.c:1278:37: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 10 [-Werror=format-truncation=]
>   1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
>        |                                     ^~~
> util/session.c:1278:36: note: directive argument in the range [1, 18446744073709551615]
>   1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
>        |                                    ^~~~~~~
> In file included from /usr/include/stdio.h:867,
>                   from /home/jolsa/kernel/linux-perf/tools/lib/perf/include/perf/cpumap.h:6,
>                   from util/session.c:13:
> /usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 3 and 22 bytes into a destination of size 10
>     67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     68 |        __bos (__s), __fmt, __va_arg_pack ());
>        |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/session.c: In function ‘get_page_size_name’:
> util/session.c:1278:37: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 10 [-Werror=format-truncation=]
>   1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
>        |                                     ^~~
> util/session.c:1278:36: note: directive argument in the range [1, 18446744073709551615]
>   1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
>        |                                    ^~~~~~~
> In file included from /usr/include/stdio.h:867,
>                   from /home/jolsa/kernel/linux-perf/tools/lib/perf/include/perf/cpumap.h:6,
>                   from util/session.c:13:
> /usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 3 and 22 bytes into a destination of size 10
>     67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     68 |        __bos (__s), __fmt, __va_arg_pack ());
>        |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: util/session.o] Error 1
> make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:647: perf-in.o] Error 2
> make[1]: *** [Makefile.perf:233: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
