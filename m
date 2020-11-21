Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7396C2BC188
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgKUSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:43:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:58032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgKUSnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:43:35 -0500
IronPort-SDR: iFKMg1V5S2/vNgF9APgVKCQ80mFXTxsrAyAXGl0XP3GFfwwkg2hpQKCu7KR1aOmZ/VuVtmU1II
 zG0JqpUSyYdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="235750283"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="235750283"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 10:43:33 -0800
IronPort-SDR: 8D2h5sBdFV5fNrvfPACWiRdNVuh7dQYTTDZV/RGsbFZqoyh1bigUvN0r8kQ4Pa3ecGTz1dZhUf
 tEYePV+czseg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="358044176"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2020 10:43:31 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgXr8-0000Ob-Fk; Sat, 21 Nov 2020 18:43:30 +0000
Date:   Sun, 22 Nov 2020 02:43:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202011220210.A7WMYcKx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bba9c532a8d21050b94224ffd310ad0058c353
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   3 months ago
config: alpha-randconfig-s032-20201122 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-134-gb59dbdaf-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/spi/spi-lp8841-rtc.c:112:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:112:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:112:41: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:121:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:121:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:121:41: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:143:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:143:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:143:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:147:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:147:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:147:41: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iomem @@     got void [noderef] __iomem * @@
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     expected void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     got void *iomem
>> drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *iomem @@
>> drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     got void *iomem
>> drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *iomem @@
>> drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
--
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:286:6: sparse: sparse: symbol 'qe_uart_set_mctrl' was not declared. Should it be static?
   drivers/tty/serial/ucc_uart.c:347:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:382:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const [noderef] __iomem *addr

vim +63 drivers/spi/spi-lp8841-rtc.c

7ecbfff6711fb3 Sergei Ianovich 2016-02-23  59  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  60  static inline int
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  61  getmiso(struct spi_lp8841_rtc *data)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  62  {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23 @63  	return ioread8(data->iomem) & SPI_LP8841_RTC_MISO;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  64  }
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  65  

:::::: The code at line 63 was first introduced by commit
:::::: 7ecbfff6711fb331591003ac32c002ce55a0758f spi: master driver to enable RTC on ICPDAS LP-8841

:::::: TO: Sergei Ianovich <ynvich@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
V0hSxW2hMkL+/K//AzFNo5e9iwEA

--EVF5PPMfhYS0aIcm--
