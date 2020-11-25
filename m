Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE202C447C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgKYPvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbgKYPvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:51:37 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D04205CB;
        Wed, 25 Nov 2020 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606319496;
        bh=ggNsVrCyQtbsTEL+kuTFOQsecsY7pAs6/oMUkc19NOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdHIWtOiue29cx6/dYEAyJcEbWsHshwrdBLRy9aawhXnzNCNcD8jvlPvkki4FeGX7
         JvU3T4C/OwziNdu8rKuz8FBKf9wMjDPN/rrztBnudXHDYwRe8he8GFCehWR0jEmpjF
         f1Mn2J0ZaBinFF6QYQ1rtsoSRqTurXGEZjgc7ki8=
Date:   Wed, 25 Nov 2020 15:51:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ning Sun <ning.sun@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        catalin.marinas@arm.com, kernel-team@android.com, x86@kernel.org,
        tboot-devel@lists.sourceforge.net,
        Adrian Huang <ahuang12@lenovo.com>,
        iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is
 forced on
Message-ID: <20201125155130.GA16839@willie-the-truck>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
 <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
 <20201125154153.GA29929@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125154153.GA29929@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On Wed, Nov 25, 2020 at 10:41:53AM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Nov 25, 2020 at 02:05:15PM +0000, Will Deacon wrote:
> > On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> > > After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> > > domain"), swiotbl could also be used for direct memory access if IOMMU
> > > is enabled but a device is configured to pass through the DMA translation.
> > > Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> > > if "iommu=pt" kernel parameter is used.
> > 
> > Applied to arm64 (for-next/iommu/fixes), thanks!
> > 
> > [1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
> >       https://git.kernel.org/arm64/c/e2be2a833ab5
> 
> But tboot never ran on ARM. It is a Intel specifc.
> 
> I think either me or Thomas should take this patch.

FWIW, I did check with Thomas before I picked it up. I know it looks weird
going via arm64, but that's only because I'm temporarily handling the IOMMU
tree there (including vt-d changes) while Joerg is away. Since this fixes a
vt-d regression, I thought I'd pick it up along with the other IOMMU fixes I
have queued for -rc6.

That said, if you insist, then I can revert it. I'm really only trying to
help here.

Will
