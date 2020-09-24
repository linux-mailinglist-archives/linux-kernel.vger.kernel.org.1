Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2923277B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIXVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIXVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:41:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B73C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:41:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600983687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PH7EM+jC9sAvN+hNyU7Ecq4szctd2TEmbXpjLXpwHLk=;
        b=s9aB8dgH+LEJxttQJWGE11+AGwucCe4uEwpFHGxM5Il9nb81ncN7r8Hx+3OJ4kNyYgM9dO
        kDfcog9G7Ae/sxkBpu4vLApMbwWN5le+lk70lojuOGsLJL9W9c6CKNvdQeBi3D7xvEu3cQ
        FOU6VlOqEjjJ5knJS9TSLoCP2sg04q4KZmCPxRcRB/WFQb8j9hv6/jKLOJw0xJ8dXflnix
        X4/ncxiUBavxFpN/gfRiblq6Sk192R/KgwTsfJX7aKtPEOTLzvHHMMr2igcXsG8uge6sN0
        byXLKaFRd6o/zeeXaTJuGR7U5fRMTbVuR4LHKBHGLiXrhaCRWJQQiu7ZdRW4rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600983687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PH7EM+jC9sAvN+hNyU7Ecq4szctd2TEmbXpjLXpwHLk=;
        b=vCvDhw1zpzFDJBuOG8UL0KkN9R1JI3ss+WSRGs73GkIopLFT6yj1AwBS6aQnWh9Fqt8jHQ
        pkn9QBcJV5uqC/CQ==
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH v4 1/6] timer: kasan: record timer stack
In-Reply-To: <20200924040335.30934-1-walter-zh.wu@mediatek.com>
References: <20200924040335.30934-1-walter-zh.wu@mediatek.com>
Date:   Thu, 24 Sep 2020 23:41:27 +0200
Message-ID: <87h7rm97js.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24 2020 at 12:03, Walter Wu wrote:
> When analyze use-after-free or double-free issue, recording the timer
> stacks is helpful to preserve usage history which potentially gives
> a hint about the affected code.
>
> Record the most recent two timer init calls in KASAN which are printed
> on failure in the KASAN report.
>
> For timers it has turned out to be useful to record the stack trace
> of the timer init call.

In which way? And what kind of bug does it catch which cannot be catched
by existing debug mechanisms already?

> Because if the UAF root cause is in timer init, then user can see
> KASAN report to get where it is registered and find out the root
> cause.

What? If the UAF root cause is in timer init, then registering it after
using it in that very same function is pretty pointless.

> It don't need to enable DEBUG_OBJECTS_TIMERS, but they have a chance
> to find out the root cause.

There is a lot of handwaving how useful this is, but TBH I don't see the
value at all.

DEBUG_OBJECTS_TIMERS does a lot more than crashing on UAF. If KASAN
provides additional value over DEBUG_OBJECTS_TIMERS then spell it out,
but just saying that you don't need to enable DEBUG_OBJECTS_TIMERS is
not making an argument for that change.

Try again please.

Thanks,

        tglx
