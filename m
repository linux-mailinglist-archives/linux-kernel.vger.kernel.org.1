Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93D3289E22
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 06:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgJJEFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 00:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbgJJDtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 23:49:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC8C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 20:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=A6yEfTlEmI3bA7daMbPF6MF3kWAB+5y5qCaDIvqZVjs=; b=WZO/n/lRwMjeVcnz5I2PX2Fj/+
        XQYCHa8SeuChpWS7IEF2zE92MgmkPI2+IhcwzdUxep1GDP+1POT/JX06nzoS8HtkyQqnqJ4DWhHs1
        Jml4GIcJmsj7V00gFM3WwgFqEnc2/I/9GFZaviw/Qt+PRSZg/tG/d3JX8fAJwSWD0PUubGpTWkZ/k
        lwlSiWVQa+vN+a2Nz9A95+wm2dNwPTaaKewoOalUTT0rIeWsPbaI+3VIWF5jYd61L9nd49593rzBR
        sqnGnsrlTFgjOYUytcfeicGhUMnsdAjy2ZqZXoMf+Pxl891k9qnFNZcX7eNfy+S8M3sg7gbRtAWl9
        D3DQk4IQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kR5sX-0003zn-9o; Sat, 10 Oct 2020 03:49:05 +0000
Subject: Re: [kbuild-all] Re: arceb-elf-ld: include/linux/leds.h:193:
 undefined reference to `devm_led_classdev_register_ext'
To:     Rong Chen <rong.a.chen@intel.com>, Pavel Machek <pavel@ucw.cz>,
        kernel test robot <lkp@intel.com>
Cc:     Dan Murphy <dmurphy@ti.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202010081415.2R50UmDQ-lkp@intel.com> <20201008071507.GA29893@amd>
 <a400ff82-e36f-346c-fd57-e1a0a75acd4e@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <19af5277-6705-4900-ad70-cb9b674caf5c@infradead.org>
Date:   Fri, 9 Oct 2020 20:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a400ff82-e36f-346c-fd57-e1a0a75acd4e@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 8:19 PM, Rong Chen wrote:
> 
> 
> On 10/8/20 3:15 PM, Pavel Machek wrote:
>> Hi!
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   c85fb28b6f999db9928b841f63f1beeb3074eeca
>>> commit: 92a81562e695628086acb92f95090ab09d9b9ec0 leds: lp55xx: Add multicolor framework support to lp55xx
>>> date:   3 months ago
>>> config: arc-randconfig-r035-20201008 (attached as .config)
>>> compiler: arceb-elf-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92a81562e695628086acb92f95090ab09d9b9ec0
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout 92a81562e695628086acb92f95090ab09d9b9ec0
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>> Hi robot. Do you have human around to talk to?
>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>>>     lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>>     arceb-elf-ld: lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>>>     arceb-elf-ld: lib/stackdepot.o: in function `in_irqentry_text':
>>>     lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>>     arceb-elf-ld: lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>>>     arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>>     arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqentry_text_start'
>>>     arceb-elf-ld: lib/stackdepot.c:325: undefined reference to `__softirqentry_text_end'
>>>     arceb-elf-ld: lib/stackdepot.c:325: undefined reference to
>> What is going on here? Did you just start testing arc? The commit
>> is... really old.
>>
> 
> Hi Pavel,
> 
> Only this error "arceb-elf-ld: include/linux/leds.h:193: undefined reference to `devm_led_classdev_register_ext'" was found in this commit,
> other errors are for reference only, and the test config is a rand config, so it's discovered by chance.

Hi,
Just for the record, I could not reproduce the build error
with the config file that was provided.

-- 
~Randy

