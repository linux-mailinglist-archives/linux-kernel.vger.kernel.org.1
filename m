Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4727B807
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgI1XXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgI1XXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:23:42 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48EBC0613B8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:44:27 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id j12so2757869ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwjW9aVhaH3Akzu5Far0IJ9TvL77Wnb7vo0nK8ZII38=;
        b=Hsrfj84emk5bg/vkeMeiJqZFbpfVVaUk3h76uCV1XQ6lC7+s63GLenwoiLxRmGJztj
         b0Cnn/lq5zkeN4AvGNMc2h7u3bG4QqQsKRCnwKojhTM7nZHN1nT+u6rhjKS5nzsrKLw4
         5xf1rq6O6v1YuUJDvN6mBxgRRxEAeFb1yRlcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwjW9aVhaH3Akzu5Far0IJ9TvL77Wnb7vo0nK8ZII38=;
        b=BSJk9EM5Pg6qRfjBcFyZGNCaEaIlCScuGLuCg0SOVH/Cee0SLOhLQ4CdrS6onVu8nh
         WItDyLxa1kHbuk4rxte+rSIv1iYbX8jJbYQ5+Vk0rWqsZ7CX4CHqnZL3hJ6AdMpDNlrR
         VY4DE+rYgIYHmiPi4voCnCSLXBGjMSJdZJSFkqer3/8cXWXvkU3/j1MVIjll3lz1F4qO
         emThYJbPwBb2CufZUq12p/LQ7W+wMSQ7eWR+AgQZFCtYhkDvAg51nUQBxzKfXyFVmE4F
         ncjOEf31OWDPF6Mq7ZtXjqsmqZh81lSCbKUuiAQLKVCGODmCwBVUXo9Bu8EI/w3UBlkO
         IObg==
X-Gm-Message-State: AOAM533MZYjJaKX7oIcC/tkGpEekXRjdwtKiyTRBJc9bhapIs3glARNi
        WYOj/4aXljjSmSOL4G7hAtM7aWE92sbz4Q==
X-Google-Smtp-Source: ABdhPJxIZG2ZKVzrPM21vM6P/CSQDbQlfgFEH8YxPEr3xR4Q0i+9eSlWCx+o/4MKEgUc6pR3PQiAJg==
X-Received: by 2002:a9f:36ca:: with SMTP id p68mr2206151uap.96.1601333066083;
        Mon, 28 Sep 2020 15:44:26 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id q74sm1342669vka.45.2020.09.28.15.44.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 15:44:24 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id 5so1793198vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:44:24 -0700 (PDT)
X-Received: by 2002:a67:ad0e:: with SMTP id t14mr1333581vsl.34.1601333064104;
 Mon, 28 Sep 2020 15:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200927211531.1380577-1-daniel.thompson@linaro.org> <20200927211531.1380577-3-daniel.thompson@linaro.org>
In-Reply-To: <20200927211531.1380577-3-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Sep 2020 15:44:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5Ro_MtGMJDCCjnB1_CPzRPHbZx5ovQ6L8JbpNNdyngA@mail.gmail.com>
Message-ID: <CAD=FV=X5Ro_MtGMJDCCjnB1_CPzRPHbZx5ovQ6L8JbpNNdyngA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kgdb: Add NOKPROBE labels on the trap handler functions
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 27, 2020 at 2:16 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kgdb honours the kprobe blocklist but doesn't place its own
> trap handling code on the list. Add labels to discourage attempting to
> use kgdb to debug itself.
>
> Not every functions that executes from the trap handler needs to be
> marked up: relatively early in the trap handler execution (just after
> we bring the other CPUs to a halt) all breakpoints are replaced with
> the original opcodes. This patch marks up code in the debug_core that
> executes between trap entry and the breakpoints being deactivated
> and, also, code that executes between breakpoint activation and trap
> exit.
>
> To be clear these changes are not sufficient to make recursive trapping
> impossible since cover all the library calls made during kgdb's
> entry/exit logic. However going much further whilst we are sharing the
> kprobe blocklist risks reducing the capabilities of kprobe and this
> would be a bad trade off (especially so given kgdb's users are currently
> conditioned to avoid recursive traps).
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/debug_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

I didn't go on any more hunts for missing functions since this seems
fine to me.  It's mostly just trying to make it a little harder for
someone to shoot themselves in the foot, after all.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
