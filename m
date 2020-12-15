Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8A2DB06F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgLOPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgLOPrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:47:36 -0500
Date:   Tue, 15 Dec 2020 12:47:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047215;
        bh=xCJsQA5vZsO3ZdsRePLWHNXETYr0KUiLqxCLsZSMK2s=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qL6YP7Ue5OktFpvWk2sQ2CZSbb3XLVJYCvpiRRX8+t6qey/KkOWzSQktnuF+vzLhD
         2gtdnp5FxSCc0FTf4gAxIszXpVkF6joEXWGHP+yf2c3GadTLeNhLQdREr19tAFUnM1
         R4TwJRuqoN0JYBj9vS8zZKIYNWjqpm2k37AgSqtfa1qSzWMfVjgDNRT665sEv7QwmY
         jR9z76N4mzZ3BW7/nn1fzNHUUQdWQPqBiIfOhcR1nKAXpRHw/C3ozU3mn4pELCa7kN
         Sct+Efhyngp7rH5b/1EwMhu8OuJWfAKHEbsmCyK62x0bkPQLbqWhErhKjoDvUUW3T4
         Rsky7M94VeScQ==
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
Subject: Re: [PATCH 8/8] perf daemon: Set control fifo for session
Message-ID: <20201215154708.GI258566@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212104358.412065-9-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 12, 2020 at 11:43:58AM +0100, Jiri Olsa escreveu:
> Setup control fifos for session and add --control
> option to session arguments.

You're stating what this does, not why this is useful, can you add a
paragraph to that effect?

- Arnaldo
 
> Use can list control fifos with:
> 
>    # perf daemon -v
>    [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
>      output:  /opt/perfdata/1/output
>      control: /opt/perfdata/1/control
>      ack:     /opt/perfdata/1/ack
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-daemon.txt |  8 +++++++-
>  tools/perf/builtin-daemon.c              | 24 +++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
> index 87de2c77e4c7..c507ba7c85cc 100644
> --- a/tools/perf/Documentation/perf-daemon.txt
> +++ b/tools/perf/Documentation/perf-daemon.txt
> @@ -16,7 +16,8 @@ DESCRIPTION
>  This command allows to run simple daemon process that starts and
>  monitors configured record sessions.
>  
> -Each session represents one perf record process.
> +Each session represents one perf record process started with
> +control setup (with perf record --control.. options).
>  
>  These sessions are configured through config file, see CONFIG FILE
>  section with EXAMPLES.
> @@ -94,10 +95,15 @@ Check sessions with more info:
>    # perf daemon -v
>    [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
>      output:  /opt/perfdata/1/output
> +    control: /opt/perfdata/1/control
> +    ack:     /opt/perfdata/1/ack
>    [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
>      output:  /opt/perfdata/2/output
> +    control: /opt/perfdata/2/control
> +    ack:     /opt/perfdata/2/ack
>  
>  The 'output' file is perf record output for specific session.
> +The 'control' and 'ack' files are perf control files.
>  
>  
>  Send SIGUSR2 signal to all sessions:
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 1bd5432a57a3..765369a30414 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -33,6 +33,8 @@
>  #include <api/fs/fs.h>
>  
>  #define SESSION_OUTPUT  "output"
> +#define SESSION_CONTROL "control"
> +#define SESSION_ACK     "ack"
>  
>  enum session_state {
>  	SESSION_STATE__OK,
> @@ -43,6 +45,7 @@ enum session_state {
>  struct session {
>  	char			*name;
>  	char			*run;
> +	char			*control;
>  	int			 pid;
>  	struct list_head	 list;
>  	enum session_state	 state;
> @@ -254,6 +257,8 @@ static void session__kill(struct session *session, struct daemon *daemon)
>  
>  static int session__run(struct session *session, struct daemon *daemon)
>  {
> +	char control[PATH_MAX];
> +	char ack[PATH_MAX];
>  	char base[PATH_MAX];
>  	char buf[PATH_MAX];
>  	char **argv;
> @@ -266,6 +271,18 @@ static int session__run(struct session *session, struct daemon *daemon)
>  		return -1;
>  	}
>  
> +	scnprintf(control, sizeof(control), "%s/" SESSION_CONTROL, base);
> +	if (mkfifo(control, O_RDWR) && errno != EEXIST) {
> +		perror("failed to create control fifo");
> +		return -1;
> +	}
> +
> +	scnprintf(ack, sizeof(ack), "%s/" SESSION_ACK, base);
> +	if (mkfifo(ack, O_RDWR) && errno != EEXIST) {
> +		perror("failed to create ack fifo");
> +		return -1;
> +	}
> +
>  	session->pid = fork();
>  	if (session->pid < 0)
>  		return -1;
> @@ -291,7 +308,8 @@ static int session__run(struct session *session, struct daemon *daemon)
>  	dup2(fd, 2);
>  	close(fd);
>  
> -	scnprintf(buf, sizeof(buf), "%s record %s", PERF, session->run);
> +	scnprintf(buf, sizeof(buf), "%s record --control=fifo:%s,%s %s",
> +		  PERF, control, ack, session->run);
>  
>  	argv = argv_split(buf, &argc);
>  	if (!argv)
> @@ -472,6 +490,10 @@ static int cmd_session_list(struct daemon *daemon, FILE *out, bool simple)
>  			continue;
>  		fprintf(out, "  output:  %s/%s/" SESSION_OUTPUT "\n",
>  			daemon->base, session->name);
> +		fprintf(out, "  control: %s/%s/" SESSION_CONTROL "\n",
> +			daemon->base, session->name);
> +		fprintf(out, "  ack:     %s/%s/" SESSION_ACK "\n",
> +			daemon->base, session->name);
>  	}
>  
>  	return 0;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
