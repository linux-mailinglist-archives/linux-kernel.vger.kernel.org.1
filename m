Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D720B7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgFZSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 14:15:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43220 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZSP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:15:58 -0400
Received: from zn.tnic (p200300ec2f0d1400d99b017616e7d256.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1400:d99b:176:16e7:d256])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3DFC1EC0136;
        Fri, 26 Jun 2020 20:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593195355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K2CJIk9iowgPaK93YLqKtsoeAarMKRZRNRyX9xlsHGw=;
        b=WGHo01Ni5a9EIBQZ8DoOJEDy11rUkc5B8Y8CS9BQdGp+nQRYe0awSHaWwqqB53p0mxhFJM
        Lsu/rM53eHDAw34OJQ2FJBVzuq+UQ08aKNwsMIH3mQ8f4RCdkPuxMLHiDGSh0WFqFtYYT6
        HOzMGAZzedykl06V0+IwBKAKwAbZLu8=
Date:   Fri, 26 Jun 2020 20:15:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200626181550.GF27151@zn.tnic>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
 <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
 <20200626181000.GA22833@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200626181000.GA22833@agluck-desk2.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:10:00AM -0700, Luck, Tony wrote:
> Do we have a standard way of coding for a feature that depends on multiple
> other features?  For this case the system needs to both suport the ENQCMD
> instruction, and also have kernel code that programs the IOMMU.

Yes, you need both. Consider distros enabling everything so that they
can ship a single kernel image.

> And/or guidance on when to use each of the very somewhat simlar looking
> 	boot_cpu_has()
> 	static_cpu_has()

See the comment over _static_cpu_has() in arch/x86/include/asm/cpufeature.h

In the exception path you should use the static_ variant.

> 	IS_ENABLED()

This is testing CONFIG_ settings, i.e., build time.

> 	cpu_feature_enabled()

This too, indirectly. See

arch/x86/include/asm/disabled-features.h

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
