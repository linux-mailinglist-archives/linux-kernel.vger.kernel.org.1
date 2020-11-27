Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C92C6D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgK0Wqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732557AbgK0WnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:43:15 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33979C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:43:15 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id x2so1780623ybt.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzKv8P6thCUeHlA5APiPYCdoVF2CX0ZH4GOpwSUzn5Q=;
        b=GCimQEP8U2Lp61xBzvEJIBG7OGwZCzcLbtdtiwgSthzxYk71MET9gkukV2HVx5h294
         Z8H4+sfcdbOlgOY5zRAv6pOZoGHRal8hkU/mRgeVnExS66d6gYyaVVrvnLiodnoYf04P
         hCLoDfs97Vuipqhi/253pZfF8uCEBzKQHDrfq76QTBb9hN2DQ5TIGJojlOQhXbG0r2xx
         RruelBnx7gchB3zLI1yeBI6MbPyEZzqK3WPxXk8RkiuvZAEdEg/mE+LP6+hETtuLz2V2
         vTk+icpi6du7qgsLL87v9CBjOBTGS5H+vknF7VclubB6wSxyQtOojUMLc/ImLKBz35nJ
         L2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzKv8P6thCUeHlA5APiPYCdoVF2CX0ZH4GOpwSUzn5Q=;
        b=g2Y6I/V7l8HTxwmhCwL+xP1spgR29aNXqDIKI2gdFwTKOmkQugHxa5yLacbdz8DtIh
         6AFyU4B89EZTpFinOraZv68yCq7ujTUt1YexYb2yL/1olWAUtiXjX2S1V0dvFsSYSpcK
         NnJ97F+mJI5Sz3EJlwHdaTjD8v8l2+0Ot69sDBHaQXYpioMmUPiBK3U+i11GV/swGglL
         onW81PEhKWz/mNlbC1cmMtZlOebYJYV8HP1nXlYXdbhHLw7muCu+ZQ9Y3kb7ahT8/mk8
         12fykru0PQb4KTjD1SGAWbXIPGlVnfId2RNiOvykCT6Il7hL4E5MQB1T3E2tR38wASER
         fsQg==
X-Gm-Message-State: AOAM531Mur8K2SwDgj7lkBp6IIwtK3jUlJJ3v+r6hakuJVrOO+DPjkcT
        q3+tMkJKzqNLFv0vzJjDmKxxrMR2uOVkcBqA0kQ=
X-Google-Smtp-Source: ABdhPJy3yJ85yX4LmIVfT85GF3SshMVYQ7Lwroljea50vrnatjFA9IAHNzpr5W8N6VMwxWXCbpTAchG1n++wpD1mhyo=
X-Received: by 2002:a25:5f0f:: with SMTP id t15mr11566592ybb.26.1606516994594;
 Fri, 27 Nov 2020 14:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20201127214316.3045640-1-trix@redhat.com>
In-Reply-To: <20201127214316.3045640-1-trix@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 27 Nov 2020 23:43:03 +0100
Message-ID: <CANiq72nBYycRrBFVQE-D8TfsLwFf+xrL=jcRN1cULG=3cexRDg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
To:     trix@redhat.com
Cc:     Robo Bot <apw@canonical.com>, Joe Perches <joe@perches.com>,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:51 PM <trix@redhat.com> wrote:
>
> From
> RFC MAINTAINERS tag for cleanup robot
> https://lkml.org/lkml/2020/11/21/190

Please use lore.kernel.org for links.

> The prefix used by subsystems in their commit log is arbitrary.
> To elimitate the time and effort to manually find a reasonable

Typo in "eliminate".

> prefix, store the preferred prefix in the MAINTAINERS file.
>
> Populate with reasonable prefixes using this algorithm.
> What did the maintainers use in their commits?
> If there were no maintainers commits then what did everyone
> else use in their commits.

Why is this in the form of a question? I am not sure I understand --
is it rhetorical?

> The results were manually reviewed and about 25% were rejected.

What do you mean by rejected?

> Add 'D' tag to checkpatch.pl
>
> Use 'D' tag by adding --subsystem_commit_prefix option
> get_maintainer.pl

This looks also out of place, as if it was squashed from other
commits. I would suggest trying to reword the message in prose,
explaining the rationale and why it was done like this.

>  AUXILIARY DISPLAY DRIVERS

Missing entry for auxdisplay.

Cheers,
Miguel
