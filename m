Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0432C5A53
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404108AbgKZRNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403901AbgKZRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:13:43 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9638821D7E;
        Thu, 26 Nov 2020 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606410822;
        bh=a6F69KFSEwwbGkU1jI6mipEDkefv4aWtBNdY/XrsELY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moMV+t+tDMHqyhOO24Sk587oGpzApzz4zos+YpOXaOYvkdPUUPbZ5Mu0eZ7y6ZwGG
         rLs8bs8su7iUWwjX7EWgDvYhC8MvDJOkj+hHzRHPrV34hpv+D10plx/R2imdwP7kwD
         sdsYLApmKeC2dQYLz9LekNKKuXu/EIHEiEbw+3O0=
From:   Will Deacon <will@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] iommu: return error code when it can't get group
Date:   Thu, 26 Nov 2020 17:13:33 +0000
Message-Id: <160640241299.1420618.8864801005246574667.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201126133825.3643852-1-yangyingliang@huawei.com>
References: <20201126133825.3643852-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 21:38:25 +0800, Yang Yingliang wrote:
> It's better to return error code if it can't get group
> in iommu_probe_device(). It's no function change.

Applied to arm64 (for-next/iommu/misc), thanks!

[1/1] iommu: return error code when it can't get group
      https://git.kernel.org/arm64/c/058236eef606

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
