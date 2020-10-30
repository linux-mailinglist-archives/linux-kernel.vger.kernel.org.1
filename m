Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653D82A066E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgJ3N2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:28:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:56233 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgJ3N2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:28:49 -0400
IronPort-SDR: ga4WjFHUjh7IwMRXUBjM1E14AZxx/xfqM4oSjXx8X779U4Vo6bHpkcDJMBHhAsNiMPzhOp/HSL
 O9UuYDmgY5sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="253313046"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="253313046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:28:49 -0700
IronPort-SDR: d2vczdT8qt0jfMqhqbMv0zVLWQV95IAonDqS5Xd0n1QDDz0vD/czgebU3kb4llfSyyl104I3Ve
 0rqvpTmhVm8g==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537065891"
Received: from lshi-mobl1.ccr.corp.intel.com (HELO [10.249.168.224]) ([10.249.168.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:28:46 -0700
Subject: Re: [kbuild-all] Re: drivers/video/backlight/ltv350qv.c:192:12:
 warning: stack frame size of 13472 bytes in function 'ltv350qv_power'
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <202010260230.VivTG0Gb-lkp@intel.com>
 <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
 <CAAeHK+wdv=X-iD208M2m3Xte9F+g2kYRDqQr4A+GP7Z1tY85BA@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <650988cc-2f70-d03a-b456-bf1915b64836@intel.com>
Date:   Fri, 30 Oct 2020 21:28:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wdv=X-iD208M2m3Xte9F+g2kYRDqQr4A+GP7Z1tY85BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2020 11:28 PM, Andrey Konovalov wrote:
> On Sun, Oct 25, 2020 at 8:17 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 26 Oct 2020 02:15:37 +0800 kernel test robot <lkp@intel.com> wrote:
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   d76913908102044f14381df865bb74df17a538cb
>>> commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
>>> date:   3 months ago
>>> config: arm64-randconfig-r005-20201026 (attached as .config)
>>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1c8371692dfe8245bc6690ff1262dcced4649d21)
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # install arm64 cross compiling tool for clang build
>>>          # apt-get install binutils-aarch64-linux-gnu
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame size of 13472 bytes in function 'ltv350qv_power' [-Wframe-larger-than=]
>>
>> That's a lot of stack.
>>
>>>     static int ltv350qv_power(struct ltv350qv *lcd, int power)
>>>                ^
>>>     1 warning generated.
>>>
>>> vim +/ltv350qv_power +192 drivers/video/backlight/ltv350qv.c
>>
>> Odd - the code looks pretty normal.  It is possible that your compiler
>> is (crazily) inlining ltv350qv_write_reg()?
> 
> This is the same issue in LLVM that was reported by Arnd for generic
> KASAN (also see KASAN_STACK_ENABLE option description). By default
> KASAN shouldn't have stack instrumentation enabled unless
> KASAN_STACK_ENABLE is specified. Perhaps it makes sense to disable it
> for KASAN_SW_TAGS config on the kernel test robot.

Hi Andrey,

Thanks for your advice, we'll take a look.

Best Regards,
Rong Chen

> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=38809
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
