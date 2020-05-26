Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1071DC079
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 22:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgETUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 16:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:47:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347C720823;
        Wed, 20 May 2020 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590007627;
        bh=9w0KILB7yrKu9yQFRYVVB7S4YciohzZHET6YkhesxmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSsCDLEy6apnsDX5MeBXi4Fk4509mpWMjOR8FzuS5GpWKtC9a1Ktet8OcT5KkctlW
         SyY0wdh7zKcGLrk3nSZJuUvxHN3aCmJYGkg0OkBlGY1rDXNNjXrwzE6q6Q+rZJuPDM
         BU3B02EeHwsi6Pb4aYNOe5xjxfUAtEO9XACaB38Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A366840AFD; Wed, 20 May 2020 17:47:04 -0300 (-03)
Date:   Wed, 20 May 2020 17:47:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] perf ftrace: trace system wide if no target is
 given
Message-ID: <20200520204704.GO32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-2-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-2-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:10PM +0800, Changbin Du escreveu:
> This align ftrace to other perf sub-commands that if no target specified
> then we trace all functions.


Thanks, applied,

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d5adc417a4ca..11fc02037899 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -493,7 +493,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	argc = parse_options(argc, argv, ftrace_options, ftrace_usage,
>  			    PARSE_OPT_STOP_AT_NON_OPTION);
>  	if (!argc && target__none(&ftrace.target))
> -		usage_with_options(ftrace_usage, ftrace_options);
> +		ftrace.target.system_wide = true;
>  
>  	ret = target__validate(&ftrace.target);
>  	if (ret) {
> -- 
> 2.25.1
> 

-- 

- Arnaldo
