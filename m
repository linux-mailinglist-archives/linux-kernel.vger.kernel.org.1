Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B326774C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 04:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgILCze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 22:55:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:57086 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgILCzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 22:55:33 -0400
IronPort-SDR: SUQYdRRj1tnBuh/6PtvbI5ZkBUzFA26tZOHyf/xP1wCtXBBiuAgpcDCngPZUyKLTKQygqWRa+3
 K8wwYIkVrxrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="158923233"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="158923233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 19:55:27 -0700
IronPort-SDR: vmC/Wd5hOLTiV2dszSt254LC3VzenID53RVvXqFy/H+n6u9sy4umjtG4kNvygYn98l+geOki29
 l7U+xqRl/kVA==
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="450185364"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.203]) ([10.254.212.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 19:55:25 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 2/5] iommu: Add iommu_dma_free_cpu_cached_iovas
 function
To:     Christoph Hellwig <hch@infradead.org>
Cc:     baolu.lu@linux.intel.com, Tom Murphy <murphyt7@tcd.ie>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-3-murphyt7@tcd.ie>
 <b30be538-a4dd-987e-78df-ff23b703bbe3@linux.intel.com>
 <20200909070540.GA28245@infradead.org>
Message-ID: <5b146104-34cb-00c5-fecc-0cbc41838682@linux.intel.com>
Date:   Sat, 12 Sep 2020 10:55:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909070540.GA28245@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/9 15:05, Christoph Hellwig wrote:
>> +static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>> +                                                  struct iommu_domain
>> *domain)
> 
> This adds a crazy long line.  Which is rather pointless as other
> bits of code in the patch use the more compact two tab indentations
> for the prototype continuation lines anyway.
>

Okay. I will use two tabs instead.

Best regards,
baolu

