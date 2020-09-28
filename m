Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4527A5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1D2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:28:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:39228 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI1D2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:28:38 -0400
IronPort-SDR: 1Xqudnf2OVN9yLxb+MA2yYzb+a/uJUz0gVO8y57J2vV0auHibsuO7wDX9xjemkGNe4tnVs/JAd
 WY4iVaqT9r2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162820847"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="162820847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 20:28:37 -0700
IronPort-SDR: aT2977SCCjxyzDkBz0o1AlJCCMkcy28iEadLgOmFExxts3PFnc0G8W2RrFEegLioAmeQ7FpoTt
 oAMQby2/NgMw==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="311619566"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 20:28:33 -0700
Date:   Mon, 28 Sep 2020 11:28:31 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 02/17] x86/acrn: Introduce acrn_{setup,
 remove}_intr_handler()
Message-ID: <20200928032804.GA1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-3-shuo.a.liu@intel.com>
 <20200927104943.GF88650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200927104943.GF88650@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 27.Sep'20 at 12:49:43 +0200, Greg Kroah-Hartman wrote:
>On Tue, Sep 22, 2020 at 07:42:56PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> The ACRN Hypervisor builds an I/O request when a trapped I/O access
>> happens in User VM. Then, ACRN Hypervisor issues an upcall by sending
>> a notification interrupt to the Service VM. HSM in the Service VM needs
>> to hook the notification interrupt to handle I/O requests.
>>
>> Notification interrupts from ACRN Hypervisor are already supported and
>> a, currently uninitialized, callback called.
>>
>> Export two APIs for HSM to setup/remove its callback.
>>
>> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Fengwei Yin <fengwei.yin@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  arch/x86/include/asm/acrn.h |  8 ++++++++
>>  arch/x86/kernel/cpu/acrn.c  | 16 ++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>  create mode 100644 arch/x86/include/asm/acrn.h
>>
>> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
>> new file mode 100644
>> index 000000000000..ff259b69cde7
>> --- /dev/null
>> +++ b/arch/x86/include/asm/acrn.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_ACRN_H
>> +#define _ASM_X86_ACRN_H
>> +
>> +void acrn_setup_intr_handler(void (*handler)(void));
>> +void acrn_remove_intr_handler(void);
>> +
>> +#endif /* _ASM_X86_ACRN_H */
>> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
>> index 0b2c03943ac6..42e88d01ccf9 100644
>> --- a/arch/x86/kernel/cpu/acrn.c
>> +++ b/arch/x86/kernel/cpu/acrn.c
>> @@ -9,7 +9,11 @@
>>   *
>>   */
>>
>> +#define pr_fmt(fmt) "acrn: " fmt
>
>Why is this needed, if you are not adding pr_* calls in this patch?

True. I will remove it. Thanks.
