Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2B9278359
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgIYIzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:55:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:55:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601024139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27rpXJWZJemqCR5/J+kJk/Ytwunk5JlcbUzkum+S4N4=;
        b=Byg4yL3te8ivcMS4F2H8gOSQgqsZFJMj7/3QGL1zpD+Uh7rAUCaut5ynvf9S5fDMomckOp
        U5NB52hUfA2U6b3+cKPcx4a4SV0DKzu47kDUHuaXyQB3h6c/zTi8HkZRbpHchKrjOmVKvR
        WzM0VPP/baGMhhiSoGWCH7oiH6uphutlfMaExg5R4H/NBJYE84qYc+05sJbCMCS2sXrWk6
        NXtbO2rgbxrUFvRLlnR3+pdP0qO+xTGpIX12bTcavQl+D3AQI1oN0JuV/sUI9EqoYPq6eT
        ZniwmFxZjcNhCpZY1YxANngzOLk9EIUxSeG+WYk4sDTAGTYDDj4qVSROVGOvWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601024139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27rpXJWZJemqCR5/J+kJk/Ytwunk5JlcbUzkum+S4N4=;
        b=UBbd3YTV3lBvSjOcMTIlxl7PlmxXWJcM7BthmUp44vKv9Dy511FWWrHXVYtIyr0/6UCITS
        jzGULCttqvgHCcDQ==
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
In-Reply-To: <1601018323.28162.4.camel@mtksdccf07>
References: <20200924040335.30934-1-walter-zh.wu@mediatek.com> <87h7rm97js.fsf@nanos.tec.linutronix.de> <1601018323.28162.4.camel@mtksdccf07>
Date:   Fri, 25 Sep 2020 10:55:39 +0200
Message-ID: <87lfgyutf8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walter,

On Fri, Sep 25 2020 at 15:18, Walter Wu wrote:
> On Thu, 2020-09-24 at 23:41 +0200, Thomas Gleixner wrote:
>> > For timers it has turned out to be useful to record the stack trace
>> > of the timer init call.
>> 
>> In which way? And what kind of bug does it catch which cannot be catched
>> by existing debug mechanisms already?
>> 
> We only provide another debug mechanisms to debug use-after-free or
> double-free, it can be displayed together in KASAN report and have a
> chance to debug, and it doesn't need to enable existing debug mechanisms
> at the same time. then it has a chance to resolve issue.

Again. KASAN can only cover UAF, but there are a dozen other ways to
wreck the system with wrong usage of timers which can't be caught by
KASAN.

>> > Because if the UAF root cause is in timer init, then user can see
>> > KASAN report to get where it is registered and find out the root
>> > cause.
>> 
>> What? If the UAF root cause is in timer init, then registering it after
>> using it in that very same function is pretty pointless.
>> 
> See [1], the call stack shows UAF happen at dummy_timer(), it is the
> callback function and set by timer_setup(), if KASAN report shows the
> timer call stack, it should be useful for programmer.

The report you linked to has absolutely nothing to do with a timer
related UAF. The timer callback calls kfree_skb() on something which is
already freed. So the root cause of this is NOT in timer init as you
claimed above. The timer callback is just exposing a problem in the URB
management of this driver. IOW the recording of the timer init stack is
completely useless for decoding this problem.

>> There is a lot of handwaving how useful this is, but TBH I don't see the
>> value at all.
>> 
>> DEBUG_OBJECTS_TIMERS does a lot more than crashing on UAF. If KASAN
>> provides additional value over DEBUG_OBJECTS_TIMERS then spell it out,
>> but just saying that you don't need to enable DEBUG_OBJECTS_TIMERS is
>> not making an argument for that change.
>> 
> We don't want to replace DEBUG_OBJECTS_TIMERS with this patches, only
> hope to use low overhead(compare with DEBUG_OBJECTS_TIMERS) to debug

KASAN has lower overhead than DEBUG_OBJECTS_TIMERS? Maybe in a different
universe.

That said, I'm not opposed to the change per se, but without a sensible
justification this is just pointless.

Sprinkling kasan_foo() all over the place and claiming it's useful
without a valid example does not provide any value.

Quite the contrary it gives the completely wrong sense what KASAN can do
and what not.

Thanks,

        tglx

