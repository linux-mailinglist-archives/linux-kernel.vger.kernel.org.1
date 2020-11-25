Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED592C41B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgKYOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKYOF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:05:27 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBAF3206D4;
        Wed, 25 Nov 2020 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313126;
        bh=o/3qU9yUVsMRXBPb0/qlY5lVdmNZJsg8udd9M106/9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8DCxn5J/JaU/e93TuntnK4oh0Kn/xsPcKugLOLB+XfEZqAVNtLJt4J7FrmsO4IUe
         goFFx0ywrjqH6A070RdD+kHWfNDB9KqRmCXZzG3UiO/RNLy4yPLrCG3ChyEIX6BWsF
         s0CfmZ/VDxamoqXudWTtMmtU4s03HAkWJG3iAXH8=
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ning Sun <ning.sun@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        tboot-devel@lists.sourceforge.net,
        Adrian Huang <ahuang12@lenovo.com>,
        iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
Date:   Wed, 25 Nov 2020 14:05:15 +0000
Message-Id: <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> domain"), swiotbl could also be used for direct memory access if IOMMU
> is enabled but a device is configured to pass through the DMA translation.
> Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> if "iommu=pt" kernel parameter is used.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
      https://git.kernel.org/arm64/c/e2be2a833ab5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
