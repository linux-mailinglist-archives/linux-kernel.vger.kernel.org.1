Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58344294E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442441AbgJUODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:03:00 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34691 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408608AbgJUOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:02:59 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201021140256epoutp0368509d80ae891a5d4031b5cba8a8efe8~ABtR27zAE2978529785epoutp038
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:02:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201021140256epoutp0368509d80ae891a5d4031b5cba8a8efe8~ABtR27zAE2978529785epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603288976;
        bh=wjrduFjgfm07XfY7v3+tVmfXvRbDBj4UbIFGVRu6kkY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=P/nxsA/evQv0kqawzDi0Iiz4l3B+QnYCGioCxJQ1cgLaSAzPImyICyZNjYxiVvD79
         ec1COVIfx+Gh7oVRT6VfKqFrZsMcetEH1iboc4LCwGaWLcwUg8ucRg3IRGfi5OfatR
         Qd6iNYZU3OWgq1s/anXgUA0dPlvv6R3FBsCeHL6c=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201021140255epcas5p3a587675a2c3fad3a63f603f1660cabbe~ABtQpT7xu1056910569epcas5p3r;
        Wed, 21 Oct 2020 14:02:55 +0000 (GMT)
X-AuditID: b6c32a49-a67ff70000002565-79-5f903f8fbc04
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.42.09573.F8F309F5; Wed, 21 Oct 2020 23:02:55 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/3] arm: introduce IRQ stacks
Reply-To: v.narang@samsung.com
Sender: Vaneet Narang <v.narang@samsung.com>
From:   Vaneet Narang <v.narang@samsung.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
CC:     AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20201021125740.GM1551@shell.armlinux.org.uk>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201021134653epcms5p7a6932d1304c604b224a04025c6f0153e@epcms5p7>
Date:   Wed, 21 Oct 2020 19:16:53 +0530
X-CMS-MailID: 20201021134653epcms5p7a6932d1304c604b224a04025c6f0153e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmhm6//YR4g1MTZC0mTHvBYnFxd6rF
        nPVr2Cy2bdnEajHt4iRmi5XzdjJabHp8jdXi8q45bBaHpu5ltDg8v43FYueck6wWHyb8Z7LY
        fPgTi8XmTVOZLbbP/8lscX6bv0XLHVMHQY8189Ywely+dpHZ4/q6AI+ds+6yeyzYVOqxaVUn
        m8e7c+fYPU7M+M3isXlJvUffllWMHp83yQVwR3HZpKTmZJalFunbJXBlTLg8mb1gqUDF4UdN
        LA2MM3m7GDk5JARMJO5eO8LcxcjFISSwm1Fix7nPTF2MHBy8AoISf3cIg9QICxhJfOhaygpi
        CwnISRy/sZsRIq4jcQLoLJByNgEtiY8t4SBhEYFYiR9djewgI5kFprJKvPg9lx1iF6/EjPan
        LBC2tMT25VvB5nAKWEl83LSKFSIuKnFz9Vt2GPv9sfmMELaIROu9s8wQtqDEg5+7oeIyEt+/
        9rOCLJMQ6GaU+Lyljw3CmcIoMfv3aSaIKnOJ3RvmsUA85itxro8DJMwioCox9+16qMUuElPv
        HAZbzCwgL7H97RxmkHJmAU2J9bv0IUpkJaaeWscEUcIn0fv7CRPMXzvmwdhKEucO7mSDsCUk
        nnTOhLrZQ2LRhDms0HBmljg8/z77BEaFWYignoVk8yyEzQsYmVcxSqYWFOempxabFhjmpZbr
        FSfmFpfmpesl5+duYgQnPy3PHYx3H3zQO8TIxMF4iFGCg1lJhDdPdEK8EG9KYmVValF+fFFp
        TmrxIUZpDhYlcV6lH2fihATSE0tSs1NTC1KLYLJMHJxSDUw213m5MlIS92ycZGByiSn3U9+C
        hKYaj2n3QoJjt2dHyve3GJ5auOJR1x+OZ50x3m9M156Qs5rmfi32pdinyQLH5a6e+/B9qeSL
        ncmdcSckG178vnl7Rc3Ro8E73sh8tNx7eMPShXuimBZNvulhwnj2MD/70+ebhYNPuN13l3g9
        07rXf2v/a/kalhMLNrJVf5v7TuDI9uSpfDMXael13KnyTLeXEbTr0HBf/sfKqe5vucVt7TQL
        m5KGrF1KvkYrXhjxBK4o/TbryoJPz+QnG0Sku/x9Ib15hUlHyOzzfw7cCBHdph73n71NZ0/F
        nu0dUdo1H45rTTF/NHUeTzRXRxT7xjP+8yVSfXJj+a341loqsRRnJBpqMRcVJwIAobyHZ+0D
        AAA=
X-CMS-RootMailID: 20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83
References: <20201021125740.GM1551@shell.armlinux.org.uk>
        <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
        <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
        <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
        <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
        <20201021124542.GL1551@shell.armlinux.org.uk>
        <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcms5p7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel & Arnd,

> > > - define 'current' as 'this_cpu_read_stable(current_task);'
> > > - convert to CONFIG_THREAD_INFO_IN_TASK
> 
unlike ARM64 ARM doesn't suport dedicated register like "sp_el0", so 
arm still stores thread info on stack and fetches using current task using
stack pointer (SP) so CONFIG_THREAD_INFO_IN_TASK is not supported on ARM. 
To implement solution inline with current ARM design, we have used indirection.

> That means we need to also code that up in assembly - remember, we
> need to access thread_info from assembly code.

> Note also that there is a circular dependency involved. If you make
> thread_info accessible via per-cpu, then:

> "We don't do it because we don't have a separate register to be able
> to store the thread_info pointer, and copying that lump between the
> SVC and IRQ stack will add massively to IRQ latency, especially for
> older machines."

We tried to minimize latency in switching between SVC stack and IRQ stack
by just copying extra thread info pointer to IRQ stack. Apart from this, 
Most of the code of SVC to IRQ switching is similar to ARM64 implementation.

Also We tried to minimize latency of get_current() by introducting self pointer in
SVC stack to avoid if check to determine, is current is called from SVC context
or IRQ context. This way will always do one extra indirection in get_current, 
irrespective get_current is called from SVC or IRQ context.

Yes we agree still there will be minor additional latency on accessing current
task and SVC to IRQ switching  which might be significant for older machines,
So this is the reason why we kept this sol. under kconfig. This solution
provides extra stack to kernel developers for further development,instead of increasing
stack size to 16KB or spending time on debugging stack overflow issues.

PS: We have debugged and resolved stack overflow issue but we still implemented this sol. to avoid
debugging such issues in future also it gives us flexibility for kernel enhancement on ARM.

Thanks & Regards,
Vaneet Narang
