Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388930415A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406078AbhAZPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:02:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60886 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406027AbhAZPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:02:40 -0500
X-UUID: 088f668070b041209353f71c69a4154d-20210126
X-UUID: 088f668070b041209353f71c69a4154d-20210126
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1954290461; Tue, 26 Jan 2021 23:01:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Jan 2021 23:01:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 23:01:50 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <bigeasy@linutronix.de>
CC:     <akpm@linux-foundation.org>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <marc.zyngier@arm.com>, <peterx@redhat.com>, <rppt@kernel.org>,
        <tglx@linutronix.de>, <walken@google.com>,
        <yj.chiang@mediatek.com>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ARM: mm: harden branch predictor before opening interrupts during fault
Date:   Tue, 26 Jan 2021 23:01:50 +0800
Message-ID: <20210126150150.13905-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210126110716.wv4igts76n3kg3ch@linutronix.de>
References: <20210126110716.wv4igts76n3kg3ch@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D66D7140C17D41472CE48D1CD6A2F9666C9EA354FC4251B7BA19B574BE151C652000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2021-01-26 10:59:32 [+0000], Russell King - ARM Linux admin wrote:
> > On Tue, Jan 26, 2021 at 05:17:08PM +0800, Lecopzer Chen wrote:
> > > Hi all,
> > > 
> > > I don't see any fix for this issue now(maybe I missed it..?),
> > > could we fix this if there is better solution?
> > > This issue exists almost two years.
> > 
> > I don't think anyone provided an acceptable patch.
> > 
> > The first patch moved the hardening out of the translation/section
> > fault handling. Since the kernel is mapped with sections, these
> > are above TASK_SIZE, and the whole point of the branch prediction
> > hardening is to prevent the prediction in the kernel being exploited,
> > missing the hardening effectively makes the mitigation useless.
> > 
> > The discussion in February 2019 never concluded from what I can see.
> 
> My memory is that I never got a reply which I understood.
> Let me try again this week with the information above.


NOTE:
Before sending this mail, I had searched the relative threads and
there are two solutions in general:
    1. Add get_pcpu()/put_cpu() https://lkml.org/lkml/2019/6/3/426
       Reject by Marc:
       > The right fix would be to move the call to a point where we haven't
       > enabled preemption yet.

    2. Move out like the patch from Sebastian:
       This seems follow the concept of 1.
       (move the call to a point where we haven't enabled preemption yet).
       But I can't find any reply in the thread.

Now the CONFIG_HARDEN_BRANCH_PREDICTOR has already backported to LTS,
and after upgrading ARM CONFIG_CPU_V7 products to latest LTS, the
CONFIG_HARDEN_BRANCH_PREDICTOR will be default y and this issue makes
our devices panic and we have to either disable HARDEN_BRANCH_PREDICTOR
or hack in-house to avoid the kernel panic.


I'll wait for anyone have acceptable idea and patching(maybe Sebastian could? :)),
and I'll also take some time to find other solution too.


Thanks,
Lecopzer

