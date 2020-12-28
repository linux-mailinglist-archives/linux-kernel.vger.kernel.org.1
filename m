Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94C2E33E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgL1DSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:18:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:2293 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgL1DSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:18:17 -0500
IronPort-SDR: 53emFCjCELw/oHui+BpaSRzns7xeA1Jn5DREXTTl3bU7NqaswtLryJp+DLihbwjg+VlZDJUNzW
 1SLc3MnRZPfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="172829798"
X-IronPort-AV: E=Sophos;i="5.78,453,1599548400"; 
   d="gz'50?scan'50,208,50";a="172829798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2020 19:17:36 -0800
IronPort-SDR: fQPFTTQFym4REBaNxYykxJO6sdT8+Ez5VjP9XomKiyCGyboaiAD7Us0JUTZg9M74F8KR0WaRy8
 b+6jbjzzFbLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,453,1599548400"; 
   d="gz'50?scan'50,208,50";a="358398358"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2020 19:17:33 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktj2L-0002jX-3X; Mon, 28 Dec 2020 03:17:33 +0000
Date:   Mon, 28 Dec 2020 11:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202012281142.jyq2WFYQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c8fe583cce542aa0b84adc939ce85293de36e5e
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   4 months ago
config: sh-randconfig-s032-20201223 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     got unsigned long addr
>> arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     got unsigned long addr
--
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     got unsigned long [assigned] addr1
>> arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse:     got unsigned int
--
>> arch/sh/boards/mach-se/770x/irq.c:100:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:100:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:100:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse:     got unsigned int
--
   arch/sh/boards/mach-se/770x/setup.c: note: in included file (through include/linux/scatterlist.h, include/linux/dma-mapping.h, include/linux/skbuff.h, ...):
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/include/asm/io.h:184:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *__addr @@     got void [noderef] __iomem * @@
   arch/sh/include/asm/io.h:184:1: sparse:     expected unsigned char volatile [usertype] *__addr
   arch/sh/include/asm/io.h:184:1: sparse:     got void [noderef] __iomem *
   arch/sh/boards/mach-se/770x/setup.c: note: in included file:
>> arch/sh/include/mach-se/mach/mrshpc.h:9:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:9:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:9:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:12:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:12:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:12:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:13:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:15:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:15:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:15:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:23:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:23:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:23:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:24:13: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:24:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:24:13: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:26:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:26:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:26:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:29:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:29:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:29:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:32:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:32:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:32:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:33:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:33:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:33:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:35:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:35:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:35:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:38:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:38:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:38:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:41:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:42:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:42:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:42:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:43:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:43:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:43:14: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:44:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:44:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:44:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:46:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:46:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:46:17: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:48:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:48:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:48:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:49:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:49:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:49:9: sparse:     got unsigned int
   arch/sh/include/mach-se/mach/mrshpc.h:50:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/mach-se/mach/mrshpc.h:50:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/mach-se/mach/mrshpc.h:50:9: sparse:     got unsigned int
--
   drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int [noderef] __user *
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int [noderef] __user *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int const *__gu_addr

vim +35 arch/sh/kernel/cpu/irq/ipr.c

68abdbbb03476a6 arch/sh/kernel/cpu/irq/ipr.c Magnus Damm    2007-06-15  29  
8df3a615da1a9fe arch/sh/kernel/cpu/irq/ipr.c Paul Mundt     2010-10-27  30  static void disable_ipr_irq(struct irq_data *data)
^1da177e4c3f415 arch/sh/kernel/cpu/irq_ipr.c Linus Torvalds 2005-04-16  31  {
8df3a615da1a9fe arch/sh/kernel/cpu/irq/ipr.c Paul Mundt     2010-10-27  32  	struct ipr_data *p = irq_data_get_irq_chip_data(data);
8df3a615da1a9fe arch/sh/kernel/cpu/irq/ipr.c Paul Mundt     2010-10-27  33  	unsigned long addr = get_ipr_desc(data)->ipr_offsets[p->ipr_idx];
^1da177e4c3f415 arch/sh/kernel/cpu/irq_ipr.c Linus Torvalds 2005-04-16  34  	/* Set the priority in IPR to 0 */
62429e036448336 arch/sh/kernel/cpu/irq/ipr.c Paul Mundt     2008-10-01 @35  	__raw_writew(__raw_readw(addr) & (0xffff ^ (0xf << p->shift)), addr);
6000fc4d6f3e55a arch/sh/kernel/cpu/irq/ipr.c Stuart Menefy  2009-08-24  36  	(void)__raw_readw(addr);	/* Read back to flush write posting */
^1da177e4c3f415 arch/sh/kernel/cpu/irq_ipr.c Linus Torvalds 2005-04-16  37  }
^1da177e4c3f415 arch/sh/kernel/cpu/irq_ipr.c Linus Torvalds 2005-04-16  38  

:::::: The code at line 35 was first introduced by commit
:::::: 62429e03644833693e6f94afe537f252e2d3b475 sh: Use __raw_xxx() I/O accessors for INTC and IPR.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
96sBAA==

--huq684BweRXVnRxX--
