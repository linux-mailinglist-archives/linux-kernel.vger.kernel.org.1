Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355562B9B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgKSTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727961AbgKSTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605814371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQsc0/0SJtGzJx5uopunB4YDTQRW/2pwvJvnUC3t0DI=;
        b=K6LvM1Kc2Q8prsdBhKpZ5b8GWUB1t6p6Yk/3IFo1XWb/ZVchDXzE71X+cQvdxEqd9IjH9K
        lI6RnlJBxWXWxMvOOIejxMjcg+ZNJMN+eTUdKDW4eDR4M+aUbI8vrxVyTMQq8jWrxJYcV5
        nfk4/ANZoDgYs/UVjJW2G/F7gaqu0TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-BdNL_hT_M0SmM5_X4uyOeA-1; Thu, 19 Nov 2020 14:32:47 -0500
X-MC-Unique: BdNL_hT_M0SmM5_X4uyOeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E28C31842140;
        Thu, 19 Nov 2020 19:32:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED4B85D9C6;
        Thu, 19 Nov 2020 19:32:43 +0000 (UTC)
Date:   Thu, 19 Nov 2020 20:32:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        ravi.bangoria@linux.ibm.com, maddy@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix metric parsing test
Message-ID: <20201119193242.GJ1475102@krava>
References: <20201119152411.46041-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119152411.46041-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 08:54:11PM +0530, Kajol Jain wrote:
> Commit e1c92a7fbbc5 ("perf tests: Add another metric parsing test")
> add another test for metric parsing. The test goes through all metrics
> compiled for arch within pmu events and try to parse them.
> 
> Right now this test is failing in powerpc machine.
> 
> Result in power9 platform:
> 
> [command]# ./perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
> 
> Issue is we are passing different runtime parameter value in "expr__find_other"
> and "expr__parse" function which is called from function `metric_parse_fake`.
> And because of this parsing of hv-24x7 metrics is failing.
> 
> [command]# ./perf test 10 -vv
> .....
> hv_24x7/pm_mcs01_128b_rd_disp_port01,chip=1/ not found
> expr__parse failed
> test child finished with -1
> ---- end ----
> PMU events subtest 4: FAILED!
> 
> This patch fix this issue and change runtime parameter value to '0' in
> expr__parse function.
> 
> Result in power9 platform after this patch:
> 
> [command]# ./perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> 
> Fixes: e1c92a7fbbc5 ("perf tests: Add another metric parsing test")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/pmu-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index ad2b21591275..0ca6a5a53523 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -575,7 +575,7 @@ static int metric_parse_fake(const char *str)
>  		}
>  	}
>  
> -	if (expr__parse(&result, &ctx, str, 1))
> +	if (expr__parse(&result, &ctx, str, 0))
>  		pr_err("expr__parse failed\n");
>  	else
>  		ret = 0;
> -- 
> 2.27.0
> 

