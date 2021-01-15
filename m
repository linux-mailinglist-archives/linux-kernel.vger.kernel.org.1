Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01A2F7496
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbhAOIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:51:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:48358 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbhAOIvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:51:22 -0500
IronPort-SDR: 4NnhZWcX3IlO6yl2cwi53wrrPQ8leOvy3bAM2+zFyLerHlgY/VxsaVnyYbP3pp2BZ2bNAN9DLK
 82hzEMrkM2AA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="175014599"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="gz'50?scan'50,208,50";a="175014599"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 00:50:35 -0800
IronPort-SDR: jclriDX3IjEelXndRV4775rVXcIMheQtpbRwh6kfN7SlUmm0a2+UHEc4kSlbehoKkDCqW9YGG1
 w6eYeiEGu+WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="gz'50?scan'50,208,50";a="401222220"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2021 00:50:33 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0KoS-0000Gh-Lw; Fri, 15 Jan 2021 08:50:32 +0000
Date:   Fri, 15 Jan 2021 16:50:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/scsi/myrs.c:2449:13: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202101151657.pWIXmPAS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kefeng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ee88057889bbca5f5bb96031b62b3756b33e164
commit: ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'
date:   8 months ago
config: riscv-randconfig-s032-20210115 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/scsi/myrs.c:1532:5: sparse: sparse: symbol 'myrs_host_reset' was not declared. Should it be static?
   drivers/scsi/myrs.c:1922:27: sparse: sparse: symbol 'myrs_template' was not declared. Should it be static?
   drivers/scsi/myrs.c:2036:31: sparse: sparse: symbol 'myrs_raid_functions' was not declared. Should it be static?
   drivers/scsi/myrs.c:2046:6: sparse: sparse: symbol 'myrs_flush_cache' was not declared. Should it be static?
   drivers/scsi/myrs.c:2275:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:2> *base @@     got struct myrs_hba *cs @@
   drivers/scsi/myrs.c:2275:34: sparse:     expected void [noderef] <asn:2> *base
   drivers/scsi/myrs.c:2275:34: sparse:     got struct myrs_hba *cs
   drivers/scsi/myrs.c:2434:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2502:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2427:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2502:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2413:9: sparse: sparse: cast from restricted __le32
>> drivers/scsi/myrs.c:2449:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2449:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2449:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2549:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2549:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2549:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2552:18: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/myrs.c:2427:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2495:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2472:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2441:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2441:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2441:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2406:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2479:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
   drivers/scsi/myrs.c:2479:13: sparse:     expected restricted __le32 [usertype] val
   drivers/scsi/myrs.c:2479:13: sparse:     got unsigned int [assigned] [usertype] __v
   drivers/scsi/myrs.c:2457:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/myrs.c:2413:9: sparse: sparse: cast from restricted __le32
--
   drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse:     got void *
>> drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     got void *
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     got void *
--
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:87:41: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:88:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] dummy_buffer_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:88:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] dummy_buffer_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:88:41: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:89:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:89:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:89:42: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:90:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:90:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:90:42: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:92:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] mtu @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:92:24: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] mtu
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:92:24: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:109:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:109:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:109:41: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:110:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:110:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:110:41: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:113:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:113:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:113:40: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:114:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:114:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:114:40: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:117:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:117:44: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:117:44: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:118:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:118:44: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:118:44: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:121:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] free_list_count @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:121:36: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] free_list_count
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:121:36: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:128:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_lo @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:128:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:128:37: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:129:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_hi @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:129:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:129:37: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:199:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] fcoe_conn_id @@     got unsigned short [assigned] [usertype] conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:199:32: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:199:32: sparse:     got unsigned short [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:202:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:202:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:202:30: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:203:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:203:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:203:30: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:205:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:205:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:205:34: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:206:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:206:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:206:34: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:208:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:208:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:208:40: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:209:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:209:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:209:40: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:212:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] rq_prod @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:212:27: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] rq_prod
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:212:27: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:221:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tx_max_fc_pay_len @@     got unsigned short [usertype] maxframe_size @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:221:37: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tx_max_fc_pay_len
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:221:37: sparse:     got unsigned short [usertype] maxframe_size
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:223:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:223:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:223:30: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:224:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:224:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:224:30: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:226:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:226:33: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:226:33: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:227:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:227:33: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:227:33: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:229:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:229:35: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:229:35: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:230:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:230:35: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:230:35: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:239:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] vlan_tag @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:239:28: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] vlan_tag
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:239:28: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:241:28: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:241:28: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:241:28: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:264:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tx_total_conc_seqs @@     got unsigned short [usertype] max_seq @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:264:38: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tx_total_conc_seqs
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:264:38: sparse:     got unsigned short [usertype] max_seq
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:267:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] rx_max_fc_pay_len @@     got unsigned int [usertype] mfs @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:267:38: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] rx_max_fc_pay_len
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:267:38: sparse:     got unsigned int [usertype] mfs
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:269:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] rx_total_conc_seqs @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:269:38: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] rx_total_conc_seqs
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:269:38: sparse:     got int
>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:273:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_lo @@     got unsigned int [usertype] confq_dma @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:273:43: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:273:43: sparse:     got unsigned int [usertype] confq_dma
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:274:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:274:43: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:274:43: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:332:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:332:31: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:332:31: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:333:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:333:31: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:333:31: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:335:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:335:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:335:42: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:336:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:336:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:336:42: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:410:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:410:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:410:29: sparse:     got unsigned int [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:411:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:411:26: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:411:26: sparse:     got unsigned int [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:469:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:469:32: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:469:32: sparse:     got unsigned int [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse:     got unsigned int [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     got unsigned int [usertype] context_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     got unsigned int [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fr_crc @@     got restricted __le32 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     expected unsigned int [usertype] fr_crc
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:696:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __le16 [usertype] ox_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:696:21: sparse:     expected unsigned short [usertype] xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:696:21: sparse:     got restricted __le16 [usertype] ox_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:731:27: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:732:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: cast from restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] ox_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse:     expected unsigned short [usertype] val
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse:     got restricted __le16 [usertype] ox_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: cast from restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: cast from restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __be16 [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:21: sparse:     expected unsigned short [usertype] xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:21: sparse:     got restricted __be16 [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:826:27: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:827:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:893:45: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:970:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] doorbell_cq_cons @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:970:33: sparse:     expected restricted __le16 [usertype] doorbell_cq_cons
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:970:33: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:973:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1027:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1097:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] wqe @@     got restricted __le16 [usertype] wqe @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1097:22: sparse:     expected unsigned short [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1097:22: sparse:     got restricted __le16 [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1261:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] conn_id @@     got restricted __le32 [usertype] fcoe_conn_id @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1261:17: sparse:     expected unsigned int [usertype] conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1261:17: sparse:     got restricted __le32 [usertype] fcoe_conn_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1377:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] err_code @@     got restricted __le32 [usertype] completion_status @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1377:53: sparse:     expected unsigned int [usertype] err_code
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1377:53: sparse:     got restricted __le32 [usertype] completion_status
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1429:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wqe @@     got int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1429:18: sparse:     expected restricted __le16 [usertype] wqe
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1429:18: sparse:     got int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1430:18: sparse: sparse: invalid assignment: |=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1430:18: sparse:    left side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1430:18: sparse:    right side has type int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1448:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1532:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1532:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1532:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1534:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1534:46: sparse:     expected restricted __le32 [usertype] init_flags
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1534:46: sparse:     got unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1537:63: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cleaned_task_id @@     got unsigned short [usertype] orig_xid @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1537:63: sparse:     expected restricted __le16 [usertype] cleaned_task_id
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1537:63: sparse:     got unsigned short [usertype] orig_xid
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1540:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] rolled_tx_data_offset @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1540:69: sparse:     expected restricted __le32 [usertype] rolled_tx_data_offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1540:69: sparse:     got unsigned int [usertype] offset
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1546:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1548:24: sparse: sparse: invalid assignment: -=
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1548:24: sparse:    left side has type unsigned int
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1548:24: sparse:    right side has type restricted __le16
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1553:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1553:69: sparse:     expected restricted __le32 [usertype] lo
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1553:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1555:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1555:69: sparse:     expected restricted __le32 [usertype] hi
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1555:69: sparse:     got unsigned int [usertype]
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cur_sge_off @@     got unsigned int [usertype] offset @@
   drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:65: sparse:     expected restricted __le16 [usertype] cur_sge_off

vim +2449 drivers/scsi/myrs.c

77266186397c6c78 Hannes Reinecke 2018-10-17  2444  
77266186397c6c78 Hannes Reinecke 2018-10-17  2445  static inline bool DAC960_GEM_init_in_progress(void __iomem *base)
77266186397c6c78 Hannes Reinecke 2018-10-17  2446  {
77266186397c6c78 Hannes Reinecke 2018-10-17  2447  	__le32 val;
77266186397c6c78 Hannes Reinecke 2018-10-17  2448  
77266186397c6c78 Hannes Reinecke 2018-10-17 @2449  	val = readl(base + DAC960_GEM_IDB_READ_OFFSET);
77266186397c6c78 Hannes Reinecke 2018-10-17  2450  	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_INIT_IN_PROGRESS;
77266186397c6c78 Hannes Reinecke 2018-10-17  2451  }
77266186397c6c78 Hannes Reinecke 2018-10-17  2452  

:::::: The code at line 2449 was first introduced by commit
:::::: 77266186397c6c782a3f670d32808a9671806ec5 scsi: myrs: Add Mylex RAID controller (SCSI interface)

:::::: TO: Hannes Reinecke <hare@suse.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--h31gzZEtNLTqOjlF--
