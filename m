Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0F28DA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgJNHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:31:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:21635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgJNHbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:31:40 -0400
IronPort-SDR: MrZ0Id//lahQKv3GGq2D4KHlKnGmlZwIobQsI+vvxjJBcP1kjSQcUgP7XOrXxIbcu9HBWQye2r
 zFHCriSNg/oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166175102"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="166175102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 00:31:38 -0700
IronPort-SDR: Q/+QmmCHxC00fwQEG7cm2Y/Tvul4iJK2EQtiK4wSrB0kAVxZDKyYHdNvbg7IpB95XB4QXdle29
 27vjgmGxEXZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="345558605"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2020 00:31:36 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
To:     Bartosz Golaszewski <brgl@bgdev.pl>
References: <20201013073055.11262-1-brgl@bgdev.pl>
 <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
 <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dc6f3226-c6e5-b361-601b-afa91540144e@linux.intel.com>
Date:   Wed, 14 Oct 2020 15:25:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 10/14/20 3:18 PM, Bartosz Golaszewski wrote:
> On Wed, Oct 14, 2020 at 2:49 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 10/13/20 3:30 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
>>> with no supported address widths") dmar.c needs struct iommu_device to
>>> be selected. We can drop this dependency by not dereferencing struct
>>> iommu_device if IOMMU_API is not selected and by reusing the information
>>> stored in iommu->drhd->ignored instead.
>>>
>>> This fixes the following build error when IOMMU_API is not selected:
>>>
>>> drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
>>> drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
>>>    1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
>>>                                                   ^
>>>
>>> Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no supported address widths")
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> With commit title adjusted to "iommu/vt-d: Don't dereference
>> iommu_device if IOMMU_API is not built",
>>
>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>>
> 
> Do you want me to resend it again with a changed title or can you fix
> it up when applying? Or should someone else pick it up?

I suppose Joerg will pick this up. I guess you don't need to resend it
unless Joerg asks you to do.

Best regards,
baolu
