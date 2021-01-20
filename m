Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB92FD30B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbhATOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733032AbhATM57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611147393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A6+8Tuy0shZJE4X0cyaUDSZDq1oqmw9x/zn4yiM/SAc=;
        b=fnH5kUzUgfVke5KL65qflmbF+vCB8d9YMvvSpA8lqzobCkJ18ARTix2ejfggNX7S9IBnHk
        z4aHVxGnp9UAQWpQ2GV7DztfS3GpUIY9ZYtzceTc1BNEp1Di8YQ4nwWIAb1+fhv4eVxqox
        Zvms7LCjvRHpq1xlwKNcKFTOUWU+klY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-vSNXAU4BOtWTd9Z0a0rfIg-1; Wed, 20 Jan 2021 07:56:29 -0500
X-MC-Unique: vSNXAU4BOtWTd9Z0a0rfIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2BC192D785;
        Wed, 20 Jan 2021 12:56:27 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FA135D9C2;
        Wed, 20 Jan 2021 12:56:23 +0000 (UTC)
Date:   Wed, 20 Jan 2021 13:56:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
Message-ID: <20210120125622.GE1760208@krava>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:33:13PM +0000, John Garry wrote:

SNIP

> Please try this:
> 
> From 2380f1ef0250e6818b3dbc7bff4a868810875e2a Mon Sep 17 00:00:00 2001
> From: John Garry <john.garry@huawei.com>
> Date: Tue, 19 Jan 2021 17:29:54 +0000
> Subject: [PATCH] perf metricgroup: Fix metric support for duration_time
> 
> For a metric using duration_time, the strcmp() check when finding identical
> events in metric_events[] is broken, as it does not consider that the
> event pmu_name is NULL - it would be for duration_time.
> 
> As such, add a NULL check here for event pmu_name.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ee94d3e8dd65..277adff8017f 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -280,6 +280,8 @@ static struct evsel *find_evsel_group(struct evlist
> *perf_evlist,
>  			 */
>  			if (!has_constraint &&
>  			    ev->leader != metric_events[i]->leader &&
> +			    ev->leader->pmu_name &&
> +			    metric_events[i]->leader->pmu_name &&
>  			    !strcmp(ev->leader->pmu_name,
>  				    metric_events[i]->leader->pmu_name))
>  				break;
> -- 
> 2.26.2
> 
> 
> 

that's fixing the issue for me, this was crashing:
  # perf stat -a -I 1000 -M L1D_Cache_Fill_BW,L2_Cache_Fill_BW

could you please send it formaly, so it can be merged?

I can't reproduce the original patch issue and I need
to check the code in more depth

thanks,
jirka

