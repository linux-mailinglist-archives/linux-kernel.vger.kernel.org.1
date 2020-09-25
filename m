Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31112792CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgIYU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIYU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:57:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98018C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:57:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so3622347pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgeT1UxhckyXDPY2lGvngm3rc9GEe2KOAzxyq6miOO4=;
        b=Au9OPHd/+pjONlExdGz/vM8D9ilyoGa2CUF7Jx7d6vg2rYzwlZQRGCVHf1LrhRLO8d
         FavKrJ8Uuo1jS6PJiuTCJz7JBoRle3blc3LHwA9CKFjq/W6mESOamnyw5LWBSiEq5e1o
         3ROQBfdwNCHkqyA3xx7gYEpMvzGukWoXktcnwVdwHH5jvW/bJCTOkdnpS6bTrqYAdIt2
         +TXRk+tZFpbaJ2NIhsEFtcrnite8Uo7tGsH2ZiLDFtnhWnIQYJmcmcAwBJuumRQXiQky
         RsnOoQ2Dac2QtP7+4nZU5xQ/hxkTtAorcEuIfwmykpf7VRXfpR6TYKHGVNxIIAmUUWYU
         2UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgeT1UxhckyXDPY2lGvngm3rc9GEe2KOAzxyq6miOO4=;
        b=k+RMqzgYY0w8tuvwGo5wKzOg9WBcScODqRUe/p5O/Z7IEXooh3YM+8+fsEyizSFIC0
         F/GYR15pg5p1wEixAWqL8+OO9To3EK7GxHwi+yxgjH+5vS+v228YCKzS9R5t9Wu+2zD3
         JJMFge1tEK2i6VEBVScaHydnRmk1aqq7qFsYGY+CuLMOCTP/eyrxuuwhCRBC7YOpe3bW
         0OZ/4My0t0KiOY/eeEYfhKPxxLoelHN/DZNQvvgfYSlR916NcwlA8+gaEtfLHEmOE0jm
         P/wDsMJknLi/PGoUnlljhUY1vT+nZi+Ya/nqZAVp/M1SCYZoyrtr7vJtWfVXujenE/Xh
         L9Yg==
X-Gm-Message-State: AOAM5305gObXYEi9PTNV+zhnE/gPj88dDj1ULTdD22BPDw7p7w6oU+HP
        Mv5+gzbVBsGHU8zyoX6Wn0SI+imuBbP5EEoM1Eq6NvMWUqs=
X-Google-Smtp-Source: ABdhPJxVl09jpOLHdh3pmxuwO+MtuO71NfvXRHLPhEquwLrebe0jp1eQkra5btFdaRin+CH3oAuPSCT70dO/XFtjtn0=
X-Received: by 2002:aa7:9556:0:b029:13e:d13d:a0fe with SMTP id
 w22-20020aa795560000b029013ed13da0femr401287pfq.26.1601067467880; Fri, 25 Sep
 2020 13:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200925190806.1870935-1-axelrasmussen@google.com> <cb89ebee230aedc9b5b6668bb333a258fc971b30.camel@kernel.org>
In-Reply-To: <cb89ebee230aedc9b5b6668bb333a258fc971b30.camel@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 25 Sep 2020 13:57:11 -0700
Message-ID: <CAJHvVcgfphkarK9mFzcKPm9RimH_eZQbYTDrOaXLp5+m+20wTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] tracing: support dynamic string field types for
 synthetic events
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:48 PM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Hi Axel,
>
> On Fri, 2020-09-25 at 12:08 -0700, Axel Rasmussen wrote:
> > Hi Steven and Tom,
> >
> > In this thread: https://lkml.org/lkml/2020/9/17/1015 we discussed how
> > to plumb
> > dynamic strings into synthetic events. Tom, you proposed adding a new
> > dynamic
> > string type to synthetic event definition like "char foo[]".
> >
> > I'm sending this patch because it may be simpler than implementing
> > that (I'm
> > not too familiar with the tracing infrastructure, apologies if this
> > is not
> > true), and in my testing it seems sufficient to address my use case.
> > I tested
> > both setting up a synthetic event as Steven described in the other
> > thread, as
> > well as doing an analogous thing with a small bpftrace program, and
> > both work as
> > expected with this patch.
> >
> > This is because I happen to know there's an upper bound on the length
> > of the
> > string in question, so I can just define a "char memcg_path[256]" in
> > the
> > synthetic event, and I can be sure the string won't be truncated.
> >
> > Let me know what you think. Happy to drop this and wait for Tom's
> > suggested
> > approach instead.
>
> Changing check_synth_field() is one of the things that will need to
> change for this to work - I'm working on a patch but am kind of in the
> middle of it, if you can wait - I expect to be able to post something
> Monday...
>
> Thanks,
>
> Tom

Absolutely, no problem waiting. I didn't mean to come off as being
impatient; mostly since I had already hacked this together a few days
ago, I figured it was worth an e-mail in case it could save you some
effort. I have no problem dropping it. :) Thanks for working on this!

>
> >
> > Axel Rasmussen (1):
> >   tracing: support dynamic string field types for synthetic events
> >
> >  kernel/trace/trace_events_hist.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
>
