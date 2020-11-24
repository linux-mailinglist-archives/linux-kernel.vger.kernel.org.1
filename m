Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378D12C2113
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgKXJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:24:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:39351 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbgKXJYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:24:01 -0500
IronPort-SDR: N6Ws2FGnDnjTIRIiR7Top/dnrV+duLZhKWVadB6XCrh3lTdwVWWJY/SrPQvnVZL0g9aZsl7Rli
 9iKERktTvN+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="256625862"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="256625862"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 01:24:01 -0800
IronPort-SDR: rzf+hTGb+Dv5gOBzH0BHWmnb4KqMg9C1xc/9bOizILZKW97lOyQ92i4cJtQFIejmDQWUtE0MTD
 Dqnlzv9Zfwvg==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="478438788"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 01:23:58 -0800
Subject: Re: [kbuild-all] Re: sound/soc/intel/catpt/loader.c:654
 catpt_first_boot_firmware() warn: consider using resource_size() here
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <202011220325.oB7oeTEq-lkp@intel.com>
 <20201123105317.GZ4077@smile.fi.intel.com>
 <8cb2dcbdef2446238c6a1fe8e8b74504@intel.com>
 <d848db76-a351-ecd7-2755-d268e1b335de@intel.com>
 <CAHp75VfxWwHja+QG-9Fhkh=6nd18RahgkS96SDL+y_uTR8o+jA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <aa75e040-7ead-6328-d148-0cbcbc8c89c1@intel.com>
Date:   Tue, 24 Nov 2020 17:23:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfxWwHja+QG-9Fhkh=6nd18RahgkS96SDL+y_uTR8o+jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/20 5:13 PM, Andy Shevchenko wrote:
> On Tue, Nov 24, 2020 at 10:06 AM Rong Chen <rong.a.chen@intel.com> wrote:
>> On 11/23/20 7:41 PM, Rojewski, Cezary wrote:
>>> On 2020-11-23 11:53 AM, Andy Shevchenko wrote:
>>>> On Sun, Nov 22, 2020 at 03:52:27AM +0800, kernel test robot wrote:
> ...
>
>>>> This sounds like false positive. From where it gets the idea of resource_size()
>>>> for the *start* offset?!
>>>>
>>> Indeed it is false positive. I've already explained this in:
>>>
>>> RE: [bug report] ASoC: Intel: catpt: Firmware loading and context restore
>>> https://www.spinics.net/lists/alsa-devel/msg117145.html
>> Thanks a lot, we'll ignore the warning next time.
> I think the proper solution here is to notify smatch upstream to fix the tool.
>

+Dan Carpenter

Hi Dan,

Could you take a look at this? the original report is at 
https://lore.kernel.org/lkml/202011220325.oB7oeTEq-lkp@intel.com/

Best Regards,
Rong Chen
