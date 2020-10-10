Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4774D289DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 05:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgJJDjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 23:39:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:62458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbgJJDbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 23:31:12 -0400
IronPort-SDR: tcceexPblw4AvcNDo2uv841sCuOBnTw+PMLUIaOABFm+Sj8h+SuXr0ji6daNwbU+hqBJ6aTbga
 fESeZN1OauDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="144878388"
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="144878388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 20:20:14 -0700
IronPort-SDR: WWcqoLMGNd5Gr4guwLHY0X1S+mxLirgx99fH2O5zpeRp4JBNYoxgYBsOLcUQcOE49eSivwyk5c
 GLrzPf//7hYQ==
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="529172434"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 20:20:12 -0700
Subject: Re: [kbuild-all] Re: arceb-elf-ld: include/linux/leds.h:193:
 undefined reference to `devm_led_classdev_register_ext'
To:     Pavel Machek <pavel@ucw.cz>, kernel test robot <lkp@intel.com>
Cc:     Dan Murphy <dmurphy@ti.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202010081415.2R50UmDQ-lkp@intel.com> <20201008071507.GA29893@amd>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <a400ff82-e36f-346c-fd57-e1a0a75acd4e@intel.com>
Date:   Sat, 10 Oct 2020 11:19:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201008071507.GA29893@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/20 3:15 PM, Pavel Machek wrote:
> Hi!
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c85fb28b6f999db9928b841f63f1beeb3074eeca
>> commit: 92a81562e695628086acb92f95090ab09d9b9ec0 leds: lp55xx: Add multicolor framework support to lp55xx
>> date:   3 months ago
>> config: arc-randconfig-r035-20201008 (attached as .config)
>> compiler: arceb-elf-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92a81562e695628086acb92f95090ab09d9b9ec0
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 92a81562e695628086acb92f95090ab09d9b9ec0
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> Hi robot. Do you have human around to talk to?
>
>> All errors (new ones prefixed by >>):
>>
>>     arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>>     lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>     arceb-elf-ld: lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>     arceb-elf-ld: lib/stackdepot.o: in function `in_irqentry_text':
>>     lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>     arceb-elf-ld: lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>     arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>     arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>     arceb-elf-ld: lib/stackdepot.c:325: undefined reference to `__softirqentry_text_end'
>>     arceb-elf-ld: lib/stackdepot.c:325: undefined reference to
> What is going on here? Did you just start testing arc? The commit
> is... really old.
>

Hi Pavel,

Only this error "arceb-elf-ld: include/linux/leds.h:193: undefined 
reference to `devm_led_classdev_register_ext'" was found in this commit,
other errors are for reference only, and the test config is a rand 
config, so it's discovered by chance.

Best Regards,
Rong Chen
