Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5228094D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgJAVRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:17:21 -0400
Received: from ale.deltatee.com ([204.191.154.188]:56506 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgJAVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hefvlh0ArBsIJRrdxVb8ZMvmEzM/8dfDueDLa3SqvBE=; b=II+kAhiqMFp53BkZhEKEIAZOGX
        Hf5R/UxJcuMpM1xKOtQiVLnXgHKpY3ATzLuzklegYpm8Lzd1IU8qbxICyHmjkg0Qz2qpCS1bBEP8S
        HH28gugNZV5UTgyncQIejXImuXayo+8VmT10XfdhXQI5u8R5f9WbfEl5R5I0IT8rf6srCIXu4FuU4
        LkJGSFOsfVVrzpphiDb6nyv0gbGpMmiFMBmRQXZ8/pSNuY7NINGyaZXcwsZgqVEvlUOKzVawggh7A
        tut4634lIqWIr54WPvoIxDjlbPT9ChDuA/3NfJEUjDRYWNClm+jYg8mM1rvruUCkLWbKSnLBSv76k
        bKlc7H2w==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kO5wx-0005DJ-Nq; Thu, 01 Oct 2020 15:17:20 -0600
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b620cd26-91cc-b564-dbb7-9c7381263f46@deltatee.com>
Date:   Thu, 1 Oct 2020 15:17:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927063437.13988-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org, ashok.raj@intel.com, tvrtko.ursulin@linux.intel.com, hch@infradead.org, dwmw2@infradead.org, murphyt7@tcd.ie, joro@8bytes.org, baolu.lu@linux.intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On 2020-09-27 12:34 a.m., Lu Baolu wrote:
> Hi,
> 
> The previous post of this series could be found here.
> 
> https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/
> 
> This version introduce a new patch [4/7] to fix an issue reported here.
> 
> https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/
> 
> There aren't any other changes.
> 
> Please help to test and review.

I've tested this patchset on my Sandy Bridge machine and found no issues (while including a 
patch to ioat I've sent to that maintainer).

Tested-By: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
