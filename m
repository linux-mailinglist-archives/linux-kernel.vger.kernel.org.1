Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7202BA73D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKTKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:20:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:17547 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgKTKUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:20:14 -0500
IronPort-SDR: 1BUquB8VvXahj32wZwPEAMeX/6Zv0bSQqEgkH8rxPEZAzakoZYLb+uB74Spl5SPw06KcOE43fe
 5aoXg0xd2fPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150717065"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="150717065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:20:14 -0800
IronPort-SDR: aW8I8Urkkd2GFoGv3fErKLdeB5fPnv11SGEjt7MP9PopNfcLKqENg8YD2derH/3Wzf3zd2hEKx
 nFoQxF1MPiQw==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="360392031"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.97]) ([10.254.215.97])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:20:11 -0800
Cc:     baolu.lu@linux.intel.com, Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
To:     Joerg Roedel <joro@8bytes.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Will Deacon <will@kernel.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
 <3f5694f3-62f9-cc2b-1c2b-f9e99a4788c1@linux.intel.com>
 <1ce5b94a-38b3-548e-3b1a-a68390b93953@linux.intel.com>
 <82dab98e-0761-8946-c31c-92f19a0615b4@linux.intel.com>
 <99a0d1eb-7fde-dff4-225f-92b68fbf7620@linux.intel.com>
 <160439750572.8460.14782978404889004150@jlahtine-mobl.ger.corp.intel.com>
 <20201103105442.GD22888@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e3299ef9-99ab-8e5a-027a-608495f5a293@linux.intel.com>
Date:   Fri, 20 Nov 2020 18:20:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201103105442.GD22888@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/3 18:54, Joerg Roedel wrote:
> Hi,
> 
> On Tue, Nov 03, 2020 at 11:58:26AM +0200, Joonas Lahtinen wrote:
>> Would that work for you? We intend to send the feature pull requests
>> to DRM for 5.11 in the upcoming weeks.
> 
> For the IOMMU side it is best to include the workaround for now. When
> the DRM fixes are merged into v5.11-rc1 together with this conversion,
> it can be reverted and will not be in 5.11-final.

Okay! So I will keep the workaround and send a new version (mostly
rebase) to Will.

Best regards,
baolu

