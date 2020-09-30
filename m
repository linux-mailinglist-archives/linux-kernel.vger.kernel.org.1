Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1BA27E277
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgI3HSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:18:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6537C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:18:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601450320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=qszLRp610KM1evPqkHZZ4TULFEPMDDCHrKhOHL9Calg=;
        b=oiDx8cqR1gH1cdVjlJen0MXBF5n8GWSksV5LbQFnVNUFTDAVQ5203uT+YL7zNshQD4TQDs
        aKH9y+x9be8PyF3THnjZdJlSsCxeYT3XilhNQoZvmntlzvJy4sKP8nyT2emK+f/Epte8RZ
        0YGtL/lotU0E4Qb6IerdeyKMVrxYslKZxSO3r0ZLAy8drw6mQfXJeZpHILvxAQ/rKNclxh
        rbMHzuHgZTJfKn2Z36yQsU4LCS+4tSkT0BoqLbxHHJMqndM3V+rQmyZt/WU5wIvSZ38aBj
        cSmKdHSyPQOGnVc4mM+MGVEMqCOKdC41fknNGgSVaE09nW5KEDjtPqZmEUdZAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601450320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=qszLRp610KM1evPqkHZZ4TULFEPMDDCHrKhOHL9Calg=;
        b=VxLi47jxjLMA/8KfOfQluB5H9tdiNpLA5xhADYI/Ahx5Yeo3d9xZB/suOR+oCyxtAJYNp3
        kzZ8RbirgaX6ugDA==
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/6] timer: kasan: record timer stack
In-Reply-To: <1601140312.15228.12.camel@mtksdccf07>
Date:   Wed, 30 Sep 2020 09:18:40 +0200
Message-ID: <87pn63ivfz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walter,

On Sun, Sep 27 2020 at 01:11, Walter Wu wrote:
> First, I think the commit log =E2=80=9CBecause if the UAF root cause is i=
n timer
> init =E2=80=A6=E2=80=9D needs to be removed, this patch hopes to help pro=
grammer gets
> timer callback is where is registered. It is useful only if free stack
> is called from timer callback, because programmer can see why & where
> register this function.
>
> Second, see [1], it should satisfies first point. The free stack is from
> timer callback, if we know where register this function, then it should
> be useful to solve UAF.

No. It's completely useless.

The problem has absolutely nothing to do with the timer callback and the
timer_init() invocation which set the timer's callback to 'dummy_timer'.

The timer callback happens to free the object, but the worker thread has
still a reference of some sort.

So the problem is either missing refcounting which allows the timer
callback to free the object or some missing serialization.

Knowing the place which initialized the timer is absolutely not helping
to figure out what's missing here.

Aside of that it's trivial enough to do:

  git grep dummy_timer drivers/usb/gadget/udc/dummy_hcd.c

if you really want to know what initialized it:

 dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
 call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]

That said, I'm all for adding useful information to KASAN or whatever
reports, but I'm not agreeing with the approach of 'Let's sprinkle
kasan_foo() all over tha place and claim it is useful to decode an UAF'.
Adding irrelevant information to a report is actually counter productive
because it makes people look at the wrong place.

Again: Provide an analysis of such a dump where the timer_init()
function is a key element of solving the problem.

Thanks,

        tglx
