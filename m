Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAE289EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgJJHPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:15:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:51777 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgJJHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:14:50 -0400
IronPort-SDR: 9ofWkcWPCG3FIMPMeuvsimSm0x9LjBKeCE1i3IQN/vryjIL1XK5qG7Q0fmX+AwgYuK/lEz0VgB
 qTTcqnSlNYrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="183017325"
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="183017325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 00:14:49 -0700
IronPort-SDR: kun2Gg2IfUgbkBdX/56fPfQJ7HpxjaKNosUQ2Z9IND9V6fhRpJEx2soN3lTFfdFEbMo58yW/36
 6v1k4ewIXpbg==
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="529225826"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 00:14:47 -0700
Subject: Re: [kbuild-all] Re: arceb-elf-ld: include/linux/leds.h:193:
 undefined reference to `devm_led_classdev_register_ext'
To:     Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        kernel test robot <lkp@intel.com>
Cc:     Dan Murphy <dmurphy@ti.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202010081415.2R50UmDQ-lkp@intel.com> <20201008071507.GA29893@amd>
 <a400ff82-e36f-346c-fd57-e1a0a75acd4e@intel.com>
 <19af5277-6705-4900-ad70-cb9b674caf5c@infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <61365b1a-5e73-14c9-ab90-4eaaf456eda8@intel.com>
Date:   Sat, 10 Oct 2020 15:13:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <19af5277-6705-4900-ad70-cb9b674caf5c@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/20 11:49 AM, Randy Dunlap wrote:
> On 10/9/20 8:19 PM, Rong Chen wrote:
>>
>> On 10/8/20 3:15 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   c85fb28b6f999db9928b841f63f1beeb3074eeca
>>>> commit: 92a81562e695628086acb92f95090ab09d9b9ec0 leds: lp55xx: Add multicolor framework support to lp55xx
>>>> date:   3 months ago
>>>> config: arc-randconfig-r035-20201008 (attached as .config)
>>>> compiler: arceb-elf-gcc (GCC) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92a81562e695628086acb92f95090ab09d9b9ec0
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout 92a81562e695628086acb92f95090ab09d9b9ec0
>>>>           # save the attached .config to linux build tree
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Hi robot. Do you have human around to talk to?
>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>>>>      lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>>>      arceb-elf-ld: lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>>>      arceb-elf-ld: lib/stackdepot.o: in function `in_irqentry_text':
>>>>      lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>>>      arceb-elf-ld: lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>>>      arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>>>      arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>>>      arceb-elf-ld: lib/stackdepot.c:325: undefined reference to `__softirqentry_text_end'
>>>>      arceb-elf-ld: lib/stackdepot.c:325: undefined reference to
>>> What is going on here? Did you just start testing arc? The commit
>>> is... really old.
>>>
>> Hi Pavel,
>>
>> Only this error "arceb-elf-ld: include/linux/leds.h:193: undefined reference to `devm_led_classdev_register_ext'" was found in this commit,
>> other errors are for reference only, and the test config is a rand config, so it's discovered by chance.
> Hi,
> Just for the record, I could not reproduce the build error
> with the config file that was provided.
>

Hi Randy,

I can reproduce it with the above reproduce steps:

➜  linux git:(92a81562e695) ✗ make 
CROSS_COMPILE=/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf- 
ARCH=arc
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   CHK     include/generated/compile.h
   GEN     .version
   CHK     include/generated/compile.h
   UPD     include/generated/compile.h
   CC      init/version.o
   AR      init/built-in.a
   LD      vmlinux.o
   MODPOST vmlinux.symvers
   MODINFO modules.builtin.modinfo
   GEN     modules.builtin
   LD      .tmp_vmlinux.kallsyms1
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
lib/stackdepot.o: in function `filter_irq_stacks':
/home/nfs/linux/lib/stackdepot.c:331: undefined reference to 
`__irqentry_text_start'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/lib/stackdepot.c:331: undefined reference to 
`__irqentry_text_start'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
lib/stackdepot.o: in function `in_irqentry_text':
/home/nfs/linux/lib/stackdepot.c:323: undefined reference to 
`__irqentry_text_end'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/lib/stackdepot.c:323: undefined reference to 
`__irqentry_text_end'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/lib/stackdepot.c:324: undefined reference to 
`__softirqentry_text_start'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/lib/stackdepot.c:324: undefined reference to 
`__softirqentry_text_start'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/lib/stackdepot.c:325: undefined reference to 
`__softirqentry_text_end'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/lib/stackdepot.c:325: undefined reference to 
`__softirqentry_text_end'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
drivers/leds/leds-lp55xx-common.o: in function `devm_led_classdev_register':
/home/nfs/linux/./include/linux/leds.h:193: undefined reference to 
`devm_led_classdev_register_ext'
/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: 
/home/nfs/linux/./include/linux/leds.h:193: undefined reference to 
`devm_led_classdev_register_ext'
make: *** [Makefile:1139: vmlinux] Error 1

Best Regards,
Rong Chen
