Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7552EB52A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbhAEWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbhAEWHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:07:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AF8422D75;
        Tue,  5 Jan 2021 22:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609884429;
        bh=QKouQDs5mHt1pS/Y2SeBb6oJBFvZCDfzTFkJdGgVs1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ITOWwX2rcOhhLmvDkNKzFrD2LxFRdIE0wkVUq0VDROLZxXGOSsH+fAUPM4+GQ6+vK
         K8z72IFnwhDIH94i/fVMzO4hM/69U7wRGS5CsnHgKPUp8rhUMT3r7m37Y1PqlGAbsi
         VaAx/35TIeN3xYMemCqE4xGm6NoT+mTTFTIFtpbDfseCchoft1LsuWA+jCbZwOkLGz
         227YFFVlq60iGVAc97odi1HkrxwJcMdG1HojSQrAwLegNs3SurTiZTeQjtFQVDztfF
         vTPe+A0scAMsVwAc8O6xyiadPA60uav2BIh9B1DLcFWArEkGF4r1t6wkdzF+UUyR1a
         IqcFXNJkiB9Bw==
From:   Will Deacon <will@kernel.org>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iommu/intel: Fix memleak in intel_irq_remapping_alloc
Date:   Tue,  5 Jan 2021 22:07:00 +0000
Message-Id: <160987392685.28117.15806761775546828125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
References: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 13:18:37 +0800, Dinghao Liu wrote:
> When irq_domain_get_irq_data() or irqd_cfg() fails
> at i == 0, data allocated by kzalloc() has not been
> freed before returning, which leads to memleak.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/intel: Fix memleak in intel_irq_remapping_alloc
      https://git.kernel.org/arm64/c/ff2b46d7cff8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
