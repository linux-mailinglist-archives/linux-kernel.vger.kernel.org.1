Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CBF2AD8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKJOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:34:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:34:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605018873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRIypW99dydWxym9olIbQVS6DGC1I29UdjlZ6dRFIRg=;
        b=lYfMzHlMG/WWVDXKfMCn2LvyjX+G8obWVeM6tdD9Aa552o6/w1BVvEOKWPzEuDUgowBIsN
        QF+ClfmH5IzvWUD7EKMVVGcyeIfQw4ZlL3Ll9au9GjdChx+D/pN1a0g4p8dvJCDvXROsqA
        VmTro+v54UJg9xlauCiW+91mDYmI59tJNe4Eqz2NZ31fJ2a/hZpknu3nwi06lig5pMTAMN
        YYk1hQXUkPWpja9CIZe3uPF/W2N1KoUiZW+V3cce8a9LG3PPuvF/zmpBGMxE3LVQ2Wn22H
        +WKJUzXVw8sup+q4yZDTny4l/B5vASkrML53HmR5BxxmiAWyO2UC3lUWiCXr6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605018873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRIypW99dydWxym9olIbQVS6DGC1I29UdjlZ6dRFIRg=;
        b=dTZmQVWhnTcXky6bOTYSOcs4vrYT+9XIHQ1oHaLh1bR+rKos1SeIp7rCt7Q+xZOJYJPTV2
        AJ/BYxtEednlJQCg==
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>
Subject: Re: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <20201110061046.GA7290@nazgul.tnic>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic>
Date:   Tue, 10 Nov 2020 15:34:32 +0100
Message-ID: <87d00lgu13.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10 2020 at 07:10, Borislav Petkov wrote:

> On Mon, Nov 09, 2020 at 05:15:03PM -0600, Tom Lendacky wrote:
>> [  105.325371] hpet: Lost 9601 RTC interrupts
>> [  105.485766] hpet: Lost 9600 RTC interrupts
>> [  105.639182] hpet: Lost 9601 RTC interrupts
>> [  105.792155] hpet: Lost 9601 RTC interrupts
>> [  105.947076] hpet: Lost 9601 RTC interrupts
>> [  106.100876] hpet: Lost 9600 RTC interrupts
>> [  106.253444] hpet: Lost 9601 RTC interrupts
>> [  106.406722] hpet: Lost 9601 RTC interrupts
>> 
>> preventing the system from booting. I bisected it to this commit.
>
> I bisected it to the exact same thing too, on an AMD laptop, after seeing what
> you're seeing.

Bah. I'm a moron.

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -809,9 +809,9 @@ static bool irq_is_level(int idx)
 	case MP_IRQTRIG_DEFAULT:
 		/*
 		 * Conforms to spec, ie. bus-type dependent trigger
-		 * mode. PCI defaults to egde, ISA to level.
+		 * mode. PCI defaults to level, ISA to edge.
 		 */
-		level = test_bit(bus, mp_bus_not_pci);
+		level = !test_bit(bus, mp_bus_not_pci);
 		/* Take EISA into account */
 		return eisa_irq_is_level(idx, bus, level);
 	case MP_IRQTRIG_EDGE:
