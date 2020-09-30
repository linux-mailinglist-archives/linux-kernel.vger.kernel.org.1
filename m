Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4491527ECC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgI3P3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbgI3P3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C623C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:29:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601479781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqZau5xYcLfz7fU6kWPWcUxXzOYMn4YTVPKLqoPQKaY=;
        b=fC9bWFoE1/eG/uG47jmppe9UycpzJfawCIUeh06a6YZbeslJwiHmJp1L5pQFxneWoDVeI2
        b0iFw0DfB4SP31ej0/wjpjX07O7+H7hhTYERNNgNBdM/DJKhLgP3L6tXl1kYwfXtniVwvx
        GCfjWUZsJJjrQxaxfPCRwC4b3RWDYPdDtNYJEsOM6Li9lkZg59Wq30CqCfUXHmXHOKba29
        /ZGOuA8Jun2KFV67EZn5T4R1fWMeNALFR7iEX97fJfH1V+6zjAuv0OGXw1icrd5DpxrUMT
        UysUUPquljDDnILpx2jORVm2BKGZbxH1eqeC/Vlz/O9B8xn82Q1rCc9B1oXfLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601479781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqZau5xYcLfz7fU6kWPWcUxXzOYMn4YTVPKLqoPQKaY=;
        b=WRJ8lzbKXtdFgjF58fjm4nGD/pJNjZ042WFzkiYHsftWabD/dNyRXEBhWXIVTsNMsuG3Q6
        umneCJHc1w51WwCA==
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
In-Reply-To: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
Date:   Wed, 30 Sep 2020 17:29:40 +0200
Message-ID: <87h7rfi8pn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24 2020 at 12:01, Walter Wu wrote:
> Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> In some of these access/allocation happened in process_one_work(),
> we see the free stack is useless in KASAN report, it doesn't help
> programmers to solve UAF on workqueue. The same may stand for times.
>
> This patchset improves KASAN reports by making them to have workqueue
> queueing stack and timer stack information. It is useful for programmers
> to solve use-after-free or double-free memory issue.
>
> Generic KASAN also records the last two workqueue and timer stacks and
> prints them in KASAN report. It is only suitable for generic KASAN.
>
> [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers

How are these links useful for people who do not have a gurgle account?


