Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD952E1AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgLWKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgLWKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:25:49 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97567C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 02:25:09 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 4so7358616qvh.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 02:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BIVaZ+amJIYk17hcvNRfEOZkF3f5ibxZdG/rIwdc0Yo=;
        b=WsMRU8hvXu0F0wH/5c7IygGvzENzsZgzwPb2r+VZVCSZEAHmwY5uXY9Z/eEQ9bTPJx
         OSk4SsKP/Ew9tnicsAZRgkUYpqTC9H+X7PoRLPZ8TlRyLHm65mBOlFhDNoSpCGRNpafM
         r5Mhs0Kl9EJ0oUzup5HrfkG5gCIUViqgx9AX54tQJ2I/Ue2KxNBnD1hEWnPvyN8r6d+N
         NYq0OEErJtN7Y9r55tE3x0FJVLALay9FvR7BGEaIWa40CX5iMfu0MItMiU4jmCeIgNrw
         OSR0GkCLLbPWBe+XoJx1s3S+7sVlC5uWj2rKXR/ufhwyi/9m6G1/FgrHor7wCaV14nXA
         +cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BIVaZ+amJIYk17hcvNRfEOZkF3f5ibxZdG/rIwdc0Yo=;
        b=N6SSqFhUjp3WtWSwa4z/13e/2lIWfOAOJFFx/pcYbytBWwQZLp2n34WWgEWZtfSjHW
         wBISNHJDfl8IXnHyQ+U6p3RqO0dcHwFvpW2m8QSifTfVWfVbL5FAkQpoMTZye+OpJMEr
         nib2M2ZOuIs7Q6Ci5nFBe4pqZTZuL6snvE7//eC6UMUJP7bN5Ddd5QPrV6LPQxoyOBZ2
         nKiskux7oF08hYQb8ToRzQ7XtxM9DOYoIDQyn3ZFre+AzQINoADPQtDkJDMe3LZHiZpv
         TyxG7gNpvZCmYPuSWr5J3fGvqlbpTJwe3PRXjqIJL/lc7tgUhtMp17YqTQ1CsGFLadOV
         Fkog==
X-Gm-Message-State: AOAM531vBPLHyC+2FhdaIcvAc92JGbchuPosC7rRnvmuwrPQ+4gBqKq1
        uq10MS8j3YnKnMxEz91RLyDsgVbfBfna3eAvyOcPhA==
X-Google-Smtp-Source: ABdhPJz8iGvbe3ixllpeEM440DsLvYlfTDTovSoPTiiXtRLWNKZydxThnASnGIXQw1Oh+sspyB/KsD5R5ugzc1umZMw=
X-Received: by 2002:a0c:fe90:: with SMTP id d16mr26552099qvs.13.1608719108602;
 Wed, 23 Dec 2020 02:25:08 -0800 (PST)
MIME-Version: 1.0
References: <000000000000264c6305a9c74d9b@google.com> <0000000000008647f705b6e215de@google.com>
 <CACT4Y+YnmECGRg7yOrkCQAw6OSm6TeEzOCBnJE7F32aoL0_2RQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YnmECGRg7yOrkCQAw6OSm6TeEzOCBnJE7F32aoL0_2RQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Dec 2020 11:24:57 +0100
Message-ID: <CACT4Y+b02CGQ7nfZV2+O7G+ihwiyHtN-xj6hsG1LgK-QVWtRFQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in tipc_release
To:     syzbot <syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 10:21 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Dec 20, 2020 at 10:37 AM syzbot
> <syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit cc00bcaa589914096edef7fb87ca5cee4a166b5c
> > Author: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
> > Date:   Wed Nov 25 18:27:22 2020 +0000
> >
> >     netfilter: x_tables: Switch synchronization to RCU
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1445cb37500000
> > start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3654c027d861c6df4b06
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12948233100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11344c05100000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: netfilter: x_tables: Switch synchronization to RCU
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> It's not immediately obvious that this is indeed the fix for this, but
> also not obvious that this is not the fix for this. Bisection log
> looks plausible.
> Was this bug in tipc fixed? Is it the fix?
> If I don't hear better suggestions I will close this bug as fixed by
> this commit later.

#syz fix: netfilter: x_tables: Switch synchronization to RCU
