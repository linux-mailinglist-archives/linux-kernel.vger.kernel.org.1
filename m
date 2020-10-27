Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981BF29C931
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830501AbgJ0Tp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:45:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44404 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830494AbgJ0Tp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:45:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id m26so2038137otk.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UuAnI3fpLSkqqbqcby7qgRRi+KejDcUiQcp3yUYFvk=;
        b=jKOI+EtivZ6h0zd2xJnMNIZvpdxRJYaqfuyFZyy2sQnJ2B4N5X0lngQkFjqFTIUb0b
         XHVePjslDpHau4ub8dKF2vK1lT+3n1MmYrNhCDGOMo8nKSH1xBAjY6t/Ll4ZLvJBe3kt
         KxHHjk6RRLkLa20oJUiamZhDcaGCu3ttyCDIuPfhYEPPmFaXNk2OuZl+qfSdsav9n87E
         CgPl49/B9SX9UEDB8XOo5GyDryAzMOKpM2504/SNisdr2wYc0c/UsPgXVpliDEAeg0s3
         NkwXzt7PZOhTzaQDTPufm4PPll6Tat2LcYEvYvUSSGXKGl4xXg50ASU0/1EGvoezUBl0
         On7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UuAnI3fpLSkqqbqcby7qgRRi+KejDcUiQcp3yUYFvk=;
        b=FvOYStHw9uY8l8bTDg+gmk51SKKMZ2HkmYUJbeEnhWTzGQOzuCMMmP+7vx1+5rhR5r
         mJ8cyv44/izCyKTp0SgvyhXqdvWyV0tXEdXRwGpENIogOXnaEawXaeBGpEoBlT3ijYxz
         dJGY1HVTJOcADB/xLnw4v87PN/+3w69FBy9eeZW4os7P97Ytu/pjxRehek6t5lAJ4e0K
         cZa4R+2fBYMI053dCo9cEV+C2wycrfbAIluMfP26ZQYKacJypCHVxOFqt7wjB8KCl2Lo
         +qCDHnsu0Gnb7WrG+9HamIa7xYXEOJNtmKIoRMMvIaMSlJCjBxJz4xQLEm7dkdJGxXB8
         KtqQ==
X-Gm-Message-State: AOAM532hPTZroloYNM+nAyQHxCd2xgYwb1Ch1VUBdEgguL4CDdopXZwN
        Iy7BbPqo9YZEbCyFdsCCVESzXy5U+ovpQy47K8qAjQ==
X-Google-Smtp-Source: ABdhPJy0pAAooP1Dbw8qY/iVoESpvqequp34nccEQyV0Xdmb2NfCFiXH4d59MM0F6LpltFcMo6AXkYRx1XrhY+pJFU8=
X-Received: by 2002:a9d:34d:: with SMTP id 71mr2456972otv.251.1603827955087;
 Tue, 27 Oct 2020 12:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201027175810.GA26121@paulmck-ThinkPad-P72> <CACT4Y+bB4sZjLx6tL6F5XzxGk5iG7j=SPbDkX_bwRXmXB=JxXA@mail.gmail.com>
In-Reply-To: <CACT4Y+bB4sZjLx6tL6F5XzxGk5iG7j=SPbDkX_bwRXmXB=JxXA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 27 Oct 2020 20:45:43 +0100
Message-ID: <CANpmjNNxAvembOetv15FfZ=04mpj0Qwx+1tnn22tABaHHRRv=Q@mail.gmail.com>
Subject: Re: Recording allocation location for blocks of memory?
To:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Let me add another option below, as an alternative to KASAN that
Dmitry mentioned.

On Tue, 27 Oct 2020 at 19:40, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Oct 27, 2020 at 6:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > I have vague memories of some facility some time some where that recorded
> > who allocated a given block of memory, but am not seeing anything that
> > does this at present.  The problem is rare enough and the situation
> > sufficiently performance-sensitive that things like ftrace need not apply,
> > and the BPF guys suggest that BPF might not be the best tool for this job.

Since you mention "performance-sensitive" and you say that "ftrace
need not apply", I have a suspicion that KASAN also need not apply.
KASAN itself uses lib/stackdepot.c to store stacktraces, which
deduplicates stack traces by hashing them; but over time its usage
grows significantly and may also not be suitable for production even
if you manage to use it without KASAN somehow.

If you want something for production that more or less works
out-of-the-box, KFENCE might work. :-)
v5 here: https://lkml.kernel.org/r/20201027141606.426816-1-elver@google.com

You can just get KFENCE to print the allocation stack (and free stack
if the object has been freed) by calling
kfence_handle_page_fault(obj_addr), which should generate a
use-after-free report if the object was allocated via KFENCE. You
could check if the object was allocated with KFENCE with
is_kfence_address(), but kfence_handle_page_fault() will just return
if the object wasn't allocated via KFENCE.

If you do have the benefit of whatever you're hunting being deployed
across lots of machines in production, it might work.

If it's not deployed across lots of machines, you might get lucky if
you set kfence.sample_interval=1 and CONFIG_KFENCE_NUM_OBJECTS=4095
(will use 32 MiB for the KFENCE pool; but you can make it larger to be
sure it won't be exhausted too soon).

> > The problem I am trying to solve is that a generic function that detects
> > reference count underflow that was passed to call_rcu(), and there are
> > a lot of places where the underlying problem might lie, and pretty much
> > no information.  One thing that could help is something that identifies
> > which use case the underflow corresponds to.
> >
> > So, is there something out there (including old patches) that, given a
> > pointer to allocated memory, gives some information about who allocated
> > it?  Or should I risk further inflaming the MM guys by creating one?  ;-)
>
> Hi Paul,
>
> KASAN can do this. However (1) it has non-trivial overhead on its own
> (but why would you want to debug something without KASAN anyway :))
> (2) there is no support for doing just stack collection without the
> rest of KASAN (they are integrated at the moment) (3) there is no
> public interface function that does what you want, though, it should
> be easy to add it. The code is around here:
> https://github.com/torvalds/linux/blob/master/mm/kasan/report.c#L111-L128
>
> Since KASAN already bears all overheads of stack collection/storing I
> was thinking that lots of other debugging tools could indeed piggy
> back on that and print much more informative errors message when
> enabled with KASAN.
>
> Since recently KASAN also memorizes up to 2 "other" stacks per
> objects. This is currently used to memorize call_rcu stacks, since
> they are frequently more useful than actual free stacks for
> rcu-managed objects.
> That mechanism could also memorize last refcount stacks, however I
> afraid that they will evict everything else, since we have only 2
> slots, and frequently there are lots of refcount operations.
