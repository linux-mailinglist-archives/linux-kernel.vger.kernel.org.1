Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA172AEF81
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgKKLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgKKLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:21:56 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC11C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:21:55 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so981146qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GUAQtUoQBJhLZ2XitoYjqnMMxULsnKpkMbmeOjjv3M=;
        b=i2WztfGYNRVXSzvxNnLtoJr/4Y18F0RCxz3C2eRGM4x6rhFWD72gNezK491S3oTvZr
         bxSKgD8twhKNJgFXAjQhP7GQJCZyj45tUrtuCfzjZlkkUszfnUjIln+yJZq7ZRls8cWZ
         pk9/O7Z7RiwhDLpnqZ0M6vvSnTD9V9wtih6sZetU9yVGW9TlL3ObMR55SXPGgBbwcCpf
         SSQ+G62B+3GhNRnCOfNt+QCD4K5MX8lsRIhtisfWG6JHTx78hyakgdz2JeSTnU+DKKf1
         4ycpQPo0vlwJT7R4H8zgZyh769jlBxlGUvyY9s48vjFVL0zq2lojKyTaoIhfwhLA0OiR
         U9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GUAQtUoQBJhLZ2XitoYjqnMMxULsnKpkMbmeOjjv3M=;
        b=h4YdnrCe0Ftr4bF20oP3pvXgDAz8GSfUWaTq2BrN+iep+hP2TX22cXH4bASz65zl5b
         wXfKfytVt64ys9UG6lTqgMYEhs4XepjWOgycIWtPSXscXBtOYie4Pr8XemMicya4XSa7
         eCQSIklDFbKrzgNoNTDxweyFx3E6+I0NMy5dcHGjQm514VOziFzOaqUL3YJcH+1/dz5e
         iw09A/MO6WGUXO0LdVQERfQS/66ZSC1KnwEzrhhIaW//dPivjPsLtzZpNrVya0M0zwT8
         XSCIY5XBcl5vj1Mjbm0Zp8t1Svj06zEKOTmoo70jKJywELXidchzTcIWzWat7htbueqk
         WAAg==
X-Gm-Message-State: AOAM530+mfxYzFhv098GROoi+1+yAJJVHKvVe0wyHxmxfOF1gze9BnFw
        sLy0Q36MVQJIMHaaui84oBoJa28lyJdeBDs2QwhSdQ==
X-Google-Smtp-Source: ABdhPJyDE0v7Tdf0pPWY/loP/q6ceYIuUoWpw6aqnIRsODilkVJ8Mn0Tlsnm9C8PN7+XRTyi9OdzrG+9Zu6hrjw8270=
X-Received: by 2002:aed:2b47:: with SMTP id p65mr21554232qtd.337.1605093714929;
 Wed, 11 Nov 2020 03:21:54 -0800 (PST)
MIME-Version: 1.0
References: <000000000000391eaf05ac87b74d@google.com> <00000000000004632a05af787ebf@google.com>
In-Reply-To: <00000000000004632a05af787ebf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:21:43 +0100
Message-ID: <CACT4Y+ao6Sq0T1GB8wqejLh7B8VLiDsxSmrE_40BciAmtcG51Q@mail.gmail.com>
Subject: Re: INFO: task hung in io_uring_flush
To:     syzbot <syzbot+6338dcebf269a590b668@syzkaller.appspotmail.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 3:42 AM syzbot
<syzbot+6338dcebf269a590b668@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b7ddce3cbf010edbfac6c6d8cc708560a7bcd7a4
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Sat Sep 5 21:45:14 2020 +0000
>
>     io_uring: fix cancel of deferred reqs with ->files
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173d9b0d900000
> start commit:   9123e3a7 Linux 5.9-rc1
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
> dashboard link: https://syzkaller.appspot.com/bug?extid=6338dcebf269a590b668
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1573f116900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144d3072900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: io_uring: fix cancel of deferred reqs with ->files
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: io_uring: fix cancel of deferred reqs with ->files
