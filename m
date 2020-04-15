Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA191A9BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896780AbgDOLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408845AbgDOLJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:09:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91134C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:09:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g74so16633042qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21hC42/qRxZDmqiUxEvzYQPrDZOJ/smRvBWWoE1k9hQ=;
        b=vvcS/23mH11jORzDN8BGcCfZvJeI826FrnG3u+asgYZjL616yu62DIXvN4L4mHRN8v
         L2mwkXiEwhvpvYYvranvuYpbFBlaCiS8JdywVkE8pyyDLAjZV2wrfEMNqxN5F6hA0JFM
         xPzIB9ihc+EQwh1lRf3VNQ4yqgX22zDAy2N0mLLHpo2AKkrhB2yb+1FqDaCjdl+fdhRa
         pzHxRoJ8HK6zqNP7CPtKx6+xSPvQ+EXt5RhNSKjPhGMfC0HC0Yv+a5M555lQPbKJ1eNL
         5Gs9DoTHmumKvr5bql4j8pBdlxxsCWamObMWPWeyLIuHNTd+ixwU/w0jqHNzja8sHO9/
         9WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21hC42/qRxZDmqiUxEvzYQPrDZOJ/smRvBWWoE1k9hQ=;
        b=ZL2F0dp2ZbWqCLXzu199QmF2zHM8kHg5fK0rwR66F7IxrML1tTK3lZ1JuqjORJ/JlK
         LLqsqb/fGm3JyRUc7gphZTsYrq1Jqkwc+zVSUJYnBR/BBIpb1eHuGdzOdKv2nDRbxjh3
         PANEmhgxLW93uPn2cVclfKeylWWlw093AMaSZ1ql/+H3+x1e4y8B+SXxfHHrnf0xqgjn
         13mJelhNweczg+AizgH+nkqykLH/QODDW2vzbz79mqOS3TwMv2yUm5VYfvEKYHZuRB8y
         Aw0yCCV+MgLwKtBDOwVd+x9PM36HGug0QpTbpmkxn/6tcfC0KPtvTbPheLk8OzPy986X
         XRPA==
X-Gm-Message-State: AGi0PuYqL8yV91FlnynpSYmXqzPzs4c/cN7R9C4Pf2jpSbidUZJ1rq3f
        dXKFrCEdPbu+2b7Lv9ODwK5yPZHOq/CH4upnb/JLVQ==
X-Google-Smtp-Source: APiQypJSkEadODH65efJa5blZDKvd61WTzbxiNRypvYGvovsgxcszhaNwzUEHkGlzlvJ9T6bppZZezWw5Pk7EPbYV2s=
X-Received: by 2002:a37:8d86:: with SMTP id p128mr26303566qkd.250.1586948984176;
 Wed, 15 Apr 2020 04:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au> <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
 <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com> <20200414192840.4yp3zqbe2tgtesve@xps.therub.org>
In-Reply-To: <20200414192840.4yp3zqbe2tgtesve@xps.therub.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Apr 2020 13:09:32 +0200
Message-ID: <CACT4Y+bi9jFKR5vHY37-RoojUiVkX6Pu69X-2F+ibo6pSCA==Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Dan Rue <dan.rue@linaro.org>
Cc:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:28 PM Dan Rue <dan.rue@linaro.org> wrote:
>
> On Tue, Apr 14, 2020 at 01:12:50PM +0200, Dmitry Vyukov wrote:
> > On Tue, Apr 14, 2020 at 12:06 AM Qian Cai <cai@lca.pw> wrote:
> > > Well, there are other CI's beyond syzbot.
> > > On the other hand, this makes me worry who is testing on linux-next every day.
> >
> > How do these use-after-free's and locking bugs get past the
> > unit-testing systems (which syzbot is not) and remain unnoticed for so
> > long?...
> > syzbot uses the dumbest VMs (GCE), so everything it triggers during
> > boot should be triggerable pretty much everywhere.
> > It seems to be an action point for the testing systems. "Boot to ssh"
> > is not the best criteria. Again if there is a LOCKDEP error, we are
> > not catching any more LOCKDEP errors during subsequent testing. If
> > there is a use-after-free, that's a serious error on its own and KASAN
> > produces only 1 error by default as well. And as far as I understand,
> > lots of kernel testing systems don't even enable KASAN, which is very
> > wrong.
> > I've talked to +Dan Rue re this few days ago. Hopefully LKFT will
> > start catching these as part of unit testing. Which should help with
> > syzbot testing as well.
>
> LKFT has recently added testing with KASAN enabled and improved the
> kernel log parsing to catch more of this class of errors while
> performing our regular functional testing.
>
> Incidentally, -next was also broken for us from March 25 through April 5
> due to a perf build failure[0], which eventually made itself all the way
> down into v5.6 release and I believe the first two 5.6.x stable
> releases.
>
> For -next, LKFT's gap is primarily reporting. We do build and run over
> 30k tests on every -next daily release, but we send out issues manually
> when we see them because triaging is still a manual effort. We're
> working to build better automated reporting. If anyone is interested in
> watching LKFT's -next results more closely (warning, it's a bit noisy),
> please let me know. Watching the results at https://lkft.linaro.org
> provides some overall health indications, but again, it gets pretty
> difficult to figure out signal from noise once you start drilling down
> without sufficient context of the system.

What kind of failures and noise do you get? Is it flaky tests?
I would assume build failures are ~0% flaky/noisy. And boot failures
are maybe ~1% flaky/noisy due to some infra issues.

I can't find any actual test failure logs in the UI. I've got to this page:
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-rc1-24-g8632e9b5645b/testrun/1363280/suite/kselftest/tests/
which seem to contain failed tests on mainline. But I still can't find
the actual test failure logs.


> Dan
>
> [0] https://lore.kernel.org/stable/CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com/
>
> --
> Linaro LKFT
> https://lkft.linaro.org
