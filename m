Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B009301AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbhAXIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 03:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbhAXIxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 03:53:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8679922C9C;
        Sun, 24 Jan 2021 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611478355;
        bh=qVIlX4cfrXPy6SQJxk30/kV8i1VqSnT07Ku9RAUEOgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qnx44mgihT/jVhLlqT9NjQJKYm5TLkGj4UZk8XWe9s/UWW4WQ5mZKaW6xq5lJgYzY
         nZJxJPMUgRAclr9JkZPn/H+Qhmg3IqN9xjebFg2cu1R5O459YKNWb2ah+fREFohz10
         rzjV+4UsER/sOa/Mk53mLcp8oioZEsD6cEChYa9cx8SzRGHgHz0cp8vjuuKOJ+9tdy
         wiTFt+an3E37RHCAiAeaMmFtqNvHhxgzVKzzV2A1hFn0c2WRwFwgNZRjDD1hMW+qrp
         3hS+SA+Ya7DFAYe4dN1ojFvLKPKdJQ1rTbL/7LQpvGdkHjm6W562PG/bDqG0LxCL/i
         nBY4WESaxQe7g==
Date:   Sun, 24 Jan 2021 17:52:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH v2] tracing: precise log info for kretprobe addr err
Message-Id: <20210124175231.fed85eccade5dbe0240b5c3b@kernel.org>
In-Reply-To: <AM6PR08MB3589CB4AB4EC3ADBBB45144C98BF0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210120155644.64721-1-Jianlin.Lv@arm.com>
        <20210120112004.4b9ff1df@gandalf.local.home>
        <20210121112847.63d2a06d72979634f25de9cd@kernel.org>
        <AM6PR08MB3589CB4AB4EC3ADBBB45144C98BF0@AM6PR08MB3589.eurprd08.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianlin,

On Sat, 23 Jan 2021 14:21:48 +0000
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> Regarding the UPROBES, I read the code of trace_uprobe_create() and  found a place for improvement.
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3cf7128e1ad3..8c81f04d7755 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -567,16 +567,18 @@ static int trace_uprobe_create(int argc, const char **argv)
>         if (!filename)
>                 return -ENOMEM;
> 
> +       trace_probe_log_init("trace_uprobe", argc, argv);
> +       trace_probe_log_set_index(1);   /* filename is the 2nd argument */
> +
>         /* Find the last occurrence, in case the path contains ':' too. */
>         arg = strrchr(filename, ':');
>         if (!arg || !isdigit(arg[1])) {
> +               trace_probe_log_err(arg + 1 - filename, BAD_UPROBE_OFFS);
>                 kfree(filename);
> -               return -ECANCELED;
> +               ret = -EINVAL;
> +               goto out;

Sorry, it's not a bug, but an expected behavior, because this is checking
routine which identify the passed command is mine (uprobe event definition)
or others (e.g. kprobe event definition).

Note that the dyn_event_operations::create operator will be used from
dyn_event, which passes the command string from TRACEFS/dynamic_events
to each create operator and check the return is -ECANCELED.
The -ECANCELED is not an error, it means "it is not mine, but maybe others."
See create_dyn_event(int argc, char **argv) in kernel/trace/trace_dynevent.c.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
