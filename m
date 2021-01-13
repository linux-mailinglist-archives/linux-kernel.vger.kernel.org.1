Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4032F421B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbhAMCzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:55:00 -0500
Received: from foss.arm.com ([217.140.110.172]:57196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbhAMCy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:54:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8231042;
        Tue, 12 Jan 2021 18:54:14 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D06E3F719;
        Tue, 12 Jan 2021 18:54:12 -0800 (PST)
Subject: Re: [PATCH v2 0/5] Optimize iommu_map_sg() performance
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
        joro@8bytes.org, pdaly@codeaurora.org, pratikp@codeaurora.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
 <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
 <20210112163307.GA1199965@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ef9390bc-57de-07fa-30fd-863672685788@arm.com>
Date:   Wed, 13 Jan 2021 02:54:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112163307.GA1199965@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-12 16:33, Christoph Hellwig wrote:
> On Tue, Jan 12, 2021 at 04:00:59PM +0000, Robin Murphy wrote:
>> Out of curiosity, how much of the difference is attributable to actual
>> indirect call overhead vs. the additional massive reduction in visits to
>> arm_smmu_rpm_{get,put} that you fail to mention? There are ways to optimise
>> indirect calling that would benefit *all* cases, rather than just one
>> operation for one particular driver.
> 
> Do we have systems that use different iommu_ops at the same time?
> If not this would be a prime candidate for static call optimizations.

They're not at all common, but such systems do technically exist. It's 
hard to make them work in the current "one set of ops per bus" model, 
but I still have a long-term dream of sorting that out so such setups 
*can* be supported properly. I certainly wouldn't want to make any 
changes that completely close the door on that idea, but any static call 
optimisation that can be done in a config-gated manner should be viable 
for x86 at least. Even better if we could do it with a dynamic 
branch-patching solution that keeps the indirect case as a fallback; 
AFAICS that should be feasible to eagerly apply somewhere around 
iommu_device_register(), then just undo again if another driver ever 
does show up registering a new set of ops that don't match. I'm pretty 
confident that the systems where performance matters most are going to 
be sensible homogeneous ones - on the Arm side the SBSA should see to 
that. The weird mix-and-match cases are typically going to be FPGA 
prototyping systems and esoteric embedded stuff that are worlds away 
from worrying about keeping up with line rate on a 40GbE NIC...

> Also I've been pondering adding direct calls to the iommu dma ops like
> we do for DMA direct.  This would allow to stop using dma_ops entirely
> for arm64.

Yes, now that we're starting to get things sufficiently consolidated 
behind iommu-dma that might be a reasonable thing to try, although given 
the amount of inherent work further down in the IOVA and IOMMU layers 
that dwarfs that of the direct case, I doubt that reducing the initial 
dispatch overhead would make any noticeable difference in practice.

Robin.
