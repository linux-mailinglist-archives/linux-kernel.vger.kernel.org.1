Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0B296C64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461805AbgJWJ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461535AbgJWJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:56:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524FBC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:56:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z33so428528qth.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMRKWLCWwiDqv8Kcsdlr0JKmuLPbQM18b8vsreWvgas=;
        b=WuUaXlyVwuJrSiRaxHYD7TdqddGgQnTLrsa8KJ7dVOxgafvuDtzkyjg2w071e0RNBp
         Qs4jsEB+LkpsUP5J32oIL07oc/ifFArjSDQ7nzDRZFHQQgeBs0O8aGZ079fzFEVQ424U
         O3g2GJUS/4pfXExNQj87rA9bLZJr5U2MWRAN49TDhu2uvUzhTOYYAiEddst0aAHgV8CF
         Kdb8t04wQRAAcp15bU0Nkilr26dfoMVOBNYBnZAVcszr8hWWgv6lsvsBtUi1VosOrFIQ
         8dq3VqRfQ1ria3svhvIFn/lT4mF1DLgLpVctQYrDcw6J54e2+7x+RNKR5j7URZkUaQYu
         JCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMRKWLCWwiDqv8Kcsdlr0JKmuLPbQM18b8vsreWvgas=;
        b=cAC3zod8aRWaRoWHcSsDGPtWLhNzEupHXmS6YLh+/WCT8jAiJZfYzalYyfjB19MWuV
         sqlKWJokxCsYDmci5/f9JhdAVYCsRIAHleqwaun6CFgGTlS3LnptHpfkeGkCBJPOs6eI
         esRRfUGp4vlRI3IANte0SEaU2lv+PWrlb8TfAViN+Onwfaa7qVpzW1za97OsoSSr7Uck
         wyiT1yfIQ/Tfk/xK8kaqOTab/G5t4yY4mR6NV09CLzFF4ELblpvd3/W5+DBf8yMMJChR
         2RTBMWwxPVR/oaW1Wn1JrPuwvUAzmQxp9kRUnJm1HflGn4jyTGugpKz2F/52MiU5mBgr
         zAaA==
X-Gm-Message-State: AOAM533vpn1A6jFBpi8B9Q4zL9XXR9ofqAPuMtgXkazPdfAtv7DUZRIj
        fjk+08osCBoaQS4tGgi8luPSy42TkmXlU5w68NzQ9A==
X-Google-Smtp-Source: ABdhPJxOPLJ+Hvsi7SDoI5LsL3Hn6kijquIduRFT614kfi2coMdgJmFYW8zhqVTxpA8JoynEVepCIaNp77n0yaRxuCU=
X-Received: by 2002:ac8:c04:: with SMTP id k4mr1348416qti.66.1603446976304;
 Fri, 23 Oct 2020 02:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069b76105b00bcbfd@google.com> <00000000000055421f05b253489b@google.com>
In-Reply-To: <00000000000055421f05b253489b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 23 Oct 2020 11:56:04 +0200
Message-ID: <CACT4Y+b9naqoj4c3qaGrqwD1YsAb96zToZg8m2QCitovV9jj7g@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_newlstat
To:     syzbot <syzbot+60b38542a0dfb2e0f746@syzkaller.appspotmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 11:34 AM syzbot
<syzbot+60b38542a0dfb2e0f746@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Oct 16 12:21:14 2020 +0000
>
>     afs: Fix cell removal
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103fa33c500000
> start commit:   eff48dde Merge tag 'trace-v5.9-rc5' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
> dashboard link: https://syzkaller.appspot.com/bug?extid=60b38542a0dfb2e0f746
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ddd69b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179a69ab900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: afs: Fix cell removal
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Based on the reproducer looks right:

#syz fix: afs: Fix cell removal
