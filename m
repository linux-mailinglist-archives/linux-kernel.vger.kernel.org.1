Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0F728B077
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgJLIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:40:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:29944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgJLIkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:40:43 -0400
IronPort-SDR: bOxD+wAWJZdFZwtC+2/c1m+1A08H0esuR70TiAaYpRiQO1OVGLamaG0SMvijths42glhyx+Qqa
 Tal9Br5oUWGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="163069115"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="163069115"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:40:42 -0700
IronPort-SDR: v/7ILIjrO/mWQyij+n38Vnk/2eLIR9uMKM1Bsf4G6fRvuKJPyluOwpcrxVZJke42qtjL8+9UvA
 xCv795zvXoAg==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529871546"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:40:39 -0700
Date:   Mon, 12 Oct 2020 16:40:36 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 03/17] x86/acrn: Introduce an API to check if a VM is
 privileged
Message-ID: <20201012084036.GJ1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-4-shuo.a.liu@intel.com>
 <20200930080959.GD6810@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200930080959.GD6810@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed 30.Sep'20 at 10:09:59 +0200, Borislav Petkov wrote:
>On Tue, Sep 22, 2020 at 07:42:57PM +0800, shuo.a.liu@intel.com wrote:
>> +static u32 acrn_cpuid_base(void)
>> +{
>> +	static u32 acrn_cpuid_base;
>> +
>> +	if (!acrn_cpuid_base && boot_cpu_has(X86_FEATURE_HYPERVISOR))
>> +		acrn_cpuid_base = hypervisor_cpuid_base("ACRNACRNACRN", 0);
>> +
>> +	return acrn_cpuid_base;
>> +}
>> +
>> +bool acrn_is_privileged_vm(void)
>> +{
>> +	return cpuid_eax(acrn_cpuid_base() | ACRN_CPUID_FEATURES) &
>
>What's that dance and acrn_cpuid_base static thing needed for? Why not
>simply:
>
>	cpuid_eax(ACRN_CPUID_FEATURES) & ...
>
>?

hypervisor_cpuid_base() searches reserved hypervisor cpuid region and
return the base matched the right signature, the base might vary. So i
put it here.

>
>> +			 ACRN_FEATURE_PRIVILEGED_VM;
>> +}
>> +EXPORT_SYMBOL_GPL(acrn_is_privileged_vm);
>
>Also, if you're going to need more of those bit checkers acrn_is_<something>
>which look at ACRN_CPUID_FEATURES, just stash CPUID_0x40000001_EAX locally and
>use a
>
>	acrn_has(ACRN_FEATURE_PRIVILEGED_VM)
>
>which does the bit testing.

Thanks. Currently, there is only one feature bit. I will introduce
that you suggested with more feature bits to be tested.

Thanks
shuo
