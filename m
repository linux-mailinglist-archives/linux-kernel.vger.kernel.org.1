Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE31D2D9D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408414AbgLNRNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408413AbgLNRNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:13:13 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED87C0613D3;
        Mon, 14 Dec 2020 09:12:33 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 82so9252658yby.6;
        Mon, 14 Dec 2020 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rKntWAzezKQY6iRUqQwhm52Tcc3Is8F5R6X0L2T4x0=;
        b=aeBQBa2+tSZ5IwKLmky59/317du25kb5QvdC9TIwDci6aoupzBEyy0TJWD23cZbZpF
         FCLyMLzHRAX3P5Z7NxUChIi374ZZENIny2AKBbunXKVNy6DzhXMgMh7TN6FO4ro5ZcY3
         R5RRQIkjF4/1PiU2BZORpSsOzq7qi2OjkmiuSssrk2EzVILNXwzCj1Xn0b6BPH21y1fP
         NstTfcQ+kIy7CTI0Cw3NpZYysrZyPyfe3eo2Tw9/QzmIwcusOC9Kr3CJ+N+zog7Klj/n
         L0UpRvL69C4gv37lyjwfCuQwFFsM/YkZqfPnLb/4wRodAzYUhgFAxa1U6OdFQFHveYpe
         L9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rKntWAzezKQY6iRUqQwhm52Tcc3Is8F5R6X0L2T4x0=;
        b=U5eXP1VXeg87W0QtoPpQ2LNheUq0us8LTfbrgpJ2/DZOPRYwPnifMf8FfVHOvdSHlf
         T8zkhwPS0gZO/nwLgnik5VDExl6BvNXsZKsUNvkPez5jAojCJ/uI9DiiBGOHe3wPWC5D
         r8Sbj+KvXB1RxmJNGEYcwMZ2pX3Lgj1jk30DTgEDR/EWao1RKWHrz/mA739sfQP68OAs
         31d3bQ8DJhfc6Kar58OHIdz6pzP+ejbPMkToEeNkF344kQQvjkH5TS6YeNQ4yOoR1pFY
         BpoU5eQCY7vWtVfs8m+o9SduzPRz8MjhJfcKBMapb4l1NW1fRqkpcENAl4/aJgfRUeMy
         fnvA==
X-Gm-Message-State: AOAM533Pfw4xfePqJugC0jaJDAleyFXw351/DPV/0T2hjKcyfP6m/5a9
        MZb1EONLWDIYS5JQPB0LeTH+Pzdq+ZzclbB6vZA=
X-Google-Smtp-Source: ABdhPJwmepRzWIWkCfUMN5Kbq6U3QkiOKjfBZudMDR1drxErt8YUn0ov9ksl8/hO4b05XcLvCKm9aVC8DsljRQN2Pl0=
X-Received: by 2002:a25:f02:: with SMTP id 2mr36268254ybp.500.1607965948994;
 Mon, 14 Dec 2020 09:12:28 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
 <20201214111512.415717ac@gandalf.local.home> <20201214112629.3cf6f240@gandalf.local.home>
In-Reply-To: <20201214112629.3cf6f240@gandalf.local.home>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 14 Dec 2020 20:12:18 +0300
Message-ID: <CADxRZqwDAZK3s2jjavUKunvbE3jux=yNfPQFRwvMZRjqqS_6cw@mail.gmail.com>
Subject: Re: [sparc64] ftrace: kernel startup-tests unaligned access
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 7:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 14 Dec 2020 11:15:12 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Does sparc64 require 8 byte alignment for 8 byte words?
> >
>
> In other words, does this patch fix anything?
>
> -- Steve
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..fa716994f77e 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -143,6 +143,22 @@ config UPROBES
>             managed by the kernel and kept transparent to the probed
>             application. )
>
> +config HAVE_64BIT_ALIGNED_ACCESS
...

Steven,

yes, this patch fully fixes ftrace sparc64 "unaligned access". Thanks!

$ journalctl -b -k --no-hostname -o short-monotonic | grep -c unaligned
0

$ diff -u <(gzip -dc ~/dmesg/config-5.10.0.gz) <(gzip -dc /proc/config.gz)
--- /dev/fd/63  2020-12-14 20:11:10.442415669 +0300
+++ /dev/fd/62  2020-12-14 20:11:10.438415619 +0300
@@ -305,6 +305,7 @@
 CONFIG_JUMP_LABEL=y
 # CONFIG_STATIC_KEYS_SELFTEST is not set
 CONFIG_UPROBES=y
+CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
 CONFIG_KRETPROBES=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
@@ -2842,7 +2843,10 @@
 # CONFIG_TRACEPOINT_BENCHMARK is not set
 # CONFIG_RING_BUFFER_BENCHMARK is not set
 # CONFIG_TRACE_EVAL_MAP_FILE is not set
-# CONFIG_FTRACE_STARTUP_TEST is not set
+CONFIG_FTRACE_SELFTEST=y
+CONFIG_FTRACE_STARTUP_TEST=y
+CONFIG_EVENT_TRACE_STARTUP_TEST=y
+# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
 # CONFIG_RING_BUFFER_STARTUP_TEST is not set
 # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
 # CONFIG_KPROBE_EVENT_GEN_TEST is not set
