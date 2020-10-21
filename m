Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EDF294D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442844AbgJUNJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441166AbgJUNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:09:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4291C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 06:09:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z6so2311609qkz.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8CzYNxUOxYJ9aS4i6ldcbySxqQpPBvkizlmhAVK1Co=;
        b=wRExLQTECGOE6jf/VWRwbwVxr2VzsZt3CqPfle3HfV/kirzws3CgoddXEVnYi7e/0v
         hvlUKo/f89fSMEfdji50yrCYfZmHNc72aZuxR8l7e0N/p43es+hPsodeQarDPpfHteGc
         ktEB8kylky6+cLzdbQhKtlCp+/3qqz/cjXg7D7xnMZ45HKjfrsVaZvd1US2fv+OzMdSV
         agDSrVTPk2zF6WQLhhx6427HR8wGP21QnM9iL3GWJf4Uf/SBrbI3a31F7MeaOjiT7SF3
         xH83LXe6jfcnPwC5tO/urEq9Rb6RLyTMqpBj1ipv0jkkpPCrUXDK7c+l1Zyo9O2eHkbc
         oWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8CzYNxUOxYJ9aS4i6ldcbySxqQpPBvkizlmhAVK1Co=;
        b=JNVSF5ghFYXmvN+0YE6TipYcET7OiTWd9R6SM8NMb3CfeZ4oDjDrLp8IPKtIbzehhJ
         2iyyNHFJlAZzmOcZyKC0F9sRCvr3Y7dBtQ0db2ZDmJoup6BCwyHB7FjYxom6H0oJLzY6
         vI76+zibSMg9lMAIwqrT8x5wRNbyqpxU93PKUSHO9h/TKO3hyl3fVe0CNUihRu6BIicS
         AKWBb0BA17zyMS502u+huHYcy8noHwlrb/K1lXo0HkDa4IhlKfIP/+30WLDDzFJ0EZ9X
         lFSz6ItgMld8rxLmEqiAx5jiPqe04PJh1ZKrQ9VD9L4RmEGhPB/V6wFPE+pQ52l6nCvK
         gDdw==
X-Gm-Message-State: AOAM533D1u46yd6Nh5A4AK/dtu1EzPmHv/ClyQG6vwa48T9CRclNjYRh
        iF6HHHu0ptF2/siVjqnJEBEyQdf1MWB5HEgU/okFqg==
X-Google-Smtp-Source: ABdhPJychB7r3nWhKMzXrze1M2JHn0D2/XGPU2wLFpddHzsaCbpUAVQZsHAyysxcjLj/O8PcvOF+zfMijACuDowT95M=
X-Received: by 2002:a05:620a:1188:: with SMTP id b8mr3124172qkk.265.1603285795684;
 Wed, 21 Oct 2020 06:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e921b305b18ba0a7@google.com> <000000000000f9990805b1cfab64@google.com>
In-Reply-To: <000000000000f9990805b1cfab64@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 21 Oct 2020 15:09:44 +0200
Message-ID: <CACT4Y+bWhOxXM1Owg7nPwAj6+ssZFF_VXNUTsYiwAdYysXfFQA@mail.gmail.com>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in trace_hardirqs_on
To:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:33 PM syzbot
<syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Oct 2 09:04:21 2020 +0000
>
>     lockdep: Fix lockdep recursion
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174a766f900000
> start commit:   9ff9b0d3 Merge tag 'net-next-5.10' of git://git.kernel.org..
> git tree:       net-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14ca766f900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ca766f900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d13c3fa80bc4bcc1
> dashboard link: https://syzkaller.appspot.com/bug?extid=53f8ce8bbc07924b6417
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b63310500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565657f900000
>
> Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com
> Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


This is now one of top crashers with 190K crashes in the past 12 days:
https://syzkaller.appspot.com/bug?id=e7cbd9d7047a1c4e14bbdc194a7d87de1f168289
This is now almost the only bug syzbot triggers.
