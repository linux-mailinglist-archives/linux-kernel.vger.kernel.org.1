Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7B2EB53C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbhAEWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbhAEWHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:07:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48D9322DFB;
        Tue,  5 Jan 2021 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609884432;
        bh=eSEXOr41V/dBpsepFxXoVybj3TSEep3A1pAtN7NQDEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBNd20msi0GKzy9EZ413szRxyQFByA2T3rvR8Vutp/ZAo0nM1NBs3LGyr/A0twlKf
         Weg5Lk8+/BeFIvXhpp3uqjFihD4fwDB6YKzqr+w39ZmACRNObBtoMLk2vkcc6wfdgg
         vFbaNRZULRaGgTGrsJXcBGoMwWLOIZOQC3J5R6oMOtr0gMEylqvNXd19a8m/tj0jLk
         j8IuzwtmuSigav1t4ghngbinXLg2yyxAPZsRncva55j8OTtTSv13pcyUqVWtzVX8mo
         eDQdDiqBSCW/gtw3K7mW5PyD3ZiVEg4YJjm8w8Tt04S/cpMc6mnBSgRkhBLCp2SvSv
         8SlWzg3Lc+ACg==
From:   Will Deacon <will@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Set iommu->int_enabled consistently when interrupts are set up
Date:   Tue,  5 Jan 2021 22:07:01 +0000
Message-Id: <160987442134.30234.7295735708927658122.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
References: <20210104132250.GE32151@zn.tnic> <20210104232353.GJ32151@zn.tnic> <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021 01:32:51 +0000, David Woodhouse wrote:
> When I made the INTCAPXT support stop gratuitously pretending to be MSI,
> I missed the fact that iommu_setup_msi() also sets the ->int_enabled
> flag. I missed this in the iommu_setup_intcapxt() code path, which means
> that a resume from suspend will try to allocate the IRQ domains again,
> accidentally re-enabling interrupts as it does, resulting in much sadness.
> 
> Lift out the bit which sets iommu->int_enabled into the iommu_init_irq()
> function which is also where it gets checked.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/amd: Set iommu->int_enabled consistently when interrupts are set up
      https://git.kernel.org/arm64/c/12bc4570c14e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
