Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC50E26E9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIRASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:18:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:54648 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIRASj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:18:39 -0400
IronPort-SDR: DsD2NMz/rMXqzbF6UtL8KCLF2wGeI92cjD4dwrIJb9lr1DmqdaQQoD8AXp2TzOX0cFLfPUkFf/
 KRccVwzVdIrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139826890"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="139826890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 17:18:31 -0700
IronPort-SDR: oBFqb4YbfThDQSPvVhMngQr4M0ZrdPrz1qiALEIgDPGX6PxJshbgVFbECZAfuO1AWpfbvp8jfM
 /DLyhVxPdEpw==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="483964775"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 17:18:27 -0700
Subject: Re: [kbuild-all] Re: include/linux/spinlock.h:346:2: error: invalid
 type argument of unary (have 'spinlock_t' {aka 'struct spinlock'})
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <202009161552.irOZaEej%lkp@intel.com>
 <20200916072733.gyrpbsttn53hscbc@linutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <698b171b-9099-bd38-3dcc-a0af5f78093c@intel.com>
Date:   Fri, 18 Sep 2020 08:17:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200916072733.gyrpbsttn53hscbc@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/20 3:27 PM, Sebastian Andrzej Siewior wrote:
> On 2020-09-16 15:18:56 [+0800], kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   fc4f28bb3daf3265d6bc5f73b497306985bb23ab
>> commit: de8f5e4f2dc1f032b46afda0a78cab5456974f89 lockdep: Introduce wait-type checks
>> date:   6 months ago
>> config: mips-randconfig-r011-20200916 (attached as .config)
>> compiler: mipsel-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout de8f5e4f2dc1f032b46afda0a78cab5456974f89
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from drivers/pcmcia/vrc4173_cardu.c:41:
> This driver does not compile even before this commit.
> Yes, it is still broken and yes it has nothing to do with this commit.

Hi Sebastian,

Only the errors prefixed by '>>' are from this commit, other errors are 
for reference only.

>> include/linux/spinlock.h:346:2: error: invalid type argument of unary '*' (have 'spinlock_t' {aka 'struct spinlock'})

      346 |  *(_lock) = __SPIN_LOCK_UNLOCKED(_lock); \


Best Regards,
Rong Chen
