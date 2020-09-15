Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836E326A917
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgIOPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:52:36 -0400
Received: from verein.lst.de ([213.95.11.211]:48140 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbgIOPJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:09:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D42568AFE; Tue, 15 Sep 2020 17:09:30 +0200 (CEST)
Date:   Tue, 15 Sep 2020 17:09:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200915150929.GA19770@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com> <20200915140719.GA14831@lst.de> <f5cba632-421a-f375-3697-51a182a53a32@oracle.com> <20200915142624.GA16005@lst.de> <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:40:39AM -0400, Thomas Tai wrote:
>> +++ b/include/linux/dma-direct.h
>> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>>   {
>>   	dma_addr_t end = addr + size - 1;
>>   -	if (!dev->dma_mask)
>> -		return false;
>> -
>
> I am concerned that some drivers may rely on this NULL checking. Would you 
> think we can keep this checking and use the following WARN_ON_ONCE()?

dma_capable is not a helper for drivers, but just for dma-direct
and related code.  And this patch adds the checks for the three
places how we call into the ->map* methods.
