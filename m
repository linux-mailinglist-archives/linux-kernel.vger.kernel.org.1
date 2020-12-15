Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D72DB462
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgLOTSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:18:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729453AbgLOTSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608059797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbweWu+fIhygk8uKC+yLgEfU1JyW6oZGEstxLfFUZx4=;
        b=M3RXhVKfRVOCvlEX9YVG5G5NFVRmgX5BAQbshGyJATBKI71P3J1NdWwT4MSOukHYg59fWm
        frIMquNG6nVcR4mT2Xj39PSAInbVESMMDBGgU2OZxlKcN0Pb4w04lrymHPrNfDSvK1Xse5
        lN9Uij3UpdYzyIhWLIkpLIO3fdWa/wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Ac600_fpP9mVn8kjgz92yQ-1; Tue, 15 Dec 2020 14:16:34 -0500
X-MC-Unique: Ac600_fpP9mVn8kjgz92yQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4EE518C9F40;
        Tue, 15 Dec 2020 19:16:32 +0000 (UTC)
Received: from krava (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3EA711A839;
        Tue, 15 Dec 2020 19:16:30 +0000 (UTC)
Date:   Tue, 15 Dec 2020 20:16:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 7/8] perf daemon: Allow only one daemon over base
 directory
Message-ID: <20201215191629.GF698181@krava>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-8-jolsa@kernel.org>
 <20201215154627.GH258566@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215154627.GH258566@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:46:27PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Dec 12, 2020 at 11:43:57AM +0100, Jiri Olsa escreveu:
> > Add 'lock' file under daemon base and flock it, so only one
> > perf daemon can run on top of it.
> > 
> >   # perf daemon --config ./config.daemon
> >   # perf daemon --config ./config.daemon
> >   failed: another perf daemon (pid 369675) owns /opt/perfdata
> 
> So the way to disambiguate is the "daemon base"?

yes, the 'base' is path where perf daemon will create
all control files and 'session' directories and does
chdir for 'perf record' session on top of that

jirka

> 
> - Arnaldo
>  
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-daemon.c | 43 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index 855fed2fe364..1bd5432a57a3 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -8,6 +8,7 @@
> >  #include <string.h>
> >  #include <sys/types.h>
> >  #include <sys/wait.h>
> > +#include <sys/file.h>
> >  #include <signal.h>
> >  #include <stdlib.h>
> >  #include <time.h>
> > @@ -639,6 +640,42 @@ static int handle_config_changes(struct daemon *daemon, int conf_fd,
> >  	return 0;
> >  }
> >  
> > +static int check_lock(struct daemon *daemon)
> > +{
> > +	char path[PATH_MAX];
> > +	char buf[20];
> > +	int fd, pid;
> > +	ssize_t len;
> > +
> > +	scnprintf(path, sizeof(path), "%s/lock", daemon->base);
> > +
> > +	fd = open(path, O_RDWR|O_CREAT, 0640);
> > +	if (fd < 0)
> > +		return -1;
> > +
> > +	if (lockf(fd, F_TLOCK, 0) < 0) {
> > +		filename__read_int(path, &pid);
> > +		fprintf(stderr, "failed: another perf daemon (pid %d) owns %s\n",
> > +			pid, daemon->base);
> > +		return -1;
> > +	}
> > +
> > +	scnprintf(buf, sizeof(buf), "%d", getpid());
> > +	len = strlen(buf);
> > +
> > +	if (write(fd, buf, len) != len) {
> > +		perror("write failed");
> > +		return -1;
> > +	}
> > +
> > +	if (ftruncate(fd, len)) {
> > +		perror("ftruncate failed");
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int go_background(struct daemon *daemon)
> >  {
> >  	int pid, fd;
> > @@ -653,6 +690,9 @@ static int go_background(struct daemon *daemon)
> >  	if (setsid() < 0)
> >  		return -1;
> >  
> > +	if (check_lock(daemon))
> > +		return -1;
> > +
> >  	umask(0);
> >  
> >  	if (chdir(daemon->base)) {
> > @@ -704,6 +744,9 @@ static int __cmd_daemon(struct daemon *daemon, bool foreground, const char *conf
> >  	if (setup_server_config(daemon))
> >  		return -1;
> >  
> > +	if (foreground && check_lock(daemon))
> > +		return -1;
> > +
> >  	if (!foreground && go_background(daemon))
> >  		return -1;
> >  
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

