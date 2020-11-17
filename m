Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C202B7254
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgKQXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQXYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:24:35 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CF7208B8;
        Tue, 17 Nov 2020 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655474;
        bh=DBKJOtjbMI3Jf+vIBiv48gZMtpfWzjVButwb4YODpxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LilzwPqewa1mZV61sPMMhaW6NNBS7lkwEtlxi+2C5T0U/xrMcdYWObdOeTOUgERii
         d5E8a6trunuE5+91q4kEHh8yI7EWncM1XQXEhr+/wAT5fmfPB/9vuAgBDm+RJjNsay
         np8iKj7ecgMhTR7Cq4FEpvikyGo6OrHrWWpctD0c=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Chen Jun <chenjun102@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, rui.xiang@huawei.com,
        guohanjun@huawei.com
Subject: Re: [PATCH] iommu: Modify the description of iommu_sva_unbind_device
Date:   Tue, 17 Nov 2020 23:24:27 +0000
Message-Id: <160565435695.2778655.8468906444241988045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201023064827.74794-1-chenjun102@huawei.com>
References: <20201023064827.74794-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 06:48:27 +0000, Chen Jun wrote:
> iommu_sva_unbind_device has no return value.
> 
> Remove the description of the return value of the function.

Applied to arm64 (for-next/iommu/misc), thanks!

[1/1] iommu: Modify the description of iommu_sva_unbind_device
      https://git.kernel.org/arm64/c/6243f572a18d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
