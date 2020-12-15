Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E62DB4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgLOTqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgLOTpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608061451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0t2O3F8bzMQmXxHesxjoW/ncuaguOfyCormLfZAXJm4=;
        b=PfwdAGc5UmuoWvtoWZaOBTGzDjw/h9AUMMNji8a3AL5sTz9rugM1+zrDr4aQhs9jZxUxh8
        aktD8cpHPU3k+yh4BR7xffWmYJ/DvvqSpImMbNkO91cyJar/J/Qw8dufsf0zkHDbEeaI/g
        qXmQcOxN4fIHNkVGOmGpsTmsPG4NMyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-I1k2LmunPNaZ1j-rNeTZ3Q-1; Tue, 15 Dec 2020 14:44:05 -0500
X-MC-Unique: I1k2LmunPNaZ1j-rNeTZ3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 287B4195D563;
        Tue, 15 Dec 2020 19:44:03 +0000 (UTC)
Received: from krava (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 37A2B19C47;
        Tue, 15 Dec 2020 19:43:58 +0000 (UTC)
Date:   Tue, 15 Dec 2020 20:43:54 +0100
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
Subject: Re: [PATCH 4/8] perf daemon: Add daemon command
Message-ID: <20201215194354.GH698181@krava>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-5-jolsa@kernel.org>
 <1e467abe-4613-765f-5138-6215b711f9fb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e467abe-4613-765f-5138-6215b711f9fb@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 06:40:26PM +0300, Alexei Budankov wrote:
> Hi,
> 
> On 12.12.2020 13:43, Jiri Olsa wrote:
> > Adding daemon command that allows to run record sessions
> > on background. Each session represents one perf record
> > process and is configured in config file.
> > 
> > Example:
> > 
> >   # cat config.daemon
> >   [daemon]
> >   base=/opt/perfdata
> 
> It could probably make sense to consider using locations at /var/
> directory, similar to other already existing daemon processes in
> system so admin and user experience would be easily reusabe for
> performance monitoring daemon (service).

hm, you can specify any /var path in there if you like,
do you suggest to hardcode it?

> 
> > 
> >   [session-1]
> >   run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
> > 
> >   [session-2]
> >   run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
> > 
> > Default perf config has the same daemon base:
> > 
> >   # cat ~/.perfconfig
> >   [daemon]
> >   base=/opt/perfdata
> > 
> > Starting the daemon:
> > 
> >   # perf daemon --config config.daemon
> 
> It could make sense to name daemon config file similar to .perfconfig
> e.g. like .perfconfig.daemon. perf daemon command would then assume, by
> default, usage of .perfconfig.daemon config or the one specified on the
> command line via --config option. It also would be helpfull have loaded
> config file path printed into console:
> # perf daemon
> Daemon process <pid> started with config /path/to/.perfconfig.daemon

so the current way is, that following creates daemon:

  # perf daemon --config <CONFIG>

and any other 'non --config' option' is used to 'query/control' daemon:

  # perf daemon
  # perf daemon --signal
  # perf daemon --stop
  ...


I'd like to keep short way checking on daemon, without too many
options, like:

  # perf daemon
  [690174:daemon] base: /opt/perfdata
  [690175:top] perf record -e cycles --switch-output=1m --switch-max-files=6 -a


I think maybe we don't need any other .perfconfig, we could have
all in standard .perfconfig, like:

  # cat .perfconfig:
  [daemon]
  base=/opt/perfdata

  [session-1]
  run = -m 1M -e cycles --overwrite --switch-output -a
  [session-2]
  run = -m 1M -e sched:* --overwrite --switch-output -a


and to run daemon on top of it:

  # perf daemon --start


to run daemon with alternate config:

  # perf daemon --start=<CONFIGFILE>

or:

  # perf daemon --start --config=<CONFIGFILE>


and checking on daemon with default .perfconfig setup:

  # perf daemon


checking on daemon with different base or config:

  # perf daemon --base=<BASE>
  # perf daemon --config=<CONFIGFILE>
  # perf daemon --base=<BASE> --stop
  # perf daemon --base=<BASE> --signal
  # perf daemon --config=<CONFIGFILE> --stop
  # perf daemon --config=<CONFIGFILE> --signal

how about that?

SNIP

> > +static struct session*
> > +daemon__find_session(struct daemon *daemon, char *name)
> > +{
> > +	struct session *session;
> > +
> > +	list_for_each_entry(session, &daemon->sessions, list) {
> > +		if (!strcmp(session->name, name))
> > +			return session;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int session_name(const char *var, char *session, int len)
> 
> should possibly name it get_session_name.

ok

> 
> > +{
> > +	const char *p = var + sizeof("session-") - 1;
> 
> should possibly check that p still points inside [var, var+len).

ok

SNIP

> > +static int session__wait(struct session *session, struct daemon *daemon,
> > +			 int secs)
> > +{
> > +	time_t current, start = 0;
> > +	int cnt;
> > +
> > +	start = current = time(NULL);
> > +
> > +	do {
> > +		usleep(500);
> 
> This polling design is actually sub-optimal because it induces redundant
> noise in a system. Ideally it should be implemented in async fashion so
> kernel would atomically notify daemon process on event happened in some
> of record processes e.g. using of poll-like() system call.

ok, any suggestion?

> 
> > +		cnt = session__check(session, daemon);
> > +		if (cnt)
> > +			break;
> > +
> > +		current = time(NULL);
> > +	} while ((start + secs > current));
> > +
> > +	return cnt;
> > +}
> > +
> > +static int session__signal(struct session *session, int sig)
> > +{
> > +	if (session->pid < 0)
> > +		return -1;
> > +	return kill(session->pid, sig);
> 
> "Better" alternative could possibly be sending of some 'stop' command
> via --control=fd.

true, nice idea.. seems more clean and we already have control fd open

will add it to next version

thanks,
jirka

