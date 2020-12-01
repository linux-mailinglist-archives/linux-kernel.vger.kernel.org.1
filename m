Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02C2CA561
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgLAOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgLAOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:14:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:13:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606832016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Skhg6O9p2Trnjrbm81ayS393ZogAa9PiayeejAPB7Ow=;
        b=Mw9HOaWVR79l72uLb07taz0LhZWUg8d2/HcmPfRcpZ4cCq6AZpzlRRr0IS9gzoIga3r+bO
        NywKzYVIGI/2M4ARyuCPl0/wuC1Xp5OFqTHMuYEFR/xerUVW4pEyqOwq9RPANMLUr8nnj6
        nK9RgMhl6/iHcXlj1MwZtbBiTQlJji+h1+OSgVyxaylqkdMQxxNPKZEBzgS1T4VuBACrXQ
        7H1zXyEIEeWWp673BEURkomaOIfS0UWl5PrTTAX9WUAp02CCJRLpzcXYMylMEtig3BnurG
        3WDPJBaoWh8ly+UtGwljZirT85nz/Lqkgx/ANbTHgmcfETrHkj5MPa/PVfoMgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606832016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Skhg6O9p2Trnjrbm81ayS393ZogAa9PiayeejAPB7Ow=;
        b=+uah8n9H51Y4ejsCR0Zmx8WPPwKY1FEz2dTA8w9rlY73cNkQ3nWGd3qzkRRjnXqZVhA9ir
        2eJhR8yltoybsLAg==
To:     Dmitry Vyukov <dvyukov@google.com>
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
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
In-Reply-To: <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com> <87h7rfi8pn.fsf@nanos.tec.linutronix.de> <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
Date:   Tue, 01 Dec 2020 15:13:36 +0100
Message-ID: <871rg9hawf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 08:59, Dmitry Vyukov wrote:
> On Wed, Sep 30, 2020 at 5:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, Sep 24 2020 at 12:01, Walter Wu wrote:
>> > Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
>> > In some of these access/allocation happened in process_one_work(),
>> > we see the free stack is useless in KASAN report, it doesn't help
>> > programmers to solve UAF on workqueue. The same may stand for times.
>> >
>> > This patchset improves KASAN reports by making them to have workqueue
>> > queueing stack and timer stack information. It is useful for programmers
>> > to solve use-after-free or double-free memory issue.
>> >
>> > Generic KASAN also records the last two workqueue and timer stacks and
>> > prints them in KASAN report. It is only suitable for generic KASAN.
>
> Walter, did you mail v5?
> Checking statuses of KASAN issues and this seems to be not in linux-next.
>
>> > [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
>> > [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers
>>
>> How are these links useful for people who do not have a gurgle account?
>
> This is a public mailing list archive, so effectively the same way as
> lore links ;)

Just that it asked me to log in last time. That's why I wrote the
above. Today it does not, odd.

Thanks,

        tglx


