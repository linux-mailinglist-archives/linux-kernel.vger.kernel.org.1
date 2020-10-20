Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D92935A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgJTHSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:18:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:57836 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgJTHSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:18:31 -0400
IronPort-SDR: 49ua4c5GSYPyDrEMDejqDyVWYX0dM4YBiio1xAAGUx58qW9IWOsEjXUX0OKEseXOHd7wr8MYt4
 4oJRhgBxcsHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="147024150"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="gz'50?scan'50,208,50";a="147024150"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 00:18:29 -0700
IronPort-SDR: apHsj2pjAkfiBDT+RzG363NZLI+T1NoZPQ/t9rTyeZc/u/QbB+Pf6BldGZoC6W5N28En4cD6l5
 smdcMOmWNQlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="gz'50?scan'50,208,50";a="315939273"
Received: from lkp-server01.sh.intel.com (HELO 88424da292e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2020 00:18:26 -0700
Received: from kbuild by 88424da292e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUluc-0000Ro-9B; Tue, 20 Oct 2020 07:18:26 +0000
Date:   Tue, 20 Oct 2020 15:18:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202010201558.jL8V9kEA-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   270315b8235e3d10c2e360cff56c2f9e0915a252
commit: d7071743db31b4f6898b1c742e4b451bb4bc4b02 RISC-V: Add EFI stub support.
date:   2 weeks ago
config: riscv-randconfig-s032-20201020 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7071743db31b4f6898b1c742e4b451bb4bc4b02
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d7071743db31b4f6898b1c742e4b451bb4bc4b02
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse:     expected unsigned long const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:160:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:167:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:209:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[addressable] attributes @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected unsigned int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *[addressable] attributes
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:243:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:248:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:253:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:301:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local @@     got struct efi_time_cap_t [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     got struct efi_time_cap_t [usertype] *
   drivers/firmware/efi/test/efi_test.c:308:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:325:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__p @@     got unsigned char [usertype] *[addressable] enabled @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected unsigned char [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *[addressable] enabled
   drivers/firmware/efi/test/efi_test.c:365:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:389:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:421:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     expected unsigned long const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:429:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:439:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:452:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:479:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *dst @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     expected unsigned short [noderef] [usertype] __user *dst
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:494:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[addressable] high_count @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected unsigned int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *[addressable] high_count
   drivers/firmware/efi/test/efi_test.c:546:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void * @@
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     got void *
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] maximum_variable_size @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_size
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct efi_capsule_header_t [usertype] *const [noderef] __user *__p @@     got struct efi_capsule_header_t [usertype] ** @@
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse:     expected struct efi_capsule_header_t [usertype] *const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     got struct efi_capsule_header_t [usertype] **
   drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: Using plain integer as NULL pointer
   drivers/firmware/efi/test/efi_test.c:629:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_capsule_header_t [usertype] *[assigned] c @@
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     got struct efi_capsule_header_t [usertype] *[assigned] c
   drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] [assigned] status @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *[addressable] [assigned] status
   drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size
   drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int *[addressable] [assigned] reset_type @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *[addressable] [assigned] reset_type
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *

vim +157 drivers/firmware/efi/test/efi_test.c

ff6301dabc3ca20 Ivan Hu      2016-08-25   26  
ff6301dabc3ca20 Ivan Hu      2016-08-25   27  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   28   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca20 Ivan Hu      2016-08-25   29   *
ff6301dabc3ca20 Ivan Hu      2016-08-25   30   * Note this function returns the number of *bytes*, not the number of
ff6301dabc3ca20 Ivan Hu      2016-08-25   31   * ucs2 characters.
ff6301dabc3ca20 Ivan Hu      2016-08-25   32   */
ff6301dabc3ca20 Ivan Hu      2016-08-25   33  static inline size_t user_ucs2_strsize(efi_char16_t  __user *str)
ff6301dabc3ca20 Ivan Hu      2016-08-25   34  {
ff6301dabc3ca20 Ivan Hu      2016-08-25   35  	efi_char16_t *s = str, c;
ff6301dabc3ca20 Ivan Hu      2016-08-25   36  	size_t len;
ff6301dabc3ca20 Ivan Hu      2016-08-25   37  
ff6301dabc3ca20 Ivan Hu      2016-08-25   38  	if (!str)
ff6301dabc3ca20 Ivan Hu      2016-08-25   39  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   40  
ff6301dabc3ca20 Ivan Hu      2016-08-25   41  	/* Include terminating NULL */
ff6301dabc3ca20 Ivan Hu      2016-08-25   42  	len = sizeof(efi_char16_t);
ff6301dabc3ca20 Ivan Hu      2016-08-25   43  
ff6301dabc3ca20 Ivan Hu      2016-08-25  @44  	if (get_user(c, s++)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   45  		/* Can't read userspace memory for size */
ff6301dabc3ca20 Ivan Hu      2016-08-25   46  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   47  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   48  
ff6301dabc3ca20 Ivan Hu      2016-08-25   49  	while (c != 0) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   50  		if (get_user(c, s++)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   51  			/* Can't read userspace memory for size */
ff6301dabc3ca20 Ivan Hu      2016-08-25   52  			return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   53  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25   54  		len += sizeof(efi_char16_t);
ff6301dabc3ca20 Ivan Hu      2016-08-25   55  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   56  	return len;
ff6301dabc3ca20 Ivan Hu      2016-08-25   57  }
ff6301dabc3ca20 Ivan Hu      2016-08-25   58  
ff6301dabc3ca20 Ivan Hu      2016-08-25   59  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   60   * Allocate a buffer and copy a ucs2 string from user space into it.
ff6301dabc3ca20 Ivan Hu      2016-08-25   61   */
ff6301dabc3ca20 Ivan Hu      2016-08-25   62  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25   63  copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
ff6301dabc3ca20 Ivan Hu      2016-08-25   64  			size_t len)
ff6301dabc3ca20 Ivan Hu      2016-08-25   65  {
ff6301dabc3ca20 Ivan Hu      2016-08-25   66  	efi_char16_t *buf;
ff6301dabc3ca20 Ivan Hu      2016-08-25   67  
ff6301dabc3ca20 Ivan Hu      2016-08-25   68  	if (!src) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   69  		*dst = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25   70  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   71  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   72  
5f72cad65cfaac5 Geliang Tang 2017-06-02   73  	buf = memdup_user(src, len);
5f72cad65cfaac5 Geliang Tang 2017-06-02   74  	if (IS_ERR(buf)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   75  		*dst = NULL;
5f72cad65cfaac5 Geliang Tang 2017-06-02   76  		return PTR_ERR(buf);
ff6301dabc3ca20 Ivan Hu      2016-08-25   77  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   78  	*dst = buf;
ff6301dabc3ca20 Ivan Hu      2016-08-25   79  
ff6301dabc3ca20 Ivan Hu      2016-08-25   80  	return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   81  }
ff6301dabc3ca20 Ivan Hu      2016-08-25   82  
ff6301dabc3ca20 Ivan Hu      2016-08-25   83  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   84   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca20 Ivan Hu      2016-08-25   85   *
ff6301dabc3ca20 Ivan Hu      2016-08-25   86   * Just a wrap for user_ucs2_strsize
ff6301dabc3ca20 Ivan Hu      2016-08-25   87   */
ff6301dabc3ca20 Ivan Hu      2016-08-25   88  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25   89  get_ucs2_strsize_from_user(efi_char16_t __user *src, size_t *len)
ff6301dabc3ca20 Ivan Hu      2016-08-25   90  {
ff6301dabc3ca20 Ivan Hu      2016-08-25   91  	*len = user_ucs2_strsize(src);
ff6301dabc3ca20 Ivan Hu      2016-08-25   92  	if (*len == 0)
ff6301dabc3ca20 Ivan Hu      2016-08-25   93  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25   94  
ff6301dabc3ca20 Ivan Hu      2016-08-25   95  	return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   96  }
ff6301dabc3ca20 Ivan Hu      2016-08-25   97  
ff6301dabc3ca20 Ivan Hu      2016-08-25   98  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   99   * Calculate the required buffer allocation size and copy a ucs2 string
ff6301dabc3ca20 Ivan Hu      2016-08-25  100   * from user space into it.
ff6301dabc3ca20 Ivan Hu      2016-08-25  101   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  102   * This function differs from copy_ucs2_from_user_len() because it
ff6301dabc3ca20 Ivan Hu      2016-08-25  103   * calculates the size of the buffer to allocate by taking the length of
ff6301dabc3ca20 Ivan Hu      2016-08-25  104   * the string 'src'.
ff6301dabc3ca20 Ivan Hu      2016-08-25  105   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  106   * If a non-zero value is returned, the caller MUST NOT access 'dst'.
ff6301dabc3ca20 Ivan Hu      2016-08-25  107   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  108   * It is the caller's responsibility to free 'dst'.
ff6301dabc3ca20 Ivan Hu      2016-08-25  109   */
ff6301dabc3ca20 Ivan Hu      2016-08-25  110  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25  111  copy_ucs2_from_user(efi_char16_t **dst, efi_char16_t __user *src)
ff6301dabc3ca20 Ivan Hu      2016-08-25  112  {
ff6301dabc3ca20 Ivan Hu      2016-08-25  113  	size_t len;
ff6301dabc3ca20 Ivan Hu      2016-08-25  114  
ff6301dabc3ca20 Ivan Hu      2016-08-25  115  	len = user_ucs2_strsize(src);
ff6301dabc3ca20 Ivan Hu      2016-08-25  116  	if (len == 0)
ff6301dabc3ca20 Ivan Hu      2016-08-25  117  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  118  	return copy_ucs2_from_user_len(dst, src, len);
ff6301dabc3ca20 Ivan Hu      2016-08-25  119  }
ff6301dabc3ca20 Ivan Hu      2016-08-25  120  
ff6301dabc3ca20 Ivan Hu      2016-08-25  121  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25  122   * Copy a ucs2 string to a user buffer.
ff6301dabc3ca20 Ivan Hu      2016-08-25  123   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  124   * This function is a simple wrapper around copy_to_user() that does
ff6301dabc3ca20 Ivan Hu      2016-08-25  125   * nothing if 'src' is NULL, which is useful for reducing the amount of
ff6301dabc3ca20 Ivan Hu      2016-08-25  126   * NULL checking the caller has to do.
ff6301dabc3ca20 Ivan Hu      2016-08-25  127   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  128   * 'len' specifies the number of bytes to copy.
ff6301dabc3ca20 Ivan Hu      2016-08-25  129   */
ff6301dabc3ca20 Ivan Hu      2016-08-25  130  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25  131  copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
ff6301dabc3ca20 Ivan Hu      2016-08-25  132  {
ff6301dabc3ca20 Ivan Hu      2016-08-25  133  	if (!src)
ff6301dabc3ca20 Ivan Hu      2016-08-25  134  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25  135  
ff6301dabc3ca20 Ivan Hu      2016-08-25  136  	return copy_to_user(dst, src, len);
ff6301dabc3ca20 Ivan Hu      2016-08-25  137  }
ff6301dabc3ca20 Ivan Hu      2016-08-25  138  
ff6301dabc3ca20 Ivan Hu      2016-08-25  139  static long efi_runtime_get_variable(unsigned long arg)
ff6301dabc3ca20 Ivan Hu      2016-08-25  140  {
ff6301dabc3ca20 Ivan Hu      2016-08-25  141  	struct efi_getvariable __user *getvariable_user;
ff6301dabc3ca20 Ivan Hu      2016-08-25  142  	struct efi_getvariable getvariable;
46b9b7135332d1e Ivan Hu      2016-10-18  143  	unsigned long datasize = 0, prev_datasize, *dz;
ff6301dabc3ca20 Ivan Hu      2016-08-25  144  	efi_guid_t vendor_guid, *vd = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  145  	efi_status_t status;
ff6301dabc3ca20 Ivan Hu      2016-08-25  146  	efi_char16_t *name = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  147  	u32 attr, *at;
ff6301dabc3ca20 Ivan Hu      2016-08-25  148  	void *data = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  149  	int rv = 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25  150  
ff6301dabc3ca20 Ivan Hu      2016-08-25  151  	getvariable_user = (struct efi_getvariable __user *)arg;
ff6301dabc3ca20 Ivan Hu      2016-08-25  152  
ff6301dabc3ca20 Ivan Hu      2016-08-25  153  	if (copy_from_user(&getvariable, getvariable_user,
ff6301dabc3ca20 Ivan Hu      2016-08-25  154  			   sizeof(getvariable)))
ff6301dabc3ca20 Ivan Hu      2016-08-25  155  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  156  	if (getvariable.data_size &&
ff6301dabc3ca20 Ivan Hu      2016-08-25 @157  	    get_user(datasize, getvariable.data_size))
ff6301dabc3ca20 Ivan Hu      2016-08-25  158  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  159  	if (getvariable.vendor_guid) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  160  		if (copy_from_user(&vendor_guid, getvariable.vendor_guid,
ff6301dabc3ca20 Ivan Hu      2016-08-25  161  					sizeof(vendor_guid)))
ff6301dabc3ca20 Ivan Hu      2016-08-25  162  			return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  163  		vd = &vendor_guid;
ff6301dabc3ca20 Ivan Hu      2016-08-25  164  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  165  
ff6301dabc3ca20 Ivan Hu      2016-08-25  166  	if (getvariable.variable_name) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  167  		rv = copy_ucs2_from_user(&name, getvariable.variable_name);
ff6301dabc3ca20 Ivan Hu      2016-08-25  168  		if (rv)
ff6301dabc3ca20 Ivan Hu      2016-08-25  169  			return rv;
ff6301dabc3ca20 Ivan Hu      2016-08-25  170  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  171  
ff6301dabc3ca20 Ivan Hu      2016-08-25  172  	at = getvariable.attributes ? &attr : NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  173  	dz = getvariable.data_size ? &datasize : NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  174  
ff6301dabc3ca20 Ivan Hu      2016-08-25  175  	if (getvariable.data_size && getvariable.data) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  176  		data = kmalloc(datasize, GFP_KERNEL);
ff6301dabc3ca20 Ivan Hu      2016-08-25  177  		if (!data) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  178  			kfree(name);
ff6301dabc3ca20 Ivan Hu      2016-08-25  179  			return -ENOMEM;
ff6301dabc3ca20 Ivan Hu      2016-08-25  180  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25  181  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  182  
ff6301dabc3ca20 Ivan Hu      2016-08-25  183  	prev_datasize = datasize;
ff6301dabc3ca20 Ivan Hu      2016-08-25  184  	status = efi.get_variable(name, vd, at, dz, data);
ff6301dabc3ca20 Ivan Hu      2016-08-25  185  	kfree(name);
ff6301dabc3ca20 Ivan Hu      2016-08-25  186  
ff6301dabc3ca20 Ivan Hu      2016-08-25  187  	if (put_user(status, getvariable.status)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  188  		rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  189  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  190  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  191  
ff6301dabc3ca20 Ivan Hu      2016-08-25  192  	if (status != EFI_SUCCESS) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  193  		if (status == EFI_BUFFER_TOO_SMALL) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  194  			if (dz && put_user(datasize, getvariable.data_size)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  195  				rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  196  				goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  197  			}
ff6301dabc3ca20 Ivan Hu      2016-08-25  198  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25  199  		rv = -EINVAL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  200  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  201  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  202  
ff6301dabc3ca20 Ivan Hu      2016-08-25  203  	if (prev_datasize < datasize) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  204  		rv = -EINVAL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  205  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  206  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  207  
ff6301dabc3ca20 Ivan Hu      2016-08-25  208  	if (data) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  209  		if (copy_to_user(getvariable.data, data, datasize)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  210  			rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  211  			goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  212  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25  213  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  214  
ff6301dabc3ca20 Ivan Hu      2016-08-25  215  	if (at && put_user(attr, getvariable.attributes)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  216  		rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  217  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  218  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  219  
ff6301dabc3ca20 Ivan Hu      2016-08-25  220  	if (dz && put_user(datasize, getvariable.data_size))
ff6301dabc3ca20 Ivan Hu      2016-08-25  221  		rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  222  
ff6301dabc3ca20 Ivan Hu      2016-08-25  223  out:
ff6301dabc3ca20 Ivan Hu      2016-08-25  224  	kfree(data);
ff6301dabc3ca20 Ivan Hu      2016-08-25  225  	return rv;
ff6301dabc3ca20 Ivan Hu      2016-08-25  226  

:::::: The code at line 157 was first introduced by commit
:::::: ff6301dabc3ca20ab8f50f8d0252ac05da610d89 efi: Add efi_test driver for exporting UEFI runtime service interfaces

:::::: TO: Ivan Hu <ivan.hu@canonical.com>
:::::: CC: Matt Fleming <matt@codeblueprint.co.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aTjWHpoBAA==

--mYCpIKhGyMATD0i+--
