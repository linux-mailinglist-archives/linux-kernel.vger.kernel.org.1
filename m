Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81B1DA3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgESVqS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 May 2020 17:46:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgESVqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:17 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id A1673E410988D330014D;
        Wed, 20 May 2020 05:46:15 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.191]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0487.000;
 Wed, 20 May 2020 05:46:08 +0800
From:   Song Bao Hua <song.bao.hua@hisilicon.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Thread-Topic: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Thread-Index: AQHWLhsB19zOKbhSok+Mjvon7Zb2Y6iv78fA
Date:   Tue, 19 May 2020 21:46:06 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-9-bigeasy@linutronix.de>
In-Reply-To: <20200519201912.1564477-9-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.125]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>

> zwap uses per-CPU compression. The per-CPU data pointer is acquired with
> get_cpu_ptr() which implicitly disables preemption. It allocates memory inside the preempt disabled region which conflicts with the PREEMPT_RT semantics.

> Replace the implicit preemption control with an explicit local lock.
> This allows RT kernels to substitute it with a real per CPU lock, which serializes the access but keeps the code section preemptible. On non RT kernels this maps to preempt_disable() as before, i.e. no functional change.

Hi Luis,
In the below patch, in order to use the acomp APIs to leverage the power of hardware compressors. I have moved to mutex:
https://marc.info/?l=linux-crypto-vger&m=158941285830302&w=2
https://marc.info/?l=linux-crypto-vger&m=158941287930311&w=2

so once we get some progress on that one, I guess we don't need a special patch for RT any more.

> [bigeasy: Use local_lock(), additional hunks, patch description]

> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/zswap.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Thanks
Barry


