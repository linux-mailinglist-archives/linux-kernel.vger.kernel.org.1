Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C123295AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509619AbgJVIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2509604AbgJVIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603356234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8dkbdp/Uq2Yj87VvahlPaV4rBENgtQDLHmQL0Vslk8=;
        b=Z5ezqhJ5p9X/S4LAPmweOM0z7gA7gr9N1uSKqXQwk8Y6X0snF7bGJcfnfdwJrpk20gwUPS
        eHH7J+wo4SqVOAlMJyLKX1gCom4UZzK51YU/lYuWFSe2SeDuFImXf62K6jM8po3tPdmBjO
        6/8HXvLLlelYPoWF1ElXvnp/FWDQOFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-ZOzc3hBYNFW0ldduxu04AA-1; Thu, 22 Oct 2020 04:43:50 -0400
X-MC-Unique: ZOzc3hBYNFW0ldduxu04AA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20839CC03;
        Thu, 22 Oct 2020 08:43:48 +0000 (UTC)
Received: from krava (unknown [10.40.195.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92A795C1C7;
        Thu, 22 Oct 2020 08:43:45 +0000 (UTC)
Date:   Thu, 22 Oct 2020 10:43:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] perf c2c: Add option '-d llc' for sorting with
 LLC load
Message-ID: <20201022084344.GA2318292@krava>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015145041.10953-8-leo.yan@linaro.org>
 <20201020072553.GC2084117@krava>
 <20201020080839.GC13630@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020080839.GC13630@leoy-ThinkPad-X240s>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 04:08:39PM +0800, Leo Yan wrote:

SNIP

> > 
> > please update man page with this
> > 
> > >  	else {
> > >  		pr_err("failed: unknown display type: %s\n", str);
> > >  		return -1;
> > > @@ -2766,9 +2795,10 @@ static int build_cl_output(char *cl_sort, bool no_source)
> > >  	}
> > >  
> > >  	if (asprintf(&c2c.cl_output,
> > > -		"%s%s%s%s%s%s%s%s%s%s",
> > > +		"%s%s%s%s%s%s%s%s%s%s%s",
> > 
> > why is there extra '%s' when we did not add new argument.. ?
> 
> This is deliberate.  The change is as below:
> 
>         if (asprintf(&c2c.cl_output,
> -               "%s%s%s%s%s%s%s%s%s%s",
> +               "%s%s%s%s%s%s%s%s%s%s%s",
>                 c2c.use_stdio ? "cl_num_empty," : "",
> -               "percent_rmt_hitm,"
> +               c2c.display == DISPLAY_LLC ? "percent_llc_hit," :
> +                                            "percent_rmt_hitm,",
>                 "percent_lcl_hitm,"
> 
> In the old code the string "percent_rmt_hitm," is merged with later
> lines (the second string is "percent_lcl_hitm,") into single string.
> 
> In this patch, it needs to check condition c2c.display and pass
> different string ("percent_llc_hit," vs "percent_rmt_hitm,"), thus
> the string ("percent_llc_hit," or "percent_rmt_hitm,") is passed
> independently, it's _NOT_ jointed with sequnetial lines.

ah right, it's now 2 arguments instead of one

thanks,
jirka

