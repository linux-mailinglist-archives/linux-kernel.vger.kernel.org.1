Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995472FAF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbhASEJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:09:57 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:43069 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbhASEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:09:12 -0500
Received: by mail-lj1-f171.google.com with SMTP id e7so20399430ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cmTHi2ZdqKzEuOMbe4F05QtWlb0L/yv8eU7C3d5RA4=;
        b=WEeq3Om+TbW39FtmDVyV1/A/757KSLgzxX1D7kOjzjKt2cRbfdHBG+Uuuoyumh995D
         E+RpndRkVDuQo1yJCbbzAhJKjTCdh05LCmcgDWFfE2gLX8KokSqKgUHylz2HmFegRkdN
         /ZBXVejJBpHJF/TeN7Py0woPqvlTT+7ZSkZZIQ+rAzQF+IOJSUAtL45O/yq6AH4lg6PP
         Q5yJdb0JihPO67t9VN2BxEWLtvWnMgP+TP+33ocsnqvvVrtQ/IcIQxsbAtgsZ5j9o3W2
         d0bN5mjcnBtbxXSYriDCjf9w87tvkyeJcs5e5BmLY0KspZbD+wHWuqVYWfWSqKCiSvno
         NeQg==
X-Gm-Message-State: AOAM5330HP44FGIHl4k9JHzIZV+ec+Z6/HtDA/xgKkBdCe2vqHPk3XUU
        88YzEgRklJNhQrRUVxht++xecon24VLflftQiSk=
X-Google-Smtp-Source: ABdhPJzggtFd7wSKV8dfmrYlI1XLTf6xCMGsockodsuUbEZqo6FGBotueD4u2xocqI1V5K+GHesPW8EMBpdcDRLZeoo=
X-Received: by 2002:a2e:870e:: with SMTP id m14mr1097520lji.166.1611029308446;
 Mon, 18 Jan 2021 20:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-8-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-8-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Jan 2021 13:08:17 +0900
Message-ID: <CAM9d7ciSkns0=0LqWK2BrTFOON2z4wx5vjb=zhP5=iUoXXjeDQ@mail.gmail.com>
Subject: Re: [PATCH 07/22] perf daemon: Add daemon command
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

Hi Jiri,

On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding daemon command that allows to run record sessions
> on background. Each session represents one perf record
> process and is configured in config file.
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
> Check sessions:
>
>   # perf daemon
>   [771394:daemon] base: /opt/perfdata
>   [771395:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
>   [771396:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
>
> Check sessions with more info:
>
>   # perf daemon -v
>   [771394:daemon] base: /opt/perfdata
>     output:  /opt/perfdata/output
>   [771395:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
>     base:    /opt/perfdata/session-cycles
>     output:  /opt/perfdata/session-cycles/output
>   [771396:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
>     base:    /opt/perfdata/session-sched
>     output:  /opt/perfdata/session-sched/output
>
> The 'output' file is perf record output for specific session.
>
> Note you have to stop all running perf processes manually at
> this point, stop command is coming in following patches.
>
> Adding empty perf-daemon.txt to skip compile warning,
> the man page is populated in following patch.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
[SNIP]
> +static int session_config(struct daemon *daemon, const char *var, const char *value)
> +{
> +       struct session *session;
> +       char name[100];
> +
> +       if (get_session_name(var, name, sizeof(name)))
> +               return -EINVAL;
> +
> +       var = strchr(var, '.');
> +       if (!var)
> +               return -EINVAL;
> +
> +       var++;
> +
> +       session = daemon__find_session(daemon, name);
> +       if (!session) {
> +               session = daemon__add_session(daemon, name);
> +               if (!session)
> +                       return -ENOMEM;
> +
> +               pr_debug("reconfig: found new session %s\n", name);
> +               /* This is new session, trigger reconfig to start it. */
> +               session->state = SESSION_STATE__RECONFIG;
> +       } else if (session->state == SESSION_STATE__KILL) {
> +               /*
> +                * The session was marked to kill and we still
> +                * found it in config file.
> +                */
> +               pr_debug("reconfig: found current session %s\n", name);
> +               session->state = SESSION_STATE__OK;
> +       }
> +
> +       if (!strcmp(var, "run")) {
> +               if (session->run && strcmp(session->run, value)) {
> +                       free(session->run);
> +                       pr_debug("reconfig: session %s is changed\n", name);
> +                       session->state = SESSION_STATE__RECONFIG;
> +               }
> +               session->run = strdup(value);

Please check the result.

> +       }
> +
> +       return 0;
> +}
> +
> +static int server_config(const char *var, const char *value, void *cb)
> +{
> +       struct daemon *daemon = cb;
> +
> +       if (strstarts(var, "session-"))
> +               return session_config(daemon, var, value);
> +       else if (!strcmp(var, "daemon.base"))
> +               daemon->base = strdup(value);

It seems these config items are mandatory.  Is there a check
for their presence?


> +
> +       return 0;
> +}
> +
> +static int client_config(const char *var, const char *value, void *cb)
> +{
> +       struct daemon *daemon = cb;
> +
> +       if (!strcmp(var, "daemon.base"))
> +               daemon->base = strdup(value);
> +
> +       return 0;
> +}
> +
> +static int setup_client_config(struct daemon *daemon)
> +{
> +       struct perf_config_set *set;
> +       int err = -ENOMEM;
> +
> +       set = perf_config_set__load_file(daemon->config_real);
> +       if (set) {
> +               err = perf_config_set(set, client_config, daemon);
> +               perf_config_set__delete(set);
> +       }
> +
> +       return err;
> +}
> +
> +static int setup_server_config(struct daemon *daemon)
> +{
> +       struct perf_config_set *set;
> +       struct session *session;
> +       int err = -ENOMEM;
> +
> +       pr_debug("reconfig: started\n");
> +
> +       /*
> +        * Mark all session for kill, the server config will
> +        * set proper state for found sessions.
> +        */
> +       list_for_each_entry(session, &daemon->sessions, list)
> +               session->state = SESSION_STATE__KILL;

Probably we can put them in a different state like INIT or READY?

> +
> +       set = perf_config_set__load_file(daemon->config_real);
> +       if (set) {
> +               err = perf_config_set(set, server_config, daemon);
> +               perf_config_set__delete(set);
> +       }
> +
> +       return err;
> +}
> +
> +static int session__signal(struct session *session, int sig)
> +{
> +       if (session->pid < 0)
> +               return -1;
> +       return kill(session->pid, sig);
> +}
> +
> +static int session__run(struct session *session, struct daemon *daemon)
> +{
> +       char buf[PATH_MAX];
> +       char **argv;
> +       int argc, fd;
> +
> +       if (asprintf(&session->base, "%s/session-%s",
> +                    daemon->base, session->name) < 0) {
> +               perror("asprintf failed");
> +               return -1;
> +       }
> +
> +       if (mkdir(session->base, 0755) && errno != EEXIST) {
> +               perror("mkdir failed");
> +               return -1;
> +       }
> +
> +       session->pid = fork();
> +       if (session->pid < 0)
> +               return -1;
> +       if (session->pid > 0) {
> +               pr_info("reconfig: ruining session [%s:%d]: %s\n",
> +                       session->name, session->pid, session->run);
> +               return 0;
> +       }
> +
> +       if (chdir(session->base)) {
> +               perror("chdir failed");
> +               return -1;
> +       }
> +
> +       fd = open("/dev/null", O_RDONLY);
> +       if (fd < 0) {
> +               perror("failed to open /dev/null");
> +               return -1;
> +       }
> +
> +       close(0);
> +       dup2(fd, 0);

The man page says dup2() will close the second file descriptor.

> +       close(fd);
> +
> +       fd = open(SESSION_OUTPUT, O_RDWR|O_CREAT|O_TRUNC, 0644);
> +       if (fd < 0) {
> +               perror("failed to open session output");
> +               return -1;
> +       }
> +
> +       close(1);
> +       close(2);
> +       dup2(fd, 1);
> +       dup2(fd, 2);

Ditto.

> +       close(fd);
> +
> +       scnprintf(buf, sizeof(buf), "%s record %s", daemon->perf, session->run);
> +
> +       argv = argv_split(buf, &argc);
> +       if (!argv)
> +               exit(-1);
> +
> +       exit(execve(daemon->perf, argv, NULL));
> +       return -1;
> +}

[SNIP]
> +static int daemon__reconfig(struct daemon *daemon)
> +{
> +       struct session *session, *n;
> +
> +       list_for_each_entry_safe(session, n, &daemon->sessions, list) {
> +               /* No change. */
> +               if (session->state == SESSION_STATE__OK)
> +                       continue;
> +
> +               /* Remove session. */
> +               if (session->state == SESSION_STATE__KILL) {
> +                       if (session->pid > 0) {
> +                               session__kill(session);
> +                               pr_info("reconfig: session '%s' killed\n", session->name);
> +                       }
> +                       session__remove(session);
> +                       continue;
> +               }
> +
> +               /* Reconfig session. */
> +               pr_debug2("reconfig: session '%s' start\n", session->name);
> +               if (session->pid > 0) {
> +                       session__kill(session);
> +                       pr_info("reconfig: session '%s' killed\n", session->name);
> +               }
> +               if (session__run(session, daemon))

Does it call a config function?  Or is it called already?

> +                       return -1;
> +               pr_debug2("reconfig: session '%s' done\n", session->name);
> +               session->state = SESSION_STATE__OK;

I think RUNNING is a better name.

Thanks,
Namhyung


> +       }
> +
> +       return 0;
> +}
> +
