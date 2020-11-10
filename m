Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739A62ADD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKJRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:50:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:50:02 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605030600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3b7gcV3PHfl8szjR2mhzbiREIPzJknFC+HdhL+o8zkg=;
        b=zRe3de4eVjLdbV2GWrOvvFEa7Zh9MfLoDUlJjaeCbp41wiP97nf42CS8zM/0gaam9/1YbY
        PgszrppoM5dYspbY90YNPaKztmChctOoLpDByyZbpx+8H2xchdG9wFFmUKuEe/ammyvf3M
        Io6q3v9Jem2qkERF8sK+PdcDpwSyTJVj3QFKX65WwEV0BK8hbZHPwnIE9zN9BKEjpnuaq4
        5wMiKGQ0PGXhUrgfmsg4Zeb3INMmGorBhrcqi+p/xo7xY/PIfFxXa5Q7ZseFuTjUGYxgGc
        XzTosG+LKhKxGdxMXtLsIADQaJzuHEHxUaCAdK3ztxfXRDszmnX0VAXyZ7fkuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605030600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3b7gcV3PHfl8szjR2mhzbiREIPzJknFC+HdhL+o8zkg=;
        b=YMmZMENHdMh65sN0d8OMREDaEU3YGuQQRbp2tHOmHexLe/K/0xc/AYoBn5iqRuKAIX2orD
        1+FzQOUVpokSlrDw==
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com> <87a6vpgqbt.fsf@nanos.tec.linutronix.de> <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com> <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
Date:   Tue, 10 Nov 2020 18:50:00 +0100
Message-ID: <877dqtgkzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10 2020 at 16:33, David Woodhouse wrote:
> On Tue, 2020-11-10 at 10:17 -0600, Tom Lendacky wrote:
>> Yep. The warning started triggering with:
>> 47bea873cf80 ("x86/msi: Only use high bits of MSI address for DMAR unit")
>> 
>> Here's the backtrace:
>> 
>> [   15.745929]  irq_chip_compose_msi_msg+0x2e/0x40
>> [   15.750984]  msi_domain_activate+0x4b/0x90
>> [   15.755556]  __irq_domain_activate_irq+0x53/0x80
>> [   15.760707]  ? irq_set_msi_desc_off+0x5a/0x90
>> [   15.765568]  irq_domain_activate_irq+0x25/0x40
>> [   15.770525]  __msi_domain_alloc_irqs+0x16a/0x310
>> [   15.775680]  __pci_enable_msi_range+0x182/0x2b0
>> [   15.780738]  ? e820__memblock_setup+0x7d/0x7d
>> [   15.785597]  pci_enable_msi+0x16/0x30
>> [   15.789685]  iommu_init_msi+0x30/0x190
>
> It's asking the core code to generate a PCI MSI message for it and
> actually program that to the PCI device (since the IOMMU itself is a
> PCI device).
>
> That isn't actually used for generating MSI, but is instead interpreted
> to write the intcapxt registers which *do* generate the interrupts.
>
> That wants fixing, preferably not to go via MSI format at all, or maybe
> just to use the 'dmar' flag to __irq_msi_compose_msg(). Either way by
> having an irqdomain of its own like the Intel IOMMU does.
>
> If I could get post-5.5 kernels to boot at all with the AMD IOMMU
> enabled, I'd have a go at throwing that together now...

It can share the dmar domain code. Let me frob something.
