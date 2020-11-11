Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF582AEE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKKJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKKJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:46:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42568C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:46:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605087983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBGgYpNE48xLdaSx9SJyuRgs17Z12VxMWi2bsgM8DpA=;
        b=JrYegkaT2uptksIpDgutFBjIzBimCAGccgf49XznMd+eIHWWMHBsn6a9BV4AuM1CuzEV0X
        sJpQE9UMam8/paR3LWytzkUuLasRXgusQNIlzAD/BThHLicM2AYUGMob2buUzHpHA98R0e
        TqPxWCRqP0A8ce4DZdzE1piJqo9tvBQBm4j1kOqLG9fDX330Tmh9QvxhotlaNkibJWg8+j
        hBpGZpN5AS4ykTcfpATYSpYdmz0UvL0vWOl2IiNwhI6ufh1FqO0lyF6AjWaOCKEU/VpxvT
        XMqb6vffoMTXoKay0NauNpsbOCYugZvKQbE7d3l+k+Pw6Dlccp/NF8dCI7pu3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605087983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBGgYpNE48xLdaSx9SJyuRgs17Z12VxMWi2bsgM8DpA=;
        b=mI/NXhm0h/Xc76FRp2LRKgSfTCSZKE3YqHkx2p/gho1GEJaYeThhJa0uNBdVg0lYTD5+LU
        ugksbj9jSSQ1YXBA==
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <5c86570ce3bedb90514bc1e73b96011660f520b0.camel@infradead.org>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com> <87a6vpgqbt.fsf@nanos.tec.linutronix.de> <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com> <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org> <877dqtgkzb.fsf@nanos.tec.linutronix.de> <874klxghwu.fsf@nanos.tec.linutronix.de> <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org> <87y2j9exk2.fsf@nanos.tec.linutronix.de> <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org> <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com> <87tutwg76j.fsf@nanos.tec.linutronix.de> <5c86570ce3bedb90514bc1e73b96011660f520b0.camel@infradead.org>
Date:   Wed, 11 Nov 2020 10:46:23 +0100
Message-ID: <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11 2020 at 08:16, David Woodhouse wrote:
> On Tue, 2020-11-10 at 23:48 +0100, Thomas Gleixner wrote:
>> + * IRQCHIP_MSI_EXTID                 The MSI message created for this chip can
>> + *                                   have an otherwise forbidden extended ID
>
> If we're going to do that then we could ditch the separate
> iommu_compose_msi_msg() function too, right?
>
> But actually I'd be more inclined to fix this differently, in a way
> that doesn't still leave AMD's iommu_init_intcapxt() having to set use
> irq_set_affinity_notifier() to update its own registers. That's icky.
>
> Given that this is *its* irqdomain in the first place, it should just
> sit at ->set_affinity() for itself, and call its parent as usual
> without having to use a notifier.
>
> We should also leave it using the basic PCI MSI support in the case
> where the IOMMU doesn't have XTSUP support. It doesn't need its own
> irqdomain for that.

Looking at it now with brain awake, the XTSUP stuff is pretty much
the same as DMAR, which I didn't realize yesterday. The affinity
notifier muck is not needed when we have a write_msg() function which
twiddles the bits into those other locations.

Thanks,

        tglx


