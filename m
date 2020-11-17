Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E272B7256
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgKQXYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgKQXYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:24:38 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406D720E65;
        Tue, 17 Nov 2020 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655478;
        bh=ykBfaRygbX5Nw3if+S2/MztoXt+36i7yOP+dAhUU160=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ5yCFwnqDrHfIUSeFtOe7Y7I/hz5GzuTTM6WqQ5rxOKayYl3T/BMO7PwZnyLtWaO
         IKd/ZAKW9b0YoaJ2x5p4bPH15w8iWEDXwp3o9YSBdtzlDfEGEPy+9jX9j4riZ+LzTw
         QW72i6M5fUrcnzA9hihBFkQeIgc+ITMUvrol46Yk=
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Liu Yi L <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iommu/vt-d: include conditionally on CONFIG_INTEL_IOMMU_SVM
Date:   Tue, 17 Nov 2020 23:24:28 +0000
Message-Id: <160565219047.2773717.5820442945194882017.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
References: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Nov 2020 21:59:51 +0100, Lukas Bulwahn wrote:
> Commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced intel_iommu_sva_invalidate() when CONFIG_INTEL_IOMMU_SVM.
> This function uses the dedicated static variable inv_type_granu_table
> and functions to_vtd_granularity() and to_vtd_size().
> 
> These parts are unused when !CONFIG_INTEL_IOMMU_SVM, and hence,
> make CC=clang W=1 warns with an -Wunused-function warning.
> 
> [...]

Applied to arm64 (for-next/iommu/vt-d), thanks!

[1/1] iommu/vt-d: include conditionally on CONFIG_INTEL_IOMMU_SVM
      https://git.kernel.org/arm64/c/68dd9d89eaf5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
