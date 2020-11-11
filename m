Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740B42AE8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKKGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:32:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:29074 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKKGcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:32:43 -0500
IronPort-SDR: nKbl4rKTzZHYqllcrD6MWxUxQbLPohpkd8g7eiKM6qmzSDFO5UcDIbDpCDEiicuWSsFA4r0pLF
 LCq+wF/FKBDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254811550"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="gz'50?scan'50,208,50";a="254811550"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 22:32:40 -0800
IronPort-SDR: 9FGmm6R9ELAg3FQZEbv9RRhdBE+ngPQMK83uzTAY0sC4oyHmFwLVkAI1xeaG3hse+bqfCgbqRM
 6cxfvwd8Nzbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="gz'50?scan'50,208,50";a="365835572"
Received: from lkp-server02.sh.intel.com (HELO 898ef09051d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2020 22:32:39 -0800
Received: from kbuild by 898ef09051d7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcjgM-00001u-Hw; Wed, 11 Nov 2020 06:32:38 +0000
Date:   Wed, 11 Nov 2020 14:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202011111408.gs05Nnay-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eccc876724927ff3b9ff91f36f7b6b159e948f0c
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   2 months ago
config: sh-randconfig-s031-20201111 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-106-gd020cf33-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user *[assigned] ptr @@
   fs/binfmt_flat.c:402:9: sparse:     expected unsigned long const *__gu_addr
   fs/binfmt_flat.c:402:9: sparse:     got unsigned long [noderef] __user *[assigned] ptr
>> fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   fs/binfmt_flat.c:402:9: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:402:9: sparse:     got unsigned long const *__gu_addr
   fs/binfmt_flat.c:775:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *[assigned] rp @@
   fs/binfmt_flat.c:775:29: sparse:     expected unsigned int const *__gu_addr
   fs/binfmt_flat.c:775:29: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] rp
   fs/binfmt_flat.c:775:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/binfmt_flat.c:775:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:775:29: sparse:     got unsigned int const *__gu_addr
   fs/binfmt_flat.c:812:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 const *__gu_addr @@     got restricted __be32 [noderef] [usertype] __user * @@
   fs/binfmt_flat.c:812:29: sparse:     expected restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:812:29: sparse:     got restricted __be32 [noderef] [usertype] __user *
   fs/binfmt_flat.c:812:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __be32 const *__gu_addr @@
   fs/binfmt_flat.c:812:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:812:29: sparse:     got restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:855:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 const *__gu_addr @@     got restricted __be32 [noderef] [usertype] __user * @@
   fs/binfmt_flat.c:855:29: sparse:     expected restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:855:29: sparse:     got restricted __be32 [noderef] [usertype] __user *
   fs/binfmt_flat.c:855:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __be32 const *__gu_addr @@
   fs/binfmt_flat.c:855:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:855:29: sparse:     got restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:865:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   fs/binfmt_flat.c:865:13: sparse:     expected void *addr
   fs/binfmt_flat.c:865:13: sparse:     got void [noderef] __user *__cl_addr
--
>> arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     got unsigned int
--
   drivers/hid/usbhid/hiddev.c:569:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     expected int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     got int [noderef] __user *
>> drivers/hid/usbhid/hiddev.c:569:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     got int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:664:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     expected int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     got int [noderef] __user *
   drivers/hid/usbhid/hiddev.c:664:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     got int const *__gu_addr
--
>> arch/sh/drivers/dma/dma-sh.c:111:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
>> arch/sh/drivers/dma/dma-sh.c:111:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:111:16: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:117:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:117:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:117:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:151:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:151:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:151:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:162:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:162:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:162:16: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:168:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:168:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:168:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:186:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:186:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:186:16: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:188:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:188:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:188:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:219:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:219:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:219:17: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:222:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:222:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:222:17: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:224:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:224:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:224:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:234:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:234:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:234:15: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:237:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:237:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:237:16: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:93:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:93:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:93:20: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:93:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:93:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:93:20: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:262:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:262:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:262:31: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:266:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:266:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:266:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:269:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:269:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:269:9: sparse:     got unsigned long
   arch/sh/drivers/dma/dma-sh.c:272:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/drivers/dma/dma-sh.c:272:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/drivers/dma/dma-sh.c:272:14: sparse:     got unsigned long

vim +402 fs/binfmt_flat.c

^1da177e4c3f415 Linus Torvalds    2005-04-16  387  
cf9a566c2c06ac3 Christoph Hellwig 2019-06-13  388  #ifdef CONFIG_BINFMT_FLAT_OLD
343034357202be3 Axel Lin          2014-06-04  389  static void old_reloc(unsigned long rl)
^1da177e4c3f415 Linus Torvalds    2005-04-16  390  {
13c3f50c914e6a5 Nicolas Pitre     2016-07-24  391  	static const char *segment[] = { "TEXT", "DATA", "BSS", "*UNKNOWN*" };
^1da177e4c3f415 Linus Torvalds    2005-04-16  392  	flat_v2_reloc_t	r;
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  393  	unsigned long __user *ptr;
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  394  	unsigned long val;
^1da177e4c3f415 Linus Torvalds    2005-04-16  395  
^1da177e4c3f415 Linus Torvalds    2005-04-16  396  	r.value = rl;
^1da177e4c3f415 Linus Torvalds    2005-04-16  397  #if defined(CONFIG_COLDFIRE)
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  398  	ptr = (unsigned long __user *)(current->mm->start_code + r.reloc.offset);
^1da177e4c3f415 Linus Torvalds    2005-04-16  399  #else
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  400  	ptr = (unsigned long __user *)(current->mm->start_data + r.reloc.offset);
^1da177e4c3f415 Linus Torvalds    2005-04-16  401  #endif
1b2ce442ea96b1e Nicolas Pitre     2016-07-24 @402  	get_user(val, ptr);
^1da177e4c3f415 Linus Torvalds    2005-04-16  403  
4adbb6ac4b807e2 Nicolas Pitre     2016-07-24  404  	pr_debug("Relocation of variable at DATASEG+%x "
13c3f50c914e6a5 Nicolas Pitre     2016-07-24  405  		 "(address %p, currently %lx) into segment %s\n",
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  406  		 r.reloc.offset, ptr, val, segment[r.reloc.type]);
^1da177e4c3f415 Linus Torvalds    2005-04-16  407  
^1da177e4c3f415 Linus Torvalds    2005-04-16  408  	switch (r.reloc.type) {
^1da177e4c3f415 Linus Torvalds    2005-04-16  409  	case OLD_FLAT_RELOC_TYPE_TEXT:
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  410  		val += current->mm->start_code;
^1da177e4c3f415 Linus Torvalds    2005-04-16  411  		break;
^1da177e4c3f415 Linus Torvalds    2005-04-16  412  	case OLD_FLAT_RELOC_TYPE_DATA:
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  413  		val += current->mm->start_data;
^1da177e4c3f415 Linus Torvalds    2005-04-16  414  		break;
^1da177e4c3f415 Linus Torvalds    2005-04-16  415  	case OLD_FLAT_RELOC_TYPE_BSS:
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  416  		val += current->mm->end_data;
^1da177e4c3f415 Linus Torvalds    2005-04-16  417  		break;
^1da177e4c3f415 Linus Torvalds    2005-04-16  418  	default:
4adbb6ac4b807e2 Nicolas Pitre     2016-07-24  419  		pr_err("Unknown relocation type=%x\n", r.reloc.type);
^1da177e4c3f415 Linus Torvalds    2005-04-16  420  		break;
^1da177e4c3f415 Linus Torvalds    2005-04-16  421  	}
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  422  	put_user(val, ptr);
^1da177e4c3f415 Linus Torvalds    2005-04-16  423  
1b2ce442ea96b1e Nicolas Pitre     2016-07-24  424  	pr_debug("Relocation became %lx\n", val);
^1da177e4c3f415 Linus Torvalds    2005-04-16  425  }
cf9a566c2c06ac3 Christoph Hellwig 2019-06-13  426  #endif /* CONFIG_BINFMT_FLAT_OLD */
^1da177e4c3f415 Linus Torvalds    2005-04-16  427  

:::::: The code at line 402 was first introduced by commit
:::::: 1b2ce442ea96b1e76300553963154d68cc5b4ad0 binfmt_flat: use proper user space accessors with old relocs code

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Greg Ungerer <gerg@linux-m68k.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
SEcVsjJgjEHheHT4PFd2Zfb/Lx07gTQeZAEA

--ZPt4rx8FFjLCG7dd--
