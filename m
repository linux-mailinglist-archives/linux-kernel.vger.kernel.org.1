Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433432FBBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391479AbhASPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:55:34 -0500
Received: from foss.arm.com ([217.140.110.172]:37278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbhASPxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:53:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79CDDD6E;
        Tue, 19 Jan 2021 07:52:43 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CA143F66E;
        Tue, 19 Jan 2021 07:52:42 -0800 (PST)
Subject: Re: [PATCH 1/2 v2] dma-iommu: use static-key to minimize the impact
 in the fast-path
To:     Christoph Hellwig <hch@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-2-lijiang@redhat.com>
 <20210119152641.GA3453587@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c961822e-e768-9d20-87cf-85db95b6aab6@arm.com>
Date:   Tue, 19 Jan 2021 15:52:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119152641.GA3453587@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19 15:26, Christoph Hellwig wrote:
> On Tue, Jan 19, 2021 at 07:16:15PM +0800, Lianbo Jiang wrote:
>> +static DEFINE_STATIC_KEY_FALSE(__deferred_attach);
> 
> Why the strange underscores?  Wouldn't iommu_deferred_attach_enabled
> be a better name?
> 
>> -	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
>> +	if (static_branch_unlikely(&__deferred_attach) &&
>> +	    iommu_dma_deferred_attach(dev, domain))
> 
> Also insted of duplicating this logic in three places, maybe rename
> iommu_dma_deferred_attach to __iommu_dma_deferred_attach and create
> a small inline wrapper for it?

Once patch #2 is in place, I really don't see any point. The "helper" 
would add a minimum of 5 lines to save at most 3, and would have to be 
annotated as always_inline - which a whole other camp of people would 
probably object to - in order for the static branch to be properly useful.

It's not as if this is a complex or hard-to-read expression, so IMO 
having 3 lines repeated 3 times is objectively better than having 2 
lines necessarily repeated 3 times plus having to scroll up and find 
several more lines to follow what it's doing.

Robin.
