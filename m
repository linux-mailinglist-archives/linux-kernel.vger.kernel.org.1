Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6E269A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIOANv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIOANn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:13:43 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33705C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:13:43 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u48so465238uau.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbe1AqHS58DfWSfiPA4xYQAF16nRd6xvbt+9w/fq7F8=;
        b=a9nIWOuBsncn5CebByhLCjo54A9sj/xgJrXzTbXB4c+iGvDoxRz2kj+HDFuTlz6FHe
         ccTCakQhRnSTvbseiPYReW0cS/V95isQRNkbPDnFi3195ZDjjfks6GzN4NKVPvcaGFRA
         OiJFlEWiuip89VPeG5qgsATN0udSYhMKAY1mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbe1AqHS58DfWSfiPA4xYQAF16nRd6xvbt+9w/fq7F8=;
        b=bX41iOiwEw7ngVUhIYWX9lJPFoNM42c8TJYDLkGtBZir6cOL7QguKS+yWHvmLRqQ1X
         EYr4rQD/jFELm6bmcSUdI7a092STMwxA+qGKmL16SoxbfbLix1/PXl267A2WsjbTnkeI
         MMk+iuPZC2oQh7Gm+UaIn7VqYGeNJKUwx8zSP34xesfT3jizfZmV0jtRKYSQgGVuqeQP
         GKWZP8jMt65fN+mN+RUMiYeDeigtjxE0gL/4hVSvnUWqUGm2KRhY3+JGKui1Sl/fP2SA
         81/jkBvunUcOZhoY+D3LJ6VP5Rvkp5Mv6KKU8OavnnJLQxAiVLZhuaPS/F/ZhEz1o1cU
         CI1A==
X-Gm-Message-State: AOAM53243d9lOtFOfNwgOjEa4gz71VcoeQHeRl++yA8xCKl0Uf6hMEm8
        83CItnFpYkW9vFwSs5t4bGahUuFlD6//XA==
X-Google-Smtp-Source: ABdhPJxZGmxqLlbPdPOR/p0/fHJrf1WRrxqvP8uaqrykvv9J/Jt+3V9nP4uc4I4vxHGguY3kQoYtxQ==
X-Received: by 2002:ab0:130a:: with SMTP id g10mr8869179uae.100.1600128820926;
        Mon, 14 Sep 2020 17:13:40 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id w6sm1723163uan.4.2020.09.14.17.13.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 17:13:40 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id n7so393031vkq.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:13:40 -0700 (PDT)
X-Received: by 2002:a1f:1dcf:: with SMTP id d198mr2927179vkd.30.1600128819652;
 Mon, 14 Sep 2020 17:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200914130143.1322802-1-daniel.thompson@linaro.org> <20200914130143.1322802-4-daniel.thompson@linaro.org>
In-Reply-To: <20200914130143.1322802-4-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Sep 2020 17:13:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUPXdHoPaQg=Pp=bH-iORicO+1LjBZ0PNu0=SumC5tYw@mail.gmail.com>
Message-ID: <CAD=FV=VUPXdHoPaQg=Pp=bH-iORicO+1LjBZ0PNu0=SumC5tYw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kernel: debug: Centralize dbg_[de]activate_sw_breakpoints
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 14, 2020 at 6:02 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> During debug trap execution we expect dbg_deactivate_sw_breakpoints()
> to be paired with an dbg_activate_sw_breakpoint(). Currently although
> the calls are paired correctly they are needlessly smeared across three
> different functions. Worse this also results in code to drive polled I/O
> being called with breakpoints activated which, in turn, needlessly
> increases the set of functions that will recursively trap if breakpointed.
>
> Fix this by moving the activation of breakpoints into the debug core.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/debug_core.c       | 2 ++
>  kernel/debug/gdbstub.c          | 1 -
>  kernel/debug/kdb/kdb_debugger.c | 2 --
>  3 files changed, 2 insertions(+), 3 deletions(-)

I like the idea, but previously the kgdb_arch_handle_exception() was
always called after the SW breakpoints were activated.  Are you sure
it's OK to swap those two orders across all architectures?

-Doug
