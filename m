Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5C29C79D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371112AbgJ0Skf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:40:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43419 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368559AbgJ0Skf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:40:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id f93so1757007qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A71w7yxcxJWosYwjYFtKyzjRaHmNMuK6z2oSv7nSpPg=;
        b=QPZgQo402e3z2dTd9e8kFd37vYAcbcvHxB22tHs8SiPwFdK+G2nPYISXeHQFpeJQ+c
         IYPfkOie+ybsJTbQH9PD6PDIEdpFCyzT3BnhqXTCJMHjk9JuSJuzGjfZiVgIPGjYzdAH
         Xg0XiQGOES05DCBHAI8hw8yRQ1Fwzf5bjP2CKZkdxFa9h86BUUcY4Q7HLhq06Be8uve4
         YdMpHZc5WuQTf6u/Pm5YZG7cPc5xLuSL6tc1bPSNtgYZ+jdfAHpD30spBxc2Ya4snQ5D
         fNsJFm9+TzCRM+z+NSyc4nu1y+1HeqW2Kdq34YG3tY6iqbpos1fIuUkLYkr4lcstG7P/
         oLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A71w7yxcxJWosYwjYFtKyzjRaHmNMuK6z2oSv7nSpPg=;
        b=JWCEgzTBBH5uncVw09vxdCb/tT/FGV/CCeI1TLZfYXYG9dP9OMDadyFgNgNSfQNv/7
         QApKSbUaLb+7zVwsjaspGL2mOURXFlS+MyVFcqMdHqC+JEpxfwr87qgxUet26Z89veZG
         qdp4jt99MFmdacVKp2gYgQj0NYkF7yEh25D9qVHcZBaS4Z81t1rhSKmMmWftwyXdepUC
         5M7mfyJxCRqKXCw9zGKecHXWk9enm3kbd30VGiYkiHZNFZ1rdu1JXEoLwRrnScUtMv34
         AN32P9KBuqx9fl4qBgO1Gb28CirfD62gV7z+dUCr4htzmA5WsFyKEsaUj0y+L97ksEMT
         jZ0A==
X-Gm-Message-State: AOAM532VvM+y0VWAbfItwbQqK7gyrq3Od0Wu9uc9en8ireCSX5T2ULu7
        SWFTb+2dEfjMj47lyuRNoJxghog4uLNkS08HE6zTZxC3iPxk6g==
X-Google-Smtp-Source: ABdhPJwQrITXfyaoMy1HWvBG+LeYx2HqH/pHaz3wycxt5T39PYbcFZDQQojSCEY/nvqDn1FfRoWe99vnETreqNTEtNQ=
X-Received: by 2002:ac8:44b1:: with SMTP id a17mr3587453qto.43.1603824031886;
 Tue, 27 Oct 2020 11:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201027175810.GA26121@paulmck-ThinkPad-P72>
In-Reply-To: <20201027175810.GA26121@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 19:40:19 +0100
Message-ID: <CACT4Y+bB4sZjLx6tL6F5XzxGk5iG7j=SPbDkX_bwRXmXB=JxXA@mail.gmail.com>
Subject: Re: Recording allocation location for blocks of memory?
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 6:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> I have vague memories of some facility some time some where that recorded
> who allocated a given block of memory, but am not seeing anything that
> does this at present.  The problem is rare enough and the situation
> sufficiently performance-sensitive that things like ftrace need not apply,
> and the BPF guys suggest that BPF might not be the best tool for this job.
>
> The problem I am trying to solve is that a generic function that detects
> reference count underflow that was passed to call_rcu(), and there are
> a lot of places where the underlying problem might lie, and pretty much
> no information.  One thing that could help is something that identifies
> which use case the underflow corresponds to.
>
> So, is there something out there (including old patches) that, given a
> pointer to allocated memory, gives some information about who allocated
> it?  Or should I risk further inflaming the MM guys by creating one?  ;-)

Hi Paul,

KASAN can do this. However (1) it has non-trivial overhead on its own
(but why would you want to debug something without KASAN anyway :))
(2) there is no support for doing just stack collection without the
rest of KASAN (they are integrated at the moment) (3) there is no
public interface function that does what you want, though, it should
be easy to add it. The code is around here:
https://github.com/torvalds/linux/blob/master/mm/kasan/report.c#L111-L128

Since KASAN already bears all overheads of stack collection/storing I
was thinking that lots of other debugging tools could indeed piggy
back on that and print much more informative errors message when
enabled with KASAN.

Since recently KASAN also memorizes up to 2 "other" stacks per
objects. This is currently used to memorize call_rcu stacks, since
they are frequently more useful than actual free stacks for
rcu-managed objects.
That mechanism could also memorize last refcount stacks, however I
afraid that they will evict everything else, since we have only 2
slots, and frequently there are lots of refcount operations.
