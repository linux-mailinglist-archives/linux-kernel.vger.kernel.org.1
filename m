Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312472CF785
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgLDXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgLDXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607124571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMf3aciavepCcHzGKcJTLCFHUdfG/7hkcLL6JjOyw9o=;
        b=OSYri7VY09ktuBJGdQfZLG8xuyzEWWKMY4TGHVViDwah5g88ljpIz9Y4mKwzplTRl0cv6k
        91LQysIRuqa2ygnAPjEOTPTxExF1vXKZFsqg7eBkWWiYJa7EazGqalWsszRxWVsuGCVytP
        PB/UnD94Ml4cT3BB5uVc5HJe6vY9m8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-MUIHu1V_P8ePYzb-SS66UA-1; Fri, 04 Dec 2020 18:28:08 -0500
X-MC-Unique: MUIHu1V_P8ePYzb-SS66UA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E3E6800D53;
        Fri,  4 Dec 2020 23:28:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17F2C5C22A;
        Fri,  4 Dec 2020 23:27:59 +0000 (UTC)
Date:   Sat, 5 Dec 2020 00:27:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 06/12] perf mem: Clean up output format
Message-ID: <20201204232756.GK3613628@krava>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172803.2676-7-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:27:57AM -0800, kan.liang@linux.intel.com wrote:

SNIP

> @@ -172,7 +172,7 @@ dump_raw_samples(struct perf_tool *tool,
>  {
>  	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
>  	struct addr_location al;
> -	const char *fmt;
> +	const char *fmt, *field_sep;
>  
>  	if (machine__resolve(machine, &al, sample) < 0) {
>  		fprintf(stderr, "problem processing %d event, skipping it.\n",
> @@ -186,60 +186,41 @@ dump_raw_samples(struct perf_tool *tool,
>  	if (al.map != NULL)
>  		al.map->dso->hit = 1;
>  
> -	if (mem->phys_addr) {
> -		if (symbol_conf.field_sep) {
> -			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
> -			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
> -		} else {
> -			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
> -			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
> -			      "%s%s:%s\n";
> -			symbol_conf.field_sep = " ";
> -		}
> -
> -		printf(fmt,
> -			sample->pid,
> -			symbol_conf.field_sep,
> -			sample->tid,
> -			symbol_conf.field_sep,
> -			sample->ip,
> -			symbol_conf.field_sep,
> -			sample->addr,
> -			symbol_conf.field_sep,
> -			sample->phys_addr,
> -			symbol_conf.field_sep,
> -			sample->weight,
> -			symbol_conf.field_sep,
> -			sample->data_src,
> -			symbol_conf.field_sep,
> -			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
> -			al.sym ? al.sym->name : "???");
> +	field_sep = symbol_conf.field_sep;

hum, what's the point of having field_sep?

> +	if (field_sep) {
> +		fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s";
>  	} else {
> -		if (symbol_conf.field_sep) {
> -			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
> -			      "%s0x%"PRIx64"%s%s:%s\n";
> -		} else {
> -			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
> -			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
> -			symbol_conf.field_sep = " ";
> -		}
> +		fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64"%s";
> +		symbol_conf.field_sep = " ";
> +	}
> +	printf(fmt,
> +		sample->pid,
> +		symbol_conf.field_sep,
> +		sample->tid,
> +		symbol_conf.field_sep,
> +		sample->ip,
> +		symbol_conf.field_sep,
> +		sample->addr,
> +		symbol_conf.field_sep);
>  
> -		printf(fmt,
> -			sample->pid,
> -			symbol_conf.field_sep,
> -			sample->tid,
> -			symbol_conf.field_sep,
> -			sample->ip,
> -			symbol_conf.field_sep,
> -			sample->addr,
> -			symbol_conf.field_sep,
> -			sample->weight,
> -			symbol_conf.field_sep,
> -			sample->data_src,
> -			symbol_conf.field_sep,
> -			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
> -			al.sym ? al.sym->name : "???");
> +	if (mem->phys_addr) {
> +		printf("0x%016"PRIx64"%s",
> +			sample->phys_addr,
> +			symbol_conf.field_sep);
>  	}
> +
> +	if (field_sep)
> +		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
> +	else
> +		fmt = "%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
> +
> +	printf(fmt,
> +		sample->weight,
> +		symbol_conf.field_sep,
> +		sample->data_src,
> +		symbol_conf.field_sep,
> +		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
> +		al.sym ? al.sym->name : "???");
>  out_put:
>  	addr_location__put(&al);
>  	return 0;
> @@ -287,10 +268,12 @@ static int report_raw_events(struct perf_mem *mem)
>  	if (ret < 0)
>  		goto out_delete;
>  
> +	printf("# PID, TID, IP, ADDR, ");
> +
>  	if (mem->phys_addr)
> -		printf("# PID, TID, IP, ADDR, PHYS ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
> -	else
> -		printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
> +		printf("PHYS ADDR, ");
> +
> +	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");

if phys addr is the only member, can't we just squeeze it via
  "%s", mem->phys_addr ? "PHYS ADDR" : "",
like I mentioned in the other reply? and same also above?

thanks,
jirka

>  
>  	ret = perf_session__process_events(session);
>  
> -- 
> 2.17.1
> 

