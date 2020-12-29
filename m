Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF472E6D67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgL2C7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 21:59:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:28217 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgL2C67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 21:58:59 -0500
IronPort-SDR: zrdThqctxy3LCgDyePL4mdaRokM+DkoHiFYPJObkIxEk/qkGPzmnVMEmxAjIE8iaLNt7D4Symw
 OxxHtlP5bfiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176547090"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="gz'50?scan'50,208,50";a="176547090"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 18:58:15 -0800
IronPort-SDR: h/xmZnY1xxxjwvjR7zn/OdwwHUpTompFAXchiUzRgOter06N9ePdAWtooI4D3OxZ2EOFcezOhj
 vdEHNxHhA0iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="gz'50?scan'50,208,50";a="358770362"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Dec 2020 18:58:13 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ku5DA-0003Hd-EX; Tue, 29 Dec 2020 02:58:12 +0000
Date:   Tue, 29 Dec 2020 10:57:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202012291003.7osGH9pq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   4 weeks ago
config: powerpc64-randconfig-s031-20201223 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:347:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:382:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:604:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:605:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:606:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:612:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:613:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:614:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:625:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:626:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:627:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:637:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:638:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:639:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:653:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] __iomem *uccup @@
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     got struct ucc_uart_pram [noderef] __iomem *uccup
   drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:662:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:663:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:664:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:665:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:666:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:667:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:667:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:668:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:668:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:668:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:669:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:669:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:669:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:670:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:670:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:670:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:671:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:671:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:671:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:672:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:672:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:672:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:674:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:674:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:674:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:675:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:713:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:713:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:713:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:714:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:714:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:714:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:715:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:715:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:715:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:716:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:716:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:716:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:717:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:718:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:719:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:720:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     expected void volatile [noderef] __iomem *addr

vim +264 drivers/tty/serial/ucc_uart.c

d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  248  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  249  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  250   * Return 1 if the QE is done transmitting all buffers for this port
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  251   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  252   * This function scans each BD in sequence.  If we find a BD that is not
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  253   * ready (READY=1), then we return 0 indicating that the QE is still sending
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  254   * data.  If we reach the last BD (WRAP=1), then we know we've scanned
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  255   * the entire list, and all BDs are done.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  256   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  257  static unsigned int qe_uart_tx_empty(struct uart_port *port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  258  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  259  	struct uart_qe_port *qe_port =
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  260  		container_of(port, struct uart_qe_port, port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  261  	struct qe_bd *bdp = qe_port->tx_bd_base;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  262  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  263  	while (1) {
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28 @264  		if (qe_ioread16be(&bdp->status) & BD_SC_READY)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  265  			/* This BD is not done, so return "not done" */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  266  			return 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  267  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  268  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  269  			/*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  270  			 * This BD is done and it's the last one, so return
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  271  			 * "done"
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  272  			 */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  273  			return 1;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  274  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  275  		bdp++;
fc811472c2167cc drivers/tty/serial/ucc_uart.c Joe Perches        2013-10-08  276  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  277  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  278  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  279  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  280   * Set the modem control lines
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  281   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  282   * Although the QE can control the modem control lines (e.g. CTS), we
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  283   * don't need that support. This function must exist, however, otherwise
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  284   * the kernel will panic.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  285   */
4be002f1dec8418 drivers/tty/serial/ucc_uart.c Jason Yan          2020-09-12  286  static void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  287  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  288  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  289  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  290  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  291   * Get the current modem control line status
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  292   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  293   * Although the QE can control the modem control lines (e.g. CTS), this
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  294   * driver currently doesn't support that, so we always return Carrier
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  295   * Detect, Data Set Ready, and Clear To Send.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  296   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  297  static unsigned int qe_uart_get_mctrl(struct uart_port *port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  298  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  299  	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  300  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  301  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  302  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  303   * Disable the transmit interrupt.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  304   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  305   * Although this function is called "stop_tx", it does not actually stop
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  306   * transmission of data.  Instead, it tells the QE to not generate an
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  307   * interrupt when the UCC is finished sending characters.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  308   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  309  static void qe_uart_stop_tx(struct uart_port *port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  310  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  311  	struct uart_qe_port *qe_port =
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  312  		container_of(port, struct uart_qe_port, port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  313  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  314  	qe_clrbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  315  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  316  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  317  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  318   * Transmit as many characters to the HW as possible.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  319   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  320   * This function will attempt to stuff of all the characters from the
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  321   * kernel's transmit buffer into TX BDs.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  322   *
af901ca181d92aa drivers/serial/ucc_uart.c     André Goddard Rosa 2009-11-14  323   * A return value of non-zero indicates that it successfully stuffed all
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  324   * characters from the kernel buffer.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  325   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  326   * A return value of zero indicates that there are still characters in the
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  327   * kernel's buffer that have not been transmitted, but there are no more BDs
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  328   * available.  This function should be called again after a BD has been made
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  329   * available.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  330   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  331  static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  332  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  333  	struct qe_bd *bdp;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  334  	unsigned char *p;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  335  	unsigned int count;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  336  	struct uart_port *port = &qe_port->port;
ebd2c8f6d2ec401 drivers/serial/ucc_uart.c     Alan Cox           2009-09-19  337  	struct circ_buf *xmit = &port->state->xmit;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  338  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  339  	/* Handle xon/xoff */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  340  	if (port->x_char) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  341  		/* Pick next descriptor and fill from buffer */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  342  		bdp = qe_port->tx_cur;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  343  
09a39ec9decd99e drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  344  		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  345  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  346  		*p++ = port->x_char;
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28 @347  		qe_iowrite16be(1, &bdp->length);
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  348  		qe_setbits_be16(&bdp->status, BD_SC_READY);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  349  		/* Get next BD. */
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  350  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  351  			bdp = qe_port->tx_bd_base;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  352  		else
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  353  			bdp++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  354  		qe_port->tx_cur = bdp;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  355  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  356  		port->icount.tx++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  357  		port->x_char = 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  358  		return 1;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  359  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  360  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  361  	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  362  		qe_uart_stop_tx(port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  363  		return 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  364  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  365  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  366  	/* Pick next descriptor and fill from buffer */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  367  	bdp = qe_port->tx_cur;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  368  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  369  	while (!(qe_ioread16be(&bdp->status) & BD_SC_READY) &&
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  370  	       (xmit->tail != xmit->head)) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  371  		count = 0;
09a39ec9decd99e drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  372  		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  373  		while (count < qe_port->tx_fifosize) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  374  			*p++ = xmit->buf[xmit->tail];
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  375  			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  376  			port->icount.tx++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  377  			count++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  378  			if (xmit->head == xmit->tail)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  379  				break;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  380  		}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  381  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  382  		qe_iowrite16be(count, &bdp->length);
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  383  		qe_setbits_be16(&bdp->status, BD_SC_READY);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  384  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  385  		/* Get next BD. */
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  386  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  387  			bdp = qe_port->tx_bd_base;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  388  		else
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  389  			bdp++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  390  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  391  	qe_port->tx_cur = bdp;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  392  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  393  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  394  		uart_write_wakeup(port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  395  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  396  	if (uart_circ_empty(xmit)) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  397  		/* The kernel buffer is empty, so turn off TX interrupts.  We
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  398  		   don't need to be told when the QE is finished transmitting
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  399  		   the data. */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  400  		qe_uart_stop_tx(port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  401  		return 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  402  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  403  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  404  	return 1;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  405  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  406  

:::::: The code at line 264 was first introduced by commit
:::::: 8b1cdc4033bd1659c5499c918d4e59bf8253abec serial: ucc_uart: replace ppc-specific IO accessors

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Li Yang <leoyang.li@nxp.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--FCuugMFkClbJLl1L--
