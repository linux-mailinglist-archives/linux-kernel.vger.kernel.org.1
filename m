Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D82D3852
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgLIBh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:37:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:25182 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgLIBh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:37:28 -0500
IronPort-SDR: zNFpNYhGTC0KLbwe5lkG7D3/jN4OSTxyA4K8p/OSXYS8cgMUpZP0MPNamytdn1ncPUOI1+1LTe
 34A+STaWCsGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153240164"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="153240164"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 17:36:29 -0800
IronPort-SDR: 5k900zkoYLmoYoXsRjK7xzJE857CScifdhN3ltyNkNsZsOYUOO0CcXFpPivszO7oDDaTZ/dASh
 21EMfRsilN5A==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363915481"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 17:36:25 -0800
Date:   Wed, 9 Dec 2020 09:36:23 +0800
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
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 01/18] docs: acrn: Introduce ACRN
Message-ID: <20201209013623.GM17702@shuo-intel.sh.intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-2-shuo.a.liu@intel.com>
 <20201208115249.GC27920@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201208115249.GC27920@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  8.Dec'20 at 12:52:49 +0100, Borislav Petkov wrote:
>On Tue, Dec 01, 2020 at 05:38:36PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> Add documentation on the following aspects of ACRN:
>
>Thanks for doing this!
>
>> +===============
>> +ACRN CPUID bits
>> +===============
>> +
>> +A guest VM running on an ACRN hypervisor, can check some of its features using
>> +cpuid.
>
>s/cpuid/CPUID/g
>
>> +ACRN Hypervisor Introduction
>> +============================
>> +
>> +The ACRN Hypervisor is a Type 1 hypervisor, running directly on the bare-metal
>
>s/the //
>
>with those fixed:
>
>Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks for review. Fixed.

Thanks
shuo
