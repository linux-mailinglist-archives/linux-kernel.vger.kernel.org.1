Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7091E26D55F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIQH4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIQHys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:54:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBEBC061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:54:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1053007b81a97eebdb4df7.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:7b81:a97e:ebdb:4df7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F19EE1EC0286;
        Thu, 17 Sep 2020 09:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600329226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ewrYTBLqmR0WdfUwbHvpOSzEiXe9R9x+7NtUrZAyuck=;
        b=jahzhXRj6VqJO/u8dRJrB6L/MOuZjY9smlFNVagk55dbglzgn9wOm6eYabLOPPJHzddEKe
        iw9Bp6bs5HWH6CcFiM3g9kuEjxizytl3FF/vT+ANglOWtc1wSI/mN0xJGGZcIFfERAJbhE
        5xkQQU1Cfslq+Fh+Pl2qMf7FlJXmsIQ=
Date:   Thu, 17 Sep 2020 09:53:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v8 3/9] Documentation/x86: Add documentation for SVA
 (Shared Virtual Addressing)
Message-ID: <20200917075338.GC31960@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:30:07AM -0700, Fenghua Yu wrote:
> +Background
> +==========
> +
> +Shared Virtual Addressing (SVA) allows the processor and device to use the
> +same virtual addresses avoiding the need for software to translate virtual
> +addresses to physical addresses. SVA is what PCIe calls Shared Virtual
> +Memory (SVM).
> +
> +In addition to the convenience of using application virtual addresses
> +by the device, it also doesn't require pinning pages for DMA.
> +PCIe Address Translation Services (ATS) along with Page Request Interface
> +(PRI) allow devices to function much the same way as the CPU handling
> +application page-faults. For more information please refer to the PCIe
> +specification Chapter 10: ATS Specification.
> +
> +Use of SVA requires IOMMU support in the platform. IOMMU also is required
> +to support PCIe features ATS and PRI. ATS allows devices to cache
> +translations for virtual addresses. The IOMMU driver uses the mmu_notifier()
> +support to keep the device TLB cache and the CPU cache in sync. PRI allows
> +the device to request paging the virtual address by using the CPU page tables
> +before accessing the address.

That still reads funny, the "the device to request paging the virtual
address" part. Do you mean that per chance here:

"Before the device can access that address, the device uses the PRI in
order to request the virtual address to be paged in into the CPU page
tables."

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
