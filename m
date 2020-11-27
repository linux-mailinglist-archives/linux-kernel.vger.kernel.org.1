Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4BA2C625F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgK0J6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgK0J6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:58:07 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B22021D91;
        Fri, 27 Nov 2020 09:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606471086;
        bh=GZ4Id4NPj/0z4l0L3vDEF+7KrF0Y8aco3ppn/S+WkzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrujzITmO0NEf5k1oxkMxuoStmoJFWbAG/YdAhpWalkHT/uOeLZPwhdfc3ag97xUq
         hw2bnfBO6IDMvsPPUiwkJvScGI2ke83QDGU/NcSk9lFcPNEIWAP62nK2Xokjjyo+Ef
         KXX1DLXv9Kx74SLWRBe+dA6EPUfky8BkY2UgTZyw=
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove set but not used variable
Date:   Fri, 27 Nov 2020 09:58:01 +0000
Message-Id: <160647075022.1960777.14243304052525988022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201127013308.1833610-1-baolu.lu@linux.intel.com>
References: <20201127013308.1833610-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 09:33:08 +0800, Lu Baolu wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/iommu/intel/iommu.c:5643:27: warning: variable 'last_pfn' set but not used [-Wunused-but-set-variable]
> 5643 |  unsigned long start_pfn, last_pfn;
>      |                           ^~~~~~~~
> 
> This variable is never used, so remove it.

Applied to arm64 (for-next/iommu/vt-d), thanks!

[1/1] iommu/vt-d: Remove set but not used variable
      https://git.kernel.org/arm64/c/405a43cc0047

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
