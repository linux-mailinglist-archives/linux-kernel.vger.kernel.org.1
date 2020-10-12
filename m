Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B701428B08F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgJLIug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:50:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:30969 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgJLIuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:50:35 -0400
IronPort-SDR: NWOtjxwsr4E7o8VOIx89lzbUfLV2DJYOEfhdyQT1JyEeL3ilKOCGDeuKQtyBw2eqrwjijqiHFE
 76tKa264x19Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="163070054"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="163070054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:50:35 -0700
IronPort-SDR: it5TryDsgM0AJSrlsYz8rNi7Sh0say+xsgHdObCqpS+YzPaQr6V8tbq5oiDz4Qdx3cd1GYiyqt
 ssBMjjKoOiUA==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="520618640"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:50:31 -0700
Date:   Mon, 12 Oct 2020 16:50:29 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 01/17] docs: acrn: Introduce ACRN
Message-ID: <20201012085029.GM1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-2-shuo.a.liu@intel.com>
 <08a5b43f-e75a-12ca-642b-133fef3606ba@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <08a5b43f-e75a-12ca-642b-133fef3606ba@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu  8.Oct'20 at 18:48:52 -0700, Randy Dunlap wrote:
>On 9/22/20 4:42 AM, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> Add documentation on the following aspects of ACRN:
>>
>>   1) A brief introduction on the architecture of ACRN.
>>   2) I/O request handling in ACRN.
>>
>> To learn more about ACRN, please go to ACRN project website
>> https://projectacrn.org, or the documentation page
>> https://projectacrn.github.io/.
>>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Sen Christopherson <sean.j.christopherson@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Fengwei Yin <fengwei.yin@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  Documentation/virt/acrn/index.rst        | 11 +++
>>  Documentation/virt/acrn/introduction.rst | 40 ++++++++++
>>  Documentation/virt/acrn/io-request.rst   | 97 ++++++++++++++++++++++++
>>  Documentation/virt/index.rst             |  1 +
>>  MAINTAINERS                              |  7 ++
>>  5 files changed, 156 insertions(+)
>>  create mode 100644 Documentation/virt/acrn/index.rst
>>  create mode 100644 Documentation/virt/acrn/introduction.rst
>>  create mode 100644 Documentation/virt/acrn/io-request.rst
>>
>
>> diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
>> new file mode 100644
>> index 000000000000..019dc5978f7c
>> --- /dev/null
>> +++ b/Documentation/virt/acrn/io-request.rst
>> @@ -0,0 +1,97 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +I/O request handling
>> +====================
>> +
>> +An I/O request of a User VM, which is constructed by the hypervisor, is
>> +distributed by the ACRN Hypervisor Service Module to an I/O client
>> +corresponding to the address range of the I/O request. Details of I/O request
>> +handling are described in the following sections.
>> +
>> +1. I/O request
>> +--------------
>> +
>
>...
>
>> +
>> +2. I/O clients
>> +--------------
>> +
>
>...
>
>> +
>> +3. I/O request state transition
>> +-------------------------------
>> +
>> +The state transitions of a ACRN I/O request are as follows.
>
>                         of an ACRN

OK. Thanks for review. 

Thanks
shuo
