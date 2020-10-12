Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2745928C168
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbgJLT0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbgJLT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:26:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99111C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:26:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m20so1184986ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Cu/ApJS4ZPLXmdUPjA+GEO/t+NxWjvWW5qIGNmGRzc=;
        b=KFwAcCtc5hqxnxdy48E86El0HI8pAhZnlOW3+QgeKE01jtXo4zTzLlN5+FR3xaB33M
         z4FtZpoJGAU/LpQzEwaDJl7xQ1sa+11Ln2+hlhYjJxmDMtqyLJ78uTq9KY9gnS9PUaSo
         GVVeaTgyS2hFPjBaaxjSqG3EgNKS0gELsmvCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Cu/ApJS4ZPLXmdUPjA+GEO/t+NxWjvWW5qIGNmGRzc=;
        b=luhVzlxHVQHxQ1HZTtP0ykBVAFc1I4olXFa26sgPJoMobYy7cW5vB5dH1WKNTuK5Jk
         ttFwnX/dlwdxLPcrOeemTIvltrXkUbEB/MJmtmA9uN2sRso8ZOlkeBP+iM/8TeH724Aw
         4RBev5nYvrhxWh98/RJiZUQAuCAitrly0A0EHzX6J9bTwMCzBOk3j+/3sH3DG1WNvsba
         Q7lW4i65/RvyNtIwC3/rtenqVMzgmwBjjzYbIYJ8EhbTKGDeVddBTcy7ti1A8jLINiOx
         WR4kSlvHol7IabqNuDaiMvrihw7kSDVi2ELiMT3YlGw7ucjQSzVNC7/odBLb1CZ/xrIs
         fofg==
X-Gm-Message-State: AOAM530Jq3WSh7XX47CVHL7m1fJysG9ISm5xkDNRn4Bh+hW3Uh9BU4xn
        g/XSZPqkEKRZgIr6r0CdbAMYrm4L5P05xA==
X-Google-Smtp-Source: ABdhPJyAe0LnSTtb4GYntdHyEAfLrD9RyGyl+69WfDSCK1ZMTIvdE4QOWt3gTECGnVRhyaSASn5pyQ==
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr2055171ljj.250.1602530761237;
        Mon, 12 Oct 2020 12:26:01 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j12sm3568127lfb.28.2020.10.12.12.26.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:26:00 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a5so17953914ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:26:00 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr3545582ljp.312.1602530759770;
 Mon, 12 Oct 2020 12:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
In-Reply-To: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 12:25:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
Message-ID: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Alexander Viro <aviro@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:40 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Between Linux 5.4 and 5.5 a regression was introduced in the operation
> of the epoll EPOLLET flag. From some manual bisecting, the regression
> appears to have been introduced in
>
>          commit 1b6b26ae7053e4914181eedf70f2d92c12abda8a
>          Author: Linus Torvalds <torvalds@linux-foundation.org>
>          Date:   Sat Dec 7 12:14:28 2019 -0800
>
>              pipe: fix and clarify pipe write wakeup logic
>
> (I also built a kernel from the  immediate preceding commit, and did
> not observe the regression.)

So the difference from that commit is that now we only wake up a
reader of a pipe when we add data to it AND IT WAS EMPTY BEFORE.

> The aim of ET (edge-triggered) notification is that epoll_wait() will
> tell us a file descriptor is ready only if there has been new activity
> on the FD since we were last informed about the FD. So, in the
> following scenario where the read end of a pipe is being monitored
> with EPOLLET, we see:
>
> [Write a byte to write end of pipe]
> 1. Call epoll_wait() ==> tells us pipe read end is ready
> 2. Call epoll_wait() [again] ==> does not tell us that the read end of
> pipe is ready

Right.

> If we go further:
>
> [Write another byte to write end of pipe]
> 3. Call epoll_wait() ==> tells us pipe read end is ready

No.

The "read end" readiness has not changed. It was ready before, it's
ready now, there's no change in readiness.

Now, the old pipe behavior was that it would wake up writers whether
they needed it or not, so epoll got woken up even if the readiness
didn't actually change.

So we do have a change in behavior.

However, clearly your test is wrong, and there is no edge difference.

Now, if this is more than just a buggy test - and it actually breaks
some actual application and real behavior - we'll need to fix it. A
regression is a regression, and we'll need to be bug-for-bug
compatible for people who depended on bugs.

But if it's only a test, and no actual workflow that got broken, then
it's just a buggy test.

[ Adding Al to the participants, not because he has anything to do
with this pipe change, but because he's been working on epoll
cleanups, and I just want him to be aware of this thread. Al - Michael
has a test program for this thing that may or may not be worth keeping
in mind ]

                  Linus
