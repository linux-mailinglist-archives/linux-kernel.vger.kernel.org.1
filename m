Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD62CADE8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgLAVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgLAVAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:00:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50567207FF;
        Tue,  1 Dec 2020 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606856395;
        bh=p9JKBySgEVo6cQvfoDeLWixQOBZhOoCP1Hb20LsMwiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8BOli3nO/sSpK8q8W0P78yKh5sMbgMiWRYD7GbfsPq3OOO6KBtFxV8BzM0l/NxZ5
         X3ngjEiJT/5Aryd3eDwUsxi6QNq/0ZUNdaxuew63tAhsQTDkDvCfz7qZ1VeHVW1m+m
         0x5VuvVHxrFlmcPzA/L6EeiV739sWFPtV57bhXTY=
Date:   Tue, 1 Dec 2020 20:59:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        zhukeqian1@huawei.com, yuzenghui@huawei.com,
        jiangkunkun@huawei.com, wangjingyi11@huawei.com,
        lushenming@huawei.com
Subject: Re: [PATCH v2 0/3] Fix several bugs in KVM stage 2 translation
Message-ID: <20201201205948.GA28178@willie-the-truck>
References: <20201201201034.116760-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201201034.116760-1-wangyanan55@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:10:31AM +0800, Yanan Wang wrote:
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
> The rewrite of page-table code and fault handling add two different handlers
> for "just relaxing permissions" and "map by stage2 page-table walk", that's
> good improvement. Yet, in function user_mem_abort(), conditions where we choose
> the above two fault handlers are not strictly distinguished. This will causes
> guest errors such as infinite-loop (soft lockup will occur in result), because of
> calling the inappropriate fault handler. So, a solution that can strictly
> distinguish conditions is introduced in PATCH 3/3.

For the series:

Acked-by: Will Deacon <will@kernel.org>

Thanks for reporting these, helping me to understand the issues and then
spinning a v2 so promptly.

Will
