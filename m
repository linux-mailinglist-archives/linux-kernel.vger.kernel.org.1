Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD62AE145
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKJVB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:01:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:01:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605042083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIElTeXRTDLPlHV76NP/glNrg6+Gyc+gwMp3NkK4NMY=;
        b=YHNPo9RfvKVO4/dhHzReWlaXfffFtSPcdQr7WZW/2uEe/9w6tc/HblhqZhJgJHUAhV267+
        vewZ1bd3erdrEDad/IE740dvev43dTaUdqWhSPWc4kDf8phJW/AwnxwmjY3VzTISuZkhFh
        rRkFkid1wT2ollhwxJ5eUY2oJjPfoi3JEPjPUHQfSkb0J9UyaL9700DsZLfoEWqcYF3nMe
        eUTa3vabVNqNLWYAW/VNb0xgvBG74QnmTvxX/QPLhPhcql9gXIUJbhgTPVlMhTjIW84gEa
        1qc7NK+kLE9RTQQuYvC+Aoug2cNsoVZYWwAEWYHkoWQn7gpOWzIO1oEu0RbRdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605042083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIElTeXRTDLPlHV76NP/glNrg6+Gyc+gwMp3NkK4NMY=;
        b=ji84W68K5k8j+V5jhvjMZzn17I/SPU8xW9VSMzTJ7LAN632k+OxFnxcFHeBX1aUCNANlRO
        Wqk5haWjnbp6DqAA==
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com> <87a6vpgqbt.fsf@nanos.tec.linutronix.de> <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com> <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org> <877dqtgkzb.fsf@nanos.tec.linutronix.de> <874klxghwu.fsf@nanos.tec.linutronix.de> <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
Date:   Tue, 10 Nov 2020 22:01:17 +0100
Message-ID: <87y2j9exk2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10 2020 at 19:21, David Woodhouse wrote:

> On 10 November 2020 18:56:17 GMT, Thomas Gleixner <tglx@linutronix.de> wrote:
>>On Tue, Nov 10 2020 at 18:50, Thomas Gleixner wrote:
>>> On Tue, Nov 10 2020 at 16:33, David Woodhouse wrote:
>>>> If I could get post-5.5 kernels to boot at all with the AMD IOMMU
>>>> enabled, I'd have a go at throwing that together now...
>>>
>>> It can share the dmar domain code. Let me frob something.
>>
>>Not much to share there and I can't access my AMD machine at the
>>moment. Something like the untested below should work.
>
> Does it even need its own irqdomain? Can it not just allocate directly
> from the vector domain then program its own register directly based on
> the irq_cfg?

It uses pci_enable_msi() and I have no clue about that piece of hardware
and whether that is actually required or not. If it is, then it needs a
domain because that's what pci_enable_msi() uses.

Thanks,

        tglx
