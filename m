Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B1A2B4495
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgKPNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:18:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:48526 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgKPNS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:18:57 -0500
IronPort-SDR: CG+t3OYBrrzGrNsbWXTC+wNB7WMZ9qg/HYxhpRmqdYndlPdp9W0/YCBrEqaKk7T2/K5u6m1PTJ
 V0OUdryu8bvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="168165488"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="168165488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 05:18:55 -0800
IronPort-SDR: /8P++diUdTWDItVkutLrG/e3OGq2HRuFggSNM9uw8ir5wxUPs0hG5QPDqsutIC/ES7W5yJhC9z
 Mk9CL3SF4LwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531844815"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 05:18:54 -0800
Subject: Re: [PATCHv1 1/4] fpga: fpga-mgr: add
 FPGA_MGR_BITSTREM_AUTHENTICATION flag
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-2-git-send-email-richard.gong@linux.intel.com>
 <a71b7a9c-effa-ad01-4fde-3e1a1e517e2d@redhat.com>
 <4dd9a747-05f3-1cca-22a6-35681677223d@linux.intel.com>
 <28d2ace8-315a-3eaf-75da-88a4e90ea045@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <3f8aed65-6010-9220-7635-e8d2726cfc27@linux.intel.com>
Date:   Mon, 16 Nov 2020 07:39:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <28d2ace8-315a-3eaf-75da-88a4e90ea045@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 11/14/20 9:53 AM, Tom Rix wrote:
> 
> On 11/14/20 6:30 AM, Richard Gong wrote:
>>
>>> A whitespace issue, the new BIT(5) should align with the others, so add two spaces to the others.
>>>
>>
>> There is only one space, also I ran checkpatch with strict option and didn't see any whitespace issue.
>>
>> In the original patch, BIT(0) to BIT(4) align themselves. I am not sure why we see differently in email.
>>
>>   #define FPGA_MGR_PARTIAL_RECONFIG      BIT(0)
>>   #define FPGA_MGR_EXTERNAL_CONFIG       BIT(1)
>>   #define FPGA_MGR_ENCRYPTED_BITSTREAM   BIT(2)
>>   #define FPGA_MGR_BITSTREAM_LSB_FIRST   BIT(3)
>>   #define FPGA_MGR_COMPRESSED_BITSTREAM  BIT(4)
>> +#define FPGA_MGR_BITSTREM_AUTHENTICATION BIT(5)
>>
>> To align BIT(5) with others, I have to use additional tab to BIT(0) to BIT(4). But I don't think I should make such change on them, agree?
> 
> The existing table of #defines has aligned values for BIT(0) to BIT(4)
> 
> Your addition of BIT(5) value has an inconsistent alignment with the others BIT(0) to BIT(4)
> 
> The alignment of all the values should be consistent.
> 

OK, I will make them all aligned.

Regards,
Richard

> Tom
> 
>>
>> Regards,
>> Richard
>>
>>> Tom
>>>
>>>>      /**
>>>>     * struct fpga_image_info - information specific to a FPGA image
>>>
>>
> 
