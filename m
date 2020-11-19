Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149C82B9BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgKSTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgKSTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605815238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E82s7cBwHPscd6rsa5ytoY+Np8WhFrIOZa+AfiYKSuo=;
        b=QkampcSmTVckuhLlAWuhWJEYU66HdsU2tasua+LV1ewydtGRh7Y+FW4mQQe0lmiMAZGoem
        X3/nf/Ttmm6IfcXo3aycCu4R5f/ODfKBnHfX+Fuq6pJERAa6L17YNZI0p3YtWnhBAQERTS
        NgwpzoFlufQIlyXU9lCCxrHYNiqzMH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-ef5n5jnXOTCyVGCQuUXRpw-1; Thu, 19 Nov 2020 14:47:14 -0500
X-MC-Unique: ef5n5jnXOTCyVGCQuUXRpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C9D80476B;
        Thu, 19 Nov 2020 19:47:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6E31A6064B;
        Thu, 19 Nov 2020 19:47:08 +0000 (UTC)
Date:   Thu, 19 Nov 2020 20:47:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/5] perf metric: Use NAN for missing event IDs.
Message-ID: <20201119194707.GK1475102@krava>
References: <20201118050335.2347358-1-irogers@google.com>
 <20201118050335.2347358-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118050335.2347358-3-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:03:32PM -0800, Ian Rogers wrote:
> If during computing a metric an event (id) is missing the parsing
> aborts. A later patch will make it so that events that aren't used in
> the output are deliberately omitted, in which case we don't want the
> abort. Modify the missing ID case to report NAN for these cases.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.y | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index b2ada8f8309a..c22e3500a40f 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -1,6 +1,7 @@
>  /* Simple expression parser */
>  %{
>  #define YYDEBUG 1
> +#include <math.h>
>  #include <stdio.h>
>  #include "util.h"
>  #include "util/debug.h"
> @@ -89,8 +90,7 @@ expr:	  NUMBER
>  					struct expr_id_data *data;
>  
>  					if (expr__resolve_id(ctx, $1, &data)) {
> -						free($1);
> -						YYABORT;
> +						$$ = NAN;

hum, it's directly overwriten in the next line, no?

jirka

>  					}
>  
>  					$$ = expr_id_data__value(data);

> -- 
> 2.29.2.299.gdc1121823c-goog
> 

