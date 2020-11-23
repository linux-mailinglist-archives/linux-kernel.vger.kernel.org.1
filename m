Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856E32C0E47
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbgKWO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgKWO4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:56:11 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7620420658;
        Mon, 23 Nov 2020 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606143370;
        bh=XUm8OV+H1ot7qmV/No9ou5eqPJW8U55vgkCpuzquesU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLvhjSzxb01JFT7bTsyemJ7VwGR2FQh0Nx3EVYr/RQNdLEZjSTfutOLl8yWkJJgCt
         UToUSkVFwohasfZMWNu27JglVMGGXy7IZMRv5AE5wbWHTia9HHBzGvPSErzFRQsnqF
         wuOwImNxJG+mc9eUYs8IbGnTbO+hjgsAOQRhDKb8=
Date:   Mon, 23 Nov 2020 14:56:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Jon.Grimm@amd.com, bp@suse.de
Subject: Re: [PATCH v2] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Message-ID: <20201123145605.GA11033@willie-the-truck>
References: <20201105145832.3065-1-suravee.suthikulpanit@amd.com>
 <c189684a-27e5-c0c2-1629-063b9fb16957@amd.com>
 <35c6f7d8-f889-8c3c-2e01-1a9226babf0a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c6f7d8-f889-8c3c-2e01-1a9226babf0a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:19:01PM -0600, Brijesh Singh wrote:
> On 11/19/20 8:30 PM, Suravee Suthikulpanit wrote:
> > On 11/18/20 5:57 AM, Will Deacon wrote:
> > > I think I'm missing something here. set_memory_4k() will break the
> > kernel
> > > linear mapping up into page granular mappings, but the IOMMU isn't
> > using
> > > that mapping, right?
> >
> > That's correct. This does not affect the IOMMU, but it affects the PSP
> > FW.
> >
> > > It's just using the physical address returned by
> > iommu_virt_to_phys(), so why does it matter?
> > >
> > > Just be nice to capture some of this rationale in the log,
> > especially as
> > > I'm not familiar with this device.
> >
> > According to the AMD SEV-SNP white paper
> > (https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf),
> > the Reverse Map Table (RMP) contains one entry for every 4K page of
> > DRAM that may be used by the VM. In this case, the pages allocated by
> > the IOMMU driver are added as 4K entries in the RMP table by the
> > SEV-SNP FW.
> >
> > During the page table walk, the RMP checks if the page is owned by the
> > hypervisor. Without calling set_memory_4k() to break the mapping up
> > into 4K pages, pages could end up being part of large mapping (e.g. 2M
> > page), in which the page access would be denied and result in #PF.
> 
> 
> Since the page is added as a 4K page in the RMP table by the SEV-SNP FW,
> so we need to split the physmap to ensure that this page will be access
> with a 4K mapping from the x86. If the page is part of large page then
> write access will cause a RMP violation (i.e #PF), this is because SNP
> hardware enforce that the CPU page level walk must match with page-level
> programmed in the RMP table.

Got it; thanks.

> > >> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion
> > wait write-back semaphore")
> > >
> > > I couldn't figure out how that commit could cause this problem.
> > Please can
> > > you explain that to me?
> >
> > Hope this helps clarify. If so, I'll update the commit log and send
> > out V3.

Cheers. No need for a v2, as I've queued this up with a Link: tag.

Will
