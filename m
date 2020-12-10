Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507C62D64F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbgLJS2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392560AbgLJS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:28:14 -0500
Date:   Thu, 10 Dec 2020 15:27:43 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607624853;
        bh=2lOAbv8B7kDTh9iNclTB/Lo7cyz05NXseUrK/M6cHRU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcdrqgMHVt/7EAaj7qwdOJrot1FHGTOrZXPmSai+RXWrwqIk5ATVp6DQeGFY1mfzz
         x37Bcpk81HzIV/qd/LppOWjhAWgQ5WbN5Ql6Cgr171/y/I2RLSozqDCCBbD7u3L3M3
         mUlt/nptvNXHacsc9OlZEnm1xHh7Ti5/15Zyb/gKPJnE0913ZRK/i5SavzhkazT5eC
         6g65YwgVlWlAu4x6cJPkNOfWlaFY24sePeYREHd1NDKvz1wJAHBWX3AUxDs+UxAjMa
         S2YHJyWni34326O7NTTgYKkQleed7nmHrFf0RPuZvWDpdTYziUz9dLoE3ogGnkK5cS
         AQu4yj4WqkCBw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Budankov <abudankov@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20201210182743.GE195565@kernel.org>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava>
 <20201210180646.GA186916@krava>
 <6214e1cd-e6a4-2a7a-160c-47212afdc190@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6214e1cd-e6a4-2a7a-160c-47212afdc190@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 09:20:42PM +0300, Alexei Budankov escreveu:
> 
> On 10.12.2020 21:06, Jiri Olsa wrote:
> > On Thu, Dec 10, 2020 at 05:24:30PM +0100, Jiri Olsa wrote:
> >> On Mon, Dec 07, 2020 at 08:02:20PM +0300, Alexei Budankov wrote:
> >>> Hi,
> >>>
> >>> On 06.12.2020 20:05, Jiri Olsa wrote:
> >>>> Adding new control events to enable/disable specific event.
> >>>> The interface string for control file are:
> >>>>
> >>>>   'enable-<EVENT NAME>'
> >>>>   'disable-<EVENT NAME>'
> >>>
> >>> <SNIP>
> >>>
> >>>>
> >>>> when received the command, perf will scan the current evlist
> >>>> for <EVENT NAME> and if found it's enabled/disabled.
> >>>
> >>> <SNIP>
> >>>
> >>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>>> index 70aff26612a9..05723227bebf 100644
> >>>> --- a/tools/perf/util/evlist.c
> >>>> +++ b/tools/perf/util/evlist.c
> >>>> @@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
> >>>>  		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> >>>>  
> >>>>  	if (bytes_read > 0) {
> >>>> -		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> >>>> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
> >>>> +				    (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
> >>>> +			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
> >>>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
> >>>> +				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
> >>>> +			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
> >>>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> >>>>  			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
> >>>>  			*cmd = EVLIST_CTL_CMD_ENABLE;
> >>>>  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> >>>> @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> >>>>  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
> >>>>  	int ctlfd_pos = evlist->ctl_fd.pos;
> >>>>  	struct pollfd *entries = evlist->core.pollfd.entries;
> >>>> +	struct evsel *evsel;
> >>>> +	char *evsel_name;
> >>>>  
> >>>>  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
> >>>>  		return 0;
> >>>> @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> >>>>  			case EVLIST_CTL_CMD_DISABLE:
> >>>>  				evlist__disable(evlist);
> >>>>  				break;
> >>>> +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> >>>> +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
> >>>
> >>> It makes sense to check that evsel_name still points
> >>> into cmd_data buffer after assigning to event name.
> >>
> >> right, will add that
> > 
> > actualy it's already checked in evlist__ctlfd_recv, evsel_name at
> > worst will be empty string so evlist__find_evsel_by_str will fail
> > 
> > I'll add '' around %s in the error output string:
> > 
> >   failed: can't find '%s' event
> > 
> > so it's obvious when it's empty
> 
> Looks good to me. Thanks!

I'm taking this as an Acked-by: you as per
Documentation/process/submitting-patches.rst:

<quoted>
Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
has at least reviewed the patch and has indicated acceptance.  Hence patch
mergers will sometimes manually convert an acker's "yep, looks good to me"
into an Acked-by: (but note that it is usually better to ask for an
explicit ack).
</>

Thanks,

- Arnaldo
