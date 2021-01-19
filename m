Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5102FB1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbhASGkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:40:52 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:47097 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbhASFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:38:37 -0500
Received: by mail-lf1-f51.google.com with SMTP id o10so27323759lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 21:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URBaQWvo21Po7lHS1Q5G/RCwEYa2F0a4Wp9IVeoO+Eg=;
        b=Fa1Xm6n/Uh4zVtknc7VhiEzPtAhy74Dw+P3yIPAU3LLhU/ywmR383CUVibhF31adB6
         E/9hC/5LwAvtWTpFGtmPbqpTJNu33zKR7d+V4tcRXiJOt8rVLmv/8yR3zbsciQVfFCMo
         9u4eWG7D2NzNAmZ8vq2gcaCQtYOCXO6n4shgp1u232sMKHFqR0Mvq8gMyy3X5woxxvL3
         kNTw9AyIABI3ei18knj4IpyfFWqfUIhS2BSev10YjuuLCYMMGPyqiS0SKEuZ0xFeztw+
         oQvEmZhp/wVgAgRmhIVuXuGUb9atsq2A8PovVy6W/Ssg2/TW4oqm+JQGJgLwB68VyY8e
         rY/A==
X-Gm-Message-State: AOAM533vnG+remunjWtXReZmbEmqhNqBrDJpkVwxgivmFDlzZ1jtF0+o
        mM/d680huenRUbUhJx4IqIzZeRTiJo0bjLUjRYc=
X-Google-Smtp-Source: ABdhPJw2LQNDH0X0sbKs4rmIbQT2cKK8YH8WGcvQPnrdC84rmwGjyVLNIfJul9d/uYNe41R55yNvnesWxwJ/nbqp0PQ=
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr1100639lfm.300.1611034674236;
 Mon, 18 Jan 2021 21:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-13-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-13-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Jan 2021 14:37:42 +0900
Message-ID: <CAM9d7cj7TaJH3CtkQDjfD9OuV77LzbcY4y_EW7PWi+winu8gcw@mail.gmail.com>
Subject: Re: [PATCH 12/22] perf daemon: Allow only one daemon over base directory
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add 'lock' file under daemon base and flock it, so only one
> perf daemon can run on top of it.
>
> Example:
>
>   # cat ~/.perfconfig
>   [daemon]
>   base=/opt/perfdata
>
>   [session-cycles]
>   run = -m 10M -e cycles --overwrite --switch-output -a
>
>   [session-sched]
>   run = -m 20M -e sched:* --overwrite --switch-output -a
>
> Starting the daemon:
>
>   # perf daemon start
>
> And try once more:
>
>   # perf daemon start
>   failed: another perf daemon (pid 775594) owns /opt/perfdata
>
> will end up with an error, because there's already one running
> on top of /opt/perfdata.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 45748bb471ec..1982eedd3f3f 100644
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
> @@ -562,12 +563,18 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
>                         /* output */
>                         csv_sep, daemon->base, SESSION_OUTPUT);
>
> +               fprintf(out, "%c%s/%s",
> +                       /* lock */
> +                       csv_sep, daemon->base, "lock");
> +
>                 fprintf(out, "\n");
>         } else {
>                 fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
>                 if (cmd->list.verbose) {
>                         fprintf(out, "  output:  %s/%s\n",
>                                 daemon->base, SESSION_OUTPUT);
> +                       fprintf(out, "  lock:    %s/lock\n",
> +                               daemon->base);
>                 }
>         }
>
> @@ -761,6 +768,42 @@ static int handle_config_changes(struct daemon *daemon, int conf_fd,
>         return 0;
>  }
>
> +static int check_lock(struct daemon *daemon)
> +{
> +       char path[PATH_MAX];
> +       char buf[20];
> +       int fd, pid;
> +       ssize_t len;
> +
> +       scnprintf(path, sizeof(path), "%s/lock", daemon->base);
> +
> +       fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0640);
> +       if (fd < 0)
> +               return -1;
> +
> +       if (lockf(fd, F_TLOCK, 0) < 0) {
> +               filename__read_int(path, &pid);
> +               fprintf(stderr, "failed: another perf daemon (pid %d) owns %s\n",
> +                       pid, daemon->base);
> +               return -1;
> +       }

So the fd is (a kind of) leaked and the lock is released only when
the daemon is going to die, right?

Thanks,
Namhyung

> +
> +       scnprintf(buf, sizeof(buf), "%d", getpid());
> +       len = strlen(buf);
> +
> +       if (write(fd, buf, len) != len) {
> +               perror("write failed");
> +               return -1;
> +       }
> +
> +       if (ftruncate(fd, len)) {
> +               perror("ftruncate failed");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  static int go_background(struct daemon *daemon)
>  {
>         int pid, fd;
> @@ -775,6 +818,9 @@ static int go_background(struct daemon *daemon)
>         if (setsid() < 0)
>                 return -1;
>
> +       if (check_lock(daemon))
> +               return -1;
> +
>         umask(0);
>
>         if (chdir(daemon->base)) {
> @@ -861,6 +907,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>         if (setup_server_config(daemon))
>                 return -1;
>
> +       if (foreground && check_lock(daemon))
> +               return -1;
> +
>         if (!foreground && go_background(daemon))
>                 return -1;
>
> --
> 2.26.2
>
