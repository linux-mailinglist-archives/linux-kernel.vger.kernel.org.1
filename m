Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8084728A3D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbgJJWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731484AbgJJT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:29:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83AFC08EA70
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XlmsX7ftEhCmpFmdh7a7209h+fCu8xVMQN4NDEvg3m4=; b=L+gBIYErdSwYIOs+QwVKQNHivY
        M0O/TYXItMukhCeIkNIrsRcgVzMPZfWTnuv4tVL/VrACx+ddnsAGdTiMJroGXFQYGh1PDdP8iMB2B
        lwyogCKsBNzgNBo+jnvpnJKRxxjIi69ENcAedyzHWDd/6cM4YdcM2CCP/T6+jHofS/j9nH0OXck5p
        7XEl1RoWVcn/GnLxRJhkjjK84E0qbDuOhKpnPqn6mbQcDFZgrKBT8yP3T+OAjUnrwhlrh9HWP/Bgq
        kMVnXVroFdSoEAoA2CVooilNPLoyJhslt3dwW9lrLwOmVundKuDYmYirTymQVLWcqqryTcvqHGcQH
        wYBBSPZQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRID8-0003bD-QR; Sat, 10 Oct 2020 16:59:11 +0000
Subject: Re: [kbuild-all] Re: arceb-elf-ld: include/linux/leds.h:193:
 undefined reference to `devm_led_classdev_register_ext'
To:     Rong Chen <rong.a.chen@intel.com>, Pavel Machek <pavel@ucw.cz>,
        kernel test robot <lkp@intel.com>
Cc:     Dan Murphy <dmurphy@ti.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202010081415.2R50UmDQ-lkp@intel.com> <20201008071507.GA29893@amd>
 <a400ff82-e36f-346c-fd57-e1a0a75acd4e@intel.com>
 <19af5277-6705-4900-ad70-cb9b674caf5c@infradead.org>
 <61365b1a-5e73-14c9-ab90-4eaaf456eda8@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47922c0f-ba68-3c24-50e7-777783901fe2@infradead.org>
Date:   Sat, 10 Oct 2020 09:59:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <61365b1a-5e73-14c9-ab90-4eaaf456eda8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/20 12:13 AM, Rong Chen wrote:
> 
> 
> On 10/10/20 11:49 AM, Randy Dunlap wrote:
>> On 10/9/20 8:19 PM, Rong Chen wrote:
>>>
>>> On 10/8/20 3:15 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>> head:   c85fb28b6f999db9928b841f63f1beeb3074eeca
>>>>> commit: 92a81562e695628086acb92f95090ab09d9b9ec0 leds: lp55xx: Add multicolor framework support to lp55xx
>>>>> date:   3 months ago
>>>>> config: arc-randconfig-r035-20201008 (attached as .config)
>>>>> compiler: arceb-elf-gcc (GCC) 9.3.0
>>>>> reproduce (this is a W=1 build):
>>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>           chmod +x ~/bin/make.cross
>>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92a81562e695628086acb92f95090ab09d9b9ec0
>>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>           git fetch --no-tags linus master
>>>>>           git checkout 92a81562e695628086acb92f95090ab09d9b9ec0
>>>>>           # save the attached .config to linux build tree
>>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Hi robot. Do you have human around to talk to?
>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>      arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>>>>>      lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>>>>      arceb-elf-ld: lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>>>>      arceb-elf-ld: lib/stackdepot.o: in function `in_irqentry_text':
>>>>>      lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>>>>      arceb-elf-ld: lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>>>>      arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>>>>      arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>>>>      arceb-elf-ld: lib/stackdepot.c:325: undefined reference to `__softirqentry_text_end'
>>>>>      arceb-elf-ld: lib/stackdepot.c:325: undefined reference to
>>>> What is going on here? Did you just start testing arc? The commit
>>>> is... really old.
>>>>
>>> Hi Pavel,
>>>
>>> Only this error "arceb-elf-ld: include/linux/leds.h:193: undefined reference to `devm_led_classdev_register_ext'" was found in this commit,
>>> other errors are for reference only, and the test config is a rand config, so it's discovered by chance.
>> Hi,
>> Just for the record, I could not reproduce the build error
>> with the config file that was provided.
>>
> 
> Hi Randy,
> 
> I can reproduce it with the above reproduce steps:
> 
> ➜  linux git:(92a81562e695) ✗ make CROSS_COMPILE=/home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf- ARCH=arc
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.kallsyms1
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
> /home/nfs/linux/lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: lib/stackdepot.o: in function `in_irqentry_text':
> /home/nfs/linux/lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/lib/stackdepot.c:325: undefined reference to `__softirqentry_text_end'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/lib/stackdepot.c:325: undefined reference to `__softirqentry_text_end'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: drivers/leds/leds-lp55xx-common.o: in function `devm_led_classdev_register':
> /home/nfs/linux/./include/linux/leds.h:193: undefined reference to `devm_led_classdev_register_ext'
> /home/nfs/0day/gcc-9.3.0-nolibc/arceb-elf/bin/arceb-elf-ld: /home/nfs/linux/./include/linux/leds.h:193: undefined reference to `devm_led_classdev_register_ext'
> make: *** [Makefile:1139: vmlinux] Error 1

Oh, I guess I see the difference. The bot is checking out a commit
that is 3 months old:

        git fetch --no-tags linus master
        git checkout 92a81562e695628086acb92f95090ab09d9b9ec0


So it's a bit like Pavel said, that commit is old. I can't say that I care
as long as current mainline builds, and I have already verified that it does.


cheers.
-- 
~Randy

