Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6F2DBC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgLPHzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:55:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2263 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLPHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:55:43 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CwnPb36Llz67QjZ;
        Wed, 16 Dec 2020 15:51:15 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 16 Dec 2020 08:54:56 +0100
Received: from [10.47.203.173] (10.47.203.173) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 16 Dec 2020 07:54:49 +0000
Subject: Re: [PATCH 4/8] perf daemon: Add daemon command
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
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-5-jolsa@kernel.org>
 <1e467abe-4613-765f-5138-6215b711f9fb@huawei.com>
 <20201215194354.GH698181@krava>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <c3981c21-e970-6e27-af2a-364cbcdc6f2e@huawei.com>
Date:   Wed, 16 Dec 2020 10:54:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215194354.GH698181@krava>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.203.173]
X-ClientProxiedBy: braeml703-chm.china.huawei.com (10.226.71.47) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.12.2020 22:43, Jiri Olsa wrote:
> On Tue, Dec 15, 2020 at 06:40:26PM +0300, Alexei Budankov wrote:
>> Hi,
>>
>> On 12.12.2020 13:43, Jiri Olsa wrote:
>>> Adding daemon command that allows to run record sessions
>>> on background. Each session represents one perf record
>>> process and is configured in config file.
>>>
>>> Example:
>>>
>>>   # cat config.daemon
>>>   [daemon]
>>>   base=/opt/perfdata
>>
>> It could probably make sense to consider using locations at /var/
>> directory, similar to other already existing daemon processes in
>> system so admin and user experience would be easily reusabe for
>> performance monitoring daemon (service).
> 
> hm, you can specify any /var path in there if you like,
> do you suggest to hardcode it?

This thing: https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
Since Perf is a part of OS it would better use some standardized locations.

> 
>>
>>>
>>>   [session-1]
>>>   run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
>>>
>>>   [session-2]
>>>   run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
>>>
>>> Default perf config has the same daemon base:
>>>
>>>   # cat ~/.perfconfig
>>>   [daemon]
>>>   base=/opt/perfdata
>>>
>>> Starting the daemon:
>>>
>>>   # perf daemon --config config.daemon
>>
>> It could make sense to name daemon config file similar to .perfconfig
>> e.g. like .perfconfig.daemon. perf daemon command would then assume, by
>> default, usage of .perfconfig.daemon config or the one specified on the
>> command line via --config option. It also would be helpfull have loaded
>> config file path printed into console:
>> # perf daemon
>> Daemon process <pid> started with config /path/to/.perfconfig.daemon
> 
> so the current way is, that following creates daemon:
> 
>   # perf daemon --config <CONFIG>
> 
> and any other 'non --config' option' is used to 'query/control' daemon:
> 
>   # perf daemon
>   # perf daemon --signal
>   # perf daemon --stop
>   ...
> 
> 
> I'd like to keep short way checking on daemon, without too many
> options, like:
> 
>   # perf daemon
>   [690174:daemon] base: /opt/perfdata
>   [690175:top] perf record -e cycles --switch-output=1m --switch-max-files=6 -a
> 
> 
> I think maybe we don't need any other .perfconfig, we could have
> all in standard .perfconfig, like:
> 
>   # cat .perfconfig:
>   [daemon]
>   base=/opt/perfdata
> 
>   [session-1]
>   run = -m 1M -e cycles --overwrite --switch-output -a
>   [session-2]
>   run = -m 1M -e sched:* --overwrite --switch-output -a
> 
> 
> and to run daemon on top of it:
> 
>   # perf daemon --start
> 
> 
> to run daemon with alternate config:
> 
>   # perf daemon --start=<CONFIGFILE>
> 
> or:
> 
>   # perf daemon --start --config=<CONFIGFILE>
> 
> 
> and checking on daemon with default .perfconfig setup:
> 
>   # perf daemon
> 
> 
> checking on daemon with different base or config:
> 
>   # perf daemon --base=<BASE>
>   # perf daemon --config=<CONFIGFILE>
>   # perf daemon --base=<BASE> --stop
>   # perf daemon --base=<BASE> --signal
>   # perf daemon --config=<CONFIGFILE> --stop
>   # perf daemon --config=<CONFIGFILE> --signal
> 
> how about that?

Extending .perfconfig would look simpler for users, IHMO.
It looks like --base option actually implements --sandbox
or similar semantics.

> 
> SNIP
> 
>>> +static struct session*
>>> +daemon__find_session(struct daemon *daemon, char *name)
>>> +{
>>> +	struct session *session;
>>> +
>>> +	list_for_each_entry(session, &daemon->sessions, list) {
>>> +		if (!strcmp(session->name, name))
>>> +			return session;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static int session_name(const char *var, char *session, int len)
>>
>> should possibly name it get_session_name.
> 
> ok
> 
>>
>>> +{
>>> +	const char *p = var + sizeof("session-") - 1;
>>
>> should possibly check that p still points inside [var, var+len).
> 
> ok
> 
> SNIP
> 
>>> +static int session__wait(struct session *session, struct daemon *daemon,
>>> +			 int secs)
>>> +{
>>> +	time_t current, start = 0;
>>> +	int cnt;
>>> +
>>> +	start = current = time(NULL);
>>> +
>>> +	do {
>>> +		usleep(500);
>>
>> This polling design is actually sub-optimal because it induces redundant
>> noise in a system. Ideally it should be implemented in async fashion so
>> kernel would atomically notify daemon process on event happened in some
>> of record processes e.g. using of poll-like() system call.
> 
> ok, any suggestion?

Possibly, checking SIGCHLDs via signalfd [1] OR using pidfd [2] on kernel v5.3+

[1] https://man7.org/linux/man-pages/man2/signalfd.2.html
[2] https://man7.org/linux/man-pages/man2/pidfd_open.2.html

Thanks,
Alexei

> 
>>
>>> +		cnt = session__check(session, daemon);
>>> +		if (cnt)
>>> +			break;
>>> +
>>> +		current = time(NULL);
>>> +	} while ((start + secs > current));
>>> +
>>> +	return cnt;
>>> +}
>>> +
>>> +static int session__signal(struct session *session, int sig)
>>> +{
>>> +	if (session->pid < 0)
>>> +		return -1;
>>> +	return kill(session->pid, sig);
>>
>> "Better" alternative could possibly be sending of some 'stop' command
>> via --control=fd.
> 
> true, nice idea.. seems more clean and we already have control fd open
> 
> will add it to next version
> 
> thanks,
> jirka
> 
> .
> 
