Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B040269302
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgINRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgINRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:22:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBDDC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:22:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so329395edo.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVKTqBvAVL/A+UXC7zGaAyoWT6Nr8r3v+Ezj9S1yIPw=;
        b=c8PBdW9DTTtB3R0OvNB3DmIeloDYpsfHYcX2vuydwqfOpYaj5PuMqsXPfMcVdzbUHS
         mkI98smfe2aaC0v+Hjloh5C8KbwYLuhnbH426Qmcqnvr/VIaHbNiiW0bZsGd15Hkq83T
         OeC+eJwO78+wBSx3DvLUvawgY5kos7ZTFgiQQrkNHs7tJukVItOT+YSJg1925fhuR08q
         /VMJSW6ZhURYvyKytxe8G2ThFcHVCpamBbDHZgePl+EAM4lKU4tOmtIU9pKA14jl4843
         waYot8MoJ8vVU9XAIALtH2hJypDZSdYZByMaxtapdnrp4B8G5yOFdFAYI1FaDv+lm7VD
         tqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVKTqBvAVL/A+UXC7zGaAyoWT6Nr8r3v+Ezj9S1yIPw=;
        b=d7RRzmC0NseWPa1RqW7QatSsGRgQYHfw9OzojPTONGbqePqvrbrv9tsPuvpFw+Yd9Z
         WB8MPUUshrSlKLq5rwES+biLpI30yc0WWzVdCYYntL7j9g/7K0D53Nb68jVHxZQ7/R2y
         qi47xNANjUxocewiiHMCrnb8P5gX51ditSuZ1+KnibPid4ENAhfLSOKdHUp8GrUWPRlC
         lwBVaRO13NKNUso/vhFRZyZqx570Umdt7vnBqEyoc6JQcMPVIGXa9vBtioDUpVpabMqO
         vW9fl0AfLjX85g1ysq5mmb5zvd9pSf5KMz0Y1MXGeYUJaRHLuoTxQd56MGlTk7JCByvE
         syig==
X-Gm-Message-State: AOAM5328xo0wO1046yNAr2O2sRr8u3oK483gJmh1w2asbvd5Kp/fF0Kh
        nziKdmeKwne7qKDoIXt62HX3TdLel38bWZs7tcUZDSuZNxwvWw==
X-Google-Smtp-Source: ABdhPJyr8SuVbuxS7t5xaz2dMyyPhGFOJTZQ8YZxwyAI9zOu2ozpYQfTVevZPjltjbwcYoT+oo2QNgu1CMBK2k+Exw4=
X-Received: by 2002:a05:6402:17b9:: with SMTP id j25mr18533021edy.203.1600104174639;
 Mon, 14 Sep 2020 10:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200912005826.586171-1-keescook@chromium.org>
In-Reply-To: <20200912005826.586171-1-keescook@chromium.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 14 Sep 2020 10:22:40 -0700
Message-ID: <CAP045Ar=-nPVw94LhZ3dV=yzY-SoS8Xf-JtfcywT9_D5eP1vEA@mail.gmail.com>
Subject: Re: [PATCH] core/entry: Report syscall correctly for trace and audit
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 5:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On v5.8 when doing seccomp syscall rewrites (e.g. getpid into getppid
> as seen in the seccomp selftests), trace (and audit) correctly see the
> rewritten syscall on entry and exit:
>
>         seccomp_bpf-1307  [000] .... 22974.874393: sys_enter: NR 110 (...
>         seccomp_bpf-1307  [000] .N.. 22974.874401: sys_exit: NR 110 = 1304
>
> With mainline we see a mismatched enter and exit (the original syscall
> is incorrectly visible on entry):
>
>         seccomp_bpf-1030  [000] ....    21.806766: sys_enter: NR 39 (...
>         seccomp_bpf-1030  [000] ....    21.806767: sys_exit: NR 110 = 1027
>
> When ptrace or seccomp change the syscall, this needs to be visible to
> trace and audit at that time as well. Update the syscall earlier so they
> see the correct value.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: d88d59b64ca3 ("core/entry: Respect syscall number rewrites")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kyle Huey <me@kylehuey.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/entry/common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 18683598edbc..6fdb6105e6d6 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>                         return ret;
>         }
>
> +       /* Either of the above might have changed the syscall number */
> +       syscall = syscall_get_nr(current, regs);
> +
>         if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
>                 trace_sys_enter(regs, syscall);
>
>         syscall_enter_audit(regs, syscall);
>
> -       /* The above might have changed the syscall number */
> -       return ret ? : syscall_get_nr(current, regs);
> +       return ret ? : syscall;
>  }
>
>  static __always_inline long
> --
> 2.25.1
>

lgtm

- Kyle
