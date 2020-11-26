Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DE2C527D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgKZKwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgKZKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:52:53 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E2420DD4;
        Thu, 26 Nov 2020 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606387972;
        bh=CdLlb1z7XnjJYWndkvYNE80/TxKCto2us3OCs2U4aPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJXkgxaV5CbnWrqz9QTFxLRPsgOxBrwKZRlu3fdo7aUfupQb8tEba6CNakQALmJHC
         vJggjhdo3I5I9yc5xGxKKwoG/A4pOJXYQDWqkW8cKqfrS1WpoY1k6RZ5V6j9hng2ED
         RBDjI7xRLc8/uFNqZkf/BXzCz074OMjY7ZVn1fz8=
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Fix htmldocs warnings in sysfs-kernel-iommu_groups
Date:   Thu, 26 Nov 2020 10:52:46 +0000
Message-Id: <160638413065.1109527.15725909042368207035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201126090603.1511589-1-baolu.lu@linux.intel.com>
References: <20201126090603.1511589-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 17:06:03 +0800, Lu Baolu wrote:
> Below warnings are fixed:
> 
> Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Enumerated list ends without a blank line; unexpected unindent.
> Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Block quote ends without a blank line; unexpected unindent.

Applied to arm64 (for-next/iommu/default-domains), thanks!

[1/1] iommu: Fix htmldocs warnings in sysfs-kernel-iommu_groups
      https://git.kernel.org/arm64/c/62c9917d9c10

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
