Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722F22ACF78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgKJGK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:10:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgKJGK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:10:56 -0500
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B893E1EC036E;
        Tue, 10 Nov 2020 07:10:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604988654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3VWGBSyEyWOjXD98dXiHVf6x4HWJyPTNApzSLF0aMCo=;
        b=EFCLExfJatYdWC/JbFyUeqqfYznW3HTgzOcp5Awz/A/Xexja1Rs/+ujzEzVTCpBIuLZrzh
        34EI/EUUwfdK7efWu++df/0w3gApExGJO40J5o3WNapcLPWflsaQpe4NtwzXZOsXi1Orrv
        BR6t9lt7kupvOHeImPTGDjWV+k9JO0c=
Date:   Tue, 10 Nov 2020 07:10:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
Message-ID: <20201110061046.GA7290@nazgul.tnic>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
 <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:15:03PM -0600, Tom Lendacky wrote:
> [  105.325371] hpet: Lost 9601 RTC interrupts
> [  105.485766] hpet: Lost 9600 RTC interrupts
> [  105.639182] hpet: Lost 9601 RTC interrupts
> [  105.792155] hpet: Lost 9601 RTC interrupts
> [  105.947076] hpet: Lost 9601 RTC interrupts
> [  106.100876] hpet: Lost 9600 RTC interrupts
> [  106.253444] hpet: Lost 9601 RTC interrupts
> [  106.406722] hpet: Lost 9601 RTC interrupts
> 
> preventing the system from booting. I bisected it to this commit.

I bisected it to the exact same thing too, on an AMD laptop, after seeing what
you're seeing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
