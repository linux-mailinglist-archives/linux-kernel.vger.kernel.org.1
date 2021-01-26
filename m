Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFA304360
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404841AbhAZQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:06:28 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36254 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404676AbhAZQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:04:11 -0500
X-UUID: 25fff92989674ba4b424e38b509e0346-20210127
X-UUID: 25fff92989674ba4b424e38b509e0346-20210127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 437533301; Wed, 27 Jan 2021 00:03:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Jan 2021 00:03:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 00:03:13 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux@armlinux.org.uk>
CC:     <akpm@linux-foundation.org>, <bigeasy@linutronix.de>,
        <gregkh@linuxfoundation.org>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <marc.zyngier@arm.com>,
        <peterx@redhat.com>, <rppt@kernel.org>, <tglx@linutronix.de>,
        <walken@google.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] ARM: mm: harden branch predictor before opening interrupts during fault
Date:   Wed, 27 Jan 2021 00:03:03 +0800
Message-ID: <20210126160303.16157-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210126152916.GJ1551@shell.armlinux.org.uk>
References: <20210126152916.GJ1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 26, 2021 at 11:01:50PM +0800, Lecopzer Chen wrote:
> > > On 2021-01-26 10:59:32 [+0000], Russell King - ARM Linux admin wrote:
> > > > On Tue, Jan 26, 2021 at 05:17:08PM +0800, Lecopzer Chen wrote:
> > > > > Hi all,
> > > > > 
> > > > > I don't see any fix for this issue now(maybe I missed it..?),
> > > > > could we fix this if there is better solution?
> > > > > This issue exists almost two years.
> > > > 
> > > > I don't think anyone provided an acceptable patch.
> > > > 
> > > > The first patch moved the hardening out of the translation/section
> > > > fault handling. Since the kernel is mapped with sections, these
> > > > are above TASK_SIZE, and the whole point of the branch prediction
> > > > hardening is to prevent the prediction in the kernel being exploited,
> > > > missing the hardening effectively makes the mitigation useless.
> > > > 
> > > > The discussion in February 2019 never concluded from what I can see.
> > > 
> > > My memory is that I never got a reply which I understood.
> > > Let me try again this week with the information above.
> > 
> > 
> > NOTE:
> > Before sending this mail, I had searched the relative threads and
> > there are two solutions in general:
> >     1. Add get_pcpu()/put_cpu() https://lkml.org/lkml/2019/6/3/426
> >        Reject by Marc:
> >        > The right fix would be to move the call to a point where we haven't
> >        > enabled preemption yet.
> > 
> >     2. Move out like the patch from Sebastian:
> >        This seems follow the concept of 1.
> >        (move the call to a point where we haven't enabled preemption yet).
> >        But I can't find any reply in the thread.
> > 
> > Now the CONFIG_HARDEN_BRANCH_PREDICTOR has already backported to LTS,
> > and after upgrading ARM CONFIG_CPU_V7 products to latest LTS, the
> > CONFIG_HARDEN_BRANCH_PREDICTOR will be default y and this issue makes
> > our devices panic and we have to either disable HARDEN_BRANCH_PREDICTOR
> > or hack in-house to avoid the kernel panic.
> 
> It does _not_ cause the kernel to panic, ever. A kernel panic takes
> out the system. This is not the case here.
> 
> It merely causes a noisy message to be emitted in the kernel log, and
> the system survives. That is way more preferable than breaking the
> effect of branch predictor hardening.
> 
> If it is taking out your kernel with a real panic, then there is
> something wrong elsewhere - and this is _not_ something that should
> be happening during normal system operation.

Oh, yes, you're right;

After reread the panic log, our panic happened because
-> invalid userspace memory access
-> debug_preempt log
-> the program seg fault
-> main service need the program but it crash
-> panic

Sorry for wrong information and thanks a lot for the correctness.
I think I have to see why the in-house hacking is working...

Thanks!!

BRs,
Lecopzer

