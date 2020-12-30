Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF362E79B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgL3NbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgL3NbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:31:06 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E093C061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 05:30:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u26so12016047iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xmQAKEoo0shcR7ZB7EMhHQfI6sQvKDMQq5NCjlV6eVs=;
        b=lkrWZFzjIak7uji4YTIhHooOSdlDUjsXlEWjgZP8ssujOqnFLC5BBIJw83He9vcgCb
         OzCOUzpbPBcrRFMmuYazWOXeO2c+e8C6mXj2JYpQvfFgVu5Rl8x64TKzJUTB+y+8pdY0
         eXcDZpcEYyDkNcAADQtY4KTygQf3cWaGJI9Q7Pd6ze3dDJlDAxwfDqiOZevBjiQIdDCn
         65hmN9nz96BmSkroTJ3hMoU0ZX5yP/tpt1XuR0yausVq/C2cREwuPB7AASD6PELNnP6z
         12mNvkp6hRmSK75nhomH29HnaxPU1nZXdjqTEPZDTQO2cNWpTMA/n9P7RcnDkZ6APC3e
         tm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xmQAKEoo0shcR7ZB7EMhHQfI6sQvKDMQq5NCjlV6eVs=;
        b=Xa2wImZaHy+cTIA9sNGBTtVAcYtwnZ4QrIMm50TcLn/aPQHfz/LtV8fDPsqr1l+yNt
         tpCaGZzHOYmQVefAFmTEcpGMYzMQ8SYMmwVKLGHDvA/X48FQUDfi27yCMjsLd0FYjtDc
         ubUWLnw/fEYxtdV85wLYfhNAeZCOY0XgVl8Ja5RIUf/zeiu963DL5rZfgHLP32vn3ZHh
         f3RAX6HfyAWl9BcfCJtM081MHTWgQpp+WROFG39m9C2TGdtKIVsvKrueGSYXKqYxnspb
         CjfBij3K3oP8bViszdcy1x6uPmobUzUC7zkj80ST3yO36BZxUVYDGzpiBiuHtrX0Ig85
         biug==
X-Gm-Message-State: AOAM530Aki1bB9DH+wTVDou25S89i8lQtXFuIxwUzTVcBjY3JymEEXe7
        ds2ez8jLiEeAkAzqsd4bActMo73hdiKi/BG6Ep8=
X-Google-Smtp-Source: ABdhPJycjuprdXWXBDbcjpYGqlI9LaK4f//K+zhg0SkLkzAeinrY/59/efDYAOyPQSsLSFf6QRybc3vZDUeVfA/F3FM=
X-Received: by 2002:a02:650e:: with SMTP id u14mr46146396jab.143.1609335025010;
 Wed, 30 Dec 2020 05:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20201225142347.27204-1-hqjagain@gmail.com>
In-Reply-To: <20201225142347.27204-1-hqjagain@gmail.com>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Wed, 30 Dec 2020 21:30:12 +0800
Message-ID: <CAJRQjodjBMAuaaNqUyb9ooV6PqxBPX=JXrDyg1z=Sm-7q_oanQ@mail.gmail.com>
Subject: Re: [PATCH] trace: Remove get/put_cpu() from function_trace_init
To:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore the patch

[trace] 2158a32526: BUG:using_smp_processor_id()in_preemptible

Thanks

On Fri, Dec 25, 2020 at 10:24 PM Qiujun Huang <hqjagain@gmail.com> wrote:
>
> Since commit b6f11df26fdc ("trace: Call tracing_reset_online_cpus before
> tracer->init()"), get/put_cpu() are not needed anymore.
> We can use smp_processor_id() instead.
>
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  kernel/trace/trace_functions.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index c5095dd28e20..e36fbb935017 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -106,8 +106,7 @@ static int function_trace_init(struct trace_array *tr)
>
>         ftrace_init_array_ops(tr, func);
>
> -       tr->array_buffer.cpu = get_cpu();
> -       put_cpu();
> +       tr->array_buffer.cpu = smp_processor_id();
>
>         tracing_start_cmdline_record();
>         tracing_start_function_trace(tr);
> --
> 2.17.1
>
