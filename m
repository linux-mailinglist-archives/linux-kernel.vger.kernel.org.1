Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA662EB77B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAFBQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:16:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:28981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbhAFBQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:16:12 -0500
IronPort-SDR: /J4YRNnm9dlDJwYkbR14IaEhRZYXTWnKizjQuahkQlfXl+Fenqiyqi9+t3RBsBK7cNb+cSCoGI
 KFONAnspXPiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="177361739"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="177361739"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 17:14:26 -0800
IronPort-SDR: Uc7toaoXygV4ij3rNtEGMj56KxFlvoN5+ltEWxTtgOBsH+UAbO8oS2jZpkufOe3pwrHjLOjtiy
 I8HD2A7cRDQA==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="379090776"
Received: from jan-mobl.ccr.corp.intel.com (HELO [10.255.29.66]) ([10.255.29.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 17:14:23 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
To:     Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-3-baolu.lu@linux.intel.com>
 <20210105190443.GB12182@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
Date:   Wed, 6 Jan 2021 09:14:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105190443.GB12182@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021/1/6 3:04, Will Deacon wrote:
> On Thu, Dec 31, 2020 at 08:53:21AM +0800, Lu Baolu wrote:
>> With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
>> the iommu ops"), the trace events for dma map/unmap have no users any
>> more. Remove them so that they don't show up under
>> /sys/kernel/debug/tracing/events/intel_iommu. The users should use the
>> map/unmap traces defined in the iommu core from now on.
>>
>> Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/trace/events/intel_iommu.h | 119 -----------------------------
>>   1 file changed, 119 deletions(-)
> 
> Is this needed in 5.11, or can it wait until 5.12?

It's necessary for 5.11 as far as I can see. Without this, users still
see the events under /sys/kernel/debug/tracing/events/intel_iommu, but
they will get nothing traced even they enable the events.

> 
> Will
> 

Best regards,
baolu
