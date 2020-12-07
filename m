Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD922D1717
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLGRDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:03:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2214 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgLGRDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:03:14 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqV0v0pSyz67MMK;
        Tue,  8 Dec 2020 00:59:59 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 18:02:31 +0100
Received: from [10.47.199.254] (10.47.199.254) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 17:02:25 +0000
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
Date:   Mon, 7 Dec 2020 20:02:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206170519.4010606-3-jolsa@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.199.254]
X-ClientProxiedBy: braeml702-chm.china.huawei.com (10.226.71.46) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06.12.2020 20:05, Jiri Olsa wrote:
> Adding new control events to enable/disable specific event.
> The interface string for control file are:
> 
>   'enable-<EVENT NAME>'
>   'disable-<EVENT NAME>'

<SNIP>

> 
> when received the command, perf will scan the current evlist
> for <EVENT NAME> and if found it's enabled/disabled.

<SNIP>

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 70aff26612a9..05723227bebf 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>  		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
>  
>  	if (bytes_read > 0) {
> -		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>  			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
>  			*cmd = EVLIST_CTL_CMD_ENABLE;
>  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
>  	int ctlfd_pos = evlist->ctl_fd.pos;
>  	struct pollfd *entries = evlist->core.pollfd.entries;
> +	struct evsel *evsel;
> +	char *evsel_name;
>  
>  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
>  		return 0;
> @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  			case EVLIST_CTL_CMD_DISABLE:
>  				evlist__disable(evlist);
>  				break;
> +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;

It makes sense to check that evsel_name still points
into cmd_data buffer after assigning to event name.

Regards,
Alexei
