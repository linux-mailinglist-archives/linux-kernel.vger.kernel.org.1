Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1D2D63A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404112AbgLJRPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:15:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392706AbgLJRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:15:34 -0500
Date:   Thu, 10 Dec 2020 14:15:03 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607620493;
        bh=2S1yzn1LvueIMmhCg3+RBjk+1uwi+KxA+4jgKLSnIxE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNEz78OHUZijXeF9SiPHSyOd249IHtspdSyid3L17++UaePtTCwpixS4XZ/zymiJO
         4PLzs12TvJqdiN7h0RLOX0MLPHYssWMvh2KIYJsFSGP/aqpV81oRVcxiM2Y92YeOGh
         FOcIo00R6qkYQvnNiTikt8LSEFXgpFODGXnD4GowyrdUVBXIDuFBNPBpqLdDpjnRjx
         dQT6qTkdTuswqbAWRfPLCX2YEoRwsTyNa/S3o5Cipm773jLTwnyltH5n97FjbyAUKh
         Mmql7t15tHzNh96MEt3U3WHz3IcFUw/GPRDMwae9qe0xZFyY1qlASYdYXiM+Mhzzi1
         N1fw+tpf8EAOg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20201210171503.GA195565@kernel.org>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210162430.GH69683@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 05:24:30PM +0100, Jiri Olsa escreveu:
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

So, I'm finishing test builds, so probably I'll push the first two
patches publicly and then you can send a patch on top of this, ok?

Unless the tests break somewhere and then I'll have to restart, so I'll
fold in whatever gets at that time...


- Arnaldo
