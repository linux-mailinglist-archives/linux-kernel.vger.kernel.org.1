Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A896B25F1C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 04:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgIGCzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 22:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGCzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 22:55:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174BC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 19:54:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so5748589pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 19:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bU0XWazdPPFcEq4aoxPeHejwsjzxydfYMihFOZbivEc=;
        b=w8P2nObbmV7vLQTrbK/RzO+6hB3rgdkb8FpeYHZoyKuOr84HY2kCmeHYZ+gycKyQRj
         mFT6aZIo04SUM8X00OHC5xf0G/M33CgRNWyNbKkPUclg8UyupIooP5cmuZSqPUsoqCQu
         +ZQKPOn8l4C1mv/TctxVdG9SOc/QJCuNRYOk/XLzbchNexkqrcLmdU0GNHldCu9uk8Vd
         7oYp7O9hw3QoQLeqXyyygAeW19++TJGHEEOa+T/Q1wSWwXKTO3fSdSPWPWUDqwC2Bhwl
         GLcKkkuWbKl/40CsogMbfIS9O2azEm1TYfQ+3JVab3X5J7NxGizDEwL+MZGw9drtlAWT
         xHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bU0XWazdPPFcEq4aoxPeHejwsjzxydfYMihFOZbivEc=;
        b=CV+6SWigP+uN2tVjnK/ZGPJgJWd55KciH341hjvBvESvqtt1aSLqJrXBkAlKQRV/Pg
         FQ9jjgJHOI7j8VJ2C4Ib/WQM/qlWQLBv9WjZLJN3rxmDpt5IkWAOAZ2OJtDyhWvXO6x7
         gh6rBR5V68fSglZ7lgTY9TaQ23gRx1/BawGreesmVuB+r+x7MwHBV0T1uhhTZOYrEvBx
         l+YR7e/O+lBlTCJdMi9tLik7Q5l2C01vu0Fs4L67RLucx/hLaC0uzAZwj4lQO1lwWVkz
         EMmSl88Tlu7+hQrZyExdm/JApKKdM0wnpXF7ffgBwj5VShrFaR6nsk5VtFpLS4IgjSNI
         2KDw==
X-Gm-Message-State: AOAM532Vr5WojLUcwFB63OV88icwedKFUuPQhvqFny4oh+iAOftzloQe
        dKxm4CTQziuq1PDzKxB1FfoViUuIk05CnjqNz8bcvg==
X-Google-Smtp-Source: ABdhPJyU4n2BlotLhZBofu4uUDlor4yqDJNvJVoJXlfehTzZLELdGoJO8yzMkxo8QTbfhaPr7Bp33lTdZPAs5bUC8vw=
X-Received: by 2002:a17:902:c206:: with SMTP id 6mr3144329pll.93.1599447298867;
 Sun, 06 Sep 2020 19:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200828031928.43584-1-songmuchun@bytedance.com>
In-Reply-To: <20200828031928.43584-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Sep 2020 10:54:23 +0800
Message-ID: <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
Subject: Re: [PATCH v2] stackleak: Fix a race between stack erasing sysctl handlers
To:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, alex.popov@linux.com,
        miguel.ojeda.sandonis@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Any comments or suggestions? Thanks.

On Fri, Aug 28, 2020 at 11:19 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> There is a race between the assignment of `table->data` and write value
> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
> the other thread.
>
>     CPU0:                                 CPU1:
>                                           proc_sys_write
>     stack_erasing_sysctl                    proc_sys_call_handler
>       table->data = &state;                   stack_erasing_sysctl
>                                                 table->data = &state;
>       proc_doulongvec_minmax
>         do_proc_doulongvec_minmax             sysctl_head_finish
>           __do_proc_doulongvec_minmax           unuse_table
>             i = table->data;
>             *i = val;  // corrupt CPU1's stack
>
> Fix this by duplicating the `table`, and only update the duplicate of
> it.
>
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> changelogs in v2:
>  1. Add more details about how the race happened to the commit message.
>
>  kernel/stackleak.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index a8fc9ae1d03d..fd95b87478ff 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
>         int ret = 0;
>         int state = !static_branch_unlikely(&stack_erasing_bypass);
>         int prev_state = state;
> +       struct ctl_table dup_table = *table;
>
> -       table->data = &state;
> -       table->maxlen = sizeof(int);
> -       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +       /*
> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
> +        * can duplicate the @table and alter the duplicate of it.
> +        */
> +       dup_table.data = &state;
> +       dup_table.maxlen = sizeof(int);
> +       ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
>         state = !!state;
>         if (ret || !write || state == prev_state)
>                 return ret;
> --
> 2.11.0
>


-- 
Yours,
Muchun
