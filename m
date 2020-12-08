Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D5B2D2EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgLHPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgLHPzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:20 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     joro@8bytes.org, John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com
Subject: Re: [PATCH 0/3] IOMMU: Some IOVA code tidy-up
Date:   Tue,  8 Dec 2020 15:54:30 +0000
Message-Id: <160743688897.2940119.3009790405455404921.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
References: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 02:34:49 +0800, John Garry wrote:
> This series contains some minor tidy-ups by deleting an unreferenced
> function and unexporting some functions, highlighted by:
> https://lore.kernel.org/linux-iommu/6e09d847-fb7f-1ec1-02bf-f0c8b315845f@huawei.com/T/#med5a019f9d3835c162c16a48f34d05cc0111b0ca
> 
> John Garry (3):
>   iommu: Delete split_and_remove_iova()
>   iommu: Stop exporting alloc_iova_mem()
>   iommu: Stop exporting free_iova_mem()
> 
> [...]

Applied to arm64 (for-next/iommu/iova), thanks!

[1/3] iommu: Delete split_and_remove_iova()
      https://git.kernel.org/arm64/c/2f24dfb71208
[2/3] iommu: Stop exporting alloc_iova_mem()
      https://git.kernel.org/arm64/c/51b70b817b18
[3/3] iommu: Stop exporting free_iova_mem()
      https://git.kernel.org/arm64/c/176cfc187c24

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
