Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB92FB1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbhASGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:49:50 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41211 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbhASFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:36:01 -0500
Received: by mail-lf1-f41.google.com with SMTP id s26so27325305lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 21:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOs2goba3DgXyxRMi81zAzSo7zeJdk9mzQns1ZLy/GU=;
        b=V0WT6WDbm+X5+XxAwDpiJ3++tTSuIj8hYTjZHx3pqqcmEz0hL37LPt0hqxdGeHXDDo
         7rQ/+3gOgBLidpSSa095KBPQvFvkLbgmVoNRCaj6CcKbXVXOWooL6XvYgWLhCsQ4JcSL
         V6KGLdUslo9V3UiBvDyCOV4kUBi8BfxnVMaidwEt/g8S9UpUgYpmHTidp8GJoCXuekN6
         jzn1JizPAWjSatAaugxV7OrBCk5Q0iPnBht7JZXBy6/eO7jI/nUVO1+HUyJGKVGgheqh
         sXHsYQUQRvVOozZMuXpC4v3XXvZSYt/ti9+cy/O9lzPTdIBUozlJ3RpHWrmGbo/OFME7
         6E8g==
X-Gm-Message-State: AOAM531EUR4GWUZjKRZTjhBejRHyvvIshhvlux+xWcfBToeJmxMG/44Z
        Xd6/k2DgV8NcD2kYGxoPO02JELC5RIrLNR9+WBg=
X-Google-Smtp-Source: ABdhPJwl36BdRN7xYu7FowXTvU1b79tYQIX3h2TpKC6vHyleYe0UMko+bjuc+7YDSzGpwf8u12njcZLpwxTzelJ3e4Y=
X-Received: by 2002:a19:8584:: with SMTP id h126mr1165258lfd.152.1611034518994;
 Mon, 18 Jan 2021 21:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-12-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-12-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Jan 2021 14:35:06 +0900
Message-ID: <CAM9d7cjo-2i88YWfZE=Shq8Qjsk1dDS7Z1ykkuO8vv8Tq2sJYg@mail.gmail.com>
Subject: Re: [PATCH 11/22] perf daemon: Add stop command
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
> Add 'perf daemon stop' command to stop daemon process
> and all running sessions.
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
> Stopping the daemon
>
>   # perf daemon stop
>
> Daemon is not running, nothing to connect to:
>
>   # perf daemon
>   connect error: Connection refused
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index a7ffbecf8d14..45748bb471ec 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -524,6 +524,7 @@ static int setup_server_socket(struct daemon *daemon)
>  enum {
>         CMD_LIST   = 0,
>         CMD_SIGNAL = 1,
> +       CMD_STOP   = 2,
>         CMD_MAX,
>  };
>
> @@ -650,6 +651,10 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
>         case CMD_SIGNAL:
>                 ret = cmd_session_kill(daemon, &cmd, out);
>                 break;
> +       case CMD_STOP:
> +               done = 1;
> +               pr_debug("perf daemon is exciting\n");

I can see how much you are excited. ;-)

Thanks,
Namhyung


> +               break;
>         default:
>                 break;
>         }
> @@ -992,6 +997,27 @@ static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
>         return send_cmd(daemon, &cmd);
>  }
>
> +static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
> +                       int argc, const char **argv)
> +{
> +       struct option start_options[] = {
> +               OPT_PARENT(parent_options),
> +               OPT_END()
> +       };
> +       union cmd cmd = { .cmd = CMD_STOP, };
> +
> +       argc = parse_options(argc, argv, start_options, daemon_usage, 0);
> +       if (argc)
> +               usage_with_options(daemon_usage, start_options);
> +
> +       if (setup_config(daemon)) {
> +               pr_err("failed: config not found\n");
> +               return -1;
> +       }
> +
> +       return send_cmd(daemon, &cmd);
> +}
> +
>  int cmd_daemon(int argc, const char **argv)
>  {
>         struct option daemon_options[] = {
> @@ -1015,6 +1041,8 @@ int cmd_daemon(int argc, const char **argv)
>         if (argc) {
>                 if (!strcmp(argv[0], "signal"))
>                         return __cmd_signal(&__daemon, daemon_options, argc, argv);
> +               else if (!strcmp(argv[0], "stop"))
> +                       return __cmd_stop(&__daemon, daemon_options, argc, argv);
>
>                 pr_err("failed: unknown command '%s'\n", argv[0]);
>                 return -1;
> --
> 2.26.2
>
