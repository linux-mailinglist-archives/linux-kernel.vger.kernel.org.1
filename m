Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172DD2C41B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgKYOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKYOF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:05:29 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7B620684;
        Wed, 25 Nov 2020 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313128;
        bh=nQ5hup1fwwMSQrELeFpnjHs2tiNhQ+aN5OpbuL8bPIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVnOunIj2kQNdkIW6L3SbrZ+v0kGNwsoPv2GtVlUXyyzlXJP4jdFboN8acLulnAso
         s5DujBJ9qKxE5XqV6zIxB57UyG/FWo2oUZiem3aIptBf3T/7ZNbxNceF0fzJm+mMC3
         ud+nxxBIQ9wQgOPF4/7pUDB3GZmV0/kjFtaFWd6k=
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v10 0/4] iommu: Add support to change default domain of an iommu group
Date:   Wed, 25 Nov 2020 14:05:16 +0000
Message-Id: <160630647396.4097517.6548182516752300652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
References: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 21:06:00 +0800, Lu Baolu wrote:
> The last post of this series:
> 
> https://lore.kernel.org/linux-iommu/20201121135620.3496419-1-baolu.lu@linux.intel.com/
> 
> Change log in this series:
>  1. Changes according to comments at
>     https://lore.kernel.org/linux-iommu/20201123120449.GB10233@willie-the-truck/
>     - Remove the unnecessary iommu_get_mandatory_def_domain_type()
> 
> [...]

Applied to arm64 (for-next/iommu/default-domains), thanks!

[1/4] iommu: Move def_domain type check for untrusted device into core
      https://git.kernel.org/arm64/c/28b41e2c6aeb
[2/4] iommu: Add support to change default domain of an iommu group
      https://git.kernel.org/arm64/c/08a27c1c3ecf
[3/4] iommu: Take lock before reading iommu group default domain type
      https://git.kernel.org/arm64/c/0b8a96a3120f
[4/4] iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file
      https://git.kernel.org/arm64/c/63a816749d86

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
