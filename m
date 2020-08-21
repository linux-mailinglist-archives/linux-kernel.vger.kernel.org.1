Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3823424D802
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgHUPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHUPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:07:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:07:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so2012046iow.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnYQNhwtXwVYlPdVsnrBy6dOuo2Ol5Ijyx6D4Eg1YoA=;
        b=ePdvtcgT7ltVEACaDkXOhjZZ02iFArzqiVXgTDQe++M82pCs5Zf0M73C4dRNooFsv/
         cgVAYMgsOzHtCuF+zIyKxbetlNSd0YbgaQjMzgkoNV1ZslxvAQKHHIMs4AuMmXRkwStD
         MxbkCWxUBT8aX9J7V4C58hIzUznGe9Ja//XJ3gocQY+1wW7Uf1c2OAAVtt6j/iB3Ive2
         /AsQS4f/5HH3nDNe9GiqlKBPJdVCcpFW9aEfQN/F1tkd+q+fPo3rAIRo7dOJMcmEFsPw
         /MqQtHQ1eHKBczcqsdcZmYgRVxC+t7yK7VUfgM+Iwx6+CU2Yv5USTsx2ilYXs/W6v0KY
         Htag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnYQNhwtXwVYlPdVsnrBy6dOuo2Ol5Ijyx6D4Eg1YoA=;
        b=NtcSwH7O5zRKH5jSCNEvESmdGCeXPby/nb7FShU9ZrKf2P8jdsut++Rcf6uNi2jSW1
         pgns6oCMycLBl+t/BDlrda2APwS6d8v0ijaGAIoTVMorYzsYH1oi3KGiBfIs9Qz6ej/P
         AG/ifiOGomfbcUMUbOSAH0dNJdnpG3TbwEZldztBFIliM73KlBUq8MgCX8CgL7/wBI9e
         eBANKPG64SGYrJF4OgQAn6juN3EkbKdnp6YEKjxx4RyNwHkBwIj6rVENxbmpNofTGF+A
         Ob1Jda3MxT8Cgy1GFgtAvIunYEWMFSW+UXfNzWg5d3b0ku7RzfloUAiHdDGAhZNkLqdV
         OuDA==
X-Gm-Message-State: AOAM533CiwcAQ/LFQBnpd16Zf+G39zCv25qUQWZwO1GSeUjQFaQBQHS4
        d0eVFTXCiNXPih+wHzPFT5LPLRQIvgZDhJocJ+L4aA==
X-Google-Smtp-Source: ABdhPJzB1KDJI41X8qYxbJ9m5IjiKVoEO8Gk4B7Q2R8J9LQz3LTFJRJTOF0VfsN9KiurkFP8iE4R3IK9Cog2hB3AgZA=
X-Received: by 2002:a6b:7846:: with SMTP id h6mr2643881iop.145.1598022421093;
 Fri, 21 Aug 2020 08:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200821063043.1949509-1-elver@google.com> <20200821085907.GJ1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200821085907.GJ1362448@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 21 Aug 2020 08:06:49 -0700
Message-ID: <CANn89i+1MQRCSRVg-af758en5e9nwQBes3aBSjQ6BY1pV5+HdQ@mail.gmail.com>
Subject: Re: [PATCH] random32: Use rcuidle variant for tracepoint
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 1:59 AM <peterz@infradead.org> wrote:
>
> On Fri, Aug 21, 2020 at 08:30:43AM +0200, Marco Elver wrote:
> > With KCSAN enabled, prandom_u32() may be called from any context,
> > including idle CPUs.
> >
> > Therefore, switch to using trace_prandom_u32_rcuidle(), to avoid various
> > issues due to recursion and lockdep warnings when KCSAN and tracing is
> > enabled.
>
> At some point we're going to have to introduce noinstr to idle as well.
> But until that time this should indeed cure things.

I do not understand what the issue is.  This _rcuidle() is kind of opaque ;)

Would this alternative patch work, or is it something more fundamental ?

Thanks !

diff --git a/lib/random32.c b/lib/random32.c
index 932345323af092a93fc2690b0ebbf4f7485ae4f3..17af2d1631e5ab6e02ad1e9288af7e007bed6d5f
100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -83,9 +83,10 @@ u32 prandom_u32(void)
        u32 res;

        res = prandom_u32_state(state);
-       trace_prandom_u32(res);
        put_cpu_var(net_rand_state);

+       trace_prandom_u32(res);
+
        return res;
 }
 EXPORT_SYMBOL(prandom_u32);
