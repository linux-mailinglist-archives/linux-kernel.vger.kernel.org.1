Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0332CBCFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgLBMZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgLBMZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:25:27 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C34221FE;
        Wed,  2 Dec 2020 12:24:47 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kkRBc-00FKdk-2e; Wed, 02 Dec 2020 12:24:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     yuzenghui@huawei.com, jiangkunkun@huawei.com,
        lushenming@huawei.com, wanghaibin.wang@huawei.com,
        zhukeqian1@huawei.com, yezengruan@huawei.com,
        wangjingyi11@huawei.com
Subject: Re: [PATCH v2 0/3] Fix several bugs in KVM stage 2 translation
Date:   Wed,  2 Dec 2020 12:24:38 +0000
Message-Id: <160691185017.266917.9856801601483446789.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201201034.116760-1-wangyanan55@huawei.com>
References: <20201201201034.116760-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gshan@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, julien.thierry.kdev@gmail.com, james.morse@arm.com, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, will@kernel.org, qperret@google.com, wangyanan55@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, lushenming@huawei.com, wanghaibin.wang@huawei.com, zhukeqian1@huawei.com, yezengruan@huawei.com, wangjingyi11@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 04:10:31 +0800, Yanan Wang wrote:
> When installing a new pte entry or updating an old valid entry in stage 2
> translation, we use get_page()/put_page() to record page_count of the page-table
> pages. PATCH 1/3 aims to fix incorrect use of get_page()/put_page() in stage 2,
> which might make page-table pages unable to be freed when unmapping a range.
> 
> When dirty logging of a guest with hugepages is finished, we should merge tables
> back into a block entry if adjustment of huge mapping is found necessary.
> In addition to installing the block entry, we should not only free the non-huge
> page-table pages but also invalidate all the TLB entries of non-huge mappings for
> the block. PATCH 2/3 adds enough TLBI when merging tables into a block entry.
> 
> [...]

Applied to kvm-arm64/fixes-5.10, thanks!

[1/3] KVM: arm64: Fix memory leak on stage2 update of a valid PTE
      commit: 5c646b7e1d8bcb12317426287c516dfa4c5171c2
[2/3] KVM: arm64: Fix handling of merging tables into a block entry
      commit: 3a0b870e3448302ca2ba703bea1b79b61c3f33c6
[3/3] KVM: arm64: Add usage of stage 2 fault lookup level in user_mem_abort()
      commit: 7d894834a305568a0168c55d4729216f5f8cb4e6

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


