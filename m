Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC42D0B36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLGHjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 02:39:08 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:54724 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:39:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A111460CEF32;
        Mon,  7 Dec 2020 08:38:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lYe7XNyoDZpR; Mon,  7 Dec 2020 08:38:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 482326231F21;
        Mon,  7 Dec 2020 08:38:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y1hHDwrmG42h; Mon,  7 Dec 2020 08:38:25 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1A58B60CEF32;
        Mon,  7 Dec 2020 08:38:25 +0100 (CET)
Date:   Mon, 7 Dec 2020 08:38:24 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        tglx <tglx@linutronix.de>
Message-ID: <1460772961.85699.1607326704865.JavaMail.zimbra@nod.at>
In-Reply-To: <20201207043518.GA1819081@boqun-archlinux>
References: <CAFLxGvwienJ7sU2+QAhFt+ywS9iYkbAXDGviuTC-4CVwLOhXfA@mail.gmail.com> <20201207043518.GA1819081@boqun-archlinux>
Subject: Re: BUG: Invalid wait context with KMEMLEAK and KASAN enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: Invalid wait context with KMEMLEAK and KASAN enabled
Thread-Index: 6g9dKygF4YhpzjznohWxx1ckhTfl2Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun,

----- Ursprüngliche Mail -----
>> Does this ring a bell?
>> 
>> [    2.298447] =============================
>> [    2.298971] [ BUG: Invalid wait context ]
>> [    2.298971] 5.10.0-rc6+ #388 Not tainted
>> [    2.298971] -----------------------------
>> [    2.298971] ksoftirqd/1/15 is trying to lock:
>> [    2.298971] ffff888100b94598 (&n->list_lock){....}-{3:3}, at:
>> free_debug_processing+0x3d/0x210
> 
> I guest you also had CONFIG_PROVE_RAW_LOCK_NESTING=y, right?

Yes, this is the case!

Thanks,
//richard
