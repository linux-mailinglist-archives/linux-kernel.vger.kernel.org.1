Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC220D258
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgF2Ssh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgF2Sro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DCC031C4A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:27:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o38so13451600qtf.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+h1WtSND1gZmFF1Lpj+XH5zZAhc+/M8o2aQRQdjh50=;
        b=vN4jQV/XHQ40iIH2MPATkDhQ9XYk5JOA4Cu18nURwdyM7Ht8324JB4h7QnrcbHSh0R
         uKKcYQU4Tmo37sWRyrYkZhvqqYzG/9ZXo5l9eyiCVc19l9Dbr/LHunoO8LapcliqcnSD
         3LhMUJkZ297hLPjw3jyZJv+TWE7c2KvXMhEaZDDuaFMIGXEHIumNwmEWUiJ862xyVmqm
         MJAfw/iY0wlRX2S10wNuLITTVXcfVN3BLWNyw66SBI6+zrw+HQX3JlHnLtj6AqxbmY24
         n6CHFe1Ehezl1qZ1Vka9N9dQ4cSLMzyuhl7Gu4Yq6Oi447DXbCbTo6nObrKVcHTc25Se
         S9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+h1WtSND1gZmFF1Lpj+XH5zZAhc+/M8o2aQRQdjh50=;
        b=VI06QvX5pOONEjdgOWeoevzMZN4juFA7z4PpoEcplEtL6R4vkTLsd6dV0BNdg76vmM
         WDVNq8b/CnrKrGcX/LkjWDvHpP3d3IspUhE47VIq4pYULL1PKJR6T8qkGW6dkgpuh+VX
         WO8vHfgeDbpndZfkWeiD2yxN0xJPh2TllmMzkAVCmEpWiBsRpLw50Z6Jqo1MWiR1vpPt
         +iQ0qi11b5ilpBwEhOmPYziuEXtlNTkOyTwrg4hzq0YWIMfbKwEaUDUWoTSqfGoG3/6C
         P1zT14jXpBeKZUgQcTi1YfeXKk2pdley4mUUQ+h14VAWMddhyv5RIo9lMMqz6ZrVN9Zl
         e4OQ==
X-Gm-Message-State: AOAM533MTXm7X3SyAdw6AADSlvo5bavbbx0ov9lvYz7qw2c40a2Bqwlz
        Hz/L2euvYbsQ7cNRwdO+OA4gZzdpVjAkvvnhM/Xgqw==
X-Google-Smtp-Source: ABdhPJwBDrl7Z6joBJSwfnK/ZIszLge5SHZULmIYamE/+wcJ4SgCb9HG2qDHpPbGVSJJDzFUwOdk4bos+M1tWqEEmog=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr17039578qtu.380.1593451672211;
 Mon, 29 Jun 2020 10:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000107b4605a7bdce7d@google.com> <20200614085321.8740-1-hdanton@sina.com>
 <20200627130205.16900-1-hdanton@sina.com> <20200627222527.GC25301@ziepe.ca> <CACT4Y+ab1q7fON3rkj+FHODPQXDGyP5c0tJt7gbrpmsAAYRb1g@mail.gmail.com>
In-Reply-To: <CACT4Y+ab1q7fON3rkj+FHODPQXDGyP5c0tJt7gbrpmsAAYRb1g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Jun 2020 19:27:40 +0200
Message-ID: <CACT4Y+Zjw=ru-Sqs-V7cP0Exgu7g0jWBXcPeVKnLqpbkS-wDRg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        parav@mellanox.com, Markus Elfring <Markus.Elfring@web.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 4:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Jun 28, 2020 at 12:25 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Jun 27, 2020 at 09:02:05PM +0800, Hillf Danton wrote:
> > > > So, to hit this syzkaller one of these must have happened:
> > > >  1) rdma_addr_cancel() didn't work and the process_one_work() is still
> > > >     runnable/running
> > >
> > > What syzbot reported indicates that the kworker did survive not only
> > > canceling work but the handler_mutex, despite it's a sync cancel that
> > > waits for the work to complete.
> >
> > The syzbot report doesn't confirm that the cancel work was actaully
> > called.
> >
> > The most likely situation is that it was skipped because of the state
> > mangling the patch fixes..
> >
> > > >  2) The state changed away from RDMA_CM_ADDR_QUERY without doing
> > > >     rdma_addr_cancel()
> > >
> > > The cancel does cover the query state in the reported case, and have
> > > difficult time working out what's in the patch below preventing the
> > > work from going across the line the sync cancel draws. That's the
> > > question we can revisit once there is a reproducer available.
> >
> > rdma-cm never seems to get reproducers from syzkaller
>
> +syzkaller mailing list
>
> Hi Jason,
>
> Wonder if there is some systematic issue. Let me double check.

By scanning bugs at:
https://syzkaller.appspot.com/upstream
https://syzkaller.appspot.com/upstream/fixed

I found a significant number of bugs that I would qualify as "rdma-cm"
and that have reproducers. Here is an incomplete list (I did not get
to the end):

https://syzkaller.appspot.com/bug?id=b8febdb3c7c8c1f1b606fb903cee66b21b2fd02f
https://syzkaller.appspot.com/bug?id=d5222b3e1659e0aea19df562c79f216515740daa
https://syzkaller.appspot.com/bug?id=c600e111223ce0a20e5f2fb4e9a4ebdff54d7fa6
https://syzkaller.appspot.com/bug?id=a9796acbdecc1b2ba927578917755899c63c48af
https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
https://syzkaller.appspot.com/bug?id=805ad726feb6910e35088ae7bbe61f4125e573b7
https://syzkaller.appspot.com/bug?id=56b60fb3340c5995373fe5b8eae9e8722a012fc4
https://syzkaller.appspot.com/bug?id=38d36d1b26b4299bf964d50af4d79688d39ab960
https://syzkaller.appspot.com/bug?id=25e00dd59f31783f233185cb60064b0ab645310f
https://syzkaller.appspot.com/bug?id=2f38d7e5312fdd0acc979c5e26ef2ef8f3370996

Do you mean some specific subset of bugs by "rdma-cm"? If yes, what is
that subset?
