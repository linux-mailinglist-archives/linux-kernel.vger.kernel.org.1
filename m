Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E894D2DB06A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgLOPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgLOPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:46:55 -0500
Date:   Tue, 15 Dec 2020 12:46:27 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047174;
        bh=davFKpdkVeM47n+X25v3kz5bsYKvXQgNcT9f19rbSow=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hS1nPVAV2C92pX9U8bILKAu75JCRBxy4wB39gZVdbnhnTmXKbUF8DqhFOSUW7Q42x
         pt5qBKEyKJ7Yuhc9psK3KpXUCeFzQ51FUxEUa/upmY1IC2X4AhIDjCeIZs1Fc/CE3N
         HNJqRVZ4h/f9PT/R12FRcXGIy13A6F2j2+fTa2+3F61KcXqXGDQL5yudxMH/3wQqYy
         zOguqMok3dZpJFOOx38ngj3wD+u9PmjoGAvkC6oUcMhRIMmOd50rPi8xdrJ9XSkBcS
         WD/xrETajAuUopZPyjBc2u/l7kj5Dbqpldahjqyi7EypSQ2y60EB3NQlG7lB09nI35
         ERUwCOsJOhMGA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20201215154627.GH258566@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212104358.412065-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 12, 2020 at 11:43:57AM +0100, Jiri Olsa escreveu:
> Add 'lock' file under daemon base and flock it, so only one
> perf daemon can run on top of it.
> 
>   # perf daemon --config ./config.daemon
>   # perf daemon --config ./config.daemon
>   failed: another perf daemon (pid 369675) owns /opt/perfdata

So the way to disambiguate is the "daemon base"?

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 855fed2fe364..1bd5432a57a3 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -8,6 +8,7 @@
>  #include <string.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> +#include <sys/file.h>
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <time.h>
> @@ -639,6 +640,42 @@ static int handle_config_changes(struct daemon *daemon, int conf_fd,
>  	return 0;
>  }
>  
> +static int check_lock(struct daemon *daemon)
> +{
> +	char path[PATH_MAX];
> +	char buf[20];
> +	int fd, pid;
> +	ssize_t len;
> +
> +	scnprintf(path, sizeof(path), "%s/lock", daemon->base);
> +
> +	fd = open(path, O_RDWR|O_CREAT, 0640);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (lockf(fd, F_TLOCK, 0) < 0) {
> +		filename__read_int(path, &pid);
> +		fprintf(stderr, "failed: another perf daemon (pid %d) owns %s\n",
> +			pid, daemon->base);
> +		return -1;
> +	}
> +
> +	scnprintf(buf, sizeof(buf), "%d", getpid());
> +	len = strlen(buf);
> +
> +	if (write(fd, buf, len) != len) {
> +		perror("write failed");
> +		return -1;
> +	}
> +
> +	if (ftruncate(fd, len)) {
> +		perror("ftruncate failed");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int go_background(struct daemon *daemon)
>  {
>  	int pid, fd;
> @@ -653,6 +690,9 @@ static int go_background(struct daemon *daemon)
>  	if (setsid() < 0)
>  		return -1;
>  
> +	if (check_lock(daemon))
> +		return -1;
> +
>  	umask(0);
>  
>  	if (chdir(daemon->base)) {
> @@ -704,6 +744,9 @@ static int __cmd_daemon(struct daemon *daemon, bool foreground, const char *conf
>  	if (setup_server_config(daemon))
>  		return -1;
>  
> +	if (foreground && check_lock(daemon))
> +		return -1;
> +
>  	if (!foreground && go_background(daemon))
>  		return -1;
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
