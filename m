Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F82D6485
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbgLJSIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392845AbgLJSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607623616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vzwpL+oyCC6ybTYdSfCdXZ5JS1M9p4/+mGraiaF/j9s=;
        b=a7FGgSxWNpoJVrX5jNakOgvBwOMumYhWXWN9PQkqI3ufHTSTubaQYGST/wCVYine2fMn9R
        P2lZU6CuART6L/C0X543ewI78ppFF/ZfTm+osoq+uyV1DzICYnbIiRYKWLYiIxiR61s9rU
        517NislATGmEtYr4AKalzFczMpMcGTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-CraozjSoN-ChzJf9f-h3Pg-1; Thu, 10 Dec 2020 13:06:52 -0500
X-MC-Unique: CraozjSoN-ChzJf9f-h3Pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3158B84A5EC;
        Thu, 10 Dec 2020 18:06:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1041F5F9B8;
        Thu, 10 Dec 2020 18:06:46 +0000 (UTC)
Date:   Thu, 10 Dec 2020 19:06:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Budankov <abudankov@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20201210180646.GA186916@krava>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210162430.GH69683@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:24:30PM +0100, Jiri Olsa wrote:
> On Mon, Dec 07, 2020 at 08:02:20PM +0300, Alexei Budankov wrote:
> > Hi,
> > 
> > On 06.12.2020 20:05, Jiri Olsa wrote:
> > > Adding new control events to enable/disable specific event.
> > > The interface string for control file are:
> > > 
> > >   'enable-<EVENT NAME>'
> > >   'disable-<EVENT NAME>'
> > 
> > <SNIP>
> > 
> > > 
> > > when received the command, perf will scan the current evlist
> > > for <EVENT NAME> and if found it's enabled/disabled.
> > 
> > <SNIP>
> > 
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index 70aff26612a9..05723227bebf 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
> > >  		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> > >  
> > >  	if (bytes_read > 0) {
> > > -		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> > > +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
> > > +				    (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
> > > +			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
> > > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
> > > +				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
> > > +			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
> > > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> > >  			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
> > >  			*cmd = EVLIST_CTL_CMD_ENABLE;
> > >  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> > > @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> > >  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
> > >  	int ctlfd_pos = evlist->ctl_fd.pos;
> > >  	struct pollfd *entries = evlist->core.pollfd.entries;
> > > +	struct evsel *evsel;
> > > +	char *evsel_name;
> > >  
> > >  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
> > >  		return 0;
> > > @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> > >  			case EVLIST_CTL_CMD_DISABLE:
> > >  				evlist__disable(evlist);
> > >  				break;
> > > +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> > > +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
> > 
> > It makes sense to check that evsel_name still points
> > into cmd_data buffer after assigning to event name.
> 
> right, will add that

actualy it's already checked in evlist__ctlfd_recv, evsel_name at
worst will be empty string so evlist__find_evsel_by_str will fail

I'll add '' around %s in the error output string:

  failed: can't find '%s' event

so it's obvious when it's empty

jirka

