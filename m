Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC62767F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIXEoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgIXEoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:44:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AEC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:44:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so1993152qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7vjrQJZYzl4t7Qzc5KyxPFIRvduWYaGYi63oEfRsSI=;
        b=Qk1E42fUukf9NVQ2u+9O+CHzmuUlFc7MYp60iMLwLZSIe0tTue7YzLfbGshaz7ti7n
         npvEqBZOXEpLbv6hBSoIM8MRrnDaUbGjPe9kf3gssjHp590RTESz7CMWsORV0LOOY1FV
         D//RX/fSxSVUFgcxH/sHepAr/zmnPhODfkJCV/yKadUsEp4kH5lxJBkhRGYyfo11aWWF
         c00vDOcRtoCvCUsqS2jgoQH7peV+EANNP6HM/6fwRtLYXWdLgkPsex0FRl5Szf23bw4u
         B/tIw/gOt4Ac/0AGfAhDTnYl/Py0on9BgoVOfH/Ohp04pupKXEFEgwq0CBFWK8dp2mU1
         iCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7vjrQJZYzl4t7Qzc5KyxPFIRvduWYaGYi63oEfRsSI=;
        b=pApDd4FFmbaz9/z/lgL78wGpqL1WBdTr9AQJm/V6piMPpuAulLwg8/YQCdyW5LSMv6
         NdIWzebh4rSQaLUFGTJKKm47nEJKU/OT/A/xmM4Zx9O7MTxFadzEoyrzYBMaLy/9fk4L
         +sW5+MNX5tP9eK7XYtPF7rZq1KUm1GrNNDXLb+POI+AS82J1vTBkbwHbzCDsmyyoPFnd
         JiWjegzrwkclQoQ1Vp1DuH8Yc8JiiJK8suzo4Vj90eWn//bU0/An/Z2QY7MMqHmWZQS+
         hc902Ynt1Ppfs1ORxxFkyOJW4EdOLTxTvIP3N/EJeWeKzf1YOjMlktARVZbhRmy10NO5
         fO/w==
X-Gm-Message-State: AOAM532sSMaqBhm/v6j3IKh2owOIVHqNbZIpSabMwq65H7oOqNrM/v92
        rREYsUlCgEgbDMef3Jp3NG/J1xgX6E070AaU3sLz9aYBM6x6jw==
X-Google-Smtp-Source: ABdhPJxD/oeIf+kXVjbVQ+G5XT9T2kSedQdO/fsZYKCHT7vsFt/CdcBUVyBAW0y09XJOUMW/4wP5wxavspD0xicoq1Y=
X-Received: by 2002:aed:26a7:: with SMTP id q36mr3561207qtd.57.1600922663684;
 Wed, 23 Sep 2020 21:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056c1dc05afc47ddb@google.com> <20200924043554.GA9443@gondor.apana.org.au>
In-Reply-To: <20200924043554.GA9443@gondor.apana.org.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Sep 2020 06:44:12 +0200
Message-ID: <CACT4Y+aw+Z_7JwDiu65hL7K99f1oBfRFavZz4Pr4o8Us5peH4g@mail.gmail.com>
Subject: Re: possible deadlock in xfrm_policy_delete
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     syzbot <syzbot+c32502fd255cb3a44048@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 6:36 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sun, Sep 20, 2020 at 01:22:14PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5fa35f24 Add linux-next specific files for 20200916
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1122e2d9900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6bdb7e39caf48f53
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c32502fd255cb3a44048
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c32502fd255cb3a44048@syzkaller.appspotmail.com
> >
> > =====================================================
> > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > 5.9.0-rc5-next-20200916-syzkaller #0 Not tainted
> > -----------------------------------------------------
> > syz-executor.1/13775 [HC0[0]:SC0[4]:HE1:SE0] is trying to acquire:
> > ffff88805ee15a58 (&net->xfrm.xfrm_policy_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:359 [inline]
> > ffff88805ee15a58 (&net->xfrm.xfrm_policy_lock){+...}-{2:2}, at: xfrm_policy_delete+0x3a/0x90 net/xfrm/xfrm_policy.c:2236
> >
> > and this task is already holding:
> > ffff8880a811b1e0 (k-slock-AF_INET6){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
> > ffff8880a811b1e0 (k-slock-AF_INET6){+.-.}-{2:2}, at: tcp_close+0x6e3/0x1200 net/ipv4/tcp.c:2503
> > which would create a new lock dependency:
> >  (k-slock-AF_INET6){+.-.}-{2:2} -> (&net->xfrm.xfrm_policy_lock){+...}-{2:2}
> >
> > but this new dependency connects a SOFTIRQ-irq-safe lock:
> >  (k-slock-AF_INET6){+.-.}-{2:2}
> >
> > ... which became SOFTIRQ-irq-safe at:
> >   lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >   spin_lock include/linux/spinlock.h:354 [inline]
> >   sctp_rcv+0xd96/0x2d50 net/sctp/input.c:231
>
> What's going on with all these bogus lockdep reports?
>
> These are two completely different locks, one is for TCP and the
> other is for SCTP.  Why is lockdep suddenly beoming confused about
> this?
>
> FWIW this flood of bogus reports started on 16/Sep.


FWIW one of the dups of this issue was bisected to:

commit 1909760f5fc3f123e47b4e24e0ccdc0fc8f3f106
Author: Ahmed S. Darwish <a.darwish@linutronix.de>
Date:   Fri Sep 4 15:32:31 2020 +0000

    seqlock: PREEMPT_RT: Do not starve seqlock_t writers

Can it be related?


A number of other new lockdep reports were bisected to the following
one, which was true intentional root cause of these, but it looks a
bit too old to cause the xfrm reports:

commit f08e3888574d490b31481eef6d84c61bedba7a47
Author: Boqun Feng <boqun.feng@gmail.com>
Date: Fri Aug 7 07:42:30 2020 +0000

  lockdep: Fix recursive read lock related safe->unsafe detection
