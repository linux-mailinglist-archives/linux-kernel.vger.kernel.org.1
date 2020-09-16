Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB08926BECF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIPIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIPIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:06:10 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5275CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:06:08 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5F1932B0; Wed, 16 Sep 2020 10:06:03 +0200 (CEST)
Date:   Wed, 16 Sep 2020 10:06:02 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
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
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] x86: tag application address space for devices
Message-ID: <20200916080510.GA32552@8bytes.org>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:30:04AM -0700, Fenghua Yu wrote:
> Ashok Raj (1):
>   Documentation/x86: Add documentation for SVA (Shared Virtual
>     Addressing)
> 
> Fenghua Yu (7):
>   drm, iommu: Change type of pasid to u32
>   iommu/vt-d: Change flags type to unsigned int in binding mm
>   x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
>   x86/msr-index: Define IA32_PASID MSR
>   mm: Define pasid in mm
>   x86/cpufeatures: Mark ENQCMD as disabled when configured out
>   x86/mmu: Allocate/free PASID
> 
> Yu-cheng Yu (1):
>   x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature

For the IOMMU bits:

Acked-by: Joerg Roedel <jroedel@suse.de>
