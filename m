Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0FA1B0572
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 05:19:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587374354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWEIBWdM9RbTpT6ETPi30Ao+bxLzhh45AcEer5KPA+s=;
        b=JoUeLSOA0KLi3MmQQolje9VNGerTxaLkYACdXka34gafhi4WcHa45letxsfg4ZUWhV8A1j
        zY5dyhxZxsVt7iSz/AWT2XojN4XuH5sW1naF4ycpycahyDinD3mE9D3p3f1knhHBYP/xzC
        0NqctZ3I9OIyFouzQgSxMvh1qPP6Inw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-5pZm9p14NXm3ZDrx20VIhw-1; Mon, 20 Apr 2020 05:19:12 -0400
X-MC-Unique: 5pZm9p14NXm3ZDrx20VIhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C093C8018A8;
        Mon, 20 Apr 2020 09:19:10 +0000 (UTC)
Received: from krava (ovpn-115-153.ams2.redhat.com [10.36.115.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9D8792FA1;
        Mon, 20 Apr 2020 09:19:08 +0000 (UTC)
Date:   Mon, 20 Apr 2020 11:19:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Improve runtime stat for interval mode
Message-ID: <20200420091906.GG718574@krava>
References: <20200417005154.9024-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417005154.9024-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 08:51:54AM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..d5c326ff46d0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -359,6 +359,7 @@ static void process_interval(void)
>  	clock_gettime(CLOCK_MONOTONIC, &ts);
>  	diff_timespec(&rs, &ts, &ref_time);
>  
> +	perf_stat__reset_rt_stat();

could you use just existing:

	perf_stat__reset_shadow_per_stat(&rt_stat)

or perhaps event perf_stat__reset_shadow_stats, given
that we init walltime_nsecs_stats just few lines below

jirka

>  	read_counters(&rs);
>  
>  	if (STAT_RECORD) {

SNIP

