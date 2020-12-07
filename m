Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56FC2D0EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLGLGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgLGLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:06:12 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ACEC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:05:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v85so4388023oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJXCIOJkKH6hh2jpxv9ilCGF+BcWVUo0z/wPZmqyr0o=;
        b=iCLr+DpHSbjjRpluEXnY/MbwwQFSTGIXeRIznSr1aKN8Q4CJ/caeEz7lHYB0v5P83A
         L5tid+yg5BlkoMMjArpvpuvL0uo3nhulaVvOviMSherdOI0kYeH8qlJc+mA9W77hOlOs
         m2bWX+mGxPPbAtKwiTfkVppZ+k0Gg5P/jXaEWAdAf1ZXdxiI9wU320g61JOpSGogktR+
         K5nhyl9AfLC8pAOyU6pKOnfMArJrYlH1qxZFjBUHJeK4yR/J0HoljQ0oJzYgILBPCgKF
         +LTDMA4E4T+wzKsVUSzcAEzfeatc97DniIjZI4TjeaP3qfa0NdxSd1Hv0uSzZjn/vDcA
         dsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJXCIOJkKH6hh2jpxv9ilCGF+BcWVUo0z/wPZmqyr0o=;
        b=Xl40F3ONo8g/XpTvWJvIF0K3JviQqXEKDzyYLCwugQcv2qy/+8ayq3sTlat3iABBH0
         7+UVBu0Wp4DqDhLT/y+TlMtoTIouQJ+DWphdEVnWICt7u2U76OKrpg+3L9IwgFLJfvZE
         45/8IpCnLDKEa/0JEdiIGZzlgkDKDQdi4msu6vEdtF13BznP+jF7243eUqtJqvUCba4z
         gNKvJwVvq56+7BC9Nc15G8/dgG402ThTNoLmfV6bLpgJxkcCkMaua6av02RABK4rJ0Wg
         Z07HoUCoKxIbLoA91uNyHSPiCY6hsxSr8hOxQAW/A5jICTGUGRELwpGfkkk08pIJdfsK
         gY6A==
X-Gm-Message-State: AOAM532jOTlxG1+qrzXCcb/92wiZuVhyjzfhYA1QWafDo6m9uCAgYuYv
        erqMl1myOZ2fr79xO7uhpwMR5B/eQB91syurNinUwQ==
X-Google-Smtp-Source: ABdhPJxv+kuYLTv1arPVZtnxPm93hns9idLkytFJ1RbiSt53pqTfehultuHOvUTGmrMWCK0YJzl86fVx2/RkXV1UKW4=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr12226310oie.70.1607339130259;
 Mon, 07 Dec 2020 03:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20201206211253.919834182@linutronix.de>
In-Reply-To: <20201206211253.919834182@linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Dec 2020 12:05:18 +0100
Message-ID: <CANpmjNPh1dhTmsBY7LCaL73wiYFLNMG9Cm5S12D38NEuRsXKGg@mail.gmail.com>
Subject: Re: [patch 0/3] tick: Annotate and document the intentionaly racy tick_do_timer_cpu
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Dec 2020 at 22:21, Thomas Gleixner <tglx@linutronix.de> wrote:
> There have been several reports about KCSAN complaints vs. the racy access
> to tick_do_timer_cpu. The syzbot moderation queue has three different
> patterns all related to this. There are a few more...
>
> As I know that this is intentional and safe, I did not pay much attention
> to it, but Marco actually made me feel bad a few days ago as he explained
> that these intentional races generate too much noise to get to the
> dangerous ones.

My strategy so far was to inspect random data races and decide which
ones might be more interesting and send those, but I haven't had time
to chase data races the past few months. Thus, getting rid of the
intentional boring ones will definitely scale better -- relying on a
human to do filtering really is suboptimal. :-)

> There was an earlier attempt to just silence KCSAN by slapping READ/WRITE
> once all over the place without even the faintiest attempt of reasoning,
> which is definitely the wrong thing to do.
>
> The bad thing about tick_do_timer_cpu is that its only barely documented
> why it is safe and works at all, which makes it extremly hard for someone
> not really familiar with the code to come up with reasoning.
>
> So Marco made me fast forward that item in my todo list and I have to admit
> that it would have been damned helpful if that Gleixner dude would have
> added proper comments in the first place. Would have spared a lot of brain
> twisting. :)
>
> Staring at all usage sites unearthed a few silly things which are cleaned
> up upfront. The actual annotation uses data_race() with proper comments as
> READ/WRITE_ONCE() does not really buy anything under the assumption that
> the compiler does not play silly buggers and tears the 32bit stores/loads
> into byte wise ones. But even that would cause just potentially shorter
> idle sleeps in the worst case and not a complete malfunction.

Ack -- thanks for marking the accesses!

Thanks,
-- Marco
