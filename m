Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641A2697B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINV2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgINV2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:28:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E5A20759;
        Mon, 14 Sep 2020 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600118888;
        bh=8bhZoVD8TkqP7pZrtp8IBtCGwd8g4lCXEJfjLAu/Ark=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Te1MQWTKnzL++nKPCKRSJUSVkg73rHLbKXx2SBQzgtKJJVlq34ZCKmHGMddsc5rOO
         TybVS7D/Ni2lGGzAqmRhlFCOLSPdfxf7/4HAzvKl6dCr9ZbVNo07+2ZYtAVvLoq8PY
         f6sZNYRl6UrdOHKIL6H/+Cmnz8kLv+fD7hHiq97U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7103C40D3D; Mon, 14 Sep 2020 18:28:06 -0300 (-03)
Date:   Mon, 14 Sep 2020 18:28:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Wang Nan <wangnan0@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf test: Fix signal test inline assembly
Message-ID: <20200914212806.GB166601@kernel.org>
References: <20200911130005.1842138-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911130005.1842138-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 11, 2020 at 03:00:05PM +0200, Jiri Olsa escreveu:
> When compiling with DEBUG=1 on Fedora 32 I'm getting crash for
> 'perf test signal':
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   0x0000000000c68548 in __test_function ()
>   (gdb) bt
>   #0  0x0000000000c68548 in __test_function ()
>   #1  0x00000000004d62e9 in test_function () at tests/bp_signal.c:61
>   #2  0x00000000004d689a in test__bp_signal (test=0xa8e280 <generic_ ...
>   #3  0x00000000004b7d49 in run_test (test=0xa8e280 <generic_tests+1 ...
>   #4  0x00000000004b7e7f in test_and_print (t=0xa8e280 <generic_test ...
>   #5  0x00000000004b8927 in __cmd_test (argc=1, argv=0x7fffffffdce0, ...
>   ...
> 
> It's caused by __test_function being in .bss section:
> 
>   $ readelf -a ./perf | less
>     [Nr] Name              Type             Address           Offset
>          Size              EntSize          Flags  Link  Info  Align
>     ...
>     [28] .bss              NOBITS           0000000000c356a0  008346a0
>          00000000000511f8  0000000000000000  WA       0     0     32
> 
>   $ nm perf | grep __test_function
>   0000000000c68548 B __test_function
> 
> I guess most of the time we're just lucky the inline asm ended up
> in .text section, so making it specific explicit with push and pop
> section cluases.
> 
>   $ readelf -a ./perf | less
>     [Nr] Name              Type             Address           Offset
>          Size              EntSize          Flags  Link  Info  Align
>     ...
>     [13] .text             PROGBITS         0000000000431240  00031240
>          0000000000306faa  0000000000000000  AX       0     0     16
> 
>   $ nm perf | grep __test_function
>   00000000004d62c8 T __test_function

Thanks, tested and applied.

- Arnaldo
 
> Cc: Wang Nan <wangnan0@huawei.com>
> Fixes: 8fd34e1cce18 ("perf test: Improve bp_signal")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/bp_signal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index da8ec1e8e064..cc9fbcedb364 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -45,10 +45,13 @@ volatile long the_var;
>  #if defined (__x86_64__)
>  extern void __test_function(volatile long *ptr);
>  asm (
> +	".pushsection .text;"
>  	".globl __test_function\n"
> +	".type __test_function, @function;"
>  	"__test_function:\n"
>  	"incq (%rdi)\n"
> -	"ret\n");
> +	"ret\n"
> +	".popsection\n");
>  #else
>  static void __test_function(volatile long *ptr)
>  {
> -- 
> 2.26.2
> 

-- 

- Arnaldo
