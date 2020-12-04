Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29E12CF780
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgLDX3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgLDX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607124477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8c8UYEFY9Nurj5pLoMl8J7loXHGqHwZmdLr1BfL4nD4=;
        b=gV4IkfCEJ8HmQWehO4HPN3eRbSICNJR9cr5ye91t8AWNc/9BoIZ6knAYfllXQjFNc8fC6R
        ucWZzRDkomvCmdp+1dJcDU7Ufw3+b66KQdM0n8hyd57r+bsw8SQ8XFABODsWB5HG0gdgyz
        wiFUrmy0/HT3U5x3k1lGmRV1ADv6PjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-I1g6wEvfPjqdyK06QD261w-1; Fri, 04 Dec 2020 18:27:52 -0500
X-MC-Unique: I1g6wEvfPjqdyK06QD261w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 473E1801B38;
        Fri,  4 Dec 2020 23:27:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id C3C5017C58;
        Fri,  4 Dec 2020 23:27:48 +0000 (UTC)
Date:   Sat, 5 Dec 2020 00:27:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 05/12] perf mem: Factor out a function to generate
 sort order
Message-ID: <20201204232747.GJ3613628@krava>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172803.2676-6-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:27:56AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Now, "--phys-data" is the only option which impacts the sort order.
> A simple "if else" is enough to handle the option. But there will be
> more options added, e.g. "--data-page-size", which also impact the sort
> order. The code will become too complex to be maintained.
> 
> Divide the sort order string into several small pieces.
> The first piece is always the default sort string for LOAD/STORE.
> Appends the specific sort string if related option is applied.
> 
> No functional change.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-mem.c | 41 ++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index fdfbff7592f4..823742036ddb 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -298,11 +298,35 @@ static int report_raw_events(struct perf_mem *mem)
>  	perf_session__delete(session);
>  	return ret;
>  }
> +static char *get_sort_order(struct perf_mem *mem)
> +{
> +	bool has_extra_options = mem->phys_addr ? true : false;

hum, would simple assignment do? ;-)

how about to do this like in c2c with extra %s:

       if (!(mem->operation & MEM_OPERATION_LOAD)) {
               strcpy(sort, "--sort=mem,sym,dso,symbol_daddr,"
                            "dso_daddr,tlb,locked%s",
                            mem->phys_addr ? ",phys_daddr" : "");
       } else if (mem->phys_addr) {
               strcpy(sort, "--sort=local_weight,mem,sym,dso,symbol_daddr,"
                            "dso_daddr,snoop,tlb,locked,phys_daddr");
       } else
               return NULL;

jirka

> +	char sort[128];
> +
> +	/*
> +	 * there is no weight (cost) associated with stores, so don't print
> +	 * the column
> +	 */
> +	if (!(mem->operation & MEM_OPERATION_LOAD)) {
> +		strcpy(sort, "--sort=mem,sym,dso,symbol_daddr,"
> +			     "dso_daddr,tlb,locked");
> +	} else if (has_extra_options) {
> +		strcpy(sort, "--sort=local_weight,mem,sym,dso,symbol_daddr,"
> +			     "dso_daddr,snoop,tlb,locked");
> +	} else
> +		return NULL;
> +
> +	if (mem->phys_addr)
> +		strcat(sort, ",phys_daddr");
> +
> +	return strdup(sort);
> +}
>  
>  static int report_events(int argc, const char **argv, struct perf_mem *mem)
>  {
>  	const char **rep_argv;
>  	int ret, i = 0, j, rep_argc;
> +	char *new_sort_order;
>  
>  	if (mem->dump_raw)
>  		return report_raw_events(mem);
> @@ -316,20 +340,9 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
>  	rep_argv[i++] = "--mem-mode";
>  	rep_argv[i++] = "-n"; /* display number of samples */
>  
> -	/*
> -	 * there is no weight (cost) associated with stores, so don't print
> -	 * the column
> -	 */
> -	if (!(mem->operation & MEM_OPERATION_LOAD)) {
> -		if (mem->phys_addr)
> -			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
> -					"dso_daddr,tlb,locked,phys_daddr";
> -		else
> -			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
> -					"dso_daddr,tlb,locked";
> -	} else if (mem->phys_addr)
> -		rep_argv[i++] = "--sort=local_weight,mem,sym,dso,symbol_daddr,"
> -				"dso_daddr,snoop,tlb,locked,phys_daddr";
> +	new_sort_order = get_sort_order(mem);
> +	if (new_sort_order)
> +		rep_argv[i++] = new_sort_order;
>  
>  	for (j = 1; j < argc; j++, i++)
>  		rep_argv[i] = argv[j];
> -- 
> 2.17.1
> 

