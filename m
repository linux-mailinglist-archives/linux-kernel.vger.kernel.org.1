Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF692C1F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgKXICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:02:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:56189 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgKXICv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:02:51 -0500
IronPort-SDR: KQtI4UTgPjplNHxc9c1qwVTk+tiqyGaAv2Ya3IVtIac8KTfUuC9oVrgPf9CPhg47EVGOwXSlpY
 bZxazO81QzMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233514955"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="233514955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:02:49 -0800
IronPort-SDR: 3JphZjpq3JdJnRoPGc5Y0j14NIUBG18Z1ITdlXdmhM0K4IoyOe+yDxx5gIBPcrNYR1jOmUEiiM
 Qgmb6ruhny+A==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="478418204"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:02:47 -0800
Subject: Re: [kbuild-all] Re: drivers/net/wan/slic_ds26522.c:205:12: warning:
 stack frame size of 12288 bytes in function 'slic_ds26522_probe'
To:     Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202011200603.Fq2dmeMk-lkp@intel.com>
 <CAAeHK+zykqmcDPAa5GAeu4hSfyWF-D4PAa15y=CSgtAxSQTkGQ@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <71e44c1f-3c9f-db89-0347-3e23699d67cb@intel.com>
Date:   Tue, 24 Nov 2020 16:01:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zykqmcDPAa5GAeu4hSfyWF-D4PAa15y=CSgtAxSQTkGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/20 10:15 PM, Andrey Konovalov wrote:
> On Thu, Nov 19, 2020 at 11:16 PM kernel test robot <lkp@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   3494d58865ad4a47611dbb427b214cc5227fa5eb
>> commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
>> date:   3 months ago
>> config: arm64-randconfig-r002-20201119 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project b2613fb2f0f53691dd0211895afbb9413457fca7)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm64 cross compiling tool for clang build
>>          # apt-get install binutils-aarch64-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/net/wan/slic_ds26522.c:205:12: warning: stack frame size of 12288 bytes in function 'slic_ds26522_probe' [-Wframe-larger-than=]
>>     static int slic_ds26522_probe(struct spi_device *spi)
>>                ^
>>     1 warning generated.
>> --
>>>> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:194:12: warning: stack frame size of 18352 bytes in function 'st7789v_prepare' [-Wframe-larger-than=]
>>     static int st7789v_prepare(struct drm_panel *panel)
>>                ^
>>     1 warning generated.
> Same issue as reported previously. Copying my response from the other
> email just in case:
>
> This is the same issue in LLVM that was reported by Arnd for generic
> KASAN (also see KASAN_STACK_ENABLE option description). By default
> KASAN shouldn't have stack instrumentation enabled unless
> KASAN_STACK_ENABLE is specified. Perhaps it makes sense to disable it
> for KASAN_SW_TAGS config on the kernel test robot.
>
> [1] https://bugs.llvm.org/show_bug.cgi?id=38809

Hi Andrey,

Thanks for the explanation, we'll disable CONFIG_KASAN_SW_TAGS.

Best Regards,
Rong Chen

