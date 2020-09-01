Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7242B259590
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgIAPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:53:13 -0400
Received: from foss.arm.com ([217.140.110.172]:44482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgIAPxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:53:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 760461045;
        Tue,  1 Sep 2020 08:52:59 -0700 (PDT)
Received: from [10.57.45.104] (unknown [10.57.45.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26ED3F71F;
        Tue,  1 Sep 2020 08:52:55 -0700 (PDT)
Subject: Re: [PATCH RESEND v1 05/11] perf mem: Support AUX trace
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
 <20200806030727.30267-6-leo.yan@linaro.org>
Cc:     nd <nd@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <7b0e61d3-3f28-0e98-9c82-b9a9573bf571@arm.com>
Date:   Tue, 1 Sep 2020 16:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806030727.30267-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

>  
> +static int process_attr(struct perf_tool *tool __maybe_unused,
> +			union perf_event *event,
> +			struct evlist **pevlist)
> +{
> +	int err;
> +
> +	err = perf_event__process_attr(tool, event, pevlist);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>  int cmd_mem(int argc, const char **argv)
>  {
>  	struct stat st;
> @@ -405,8 +430,12 @@ int cmd_mem(int argc, const char **argv)
>  			.comm		= perf_event__process_comm,
>  			.lost		= perf_event__process_lost,
>  			.fork		= perf_event__process_fork,
> +			.attr		= process_attr,
>  			.build_id	= perf_event__process_build_id,

I don't understand the __maybe_unused here. And also isn't this equivalent
to this without the new function:

  @@ -405,8 +430,12 @@ int cmd_mem(int argc, const char **argv)
   			.comm		= perf_event__process_comm,
   			.lost		= perf_event__process_lost,
   			.fork		= perf_event__process_fork,
  +			.attr		= perf_event__process_attr,
   			.build_id	= perf_event__process_build_id,


James
