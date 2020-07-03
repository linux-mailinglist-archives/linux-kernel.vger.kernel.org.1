Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523542133FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGCGRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 02:17:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38277 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:17:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id z13so31378267wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQo/Rd+xHPmGgmIcOXUptpIYqJIjEhRxjJjwkv3wZFI=;
        b=Wie+xtDAvAwWBXbi4/yP7vQ4nDAQiF2GdEufERB9liab+KBJocGiyI6ZxxFXOakZuE
         xa3oyrjrnUBJdIirgnMvt/SQEFjASFLkUtxjpW3ASTEkArMbfSTd9h22Xj6BJ/CFZxOk
         cYCTB0pX2JaZ6W5nrudfpZFRsaI+jUAIMGs/6GgQV0NSlTb/Eom3YQKHlmB0YVTXW0AE
         uo25Wk9UlbHt2wZy5IBRoas1AmdhGJZm7o9MD+FfY6hB3qnf0nnBgCKCX1aF+D9m1vNX
         Pf/V/23EoXpYKIDlfsxdtWmFWRPPLCN61zgUjmTj85PQJIs7QWV/nx/rqIzNJAMUf1N8
         8zdA==
X-Gm-Message-State: AOAM531F3GdslPfGBbUQ2KP+pihD0mvRR4Dw73hK+dQSmBkcYeL0NL9P
        PXSsOoc+VCwfEVmjW4VIuU0MJK/CPHHsv3sXLdg=
X-Google-Smtp-Source: ABdhPJwBMXQlurLy8cM/1IC3M7Tdh9XzAktBL8oNObjKKNSPpO6SiR8eMtFvqghg6aa33QMGRehJe3KvSnmAMSc0lo4=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr35161491wrv.21.1593757042208;
 Thu, 02 Jul 2020 23:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-7-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-7-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 15:17:04 +0900
Message-ID: <CAM9d7cjM6p8pMLjzAoiGpT4RX-htL8GvmFRmTP8mXqk0oUfHAA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] perf ftrace: add option '-m/--buffer-size' to
 set per-cpu buffer size
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds an option '-m/--buffer-size' to allow us set the size of per-cpu
> tracing buffer.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
[SNIP]
> @@ -555,6 +575,8 @@ int cmd_ftrace(int argc, const char **argv)
>                     "Max depth for function graph tracer"),
>         OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
>                      "ms to wait before starting tracing after program start"),
> +       OPT_UINTEGER('m', "buffer-size", &ftrace.buffer_size_kb,
> +                    "size of per cpu buffer in kb"),

It'd be nice if we support units as a suffix (like perf record). e.g. -m 4M

Thanks
Namhyung

>         OPT_END()
>         };
>
> --
> 2.25.1
>
