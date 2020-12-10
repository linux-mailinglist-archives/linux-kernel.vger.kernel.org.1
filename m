Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065222D651D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393085AbgLJSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:33:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2246 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392680AbgLJSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:33:44 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsMsp5bTZz67K4w;
        Fri, 11 Dec 2020 02:30:22 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 19:33:02 +0100
Received: from [10.47.200.37] (10.47.200.37) by lhreml741-chm.china.huawei.com
 (10.201.108.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 10 Dec
 2020 18:32:55 +0000
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
From:   Alexei Budankov <abudankov@huawei.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava> <20201210180646.GA186916@krava>
 <6214e1cd-e6a4-2a7a-160c-47212afdc190@huawei.com>
Message-ID: <65ed9170-e88a-d034-5fda-e82c50846b0a@huawei.com>
Date:   Thu, 10 Dec 2020 21:32:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <6214e1cd-e6a4-2a7a-160c-47212afdc190@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.200.37]
X-ClientProxiedBy: braeml707-chm.china.huawei.com (10.226.71.37) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.2020 21:20, Alexei Budankov wrote:
> 
> On 10.12.2020 21:06, Jiri Olsa wrote:
>> On Thu, Dec 10, 2020 at 05:24:30PM +0100, Jiri Olsa wrote:
>>> On Mon, Dec 07, 2020 at 08:02:20PM +0300, Alexei Budankov wrote:
>>>> Hi,
>>>>
>>>> On 06.12.2020 20:05, Jiri Olsa wrote:
>>>>> Adding new control events to enable/disable specific event.
>>>>> The interface string for control file are:
>>>>>
>>>>>   'enable-<EVENT NAME>'
>>>>>   'disable-<EVENT NAME>'
>>>>
>>>> <SNIP>
>>>>
>>>>>
>>>>> when received the command, perf will scan the current evlist
>>>>> for <EVENT NAME> and if found it's enabled/disabled.
>>>>
>>>> <SNIP>
>>>>
>>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>>> index 70aff26612a9..05723227bebf 100644
>>>>> --- a/tools/perf/util/evlist.c
>>>>> +++ b/tools/perf/util/evlist.c
>>>>> @@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>>>>>  		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
>>>>>  
>>>>>  	if (bytes_read > 0) {
>>>>> -		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>>>>> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
>>>>> +				    (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
>>>>> +			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
>>>>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
>>>>> +				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
>>>>> +			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
>>>>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>>>>>  			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
>>>>>  			*cmd = EVLIST_CTL_CMD_ENABLE;
>>>>>  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
>>>>> @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>>>>>  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
>>>>>  	int ctlfd_pos = evlist->ctl_fd.pos;
>>>>>  	struct pollfd *entries = evlist->core.pollfd.entries;
>>>>> +	struct evsel *evsel;
>>>>> +	char *evsel_name;
>>>>>  
>>>>>  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
>>>>>  		return 0;
>>>>> @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>>>>>  			case EVLIST_CTL_CMD_DISABLE:
>>>>>  				evlist__disable(evlist);
>>>>>  				break;
>>>>> +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
>>>>> +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
>>>>
>>>> It makes sense to check that evsel_name still points
>>>> into cmd_data buffer after assigning to event name.
>>>
>>> right, will add that
>>
>> actualy it's already checked in evlist__ctlfd_recv, evsel_name at
>> worst will be empty string so evlist__find_evsel_by_str will fail
>>
>> I'll add '' around %s in the error output string:
>>
>>   failed: can't find '%s' event
>>
>> so it's obvious when it's empty

Acked-by: Alexei Budankov <abudankov@huawei.com>

Thanks,
Alexei
