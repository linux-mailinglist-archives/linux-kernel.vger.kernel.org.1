Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95756279470
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgIYW7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:59:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgIYW7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:59:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601074776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNfIywwa8zLp7Ze2sUjIPjT6qUcXBaqd2I3y05VFQpk=;
        b=i68A1tT8A/9EgAmBPvJHilJ6RBDhd4/QF+g/MLgQuc/v1+mdbNY8WaeAszXaDnCric2Akk
        KmDZ/Lc1xD6A/6ODG9xAPKNYDDsBE2nybK5rmyc4G20JNX4edmbL7MriKBcYu4Q23Du+xq
        quDNOluI2E7ZWAPNm6p4t1HiWrnqxRvryKC5u45mpVVpm3XaICWRoRjC9Ob5ruJaf5l14a
        wpig8PghERkqsJaSQBkduAOY5R012KtRu5gwJBw+RvVGbKgjvY9LoakcRfmEYOb+sp/BET
        NRJu3zb0X3mD7QAmUifsEaNQWw0UUBUOt7xmVnnxT7WBSmHlm/dhxSfwMCwy5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601074776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNfIywwa8zLp7Ze2sUjIPjT6qUcXBaqd2I3y05VFQpk=;
        b=2mWokoRSIrGozji4bFmvucaPRe+NHLQXPr6rwiZVkAx2M7CgxaJ05sXDgjvu2vMLGeEZbx
        PCndjBlCAkGPwYDg==
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
In-Reply-To: <1601025346.2255.2.camel@mtksdccf07>
References: <20200924040335.30934-1-walter-zh.wu@mediatek.com> <87h7rm97js.fsf@nanos.tec.linutronix.de> <1601018323.28162.4.camel@mtksdccf07> <87lfgyutf8.fsf@nanos.tec.linutronix.de> <1601025346.2255.2.camel@mtksdccf07>
Date:   Sat, 26 Sep 2020 00:59:35 +0200
Message-ID: <87wo0htqco.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25 2020 at 17:15, Walter Wu wrote:
> On Fri, 2020-09-25 at 10:55 +0200, Thomas Gleixner wrote:
>> > We don't want to replace DEBUG_OBJECTS_TIMERS with this patches, only
>> > hope to use low overhead(compare with DEBUG_OBJECTS_TIMERS) to debug
>> 
>> KASAN has lower overhead than DEBUG_OBJECTS_TIMERS? Maybe in a different
>> universe.
>> 
> I mean KASAN + our patch vs KASAN + DEBUG_OBJECTS_TIMERS. The front one
> have the information to the original caller and help to debug. It is
> smaller overhead than the one behind.

For ONE specific problem related to timers and you have still not shown
a single useful debug output where this information helps to debug
anything.

> I agree your saying, so that I need to find out a use case to explain to
> you.

Indeed.

Thanks,

        tglx
