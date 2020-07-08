Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCAD217CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 04:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgGHCLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 22:11:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:64610 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgGHCLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:11:46 -0400
IronPort-SDR: 6LKigIpTux0CaRgMcXsjUGs+OEpjDDHWxkKQtJH3T7d8GQvH//KSkZs7j/IVPCnc2aPjgHjtLM
 JpgWSVjpoL6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="209256245"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="209256245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 19:11:46 -0700
IronPort-SDR: 9NjUpd+YjYPydnz78S631g5TyybmpyA9HfJmR8+sUT1YXVleW1KorRBhS3nAGU35G6NSN5j5NP
 f8CGEd3cQDdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="457322804"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2020 19:11:42 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 1/5] docs: IOMMU user API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6d01dac0-aa9d-e22b-9baf-28c2f538871a@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:07:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/8/20 7:43 AM, Jacob Pan wrote:
> +For UAPIs that are shared with in-kernel users, a wrapper function
> +is provided to distinguish the callers. For example,
> +
> +Userspace caller ::
> +
> +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +  void __user *udata)
> +
> +In-kernel caller ::
> +
> +  int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +  struct iommu_gpasid_bind_data *data)

iommu_page_response() may have the same needs. Can we reach an agreement
on the naming rules?

Best regards,
baolu
