Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6502F5608
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbhANBUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:20:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:33836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbhANBRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:17:49 -0500
IronPort-SDR: dHbqvZqe2A9230ONyYkMzVfCSj5wbg2gnLdxD9jAm82nvj6KmvCM4EcNeFR44Xn+tla4ZX/6b3
 ZYTER0xQCcKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="239833686"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="gz'50?scan'50,208,50";a="239833686"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 17:17:05 -0800
IronPort-SDR: C9u/Qd0Q7ozH2hIEtuOFeX7xjW9nf9UccaGPb2Re/VacTiemaTrsECFmWzSFzZzd8Sk3KprKZg
 opdxJDq2OGrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="gz'50?scan'50,208,50";a="499443573"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2021 17:17:00 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzrG0-0000Qg-34; Thu, 14 Jan 2021 01:17:00 +0000
Date:   Thu, 14 Jan 2021 09:16:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>, palmerdabbelt@google.com,
        Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, Palmer Dabbelt <palmer@dabbelt.com>,
        guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] initramfs: Provide a common initrd reserve function
Message-ID: <202101140946.6tIupH21-lkp@intel.com>
References: <20210113144530.98165-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20210113144530.98165-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kefeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.11-rc3 next-20210113]
[cannot apply to soc/for-next arm/for-next linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/initramfs-Provide-a-common-initrd-reserve-function/20210113-224338
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e609571b5ffa3528bf85292de1ceaddac342bc1c
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1336e01e9195f537da5a004080c0cf9f265678d7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kefeng-Wang/initramfs-Provide-a-common-initrd-reserve-function/20210113-224338
        git checkout 1336e01e9195f537da5a004080c0cf9f265678d7
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/microcode.h:7,
                    from arch/x86/mm/init.c:22:
>> include/linux/initrd.h:21:27: error: redefinition of 'reserve_initrd_mem'
      21 | static inline void __init reserve_initrd_mem(void) {}
         |                           ^~~~~~~~~~~~~~~~~~
   In file included from arch/x86/mm/init.c:2:
   include/linux/initrd.h:21:27: note: previous definition of 'reserve_initrd_mem' was here
      21 | static inline void __init reserve_initrd_mem(void) {}
         |                           ^~~~~~~~~~~~~~~~~~


vim +/reserve_initrd_mem +21 include/linux/initrd.h

    17	
    18	#ifdef CONFIG_BLK_DEV_INITRD
    19	extern void __init reserve_initrd_mem(void);
    20	#else
  > 21	static inline void __init reserve_initrd_mem(void) {}
    22	#endif
    23	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UlVJffcvxoiEqYs2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UlVJffcvxoiEqYs2--
