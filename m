Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE11F2811DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgJBL7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:59:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:50536 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBL7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:59:20 -0400
IronPort-SDR: 5Sl38pFbgqRpdwXM4jgB+eEmscRBCRGuWRmwKLKB/PNKgfslCV3VJeGNzSCVDyTNoM9kwh27+n
 w8UzF7PN4atQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="142365981"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="142365981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 04:59:17 -0700
IronPort-SDR: OtNiM2HO2Z1S5KtTbtVc5cavGbgWoRWySKGU2DCpD77OVe0Lf/vd46XtwcUK/2V8m0hld57YT/
 RCyoSYnCtHXQ==
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="508270379"
Received: from yili1-mobl.ccr.corp.intel.com (HELO [10.254.208.108]) ([10.254.208.108])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 04:59:15 -0700
Cc:     baolu.lu@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
To:     Joerg Roedel <joro@8bytes.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <20201001121701.GB30426@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5a9d7412-3d7a-f4f7-e3b9-c295718448aa@linux.intel.com>
Date:   Fri, 2 Oct 2020 19:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001121701.GB30426@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020/10/1 20:17, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Sep 29, 2020 at 08:11:35AM +0800, Lu Baolu wrote:
>> I have no preference. It depends on which patch goes first. Let the
>> maintainers help here.
> 
> No preference on my side, except that it is too late for this now to
> make it into v5.10. Besides that I let the decission up to you when this
> is ready. Just send me a pull-request when it should get into the
> iommu-tree.

Sure.

Best regards,
baolu

> 
> Regards,
> 
> 	Joerg
> 
