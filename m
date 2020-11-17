Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2A2B71E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgKQW5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgKQW5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:57:22 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC03522202;
        Tue, 17 Nov 2020 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605653841;
        bh=KgP6kIuW2/56O4LdccOpIcXq+RuiisQme+VZtaE2LFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D73w5s+6pbC0lfIN6P0E9PzWBfZfNHkLIspBx7xGiSb9StntWhr6b+6rRYzmOTmmC
         SlPll7ltr48r+vg3hewCLk0famlOjGYTs1XdwidEEC0KWezG0bnkr/X10ifPYFzy2n
         +sa/U5hVGNMnYarhrP3GfLUORm9edCExp+AOfs30=
Date:   Tue, 17 Nov 2020 22:57:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Message-ID: <20201117225717.GF524@willie-the-truck>
References: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:18:24PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
> and the completion wait write-back regions. However, when allocating
> the pages, they could be part of large mapping (e.g. 2M) page.
> This causes #PF due to the SNP RMP hardware enforces the check based
> on the page level for these data structures.

Please could you include an example backtrace here?

> So, fix by calling set_memory_4k() on the allocated pages.

I think I'm missing something here. set_memory_4k() will break the kernel
linear mapping up into page granular mappings, but the IOMMU isn't using
that mapping, right? It's just using the physical address returned by
iommu_virt_to_phys(), so why does it matter?

Just be nice to capture some of this rationale in the log, especially as
I'm not familiar with this device.

> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")

I couldn't figure out how that commit could cause this problem. Please can
you explain that to me?

Cheers,

Will
