Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C829C2D61C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392292AbgLJQ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392281AbgLJQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607617482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGEys4guit1Peg9rzsiLjWoGUjIF1t2qZa/JrqY7jw8=;
        b=Ho4+GnQAcXSDX17oqNFygnfghjZNueO30V7jTTktg2sUGLa7TRrZZLi01rQj8R3Y9Ae+3y
        tUf5z3/3Y7X5/LRTp7Z6UU5ZgqYfePsTGhlZx4tIHxt0WMzUZy1ykD4gSpnDE3w8rzH1Q5
        mFRrf1wFtDxV9kJJEERAs3g/ZA3A/lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Ld0wTVVtPu2uaeR-Q1KW0Q-1; Thu, 10 Dec 2020 11:24:38 -0500
X-MC-Unique: Ld0wTVVtPu2uaeR-Q1KW0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA42A190A7A0;
        Thu, 10 Dec 2020 16:24:34 +0000 (UTC)
Received: from krava (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id 785F86F965;
        Thu, 10 Dec 2020 16:24:31 +0000 (UTC)
Date:   Thu, 10 Dec 2020 17:24:30 +0100
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
Message-ID: <20201210162430.GH69683@krava>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 08:02:20PM +0300, Alexei Budankov wrote:
> Hi,
> 
> On 06.12.2020 20:05, Jiri Olsa wrote:
> > Adding new control events to enable/disable specific event.
> > The interface string for control file are:
> > 
> >   'enable-<EVENT NAME>'
> >   'disable-<EVENT NAME>'
> 
> <SNIP>
> 
> > 
> > when received the command, perf will scan the current evlist
> > for <EVENT NAME> and if found it's enabled/disabled.
> 
> <SNIP>
> 
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 70aff26612a9..05723227bebf 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
> >  		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> >  
> >  	if (bytes_read > 0) {
> > -		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> > +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
> > +				    (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
> > +			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
> > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
> > +				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
> > +			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
> > +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> >  			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
> >  			*cmd = EVLIST_CTL_CMD_ENABLE;
> >  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> > @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> >  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
> >  	int ctlfd_pos = evlist->ctl_fd.pos;
> >  	struct pollfd *entries = evlist->core.pollfd.entries;
> > +	struct evsel *evsel;
> > +	char *evsel_name;
> >  
> >  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
> >  		return 0;
> > @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> >  			case EVLIST_CTL_CMD_DISABLE:
> >  				evlist__disable(evlist);
> >  				break;
> > +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> > +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
> 
> It makes sense to check that evsel_name still points
> into cmd_data buffer after assigning to event name.

right, will add that

thanks,
jirka

