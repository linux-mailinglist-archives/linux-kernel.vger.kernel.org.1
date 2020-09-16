Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0826C73E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgIPSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgIPSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:09:17 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542FC02B8C2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:14:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b2so1159696qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Xbnktyhb9WFDAxiYS4WBTdEl5zwV8oooRagE02H28Q=;
        b=O9iue7DFM0C0fMvpQTb/en9DF5Peqm1IRWDZ/2HLqA3NAMA4dplbaveetPHUNKbI2B
         hHXo1npQenyDC/Jes0H08n83h8MpUodySpfwjlIh9cTrsx39P+KxRosDsNcj/yY4kEiS
         FifgLyPzzII2OBnnF5z5X86ELPHY1JlsTlfIz8stfbLcaK7RxN1WzbifRuk8xVMQo9oL
         O7XhaaMzzq3TqpoIAs7YZAGaslFDeMJD+Hh57gIVzzScSpEgcv5mkcNhtyaIyp8SGYQT
         iJWNMDWyvTShNWoE38x3LEitrberwD3B3UFfHHX4/q8Km9BStX0KqYOXhBW9zIwqKmYg
         hyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Xbnktyhb9WFDAxiYS4WBTdEl5zwV8oooRagE02H28Q=;
        b=KNsxpoMmEV8jRBRosp+0zvAo1cG96CzUV8tJZjiRbAj605gNgcertpBAxiXLtlxaYX
         Dlc5RIhqATuMcfwCOC7zJmZYSq077ySPqeNo49nMn2eoV+7ZkU83vLv6noWGgb5h+xt4
         GzWSlf+uuvNajYriPl4KcpSORRO7mBeOQH0Hvh7Ka00bMKdKFuTVGw1kxgv9U2aVL468
         EpQmi86kjQDZ43ZGO8XGjn8JN34yS89CMxInuFz4uz2b1MW0+Wzrc9ckJi0Pfqmj6U8Q
         dMDlDxQWeRMxpMHR+gteZBXOIOwsk58sHiOCLTO28NXq1ZDnrL2ab4cxh6Apkm9Pz8Ua
         VM3g==
X-Gm-Message-State: AOAM5323dmWyMzCoZpQJevzNHCe9sNRdoXLsJMnvCgMCDcbgYpIPHkxm
        SK38CiM4AviYs+5SOZFdkvPIM5J37N2Ne0YDPyyyPQ==
X-Google-Smtp-Source: ABdhPJz9hl+ql/G7KsG6GCCB3DH6ja/PjLgOIbxONlOCd+8u2KC9lkeF2J51UlMuEo9JHwAhKill2G6dnSDuoU3FHAc=
X-Received: by 2002:aed:26a7:: with SMTP id q36mr22023441qtd.57.1600258454063;
 Wed, 16 Sep 2020 05:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
 <CACT4Y+bjPr=64Lq1-ARD6T=K9LmC_Aor4BRXPcZVtUU8vF0oGg@mail.gmail.com> <20200916115057.GO2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200916115057.GO2674@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Sep 2020 14:14:02 +0200
Message-ID: <CACT4Y+agTiEF-1i9LbAgp-q_02oYF0kAPZGAAJ==-wx2Xh7xzQ@mail.gmail.com>
Subject: Re: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 1:51 PM <peterz@infradead.org> wrote:
>
> On Wed, Sep 16, 2020 at 01:28:19PM +0200, Dmitry Vyukov wrote:
> > On Fri, Sep 4, 2020 at 6:05 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > Hello. Can we apply this patch?
> > >
> > > This patch addresses top crashers for syzbot, and applying this patch
> > > will help utilizing syzbot's resource for finding other bugs.
> >
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > Peter, do you still have concerns with this?
>
> Yeah, I still hate it with a passion; it discourages thinking. A bad
> annotation that blows up the lockdep storage, no worries, we'll just
> increase this :/
>
> IIRC the issue with syzbot is that the current sysfs annotation is
> pretty terrible and generates a gazillion classes, and syzbot likes
> poking at /sys a lot and thus floods the system.
>
> I don't know enough about sysfs to suggest an alternative, and haven't
> exactly had spare time to look into it either :/
>
> Examples of bad annotations is getting every CPU a separate class, that
> leads to nr_cpus! chains if CPUs arbitrarily nest (nr_cpus^2 if there's
> only a single nesting level).

Maybe on "BUG: MAX_LOCKDEP_CHAINS too low!" we should then aggregate,
sort and show existing chains so that it's possible to identify if
there are any worst offenders and who they are.

Currently we only have a hypothesis that there are some worst
offenders vs lots of normal load. And we can't point fingers which
means that, say, sysfs, or other maintainers won't be too inclined to
fix anything.

If we would know for sure that lock class X is guilty. That would make
the situation much more actionable.
