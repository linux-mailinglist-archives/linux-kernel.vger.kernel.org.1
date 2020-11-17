Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5342B7258
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgKQXYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgKQXYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:24:40 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A976421D91;
        Tue, 17 Nov 2020 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655480;
        bh=qYz2LNdZNi0aiX1wyp0QjexK42xd/yudcPZ60Vwb+1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bN2fZGAXDDeG9uCBKlptr8v/nlDi28S7SdjahoRESEKjcT9h9nSguvM/TbqXNTjuh
         hFYdRL/I28utCz99QExXTv/DFtQSJ888jdQnt0tzsVNERU0mtu2YnPa0Wx12teFyXr
         k3xSvkO0maYh/nxhg4ba+S0jfWwS91Wwdwg1pQgQ=
From:   Will Deacon <will@kernel.org>
To:     "vjitta@codeaurora.org" <vjitta@codeaurora.org>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, robin.murphy@arm.com,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v5 1/2] iommu/iova: Retry from last rb tree node if iova search fails
Date:   Tue, 17 Nov 2020 23:24:29 +0000
Message-Id: <160565419447.2778079.10643367410535150698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 13:14:23 +0530, vjitta@codeaurora.org wrote:
> When ever a new iova alloc request comes iova is always searched
> from the cached node and the nodes which are previous to cached
> node. So, even if there is free iova space available in the nodes
> which are next to the cached node iova allocation can still fail
> because of this approach.
> 
> Consider the following sequence of iova alloc and frees on
> 1GB of iova space
> 
> [...]

Applied to arm64 (for-next/iommu/iova), thanks!

[1/2] iommu/iova: Retry from last rb tree node if iova search fails
      https://git.kernel.org/arm64/c/4e89dce72521
[2/2] iommu/iova: Free global iova rcache on iova alloc failure
      https://git.kernel.org/arm64/c/6fa3525b455a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
