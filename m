Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43E62F7AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbhAOMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbhAOMyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:54:12 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804BC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:53:31 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v3so3593777qtw.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9BqWIgWq/g/lc4wxnz/C2MSjqoIDnb6hVrxU6/5964=;
        b=fsxbLQTv4QHG2UcsckTqMjmrG03y3+pTx+WTSO8AeJJ+GASM54h8CQ3OeflsRyvuBa
         ODfEbZ5T0w/m5QxidfUTRdMzn+1sRznlV+k4bL0o4mv3QWA9b7Tiwhy0eDdt8Ts/b6AV
         uTProyUUXB6BZ1FLkR75KQ4R+kbcatGnuYLZkPsmuoHQq47jRf4QsUdVv02hWSO6rEC5
         71prJRRhVbmWvZnOQLdHfbwbFZxXN+EB/6TFYmLx0T5kVyFREPTx6GTtEHXxJa/8shd+
         2n31E30fmPRLW4xt4dfuJA0krrhXcYEGUB5m8nUjM6+irdLOK0yAqttoSbBSWrRtZBFB
         Tu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9BqWIgWq/g/lc4wxnz/C2MSjqoIDnb6hVrxU6/5964=;
        b=Ay0J3B0XM7QgJ6YhZvJvFleSfMQDrkSZjlPmFehF0tQuNSQOhAhBOEkjMkzYvZBl/h
         0m3R9rE9lHvb03r9z7zV0C2bm6+qWtT1qqkPv4LEiMFrHlbQAhBbPA1fIukAHbGVaph5
         48nzuI9OlbpCPvyl+tydAgqPVlSZCnazqSy4Zu5rzP/kGE1qmbkYzPNWVhaapdQs1b+y
         eSMBpreUO2vSiomAS3YL+fwKXZRR+3FMg/MA7aSP9W5wDzMFBHypaBj4sVmVGiYz3TVm
         k9LG+id5NKdsWb+zgWxE/qzrBbr49OXEGuKL5GVUKqhY8KccEWfeFTgfd3Lnz4uCRLi6
         mjfQ==
X-Gm-Message-State: AOAM532FgvwD4esrZf8/6d5HEYg/ug7O2e52bZg3DyKzyLq7V3NXjhIu
        MWtyL9r5oF5b9YKN+2+QVGm6vuoI64MyFVa4rQhnDw==
X-Google-Smtp-Source: ABdhPJyR26Dq7PRJCQR60dg/UhwPOr3JlA1eLMB/yfyYpZYY3e3g+nHZdP7UF5zVM70UIkbAmIhp62krHnUXfAkZYII=
X-Received: by 2002:ac8:7111:: with SMTP id z17mr11638832qto.369.1610715210857;
 Fri, 15 Jan 2021 04:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com> <20210113091657.1456216-2-glider@google.com>
 <20210113161044.43bc1c1a@gandalf.local.home> <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
 <20210114095232.7ba3f9a8@gandalf.local.home>
In-Reply-To: <20210114095232.7ba3f9a8@gandalf.local.home>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 13:53:19 +0100
Message-ID: <CAG_fn=Uq9SeT4wBsbuEEniy7UmQBvtaLwkgAAR_FqkqD7aoDfw@mail.gmail.com>
Subject: Re: [PATCH 1/4] tracing: add error_report trace points
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 3:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 14 Jan 2021 08:49:57 +0100
> Alexander Potapenko <glider@google.com> wrote:
>
> > We'll need to explicitly list the enum values once again in
> > __print_symbolic(), right? E.g.:
> >
> > enum debugging_tool {
> >          TOOL_KFENCE,
> >          TOOL_KASAN,
> >          ...
> > }
> >
> > TP_printk(__print_symbolic(__entry->error_detector, TOOL_KFENCE,
> > TOOL_KASAN, ...),
>
> Usually what is done is to make this into a macro:
>
> #define REPORT_TOOL_LIST \
>   EM(KFENCE, kfence) \
>   EMe(KASAN, kasan)

Thanks, will be done in v2!
Note that checkpatch doesn't really like this declaration style,
claiming that "Macros with complex values should be enclosed in
parentheses".
(although it is consistent with what's done in other trace event headers)

>
> #define EM(a,b) TRACE_DEFINE_ENUM(a)
> #define EMe(a,b) TRACE_DEFINE_ENUM(a)

These lines must end with a semicolon, according to other headers (and
that becomes yet another thing that checkpatch barks at).
