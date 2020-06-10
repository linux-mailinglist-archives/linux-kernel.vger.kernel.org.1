Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739EF1F56B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgFJOVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 10:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJOVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:21:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DA120734;
        Wed, 10 Jun 2020 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591798899;
        bh=xN9FS4n39c9+QGo7i5xcdSH/LWePwYU8kUEmI5g4LVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BMcG5fQ+zB5lXSj9c4DJVWKDjZiqrbkB7Q6n/OIsVZcr3hUhKABA81PG5vb9PyKpA
         p7xy3+Kkm16xEm9rl9vKHL91Phkvnt7XwjefIELeHKMuNtXTOlthN8Ty8SA0kR8tQb
         VjszteuBTHFzyMzLk728GFmNuF4b6DVnkqZXXBME=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9763440AFD; Wed, 10 Jun 2020 11:21:36 -0300 (-03)
Date:   Wed, 10 Jun 2020 11:21:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf expr: Add < and > operators
Message-ID: <20200610142136.GO24868@kernel.org>
References: <20200610051717.170457-1-irogers@google.com>
 <20200610051717.170457-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610051717.170457-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 09, 2020 at 10:17:16PM -0700, Ian Rogers escreveu:
> These are broadly useful and necessary for Intel's top-down analysis.

Ditto.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 2 ++
>  tools/perf/util/expr.y | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 298d86660a96..13e5e3c75f56 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -111,6 +111,8 @@ else		{ return ELSE; }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
>  "&"		{ return '&'; }
> +"<"		{ return '<'; }
> +">"		{ return '>'; }
>  "-"		{ return '-'; }
>  "+"		{ return '+'; }
>  "*"		{ return '*'; }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index fe145344bb39..5fcb98800f9c 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -41,6 +41,7 @@ static double d_ratio(double val0, double val1)
>  %left '|'
>  %left '^'
>  %left '&'
> +%left '<' '>'
>  %left '-' '+'
>  %left '*' '/' '%'
>  %left NEG NOT
> @@ -73,7 +74,7 @@ other: ID
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
>  |
> -D_RATIO
> +'<' | '>' | D_RATIO
>  
>  all_expr: if_expr			{ *final_val = $1; }
>  	;
> @@ -94,6 +95,8 @@ expr:	  NUMBER
>  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
>  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
>  	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
> +	| expr '<' expr		{ $$ = $1 < $3; }
> +	| expr '>' expr		{ $$ = $1 > $3; }
>  	| expr '+' expr		{ $$ = $1 + $3; }
>  	| expr '-' expr		{ $$ = $1 - $3; }
>  	| expr '*' expr		{ $$ = $1 * $3; }
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

-- 

- Arnaldo
