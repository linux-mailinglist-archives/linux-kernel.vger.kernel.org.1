Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EE2CEE06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgLDMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbgLDMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:25:04 -0500
Date:   Fri, 4 Dec 2020 09:24:30 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607084663;
        bh=Y1bMeJShgRce/XY+jTXwelWQ41TtFeAQ0C5dZ7g79U0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9h9+kJVbWm2VNiFW/jlctf36I2M1h8T6vpP54557IBdWrP0I6z85HGT8V7pFjyh4
         qBGV2JTxAog/Jd4EwhiNILatXaa9pY3GoAHWmJg+xfEmAY/lnxKVJ+03B7VZeoXkNH
         36aFUKidJoyRXYaydR181KZoovYTBtLWUhSA9l+sn8d/MpFck0+FLY1jnMGuTl5wKn
         oWoFwb/jOr9IAf6EhMWopbKFkccsSAOjtx19jgKjkl1yn2Y0N1tgoBfjcEoAO5QVx5
         mrUB5+Ju8OyPKGfk5/BGymTMdtsLpGAAcf/fH0CQ5U1SzdfJgpU+9nytdHmCjvyz9W
         CcaxhcsPgud2w==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] tools build: Add missing libcap to test-all.bin target
Message-ID: <20201204122430.GA120850@kernel.org>
References: <20201203230836.3751981-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203230836.3751981-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 04, 2020 at 12:08:36AM +0100, Jiri Olsa escreveu:
> We're missing -lcap in test-all.bin target, so in case it's
> the only library missing (if more are missing test-all.bin
> fails anyway), we will falsely claim that we detected it and
> fail build, like:

Thanks, applied.

- Arnaldo

 
>   $ make
>   ...
>   Auto-detecting system features:
>   ...                         dwarf: [ on  ]
>   ...            dwarf_getlocations: [ on  ]
>   ...                         glibc: [ on  ]
>   ...                        libbfd: [ on  ]
>   ...                libbfd-buildid: [ on  ]
>   ...                        libcap: [ on  ]
>   ...                        libelf: [ on  ]
>   ...                       libnuma: [ on  ]
>   ...        numa_num_possible_cpus: [ on  ]
>   ...                       libperl: [ on  ]
>   ...                     libpython: [ on  ]
>   ...                     libcrypto: [ on  ]
>   ...                     libunwind: [ on  ]
>   ...            libdw-dwarf-unwind: [ on  ]
>   ...                          zlib: [ on  ]
>   ...                          lzma: [ on  ]
>   ...                     get_cpuid: [ on  ]
>   ...                           bpf: [ on  ]
>   ...                        libaio: [ on  ]
>   ...                       libzstd: [ on  ]
>   ...        disassembler-four-args: [ on  ]
> 
>   ...
> 
>     CC       builtin-ftrace.o
> 
>   In file included from builtin-ftrace.c:29:
>   util/cap.h:11:10: fatal error: sys/capability.h: No such file or directory
>      11 | #include <sys/capability.h>
>         |          ^~~~~~~~~~~~~~~~~~
>   compilation terminated.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/build/feature/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index cdde783f3018..89ba522e377d 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -90,7 +90,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>  
>  $(OUTPUT)test-all.bin:
> -	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
> +	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
>  
>  $(OUTPUT)test-hello.bin:
>  	$(BUILD)
> -- 
> 2.26.2
> 

-- 

- Arnaldo
