Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24F20D8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgF2Tlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgF2Tlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:41:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D24C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:41:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so16412391qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvdDQWAT9Z1b4tHlY2KQ+Wb11SVaesY+vPIQJ1iufDY=;
        b=HWSftGfFhpY45fPy7VC+cdsQ/Po0jzPrZQNmUtOCkM8OGbVOH+RnvN5bi3ioCkrqhy
         Glwz6OtqSDkSsxh2JcQZqlUOechGWpxo/iXVO1UmSf4pQrKdXgCbuwivQ8G32n0XYol2
         elUQuh2gf8XMT12Qe8yzTazj1rhPUtPM7KWJdT3Bhcbu9ETe3ADUOoIHEUkMNrdKBrHm
         WbhAOmfTPlBSNyWVvFAO1M9zWtm3iJK9FRCM9wJ1PkpR9aKDUmLc73e7xHqZ69fxUKYc
         THiFKTecK4CdTMI1NiLDTu1I3uuh/JB0RhqpvNwYLaJ0RIf5YuxSkmxacUcMYL6yUENV
         7AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvdDQWAT9Z1b4tHlY2KQ+Wb11SVaesY+vPIQJ1iufDY=;
        b=tIDUAlrFqWEi/5KueuKhx2JRG4Ed+FEdFOolxWBAeGFklqpWH/Rpru4z7XcXGygs+2
         xe0GKptOXAt0upGw+l4AILYbZ98yulFNy0HJ6cMDoczrC/nfCwmdC5qUR8ghLJPAmaDc
         Yvb6LH330PdcwuJfc+Hb5kSqk+OPYNQtS1ULXuVDFSueeMMgUjZQxFrOeJCnz63Rc5RS
         BgL40ET3wrzdWBb+OcT3Dq7dnGSZ4BinrzxuOTZYfrvSWiXEj/WFItfvc4W3aGW2rYcf
         JEc7aGzlqy39Pa6r+/+wD6/IpXJHo9oQeDEl0lpkrXi5ajdD4mARrZVnk6uyGxmV+NRH
         c7lg==
X-Gm-Message-State: AOAM531ViNYf9R/nVhaSupJO3YywCtJCEsW6OE0Jq2shwF1NF7l6/U0P
        eBnj6ZjyJ4csGn25wppIWzJIAkAbFTfJ42X+Qktb6g==
X-Google-Smtp-Source: ABdhPJym2+ZxxMc80cE9zQefSkfB/DFa2F6Ga0IhHiGx/uZihQ9c950v7wLi4cPLxYn3pL2TcfRcNPT9qrbCtEXeEcw=
X-Received: by 2002:a37:4f0e:: with SMTP id d14mr17080420qkb.8.1593459699006;
 Mon, 29 Jun 2020 12:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000107b4605a7bdce7d@google.com> <20200614085321.8740-1-hdanton@sina.com>
 <20200627130205.16900-1-hdanton@sina.com> <20200627222527.GC25301@ziepe.ca>
 <CACT4Y+ab1q7fON3rkj+FHODPQXDGyP5c0tJt7gbrpmsAAYRb1g@mail.gmail.com>
 <CACT4Y+Zjw=ru-Sqs-V7cP0Exgu7g0jWBXcPeVKnLqpbkS-wDRg@mail.gmail.com> <20200629192255.GE25301@ziepe.ca>
In-Reply-To: <20200629192255.GE25301@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Jun 2020 21:41:27 +0200
Message-ID: <CACT4Y+bWgEMuSoYKf4GQdfH1VZi_vpDJZ6q3gUZ-6Ce=OsrCuA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>,
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

On Mon, Jun 29, 2020 at 9:22 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Sat, Jun 27, 2020 at 09:02:05PM +0800, Hillf Danton wrote:
> > > > > > So, to hit this syzkaller one of these must have happened:
> > > > > >  1) rdma_addr_cancel() didn't work and the process_one_work() is still
> > > > > >     runnable/running
> > > > >
> > > > > What syzbot reported indicates that the kworker did survive not only
> > > > > canceling work but the handler_mutex, despite it's a sync cancel that
> > > > > waits for the work to complete.
> > > >
> > > > The syzbot report doesn't confirm that the cancel work was actaully
> > > > called.
> > > >
> > > > The most likely situation is that it was skipped because of the state
> > > > mangling the patch fixes..
> > > >
> > > > > >  2) The state changed away from RDMA_CM_ADDR_QUERY without doing
> > > > > >     rdma_addr_cancel()
> > > > >
> > > > > The cancel does cover the query state in the reported case, and have
> > > > > difficult time working out what's in the patch below preventing the
> > > > > work from going across the line the sync cancel draws. That's the
> > > > > question we can revisit once there is a reproducer available.
> > > >
> > > > rdma-cm never seems to get reproducers from syzkaller
> > >
> > > +syzkaller mailing list
> > >
> > > Hi Jason,
> > >
> > > Wonder if there is some systematic issue. Let me double check.
> >
> > By scanning bugs at:
> > https://syzkaller.appspot.com/upstream
> > https://syzkaller.appspot.com/upstream/fixed
> >
> > I found a significant number of bugs that I would qualify as "rdma-cm"
> > and that have reproducers. Here is an incomplete list (I did not get
> > to the end):
> >
> > https://syzkaller.appspot.com/bug?id=b8febdb3c7c8c1f1b606fb903cee66b21b2fd02f
> > https://syzkaller.appspot.com/bug?id=d5222b3e1659e0aea19df562c79f216515740daa
> > https://syzkaller.appspot.com/bug?id=c600e111223ce0a20e5f2fb4e9a4ebdff54d7fa6
> > https://syzkaller.appspot.com/bug?id=a9796acbdecc1b2ba927578917755899c63c48af
> > https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> > https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
> > https://syzkaller.appspot.com/bug?id=805ad726feb6910e35088ae7bbe61f4125e573b7
> > https://syzkaller.appspot.com/bug?id=56b60fb3340c5995373fe5b8eae9e8722a012fc4
> > https://syzkaller.appspot.com/bug?id=38d36d1b26b4299bf964d50af4d79688d39ab960
> > https://syzkaller.appspot.com/bug?id=25e00dd59f31783f233185cb60064b0ab645310f
> > https://syzkaller.appspot.com/bug?id=2f38d7e5312fdd0acc979c5e26ef2ef8f3370996
> >
> > Do you mean some specific subset of bugs by "rdma-cm"? If yes, what is
> > that subset?
>
> The race condition bugs never seem to get reproducers, I checked a few
> of the above and these are much more deterministic things.
>
> I think the recurrance rate for the races is probably too low?

Yes, it definitely may depend on probability. There is usually a
significant correlation with the number of crashes. This bug happened
only once, that usually means either a very hard to trigger race
condition, or a previous induced memory corruption. For harder to
trigger race conditions, KCSAN (the data race detector) may help in
future. However, kernel has too many races to report them to mailing
lists:
https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
Though, some race conditions are manageable to trigger and I think we
have hundreds of race conditions with reproducers on the dashboard.
