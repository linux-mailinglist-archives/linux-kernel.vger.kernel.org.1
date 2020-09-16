Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB126C95D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgIPTHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgIPRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:44:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B2C0698CB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:28:34 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b13so3319460qvl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnKcSlNkQR35LZf6iND6zHQpJOWDy/dSu0BrUtUSzkE=;
        b=LbcnFSLBii35TjI4Hw5pPUs1/st3gHYC+ASBPFwHWMKMpNzK2VB2UixcZ/j9kJRgSO
         k/xy69mEwCXzw3XZeqk8eX47sZ3+aZ8shmj6m1AGrUbViI8jmB1Md9rRtUcrudBLJe6j
         retA+MwIvQa2N7Hj4kUyxSibd7QVqw8ptlyKIBw8yoOaSLBRSjisGs7QwajJHnqV9Nhk
         9PT87+aV1o5dVkn+/J6yffrnFkyvLchUprUGWWAFAEQsSwHA0ldI3r+b2LBb40yKa/iO
         zoT5OnR1OqrfwEMGJTdBQJEauDuudHtB7jS+F7gbztZ6D3rHEu23lAXKQP8HX8BFwpc+
         UGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnKcSlNkQR35LZf6iND6zHQpJOWDy/dSu0BrUtUSzkE=;
        b=mwo9rO1gBvC6RITSjKsgFq5maEj5qVkAVViKGt77kVqeNlzxqNIv76vJA/0JUrdki9
         VhY8N8Q/1FERx/uGJ0vBuPyBlxMGZWKahZvLf7/TNn5iBZB0xzW+rVqQreTi4W/vTDof
         naDROjKznjtXhiF0pg+a5epoRJdCDiCWMyAfVUYSISiwHsEgP7rQcjpRDxuOPL/jWOMy
         e8YbHBly4uIkX1nzFvBzj1Tjf1hqmEg94T4VO/UkbnFjr/gxGqa7Nr5MDgRSs4sMf/D5
         rZvoDsttVj1By04NOsbbZ0HfwNRsRzxG5Q2bFz2dRaZ1G+MiD9lP2OXnIEXVez0iHGGI
         9syQ==
X-Gm-Message-State: AOAM532cKRdc3njrby1NFL9gwvXOGvYbLFJ8KRW6E/rVBDSfWXWFvfi5
        rvTQzrUXFWkZfI0VIdvMU4elzniMRaX8MqlgjtOTUA==
X-Google-Smtp-Source: ABdhPJzV6FkEuZbmAv7oARvd/eh2RnB+dgMffb2TR9yN0gIClEXp5egnd6G5hCJ9qchy7RbOzo6GZmxnYvrPUwb2qFU=
X-Received: by 2002:ad4:4e33:: with SMTP id dm19mr6414279qvb.47.1600255711033;
 Wed, 16 Sep 2020 04:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp> <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
In-Reply-To: <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Sep 2020 13:28:19 +0200
Message-ID: <CACT4Y+bjPr=64Lq1-ARD6T=K9LmC_Aor4BRXPcZVtUU8vF0oGg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:05 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello. Can we apply this patch?
>
> This patch addresses top crashers for syzbot, and applying this patch
> will help utilizing syzbot's resource for finding other bugs.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Peter, do you still have concerns with this?

Both MAX_LOCKDEP_ENTRIES and MAX_LOCKDEP_CHAINS still fire on syzbot a
lot and harm ability to test whole kernel:
https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
https://syzkaller.appspot.com/bug?id=63fc8d0501c39609dd2f268e4190ec9a72619563

I hate disabling lockdep entirely as it also finds lots of useful things.


> On 2020/08/28 0:20, Tetsuo Handa wrote:
> > Since syzkaller continues various test cases until the kernel crashes,
> > syzkaller tends to examine more locking dependencies than normal systems.
> > As a result, syzbot is reporting that the fuzz testing was terminated
> > due to hitting upper limits lockdep can track [1] [2] [3].
> >
> > Let's allow individually tuning upper limits via kernel config options
> > (based on an assumption that there is no inter-dependency among these
> > constants).
> >
> > [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> > [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
> > [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
> >
> > Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
> > Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
> > Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  kernel/locking/lockdep.c           |  2 +-
> >  kernel/locking/lockdep_internals.h |  8 +++---
> >  lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
> >  3 files changed, 45 insertions(+), 5 deletions(-)
> >
