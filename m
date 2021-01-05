Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED08B2EB34A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbhAETF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbhAETF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:05:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E6AA22D5B;
        Tue,  5 Jan 2021 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609873488;
        bh=pdXRW916AxUwPNH0kbaMgbe9akT1S9yC68nIHVv6WCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Can7n0XI6x+F1komFvkalUvv/x7rXUScyw9/9a0C3+bDiPdqzD4xLrOCtLaXzpeBU
         1gBZ5w5GpyUdxf4dwuET/BE/ul0xSGcViKsDl09rIruNaRgZ0c1dOQkV2HLlhZYiO7
         F2dwAYmCeyAWavyKHFvJWByFNocak2A51pTJgDl03Cl6//+l7A+XjBe4kV1eTP8W41
         dh/gAJWdTQCWkV9L48A7bb+1ujJ/CEzFCz7BraSbDL9CJJOraRLzj0+KBpiMkgQ/W7
         Z+8h5QFeBvhgEO/sReSWgFkGuEyW+Kgixxeo0mkfqKfmsnzhW63qEyB5ZwNuTD3WfF
         gr47l397khkEQ==
Date:   Tue, 5 Jan 2021 19:04:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
Message-ID: <20210105190443.GB12182@willie-the-truck>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231005323.2178523-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 08:53:21AM +0800, Lu Baolu wrote:
> With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
> the iommu ops"), the trace events for dma map/unmap have no users any
> more. Remove them so that they don't show up under
> /sys/kernel/debug/tracing/events/intel_iommu. The users should use the
> map/unmap traces defined in the iommu core from now on.
> 
> Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/trace/events/intel_iommu.h | 119 -----------------------------
>  1 file changed, 119 deletions(-)

Is this needed in 5.11, or can it wait until 5.12?

Will
