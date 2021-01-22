Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBF30048C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbhAVNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbhAVNuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:50:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1339023A03;
        Fri, 22 Jan 2021 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611323384;
        bh=ATGg834zTjJdh8VUvM7w7CzgPmIsq9O4h4GoJ1kWZVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5LtdfjyO0ZJ2wQDdYwmQ4PqiVRch4YhpzCOMXbf0r0S7nuVSVA1jIjWE9dC+tHL4
         KWOdvanqNypQJ07oVpa2sscyyVLOiKwFzXZPJUCCuf8bCfCrnGSABRiknluMJmk7Rj
         a/0Uy0RBlsq8Xh124Ljo4RMqB4854HffS2HTDcqaWWQBUu4+kRCt0GRIN07+wLXBhe
         /lkGqupa4PqqJkWlg2hZC0XcQuLrveaBIKYj/k/xDpnFHI/JLxfHD5dH/5ZZHZHn/q
         DWOTARY7saHkKmti1FJ9U7Yioy+QjHefkFSLS7gbEYaeds1zvwLIl4s1fwm/VlJcLP
         axaoW6gFiCMvg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify code
Date:   Fri, 22 Jan 2021 13:49:33 +0000
Message-Id: <161132233107.235458.16848048173103026904.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122131448.1167-1-thunder.leizhen@huawei.com>
References: <20210122131448.1167-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 21:14:48 +0800, Zhen Lei wrote:
> No functional change.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify code
      https://git.kernel.org/will/c/932bc8c7d742

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
