Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1792B903C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKSKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgKSKhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:37:07 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92906246D3;
        Thu, 19 Nov 2020 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605782227;
        bh=TKCufnkL7v52leDjZA5aQSovB4YY3GyC4v0oEhprvno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xc3qmQwfX6dCz0aRkdTQiS5LS/CsnHRsCpU3UTuRURQqSTxLJ70tsKnJ9AXdJzIqI
         4iCg2gFoeA6HqQr1akzY3dld3Omt3QQpH785pVAxGiICa6/uOVP3zKvor98LoUzg9J
         GgXNxRjoxXp9eFoLUTFyS8mAFstlCWSyn7DwtihM=
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix compile error with CONFIG_PCI_ATS not set
Date:   Thu, 19 Nov 2020 10:37:01 +0000
Message-Id: <160577954777.1956553.12280033649864052626.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119055119.2862701-1-baolu.lu@linux.intel.com>
References: <20201119055119.2862701-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 13:51:19 +0800, Lu Baolu wrote:
> Fix the compile error below (CONFIG_PCI_ATS not set):
> 
> drivers/iommu/intel/dmar.c: In function ‘vf_inherit_msi_domain’:
> drivers/iommu/intel/dmar.c:338:59: error: ‘struct pci_dev’ has no member named ‘physfn’; did you mean ‘is_physfn’?
>   338 |  dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
>       |                                                           ^~~~~~
>       |                                                           is_physfn

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/vt-d: Fix compile error with CONFIG_PCI_ATS not set
      https://git.kernel.org/arm64/c/3645a34f5b96

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
