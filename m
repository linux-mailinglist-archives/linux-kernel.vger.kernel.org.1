Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2666E304449
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbhAZHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbhAYQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:02:37 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7DC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:01:57 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id m145so3203582vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/v4OJUMnI2Hi06JUgt13GRLw3pm4pkZR5SedogE/Jw=;
        b=PWHcK7+QLWqXN2BKaHfQlpwTEcM43EJGv/cRbgk+jH9jDlXanZdbnxgoV9LjNqVOQ/
         OJV1i/yQ+qnaUSwe6nWNCpStNQMMiBBeYYgUIGX/uH8eCTAA8xL9FL0mv/PN2cMfjen0
         dgJrXXkSlE6fsbtlxGYRda/UWG11WCp1Pfhf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/v4OJUMnI2Hi06JUgt13GRLw3pm4pkZR5SedogE/Jw=;
        b=ZjykFWeO83TDXg+KfbhImdJiVkNa8D31YUu1RhU2+2J6R+6wUCqlYrEzAkDDcJ9DNK
         IsKAAffcCikO5I3PubGJav58r/udyc/OFJUYuvvWh1cfkskAPK+iQ/qzQko1xvZw4aCD
         2c+sbj9iv1B43TAnazOxTvaw3iOJykXnzT2Rdiqobqu5ksFZe+5V0LJEfBieqJ1x+vD8
         3cVZwmlnXlAeyJVXs43JGp5edOWl3gj4Jr5Iz2B8Clqy/LJiigiDdYW+q3gb4K9I+UMG
         TL5U/Q5zNau5i3R6qZerGUhQHLrF3hGzSq/uWnhjLIQFy3kZ41PiluzpNOiaYQjf5+DK
         1qtQ==
X-Gm-Message-State: AOAM530CVCWz8dzs9mw+oB6xIhr5d4snkMlWYPFd5BeCNtwRPQCDiTNA
        i2YnF4JLFifdGkyT6ZkQuIbh6Sy7g2GLWw==
X-Google-Smtp-Source: ABdhPJyL3IC5ok1cKwcpvwBRAVvtBJ13prEl8DpurdUEE3BM9Gpjk3E5PVbc6ESr1N06ae1H4lFf/Q==
X-Received: by 2002:a1f:1d4a:: with SMTP id d71mr1234316vkd.12.1611590515466;
        Mon, 25 Jan 2021 08:01:55 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a22sm2598454vkm.0.2021.01.25.08.01.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:01:52 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id f3so3197682vkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:01:52 -0800 (PST)
X-Received: by 2002:ac5:c318:: with SMTP id j24mr1121336vkk.21.1611590512183;
 Mon, 25 Jan 2021 08:01:52 -0800 (PST)
MIME-Version: 1.0
References: <1611558371-14414-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1611558371-14414-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Jan 2021 08:01:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-rA6F_dS-f7f5WO2SZbVYrrg5A5dOrXe_6FrE=ZhqQg@mail.gmail.com>
Message-ID: <CAD=FV=X-rA6F_dS-f7f5WO2SZbVYrrg5A5dOrXe_6FrE=ZhqQg@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Simplify kdb commands registration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 24, 2021 at 11:06 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Simplify kdb commands registration via using linked list instead of
> static array for commands storage.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Remove redundant NULL check for "cmd_name".
> - Incorporate misc. comment.
>
>  kernel/debug/kdb/kdb_main.c    | 119 ++++++++++++-----------------------------
>  kernel/debug/kdb/kdb_private.h |   1 +
>  2 files changed, 34 insertions(+), 86 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 930ac1b..a0989a0 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -33,6 +33,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/kgdb.h>
>  #include <linux/kdb.h>
> +#include <linux/list.h>
>  #include <linux/notifier.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -84,15 +85,8 @@ static unsigned int kdb_continue_catastrophic =
>  static unsigned int kdb_continue_catastrophic;
>  #endif
>
> -/* kdb_commands describes the available commands. */
> -static kdbtab_t *kdb_commands;
> -#define KDB_BASE_CMD_MAX 50
> -static int kdb_max_commands = KDB_BASE_CMD_MAX;
> -static kdbtab_t kdb_base_commands[KDB_BASE_CMD_MAX];
> -#define for_each_kdbcmd(cmd, num)                                      \
> -       for ((cmd) = kdb_base_commands, (num) = 0;                      \
> -            num < kdb_max_commands;                                    \
> -            num++, num == KDB_BASE_CMD_MAX ? cmd = kdb_commands : cmd++)
> +/* kdb_cmds_head describes the available commands. */
> +static LIST_HEAD(kdb_cmds_head);
>
>  typedef struct _kdbmsg {
>         int     km_diag;        /* kdb diagnostic */
> @@ -921,7 +915,7 @@ int kdb_parse(const char *cmdstr)
>         char *cp;
>         char *cpp, quoted;
>         kdbtab_t *tp;
> -       int i, escaped, ignore_errors = 0, check_grep = 0;
> +       int escaped, ignore_errors = 0, check_grep = 0;
>
>         /*
>          * First tokenize the command string.
> @@ -1011,25 +1005,18 @@ int kdb_parse(const char *cmdstr)
>                 ++argv[0];
>         }
>
> -       for_each_kdbcmd(tp, i) {
> -               if (tp->cmd_name) {
> -                       /*
> -                        * If this command is allowed to be abbreviated,
> -                        * check to see if this is it.
> -                        */
> -
> -                       if (tp->cmd_minlen
> -                        && (strlen(argv[0]) <= tp->cmd_minlen)) {
> -                               if (strncmp(argv[0],
> -                                           tp->cmd_name,
> -                                           tp->cmd_minlen) == 0) {
> -                                       break;
> -                               }
> -                       }
> -
> -                       if (strcmp(argv[0], tp->cmd_name) == 0)
> +       list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> +               /*
> +                * If this command is allowed to be abbreviated,
> +                * check to see if this is it.
> +                */
> +               if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen)) {
> +                       if (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0)
>                                 break;
>                 }

The old code had the same problem, but since you're touching it you could fix?

if (a) {
  if (b)
    break;
}

...is the same as:

if (a && b)
  break;

In any case, this looks like quite a nice cleanup, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
