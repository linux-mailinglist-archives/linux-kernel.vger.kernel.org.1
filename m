Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7490726F023
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgIRClB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:41:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:29660 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgIRCkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:40:49 -0400
IronPort-SDR: FVMMBvozQwaCTu29bgRW+STIxwnqA2YkdFfxhayi/ugGYA17ax5F7OHBm8J7aGWuObVo3k7eGP
 4FiZoI1RSgKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="224008955"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="224008955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:40:45 -0700
IronPort-SDR: 4OcKTF3+3Jjs6phJYizojKrOEWsP1qfsJAts4y07Sj31wHpNJU/+YPkt6rygcDr482pT19Bmfz
 eIWz6G4i1h/g==
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="484007514"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:40:43 -0700
Subject: Re: drivers/gpu/drm/ingenic/ingenic-drm-drv.c:undefined reference to
 `clk_get_parent'
To:     Paul Cercueil <paul@crapouillou.net>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
References: <202009091012.ctqRlkdT%lkp@intel.com>
 <SPBPGQ.UQS754BTO0FA1@crapouillou.net>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <5ff24bdf-254f-98be-070a-262bdf8fdf8c@intel.com>
Date:   Fri, 18 Sep 2020 10:40:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SPBPGQ.UQS754BTO0FA1@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/20 9:20 PM, Paul Cercueil wrote:
> Hi,
>
> Le mer. 9 sept. 2020 à 10:28, kernel test robot <lkp@intel.com> a écrit :
>> Hi Paul,
>>
>> First bad commit (maybe != root cause):
>>
>> tree: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> master
>> head:   34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
>> commit: 54fe894219903e32f5154265f46ed1eb5cdc2f5f drm/ingenic: Rename 
>> ingenic-drm.c to ingenic-drm-drv.c
>> date:   8 weeks ago
>> config: mips-randconfig-r022-20200909 (attached as .config)
>> compiler: mips-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 54fe894219903e32f5154265f46ed1eb5cdc2f5f
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 
>> make.cross ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    mips-linux-ld: drivers/gpu/drm/ingenic/ingenic-drm-drv.o: in 
>> function `ingenic_drm_probe':
>>>>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c:(.text+0xc90): undefined 
>>>> reference to `clk_get_parent'
>>    mips-linux-ld: drivers/mmc/host/mtk-sd.o: in function 
>> `msdc_set_mclk':
>>    drivers/mmc/host/mtk-sd.c:(.text+0x26fc): undefined reference to 
>> `clk_get_parent'
>>    mips-linux-ld: drivers/mmc/host/mtk-sd.c:(.text+0x27c0): undefined 
>> reference to `clk_get_parent'
>>
>
> clk_get_parent() is either provided if CONFIG_HAVE_CLK, or it's a 
> inline dummy in clk.h otherwise. Given it chokes on other drivers too, 
> I would say this is a false positive.
>
> -Paul
>

Hi Paul,

Sorry for the inconvenience, the bot can't distinguish the errors yet if 
only file name changed.
we'll continue to improve it.

Best Regards,
Rong Chen


