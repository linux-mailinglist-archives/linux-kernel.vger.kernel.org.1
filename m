Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330912C1F56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgKXIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:01:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:54010 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbgKXIBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:01:41 -0500
IronPort-SDR: 1cMqnpTyoXD8k8AyTdMHzBgY/ZHv7Ux8cDuRbHOJBm/3gYRPNSoDXyLMw66dUEikG0IG4seuJR
 Zfr2GyAWlwDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172003161"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="172003161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:01:40 -0800
IronPort-SDR: wFEf4qRNJPUR0/CmrXn7S4TJBdmYrgTlsGu7k8XhaDZBB0Md6eCb9a59okejddGjyjr3vCvxb+
 7JBoq5x6Dx0w==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="478417780"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:01:38 -0800
Subject: Re: [kbuild-all] Re: sound/soc/intel/catpt/loader.c:654
 catpt_first_boot_firmware() warn: consider using resource_size() here
To:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lkp <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <202011220325.oB7oeTEq-lkp@intel.com>
 <20201123105317.GZ4077@smile.fi.intel.com>
 <8cb2dcbdef2446238c6a1fe8e8b74504@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d848db76-a351-ecd7-2755-d268e1b335de@intel.com>
Date:   Tue, 24 Nov 2020 16:00:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8cb2dcbdef2446238c6a1fe8e8b74504@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/20 7:41 PM, Rojewski, Cezary wrote:
> On 2020-11-23 11:53 AM, Andy Shevchenko wrote:
>> On Sun, Nov 22, 2020 at 03:52:27AM +0800, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   27bba9c532a8d21050b94224ffd310ad0058c353
>>> commit: 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1 ASoC: Intel: Select catpt and deprecate haswell
>>> date:   7 weeks ago
>>> config: x86_64-randconfig-m001-20201122 (attached as .config)
>>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> smatch warnings:
>>> sound/soc/intel/catpt/loader.c:654 catpt_first_boot_firmware() warn: consider using resource_size() here
>> ...
>>
>>> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29  652  	for (res = cdev->dram.child; res->sibling; res = res->sibling)
>>> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29  653  		;
>>> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29 @654  	__request_region(&cdev->dram, res->end + 1,
>>
>> This sounds like false positive. From where it gets the idea of resource_size()
>> for the *start* offset?!
>>
> Indeed it is false positive. I've already explained this in:
>
> RE: [bug report] ASoC: Intel: catpt: Firmware loading and context restore
> https://www.spinics.net/lists/alsa-devel/msg117145.html

Hi all,

Thanks a lot, we'll ignore the warning next time.

Best Regards,
Rong Chen
