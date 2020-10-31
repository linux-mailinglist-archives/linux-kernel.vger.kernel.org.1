Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7C2A1A84
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgJaUVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbgJaUVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604175675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MviwNPfEWhgiwYrzzU/hWekrxH9/LdyDhzttAr8AwxQ=;
        b=F0zPzaZSpVmLW11iU+8V03R89SFNl2bfcXdB6i3qpkPhR5WKiIMbt5mM/InNqOamo0xCK/
        udQKuGHPaMKVVnxMwDDZu6RDD0rh27TgL267GhkLW+7/LT9DuwlwcX1mrHZP3wRRsxRDi/
        fZ/tCt2cOo5C8aveHEpeAFSrBCTXlx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-i4Ip-7YgN0KlOdRHSHLlyg-1; Sat, 31 Oct 2020 16:21:11 -0400
X-MC-Unique: i4Ip-7YgN0KlOdRHSHLlyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65BD41006C82;
        Sat, 31 Oct 2020 20:21:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1AF1F55767;
        Sat, 31 Oct 2020 20:21:03 +0000 (UTC)
Date:   Sat, 31 Oct 2020 21:21:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/9] perf c2c: Support AUX trace
Message-ID: <20201031202103.GA3380099@krava>
References: <20201028063813.8562-1-leo.yan@linaro.org>
 <20201028063813.8562-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028063813.8562-7-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:38:10PM +0800, Leo Yan wrote:
> This patches adds the AUX callbacks in session structure, so support
> AUX trace for "perf c2c" tool.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 4d1a08e38233..24f4af997aab 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -369,6 +369,10 @@ static struct perf_c2c c2c = {
>  		.exit		= perf_event__process_exit,
>  		.fork		= perf_event__process_fork,
>  		.lost		= perf_event__process_lost,
> +		.attr		= perf_event__process_attr,
> +		.auxtrace_info  = perf_event__process_auxtrace_info,
> +		.auxtrace       = perf_event__process_auxtrace,
> +		.auxtrace_error = perf_event__process_auxtrace_error,

so this will process aux data, but don't you have to
say which events you want to synthesize?

like in script/report via --itrace option?

aybe arm differs from x86 in this, and it's happening
in the background.. I have no idea ;-)

jirka

>  		.ordered_events	= true,
>  		.ordering_requires_timestamps = true,
>  	},
> -- 
> 2.17.1
> 

