Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA428ADC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgJLFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:36:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:38309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgJLFgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:36:32 -0400
IronPort-SDR: Etbf+2t2AI2iytjafSwrc3pBuv5wFGeQt7v8oRLJ9qLyrA6QCRowWElFPTvXCqDoiiqLJgNFxn
 bWEW76EkULEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="229874740"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="229874740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:36:31 -0700
IronPort-SDR: vpHbOx+gNG5XUt9hhcJIyvza4nUPAxHrE4HXYDg+0rrSuFnDnfPNZG2lQyYbIDTNVmmzYQLrOX
 tsL2l/cMzOPA==
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="529819680"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:36:30 -0700
Subject: Re: [kbuild-all] Re: drivers/power/supply/mp2629_charger.c:522:9:
 warning: %d in format string (no. 1) requires 'int' but the argument type is
 'unsigned int'.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Saravanan Sekar <sravanhome@gmail.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20201009133734.GE8133@xsang-OptiPlex-9020>
 <CAHp75VdX_uxbrkX=XF11WDBcuXjpQYWjjOzVzJ8ffj46oGw_JA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <bbb89cb9-ce1b-6863-dcc5-c27ba9c05819@intel.com>
Date:   Mon, 12 Oct 2020 13:35:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdX_uxbrkX=XF11WDBcuXjpQYWjjOzVzJ8ffj46oGw_JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/20 10:27 PM, Andy Shevchenko wrote:
> On Fri, Oct 9, 2020 at 4:23 PM kernel test robot <lkp@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   549738f15da0e5a00275977623be199fbbf7df50
>> commit: 3bc6d790c39dfc4539c36525e6bcb617abbae467 power: supply: Add support for mps mp2629 battery charger
>> date:   4 months ago
>> :::::: branch date: 12 hours ago
>> :::::: commit date: 4 months ago
>> compiler: sh4-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> ...
>
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  514          unsigned int rval;
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  515          int ret;
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  516
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  517          ret = regmap_read(charger->regmap, MP2629_REG_IMPEDANCE_COMP, &rval);
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  518          if (ret)
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  519                  return ret;
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  520
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  521          rval = (rval >> 4) * 10;
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26 @522          return sprintf(buf, "%d mohm\n", rval);
>> 3bc6d790c39dfc Saravanan Sekar 2020-05-26  523  }
> Right, should be %u. Can LKP generate this type of patches?
>

Hi Andy,

Thanks for the advice, is there a auto correct tool to do such thing?
I afraid we can't cover all the circumstances.

Best Regards,
Rong Chen
