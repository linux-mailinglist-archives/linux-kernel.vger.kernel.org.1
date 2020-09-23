Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1A2757E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIWMcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWMb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:31:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E8521D43;
        Wed, 23 Sep 2020 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600864318;
        bh=mMNqNnQdSGAR8f+U5kcP/UIbRI+sperPLvc/K9QxbME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcOqlW4ZsXiJU9g6ihPMr/Ovt+fyRRFNBzWB8Cl7IbrSxG042hKkmFA1S+nrncUhc
         iCBgBBD8zfugNLf+8vqz7chY9sMLOKbybaed01PkGWKzR92bszXQtvgXl2RGUzb3iu
         BPLTA8FAm0byB5B2uxo6UkKi/KTD72R4R0xefTdA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9462400E9; Wed, 23 Sep 2020 09:31:55 -0300 (-03)
Date:   Wed, 23 Sep 2020 09:31:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf script: add min, max to futex-contention
Message-ID: <20200923123155.GA2516911@kernel.org>
References: <20200921201928.799498-2-hagen@jauu.net>
 <20200922200922.1306034-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922200922.1306034-1-hagen@jauu.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 22, 2020 at 10:09:22PM +0200, Hagen Paul Pfeifer escreveu:
> Average is quite informative, but the outliners - especially max - are
> also of interest.
> 
> Before:
> 
> mutex-locker[793299] lock 5637ec61e080 contended 3400 times, 446 avg ns
> mutex-locker[793301] lock 5637ec61e080 contended 3563 times, 385 avg ns
> mutex-locker[793300] lock 5637ec61e080 contended 3110 times, 1855 avg ns
> 
> After:
> 
> mutex-locker[795251] lock 55b14e6dd080 contended 3853 times, 1279 avg ns [max: 12270 ns, min 340 ns]
> mutex-locker[795253] lock 55b14e6dd080 contended 2911 times, 518 avg ns [max: 51660261 ns, min 347 ns]
> mutex-locker[795252] lock 55b14e6dd080 contended 3843 times, 385 avg ns [max: 24323998 ns, min 338 ns]
> 
> Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---

Didn't apply here, I did it by hand, please check, probably some
indentation artifact.

Thanks for the patch!

- Arnaldo

diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index 0c4841acf75dadcb..ba044d20e8fff39b 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -47,6 +47,6 @@ def trace_begin():
 def trace_end():
 	for (tid, lock) in lock_waits:
 		min, max, avg, count = lock_waits[tid, lock]
-		print("%s[%d] lock %x contended %d times, %d avg ns" %
-			(process_names[tid], tid, lock, count, avg))
+		print("%s[%d] lock %x contended %d times, %d avg ns [max: %d ns, min %d ns]" %
+			(process_names[tid], tid, lock, count, avg, max, min))
 

 
> v2: nanosecond, not microseconds
> 
>  tools/perf/scripts/python/futex-contention.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
> index c440f02627dd..7e884d46f920 100644
> --- a/tools/perf/scripts/python/futex-contention.py
> +++ b/tools/perf/scripts/python/futex-contention.py
> @@ -53,5 +53,5 @@ def trace_begin():
>  def trace_end():
>      for (tid, lock) in lock_waits:
>          min, max, avg, count = lock_waits[tid, lock]
> -        print("%s[%d] lock %x contended %d times, %d avg ns" %
> -              (process_names[tid], tid, lock, count, avg))
> +        print("%s[%d] lock %x contended %d times, %d avg ns [max: %d ns, min %d ns]" %
> +              (process_names[tid], tid, lock, count, avg, max, min))
> -- 
> 2.28.0
> 

-- 

- Arnaldo
