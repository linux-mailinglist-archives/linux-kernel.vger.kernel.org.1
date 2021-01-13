Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71A22F48FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAMKrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbhAMKrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610534786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ec0y/BdJxRfTy0k6b2igIfk1/DDD0lJc0nWam9VBkXg=;
        b=ioNcbNlZHjI44f9y0aWreo5feCpdiMFu7NOf7QlYhEdt5Qvy9X8i5pu8/IOI/+QNK0Ucy7
        by/B9VCJ4J+lQyOLAyCMSJll2ILCkP8YDxnnoDdNDMKYhJovMDeUaVCT3evuesC/R529ut
        UXiX2K62sWzxu36bA67rrkkAVRb1dYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-TJW31ew2Ps2czLwl7amhYg-1; Wed, 13 Jan 2021 05:46:22 -0500
X-MC-Unique: TJW31ew2Ps2czLwl7amhYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100E68144E0;
        Wed, 13 Jan 2021 10:46:21 +0000 (UTC)
Received: from krava (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C9F95D9DC;
        Wed, 13 Jan 2021 10:46:18 +0000 (UTC)
Date:   Wed, 13 Jan 2021 11:46:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
Message-ID: <20210113104618.GB1331835@krava>
References: <20210113080128.10286-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113080128.10286-1-jslaby@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
> With LTO, there are symbols like these:
> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
>  10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
> 
> This comes from a runtime/debug split done by the standard way:
> objcopy --only-keep-debug $runtime $debug
> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
> 
> perf currently cannot resolve such symbols (relicts of LTO), as section
> 29 exists only in the debug file (29 is .debug_info). And perf resolves
> symbols only against runtime file. This results in all symbols from such
> a library being unresolved:
>      0.38%  main2    libantlr4-runtime.so.4.8  [.] 0x00000000000671e0
> 
> So try resolving against the debug file first. And only if it fails (the
> section has NOBITS set), try runtime file. We can do this, as "objcopy
> --only-keep-debug" per documentation preserves all sections, but clears
> data of some of them (the runtime ones) and marks them as NOBITS.
> 
> The correct result is now:
>      0.38%  main2    libantlr4-runtime.so.4.8  [.] antlr4::IntStream::~IntStream
> 
> Note that these LTO symbols are properly skipped anyway as they belong
> neither to *text* nor to *data* (is_label && !elf_sec__filter(&shdr,
> secstrs) is true).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/symbol-elf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index f3577f7d72fe..a31b716fa61c 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		if (sym.st_shndx == SHN_ABS)
>  			continue;
>  
> -		sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> +		sec = elf_getscn(syms_ss->elf, sym.st_shndx);
>  		if (!sec)
>  			goto out_elf_end;

we iterate symbols from syms_ss, so the fix seems to be correct
to call elf_getscn on syms_ss, not on runtime_ss as we do now

I'd think this worked only when runtime_ss == syms_ss

>  
>  		gelf_getshdr(sec, &shdr);
>  
> +		if (shdr.sh_type == SHT_NOBITS) {
> +			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> +			if (!sec)
> +				goto out_elf_end;
> +
> +			gelf_getshdr(sec, &shdr);
> +		}

is that fallback necessary? the symbol is from syms_ss

Namhyung, any idea?

thanks,
jirka

