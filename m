Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A82712B2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 08:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgITGgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 02:36:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:59924 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgITGgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 02:36:54 -0400
IronPort-SDR: OM501Ysg/tZ+CsDdS3Nxi57CyzoOLVfNZy40sW7fAuJVHfTF4C4yf67ZF/aenapTFInoFs1l0l
 /KEATbhftZDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="157597866"
X-IronPort-AV: E=Sophos;i="5.77,281,1596524400"; 
   d="scan'208";a="157597866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2020 23:36:53 -0700
IronPort-SDR: jabbN3qQsO/QbcFPJwnrAIPouqbK8zIgTL8nP5gVkx2hTZ+WRQO216CTjg+hH0Rcn4dLkQQA4T
 ixr2XHqNPtSQ==
X-IronPort-AV: E=Sophos;i="5.77,281,1596524400"; 
   d="scan'208";a="308504530"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.187]) ([10.254.213.187])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2020 23:36:50 -0700
Cc:     baolu.lu@linux.intel.com, Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [Intel-gfx] [PATCH v3 0/6] Convert the intel iommu driver to the
 dma-iommu api
To:     Logan Gunthorpe <logang@deltatee.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fe94760f-3c10-4222-ec87-291c01325fef@linux.intel.com>
Date:   Sun, 20 Sep 2020 14:36:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On 2020/9/19 4:47, Logan Gunthorpe wrote:
> Hi Lu,
> 
> On 2020-09-11 9:21 p.m., Lu Baolu wrote:
>> Tom Murphy has almost done all the work. His latest patch series was
>> posted here.
>>
>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
>>
>> Thanks a lot!
>>
>> This series is a follow-up with below changes:
>>
>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>> letter.
>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>> bounce buffers" to make the bounce buffer work for untrusted devices.
>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>
> 
> I'm trying to test this on an old Sandy Bridge, but found that I get
> spammed with warnings on boot. I've put a sample of a few of them below.
> They all seem to be related to ioat.
> 
> I had the same issue with Tom's v2 but never saw this on his v1.

Have you verified whether this could be reproduced with the lasted
upstream kernel (without this patch series)?

Best regards,
baolu
