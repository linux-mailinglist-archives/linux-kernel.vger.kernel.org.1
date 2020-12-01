Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E22C98C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgLAIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLAIA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:00:58 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 00:00:12 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h20so518830qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 00:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wB450hvW9e7AfsLXXAZocstx55cLQvcfr6fR43xbcBE=;
        b=wJyxFNusdsDuwyAi69WN0ezTnUmElXIC+bVx2NKOZEzaA8KH5HMYRqHg18PLQ0eGWk
         kvWswi+j5rfOaoQwyLdZa3sBAJGk3mh+pORozELpaPkKZJNu+0+PJgLXbgr4dACsOCzx
         c8mOQmBc8zpik3P2XGadEWG10Syl0Cg6qi/YDuAAw29NYGbY8jpNw/lXH7HEx4yZPYKg
         cs7ZlM5JEz2qTZel7RGDRxnrGxMtFyLDr50t3lwDZWiLt37dqlJ+AjDc5feTUsL3M9rq
         IUY9087nM8OUj/xNO4f3S+6cGEhjQIpS67xHKa5BnzjWzGbspo6TfrENqDL18gUmdfmQ
         LaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wB450hvW9e7AfsLXXAZocstx55cLQvcfr6fR43xbcBE=;
        b=gtOCceAc0RLqVAGBT7LEsqeA43pNAidPpAAs40GC3dRv7lf0qCzIoSj1YnOihS2fzp
         j2oRS7jSPHVVGmtUp2z9SJ0an1uamir9MjsFx+nstGdLwiRPSFDIHRc1Xv0W8acn+tsw
         yKuP9Yf9D7tW4jApcUIhVhavD/53vm9yTrz1yFzzQopow2DaBG15Rqm+duLDtEKILO6g
         dIQ0363XUi13sGQ1OOyad1HXC52NfpDEEi+5pvgpH0ZZRUzpyTdUTD9eyb3yR3kpGq72
         vOc00pTq0tbAdNEE9Qj0+VK4Z64Zr5cA3Ezspj1gr+tkjo1a0RW7UswXIZWaylPvnRZp
         NgSQ==
X-Gm-Message-State: AOAM533s2ZHcrzK8PEd+j/wXFbzvw4mwrCmFSlGGP2V4XFMVI0chUv52
        CkHJ6H8EAdVGH5EhoPfGKQ9kAr2egJxBePKoB3hRUw==
X-Google-Smtp-Source: ABdhPJwXCE/d50QhUxDFlhDrKxp4+IR+1osE3SkqrUY+gAQJxO0ZPDV+UCHZE+6eX+bpLCu4GF1xWLqDqUEdyUloNII=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr1641518qkc.350.1606809611184;
 Tue, 01 Dec 2020 00:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com> <87h7rfi8pn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87h7rfi8pn.fsf@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Dec 2020 08:59:59 +0100
Message-ID: <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 5:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Sep 24 2020 at 12:01, Walter Wu wrote:
> > Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> > In some of these access/allocation happened in process_one_work(),
> > we see the free stack is useless in KASAN report, it doesn't help
> > programmers to solve UAF on workqueue. The same may stand for times.
> >
> > This patchset improves KASAN reports by making them to have workqueue
> > queueing stack and timer stack information. It is useful for programmers
> > to solve use-after-free or double-free memory issue.
> >
> > Generic KASAN also records the last two workqueue and timer stacks and
> > prints them in KASAN report. It is only suitable for generic KASAN.

Walter, did you mail v5?
Checking statuses of KASAN issues and this seems to be not in linux-next.

> > [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> > [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers
>
> How are these links useful for people who do not have a gurgle account?

This is a public mailing list archive, so effectively the same way as
lore links ;)
