Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DBF2FFA58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhAVCWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:22:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:30840 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbhAVCWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:22:40 -0500
IronPort-SDR: lI3xs26WalYvvwvMp8HCPPBWEPlUUDXTadPB5aceuX4wIutwBPacE4zj1QzduFmu/Zct7YL+r3
 OAISyeEvJN2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178603396"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="gz'50?scan'50,208,50";a="178603396"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 18:21:57 -0800
IronPort-SDR: r02gBlvxqdah//BJdtN8VwRQXBeIoCI5Br2jSe5mWv7jTDVZSCju0rnooZdazpXclsn/FcFVri
 FxsXQvZuwIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="gz'50?scan'50,208,50";a="351679174"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2021 18:21:55 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2m5C-0006pz-Gs; Fri, 22 Jan 2021 02:21:54 +0000
Date:   Fri, 22 Jan 2021 10:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: include/uapi/sound/asound.h:562:14: error: conflicting types for
 '__pad_before_uframe'
Message-ID: <202101221020.BzdYLNeS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f29bd8b2e7132b409178d1367dae1813017bd0e
commit: 80fe7430c7085951d1246d83f638cc17e6c0be36 ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
date:   1 year, 1 month ago
config: mips-randconfig-r034-20210122 (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80fe7430c7085951d1246d83f638cc17e6c0be36
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 80fe7430c7085951d1246d83f638cc17e6c0be36
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from include/linux/kernel.h:12,
                    from include/linux/clk.h:13,
                    from drivers/base/regmap/regmap-mmio.c:7:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_gen_context':
>> drivers/base/regmap/regmap-mmio.c:274:2: error: duplicate case value
     274 |  case REGMAP_ENDIAN_NATIVE:
         |  ^~~~
   drivers/base/regmap/regmap-mmio.c:246:2: note: previously used here
     246 |  case REGMAP_ENDIAN_NATIVE:
         |  ^~~~
--
   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from include/linux/kernel.h:12,
                    from include/asm-generic/bug.h:19,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from sound/core/sound.c:8:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from include/sound/asound.h:24,
                    from include/sound/control.h:12,
                    from sound/core/sound.c:15:
>> include/uapi/sound/asound.h:562:14: error: conflicting types for '__pad_before_uframe'
     562 | typedef char __pad_before_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:557:14: note: previous declaration of '__pad_before_uframe' was here
     557 | typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~~
>> include/uapi/sound/asound.h:563:14: error: conflicting types for '__pad_after_uframe'
     563 | typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:558:14: note: previous declaration of '__pad_after_uframe' was here
     558 | typedef char __pad_after_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~
--
   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from include/linux/kernel.h:12,
                    from include/linux/delay.h:22,
                    from sound/core/timer.c:7:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from include/sound/asound.h:24,
                    from include/sound/timer.h:11,
                    from sound/core/timer.c:17:
>> include/uapi/sound/asound.h:562:14: error: conflicting types for '__pad_before_uframe'
     562 | typedef char __pad_before_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:557:14: note: previous declaration of '__pad_before_uframe' was here
     557 | typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~~
>> include/uapi/sound/asound.h:563:14: error: conflicting types for '__pad_after_uframe'
     563 | typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:558:14: note: previous declaration of '__pad_after_uframe' was here
     558 | typedef char __pad_after_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~
   sound/core/timer.c: In function 'snd_timer_user_read':
   sound/core/timer.c:2219:19: warning: initialized field overwritten [-Woverride-init]
    2219 |     .tstamp_sec = tread->tstamp_nsec,
         |                   ^~~~~
   sound/core/timer.c:2219:19: note: (near initialization for '(anonymous).tstamp_sec')
--
   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/compat.h:10,
                    from sound/core/pcm_native.c:7:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from include/sound/asound.h:24,
                    from include/sound/control.h:12,
                    from sound/core/pcm_native.c:19:
>> include/uapi/sound/asound.h:562:14: error: conflicting types for '__pad_before_uframe'
     562 | typedef char __pad_before_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:557:14: note: previous declaration of '__pad_before_uframe' was here
     557 | typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~~
>> include/uapi/sound/asound.h:563:14: error: conflicting types for '__pad_after_uframe'
     563 | typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:558:14: note: previous declaration of '__pad_after_uframe' was here
     558 | typedef char __pad_after_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~
   sound/core/pcm_native.c: In function 'constrain_mask_params':
   sound/core/pcm_native.c:251:18: warning: variable 'old_mask' set but not used [-Wunused-but-set-variable]
     251 |  struct snd_mask old_mask;
         |                  ^~~~~~~~
   sound/core/pcm_native.c: In function 'constrain_interval_params':
   sound/core/pcm_native.c:287:22: warning: variable 'old_interval' set but not used [-Wunused-but-set-variable]
     287 |  struct snd_interval old_interval;
         |                      ^~~~~~~~~~~~
   sound/core/pcm_native.c: In function 'constrain_params_by_rules':
   sound/core/pcm_native.c:328:22: warning: variable 'old_interval' set but not used [-Wunused-but-set-variable]
     328 |  struct snd_interval old_interval;
         |                      ^~~~~~~~~~~~
   sound/core/pcm_native.c:327:18: warning: variable 'old_mask' set but not used [-Wunused-but-set-variable]
     327 |  struct snd_mask old_mask;
         |                  ^~~~~~~~
   sound/core/pcm_native.c: In function 'snd_pcm_hw_params_choose':
   sound/core/pcm_native.c:611:22: warning: variable 'old_interval' set but not used [-Wunused-but-set-variable]
     611 |  struct snd_interval old_interval;
         |                      ^~~~~~~~~~~~
   sound/core/pcm_native.c:610:18: warning: variable 'old_mask' set but not used [-Wunused-but-set-variable]
     610 |  struct snd_mask old_mask;
         |                  ^~~~~~~~
--
   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from lib/find_bit.c:15:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
>> lib/find_bit.c:199:15: error: redefinition of 'find_next_zero_bit_le'
     199 | unsigned long find_next_zero_bit_le(const void *addr, unsigned
         |               ^~~~~~~~~~~~~~~~~~~~~
   In file included from arch/mips/include/asm/bitops.h:458,
                    from include/linux/bitops.h:26,
                    from lib/find_bit.c:15:
   include/asm-generic/bitops/le.h:12:29: note: previous definition of 'find_next_zero_bit_le' was here
      12 | static inline unsigned long find_next_zero_bit_le(const void *addr,
         |                             ^~~~~~~~~~~~~~~~~~~~~
>> lib/find_bit.c:208:15: error: redefinition of 'find_next_bit_le'
     208 | unsigned long find_next_bit_le(const void *addr, unsigned
         |               ^~~~~~~~~~~~~~~~
   In file included from arch/mips/include/asm/bitops.h:458,
                    from include/linux/bitops.h:26,
                    from lib/find_bit.c:15:
   include/asm-generic/bitops/le.h:18:29: note: previous definition of 'find_next_bit_le' was here
      18 | static inline unsigned long find_next_bit_le(const void *addr,
         |                             ^~~~~~~~~~~~~~~~
--
   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from lib/lzo/lzo1x_decompress_safe.c:16:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from lib/lzo/lzo1x_decompress_safe.c:21:
>> lib/lzo/lzodefs.h:33:2: error: #error "conflicting endian definitions"
      33 | #error "conflicting endian definitions"
         |  ^~~~~
--
   In file included from arch/mips/include/uapi/asm/byteorder.h:13,
                    from arch/mips/include/asm/bitops.h:20,
                    from include/linux/bitops.h:26,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from lib/lzo/lzo1x_compress.c:15:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from lib/lzo/lzo1x_compress.c:19:
>> lib/lzo/lzodefs.h:33:2: error: #error "conflicting endian definitions"
      33 | #error "conflicting endian definitions"
         |  ^~~~~
   lib/lzo/lzo1x_compress.c:291:5: warning: no previous prototype for 'lzogeneric1x_1_compress' [-Wmissing-prototypes]
     291 | int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/__pad_before_uframe +562 include/uapi/sound/asound.h

   560	
   561	#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
 > 562	typedef char __pad_before_uframe[0];
 > 563	typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
   564	#endif
   565	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
D3PARdDUhwEA

--mYCpIKhGyMATD0i+--
