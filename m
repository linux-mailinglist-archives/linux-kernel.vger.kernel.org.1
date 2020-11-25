Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64452C35AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgKYAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:34:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:58811 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbgKYAef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:34:35 -0500
IronPort-SDR: q454x9K8oVFh4qis0wQiYaQQQcizJs8+cAPXBEnJfAXOtzQXYLLhplVMSShjcuVF4ZUUNpE5Fw
 2mw9qc5wV6EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="190174679"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="190174679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:34:34 -0800
IronPort-SDR: 49PvZQybSUK2OMDtn3ohRmvYCPCcdvONETyCCkFn5JQrLjvs1WpJs3S5tTiZVTGpaPef3zbYtm
 QkWokUDiIpQw==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="478713242"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:34:32 -0800
Subject: Re: [kbuild-all] Re: drivers/net/wan/slic_ds26522.c:205:12: warning:
 stack frame size of 12288 bytes in function 'slic_ds26522_probe'
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202011200603.Fq2dmeMk-lkp@intel.com>
 <CAAeHK+zykqmcDPAa5GAeu4hSfyWF-D4PAa15y=CSgtAxSQTkGQ@mail.gmail.com>
 <71e44c1f-3c9f-db89-0347-3e23699d67cb@intel.com>
 <CAAeHK+wc=A=52o1fwK3KeRMk7k6QE-nuoU51TrkoRTWhAF44rQ@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <cf982a93-9517-5cd8-0170-a414441d47e6@intel.com>
Date:   Wed, 25 Nov 2020 08:33:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wc=A=52o1fwK3KeRMk7k6QE-nuoU51TrkoRTWhAF44rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/20 7:51 PM, Andrey Konovalov wrote:
> On Tue, Nov 24, 2020 at 9:02 AM Rong Chen <rong.a.chen@intel.com> wrote:
>> On 11/23/20 10:15 PM, Andrey Konovalov wrote:
>>> On Thu, Nov 19, 2020 at 11:16 PM kernel test robot <lkp@intel.com> wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   3494d58865ad4a47611dbb427b214cc5227fa5eb
>>>> commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
>>>> date:   3 months ago
>>>> config: arm64-randconfig-r002-20201119 (attached as .config)
>>>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project b2613fb2f0f53691dd0211895afbb9413457fca7)
>>>> reproduce (this is a W=1 build):
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # install arm64 cross compiling tool for clang build
>>>>           # apt-get install binutils-aarch64-linux-gnu
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>>>>           # save the attached .config to linux build tree
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>>> drivers/net/wan/slic_ds26522.c:205:12: warning: stack frame size of 12288 bytes in function 'slic_ds26522_probe' [-Wframe-larger-than=]
>>>>      static int slic_ds26522_probe(struct spi_device *spi)
>>>>                 ^
>>>>      1 warning generated.
>>>> --
>>>>>> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:194:12: warning: stack frame size of 18352 bytes in function 'st7789v_prepare' [-Wframe-larger-than=]
>>>>      static int st7789v_prepare(struct drm_panel *panel)
>>>>                 ^
>>>>      1 warning generated.
>>> Same issue as reported previously. Copying my response from the other
>>> email just in case:
>>>
>>> This is the same issue in LLVM that was reported by Arnd for generic
>>> KASAN (also see KASAN_STACK_ENABLE option description). By default
>>> KASAN shouldn't have stack instrumentation enabled unless
>>> KASAN_STACK_ENABLE is specified. Perhaps it makes sense to disable it
>>> for KASAN_SW_TAGS config on the kernel test robot.
>>>
>>> [1] https://bugs.llvm.org/show_bug.cgi?id=38809
>> Hi Andrey,
>>
>> Thanks for the explanation, we'll disable CONFIG_KASAN_SW_TAGS.
> Hi Rong,
>
> No, no, if you have a CONFIG_KASAN_SW_TAGS-based config - keep it
> enabled, just disable CONFIG_KASAN_STACK_ENABLE to avoid these stack
> overflows.
>
> Thanks!

Ah.. my fault, will disable CONFIG_KASAN_STACK_ENABLE for this case.

Best Regards,
Rong Chen
