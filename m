Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2F267765
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 05:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgILDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 23:13:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:11561 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgILDN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 23:13:57 -0400
IronPort-SDR: 7vrVV87JtpRU8suMXOXzn17n75QFSZWn4dP1/T7UtUqg4/9G+9SZ7DTtX+6wWjmFLwMVtbtJ6c
 WcM3pOy5oGvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="138397365"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="138397365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 20:13:53 -0700
IronPort-SDR: loX3EgoYAZYme1znZJfeaI/r7pIPYNsgYHy4/zzxkRoOl4GgCMscW7J0njqdIzhqNsEmDKhHWJ
 0XHzTAidexJw==
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="481555306"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.203]) ([10.254.212.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 20:13:49 -0700
Cc:     baolu.lu@linux.intel.com, Tom Murphy <murphyt7@tcd.ie>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
To:     Christoph Hellwig <hch@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org> <20200908055510.GA19078@infradead.org>
 <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
 <20200908062326.GB20774@infradead.org>
 <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
 <20200909070620.GB28245@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8c8f3df1-7fab-d019-7e4a-4ce5f5b2b273@linux.intel.com>
Date:   Sat, 12 Sep 2020 11:13:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909070620.GB28245@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/9 15:06, Christoph Hellwig wrote:
> On Wed, Sep 09, 2020 at 09:43:09AM +0800, Lu Baolu wrote:
>> +       /*
>> +        * The Intel graphic device driver is used to assume that the
>> returned
>> +        * sg list is not combound. This blocks the efforts of converting
>> the
> 
> This adds pointless overly long lines.
> 
>> +        * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
>> +        * device driver work and should be removed once it's fixed in i915
>> +        * driver.
>> +        */
>> +       if (dev_is_pci(dev) &&
>> +           to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
>> +           (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
>> +               for_each_sg(sg, s, nents, i) {
>> +                       unsigned int s_iova_off = sg_dma_address(s);
>> +                       unsigned int s_length = sg_dma_len(s);
>> +                       unsigned int s_iova_len = s->length;
>> +
>> +                       s->offset += s_iova_off;
>> +                       s->length = s_length;
>> +                       sg_dma_address(s) = dma_addr + s_iova_off;
>> +                       sg_dma_len(s) = s_length;
>> +                       dma_addr += s_iova_len;
>> +               }
>> +
>> +               return nents;
>> +       }
> 
> This wants an IS_ENABLED() check.  And probably a pr_once reminding
> of the workaround.
> 

Will fix in the next version.

Best regards,
baolu
