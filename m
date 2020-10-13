Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA128C6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 03:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgJMBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 21:44:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:29432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgJMBoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:44:30 -0400
IronPort-SDR: 07SDk7j8geFLrs/B2y62DjvJSwE8Jr5EwWK7BRinf1K5JptEu+KtLAHLFyEteJXr3SY4AFjG5W
 PVpy1n916IlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152760711"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="gz'50?scan'50,208,50";a="152760711"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:44:29 -0700
IronPort-SDR: HayPcjSVFWi7tiCrcgwQ3xOVCnMhujoml6VTOqnC86GQp9S3AeSwyGY9wLV4R7Vt4w3rcZmJRg
 epPiBrzTAgFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="gz'50?scan'50,208,50";a="356828034"
Received: from lkp-server01.sh.intel.com (HELO aa1d92d39b27) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2020 18:44:27 -0700
Received: from kbuild by aa1d92d39b27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kS9MY-0000FS-Co; Tue, 13 Oct 2020 01:44:26 +0000
Date:   Tue, 13 Oct 2020 09:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Auchter <michael.auchter@ni.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] extcon: add driver for TI TUSB320
Message-ID: <202010130952.lph7AvpG-lkp@intel.com>
References: <20201012144754.738830-1-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20201012144754.738830-1-michael.auchter@ni.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on chanwoo-extcon/extcon-next]
[also build test WARNING on v5.9 next-20201012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Auchter/extcon-add-driver-for-TI-TUSB320/20201012-232733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
config: s390-randconfig-r022-20201013 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project a324d8f964bf421fa7d8b882b0f64ead28c4149c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/5065d684df89cf11f57743f3c1440e6bd09054ea
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Auchter/extcon-add-driver-for-TI-TUSB320/20201012-232733
        git checkout 5065d684df89cf11f57743f3c1440e6bd09054ea
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:19:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
                     ^
   In file included from drivers/extcon/extcon-usbc-tusb320.c:13:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:20:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |            \
                     ^
   In file included from drivers/extcon/extcon-usbc-tusb320.c:13:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:21:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |            \
                     ^
   In file included from drivers/extcon/extcon-usbc-tusb320.c:13:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:22:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
                     ^
   In file included from drivers/extcon/extcon-usbc-tusb320.c:13:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:120:12: note: expanded from macro '__swab32'
           __fswab32(x))
                     ^
   In file included from drivers/extcon/extcon-usbc-tusb320.c:13:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/extcon/extcon-usbc-tusb320.c:163:35: warning: unused variable 'tusb320_i2c_id' [-Wunused-const-variable]
   static const struct i2c_device_id tusb320_i2c_id[] = {
                                     ^
   21 warnings generated.

vim +/tusb320_i2c_id +163 drivers/extcon/extcon-usbc-tusb320.c

   162	
 > 163	static const struct i2c_device_id tusb320_i2c_id[] = {
   164		{ "tusb320", 0 },
   165		{ }
   166	};
   167	MODULE_DEVICE_TABLE(i2c, tusb320_i2c_id);
   168	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ScKe/wEPmti6HC8BAA==

--pWyiEgJYm5f9v55/--
