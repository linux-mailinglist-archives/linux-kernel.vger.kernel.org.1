Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B242507A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHXSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:31:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63A7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eeb/lofeYf1TCWyrHZnrHrCwUORKtAAL/E3G5LqeoV8=; b=tyAhmC5NK1NmIxVurpWk0ICF7W
        0GOZihikQ5cGdlRZt9BfRQqngR5HtVAH3DQcGdXkOU+6cUocfIBerC91iW1CFEphd349WGoxVOq1p
        xKcoMVE9AA10kmv+1W+pxwTt7CDcZL/NGU17dUdS/b/KDvrAgH1xJKYmq8yWB3ak2y0QxiBr2GzB8
        G7eGKwOz3CPbCHCbKdZ+U+kFu9yxctqMNghSrfsOuKS2mjUGdDb8vhCsUEGr78vb08PmKHbwqmVeS
        RuQZzr3Lb7NmvjANm3CJOk4KvNuf2aRFkz2kmtT5ZFIQ3X2+C3MZqfWYTq9GSzHnF9el1bnHZoasu
        YjYeyNtg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAHFF-0000zM-N6; Mon, 24 Aug 2020 18:31:02 +0000
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824182848.GB3210689@myrica>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6bc666c-d327-998b-b740-d03b9f0f5ffc@infradead.org>
Date:   Mon, 24 Aug 2020 11:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824182848.GB3210689@myrica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
>> +/**
>> + * struct ioasid_data - Meta data about ioasid
>> + *
>> + * @id:		Unique ID
>> + * @users	Number of active users
>> + * @state	Track state of the IOASID
>> + * @set		Meta data of the set this IOASID belongs to
>> + * @private	Private data associated with the IOASID
>> + * @rcu		For free after RCU grace period
> nit: it would be nicer to follow the struct order

and use a ':' after each struct member name, as is done for @id:

-- 
~Randy

