Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC902A0ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgJ3Tkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:40:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:37063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgJ3Tkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:40:31 -0400
IronPort-SDR: 6WdOJHGc9U+32db0jQZo/5BLJltSbSLFex80iCELnq/P2+WOmXJbZ2+cijjM/gB/l3utQXkZFz
 dpAA+MubXCfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="156430920"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="gz'50?scan'50,208,50";a="156430920"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:40:27 -0700
IronPort-SDR: AbyFlw/8QAC9E3KxC7N4mobhLOq+U2wU6/qqTFFKmMbRupLHt7e7tEYmsls2y7EJY9GsBh59/3
 NxlFvAzmQbQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="gz'50?scan'50,208,50";a="361944004"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2020 12:40:24 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYaG7-0000HY-TX; Fri, 30 Oct 2020 19:40:23 +0000
Date:   Sat, 31 Oct 2020 03:40:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202010310307.INCPoqmf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07e0887302450a62f51dba72df6afb5fabb23d1c
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   3 months ago
config: alpha-randconfig-s031-20201029 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-56-gc09e8239-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *
   drivers/scsi/mvumi.c:81:52: sparse:     got void *
   drivers/scsi/mvumi.c:90:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/scsi/mvumi.c:90:39: sparse:     expected void *
   drivers/scsi/mvumi.c:90:39: sparse:     got void [noderef] __iomem *
   drivers/scsi/mvumi.c:210:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:210:34: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:210:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:211:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:211:34: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:211:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:213:17: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:213:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:213:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:213:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:213:17: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:213:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:242:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:242:26: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:242:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:243:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:243:26: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:243:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:245:9: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:245:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:245:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:245:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:245:9: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:245:9: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *inb_read_pointer @@
>> drivers/scsi/mvumi.c:407:40: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:407:40: sparse:     got void *inb_read_pointer
>> drivers/scsi/mvumi.c:429:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:429:30: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:429:30: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:458:31: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:458:31: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:459:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_write_pointer @@
   drivers/scsi/mvumi.c:459:48: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:459:48: sparse:     got void *inb_write_pointer
>> drivers/scsi/mvumi.c:496:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:496:41: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:496:41: sparse:     got void *outb_copy_pointer
>> drivers/scsi/mvumi.c:497:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:497:48: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:497:48: sparse:     got void *ob_shadow
>> drivers/scsi/mvumi.c:516:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:516:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:516:33: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:517:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:517:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:517:33: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:578:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:578:42: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:578:42: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:585:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:585:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:585:26: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:586:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:586:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:586:26: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:589:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:589:40: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:589:40: sparse:     got void *pciea_to_arm_drbl_reg
>> drivers/scsi/mvumi.c:1281:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1281:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1281:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1282:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1282:28: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1282:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1284:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1284:48: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1284:48: sparse:     got void *arm_to_pciea_mask_reg
>> drivers/scsi/mvumi.c:1285:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1285:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1285:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1286:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1286:28: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1286:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:612:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:612:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:612:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:613:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:613:28: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:615:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:615:46: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:615:46: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:624:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:624:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:624:36: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:670:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:670:32: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:670:32: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:671:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:671:34: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:671:34: sparse:     got void *reset_request
   drivers/scsi/mvumi.c:673:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:673:35: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:673:35: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:674:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:674:35: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:674:35: sparse:     got void *reset_request
>> drivers/scsi/mvumi.c:1100:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg0 @@
   drivers/scsi/mvumi.c:1100:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1100:36: sparse:     got void *arm_to_pciea_msg0
   drivers/scsi/mvumi.c:1115:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1115:52: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1115:52: sparse:     got void *pciea_to_arm_msg1
   drivers/scsi/mvumi.c:1116:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1116:39: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1116:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1117:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1117:47: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1117:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1122:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1122:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1122:45: sparse:     got void *pciea_to_arm_msg1
   drivers/scsi/mvumi.c:1124:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1124:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1124:45: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1127:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1127:39: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1127:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1128:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1128:47: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1128:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1168:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1168:39: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1168:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1169:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1169:47: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1169:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1174:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1174:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1174:36: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1176:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1176:36: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1176:36: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1177:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:1177:50: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1177:50: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:1180:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_aval_count_basel @@
   drivers/scsi/mvumi.c:1180:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1180:45: sparse:     got void *inb_aval_count_basel
   drivers/scsi/mvumi.c:1182:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_aval_count_baseh @@
   drivers/scsi/mvumi.c:1182:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1182:45: sparse:     got void *inb_aval_count_baseh
   drivers/scsi/mvumi.c:1188:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:1188:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1188:61: sparse:     got void *ob_shadow
   drivers/scsi/mvumi.c:1190:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_copy_basel @@
   drivers/scsi/mvumi.c:1190:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1190:61: sparse:     got void *outb_copy_basel
   drivers/scsi/mvumi.c:1192:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_copy_baseh @@
   drivers/scsi/mvumi.c:1192:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1192:61: sparse:     got void *outb_copy_baseh
   drivers/scsi/mvumi.c:1244:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1244:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1244:34: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1248:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1248:51: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1248:51: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1256:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1256:42: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1256:42: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1849:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_low_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1849:35: sparse:     expected unsigned int [usertype] src_low_addr
   drivers/scsi/mvumi.c:1849:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1851:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_high_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1851:36: sparse:     expected unsigned int [usertype] src_high_addr
   drivers/scsi/mvumi.c:1851:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1903:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1903:48: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1903:48: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1904:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1904:29: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1904:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1906:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1906:29: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1906:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1918:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1918:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1918:26: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1919:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1919:29: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1919:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1922:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1922:29: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1922:29: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:1931:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *main_int_cause_reg @@
   drivers/scsi/mvumi.c:1931:31: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1931:31: sparse:     got void *main_int_cause_reg
>> drivers/scsi/mvumi.c:1935:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1935:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1935:36: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1939:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1939:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1939:61: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1945:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1945:53: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1945:53: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1951:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1951:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1951:36: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1953:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1953:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1953:61: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1956:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1956:43: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1956:43: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1958:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1958:51: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1958:51: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1975:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1975:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1975:37: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1977:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1977:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1977:45: sparse:     got void *arm_to_pciea_drbl_reg
--
   drivers/uio/uio_aec.c:44:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *int_flag @@     got void * @@
   drivers/uio/uio_aec.c:44:49: sparse:     expected void [noderef] __iomem *int_flag
   drivers/uio/uio_aec.c:44:49: sparse:     got void *
>> drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:50:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:50:49: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:88:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/uio/uio_aec.c:88:20: sparse:     expected void *priv
   drivers/uio/uio_aec.c:88:20: sparse:     got void [noderef] __iomem *
   drivers/uio/uio_aec.c:104:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:104:42: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:104:42: sparse:     got void *
   drivers/uio/uio_aec.c:105:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:105:43: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:105:43: sparse:     got void *
   drivers/uio/uio_aec.c:106:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:106:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:106:34: sparse:     got void *
   drivers/uio/uio_aec.c:115:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void *priv @@
   drivers/uio/uio_aec.c:115:31: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:115:31: sparse:     got void *priv
   drivers/uio/uio_aec.c:130:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:130:42: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:130:42: sparse:     got void *
   drivers/uio/uio_aec.c:131:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:131:43: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:131:43: sparse:     got void *
   drivers/uio/uio_aec.c:133:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:133:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:133:28: sparse:     got void *
   drivers/uio/uio_aec.c:138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *priv @@
   drivers/uio/uio_aec.c:138:21: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:138:21: sparse:     got void *priv

vim +407 drivers/scsi/mvumi.c

f0c568a478f0353 Jianyun Li 2011-05-11  401  
bd756ddea18e02c Shun Fu    2012-09-23  402  static unsigned int mvumi_check_ib_list_9143(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li 2011-05-11  403  {
bd756ddea18e02c Shun Fu    2012-09-23  404  	unsigned int ib_rp_reg;
bd756ddea18e02c Shun Fu    2012-09-23  405  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  406  
bd756ddea18e02c Shun Fu    2012-09-23 @407  	ib_rp_reg = ioread32(mhba->regs->inb_read_pointer);
f0c568a478f0353 Jianyun Li 2011-05-11  408  
bd756ddea18e02c Shun Fu    2012-09-23  409  	if (unlikely(((ib_rp_reg & regs->cl_slot_num_mask) ==
bd756ddea18e02c Shun Fu    2012-09-23  410  			(mhba->ib_cur_slot & regs->cl_slot_num_mask)) &&
bd756ddea18e02c Shun Fu    2012-09-23  411  			((ib_rp_reg & regs->cl_pointer_toggle)
bd756ddea18e02c Shun Fu    2012-09-23  412  			 != (mhba->ib_cur_slot & regs->cl_pointer_toggle)))) {
bd756ddea18e02c Shun Fu    2012-09-23  413  		dev_warn(&mhba->pdev->dev, "no free slot to use.\n");
bd756ddea18e02c Shun Fu    2012-09-23  414  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23  415  	}
f0c568a478f0353 Jianyun Li 2011-05-11  416  	if (atomic_read(&mhba->fw_outstanding) >= mhba->max_io) {
f0c568a478f0353 Jianyun Li 2011-05-11  417  		dev_warn(&mhba->pdev->dev, "firmware io overflow.\n");
bd756ddea18e02c Shun Fu    2012-09-23  418  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23  419  	} else {
bd756ddea18e02c Shun Fu    2012-09-23  420  		return mhba->max_io - atomic_read(&mhba->fw_outstanding);
bd756ddea18e02c Shun Fu    2012-09-23  421  	}
f0c568a478f0353 Jianyun Li 2011-05-11  422  }
f0c568a478f0353 Jianyun Li 2011-05-11  423  
bd756ddea18e02c Shun Fu    2012-09-23  424  static unsigned int mvumi_check_ib_list_9580(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu    2012-09-23  425  {
bd756ddea18e02c Shun Fu    2012-09-23  426  	unsigned int count;
bd756ddea18e02c Shun Fu    2012-09-23  427  	if (atomic_read(&mhba->fw_outstanding) >= (mhba->max_io - 1))
bd756ddea18e02c Shun Fu    2012-09-23  428  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23 @429  	count = ioread32(mhba->ib_shadow);
bd756ddea18e02c Shun Fu    2012-09-23  430  	if (count == 0xffff)
bd756ddea18e02c Shun Fu    2012-09-23  431  		return 0;
bd756ddea18e02c Shun Fu    2012-09-23  432  	return count;
f0c568a478f0353 Jianyun Li 2011-05-11  433  }
f0c568a478f0353 Jianyun Li 2011-05-11  434  
bd756ddea18e02c Shun Fu    2012-09-23  435  static void mvumi_get_ib_list_entry(struct mvumi_hba *mhba, void **ib_entry)
bd756ddea18e02c Shun Fu    2012-09-23  436  {
bd756ddea18e02c Shun Fu    2012-09-23  437  	unsigned int cur_ib_entry;
bd756ddea18e02c Shun Fu    2012-09-23  438  
bd756ddea18e02c Shun Fu    2012-09-23  439  	cur_ib_entry = mhba->ib_cur_slot & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li 2011-05-11  440  	cur_ib_entry++;
f0c568a478f0353 Jianyun Li 2011-05-11  441  	if (cur_ib_entry >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li 2011-05-11  442  		cur_ib_entry -= mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  443  		mhba->ib_cur_slot ^= mhba->regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li 2011-05-11  444  	}
bd756ddea18e02c Shun Fu    2012-09-23  445  	mhba->ib_cur_slot &= ~mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  446  	mhba->ib_cur_slot |= (cur_ib_entry & mhba->regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu    2012-09-23  447  	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02c Shun Fu    2012-09-23  448  		*ib_entry = mhba->ib_list + cur_ib_entry *
bd756ddea18e02c Shun Fu    2012-09-23  449  				sizeof(struct mvumi_dyn_list_entry);
bd756ddea18e02c Shun Fu    2012-09-23  450  	} else {
f0c568a478f0353 Jianyun Li 2011-05-11  451  		*ib_entry = mhba->ib_list + cur_ib_entry * mhba->ib_max_size;
bd756ddea18e02c Shun Fu    2012-09-23  452  	}
f0c568a478f0353 Jianyun Li 2011-05-11  453  	atomic_inc(&mhba->fw_outstanding);
f0c568a478f0353 Jianyun Li 2011-05-11  454  }
f0c568a478f0353 Jianyun Li 2011-05-11  455  
f0c568a478f0353 Jianyun Li 2011-05-11  456  static void mvumi_send_ib_list_entry(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li 2011-05-11  457  {
bd756ddea18e02c Shun Fu    2012-09-23  458  	iowrite32(0xffff, mhba->ib_shadow);
bd756ddea18e02c Shun Fu    2012-09-23  459  	iowrite32(mhba->ib_cur_slot, mhba->regs->inb_write_pointer);
f0c568a478f0353 Jianyun Li 2011-05-11  460  }
f0c568a478f0353 Jianyun Li 2011-05-11  461  
f0c568a478f0353 Jianyun Li 2011-05-11  462  static char mvumi_check_ob_frame(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li 2011-05-11  463  		unsigned int cur_obf, struct mvumi_rsp_frame *p_outb_frame)
f0c568a478f0353 Jianyun Li 2011-05-11  464  {
f0c568a478f0353 Jianyun Li 2011-05-11  465  	unsigned short tag, request_id;
f0c568a478f0353 Jianyun Li 2011-05-11  466  
f0c568a478f0353 Jianyun Li 2011-05-11  467  	udelay(1);
f0c568a478f0353 Jianyun Li 2011-05-11  468  	p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li 2011-05-11  469  	request_id = p_outb_frame->request_id;
f0c568a478f0353 Jianyun Li 2011-05-11  470  	tag = p_outb_frame->tag;
f0c568a478f0353 Jianyun Li 2011-05-11  471  	if (tag > mhba->tag_pool.size) {
f0c568a478f0353 Jianyun Li 2011-05-11  472  		dev_err(&mhba->pdev->dev, "ob frame data error\n");
f0c568a478f0353 Jianyun Li 2011-05-11  473  		return -1;
f0c568a478f0353 Jianyun Li 2011-05-11  474  	}
f0c568a478f0353 Jianyun Li 2011-05-11  475  	if (mhba->tag_cmd[tag] == NULL) {
f0c568a478f0353 Jianyun Li 2011-05-11  476  		dev_err(&mhba->pdev->dev, "tag[0x%x] with NO command\n", tag);
f0c568a478f0353 Jianyun Li 2011-05-11  477  		return -1;
f0c568a478f0353 Jianyun Li 2011-05-11  478  	} else if (mhba->tag_cmd[tag]->request_id != request_id &&
f0c568a478f0353 Jianyun Li 2011-05-11  479  						mhba->request_id_enabled) {
f0c568a478f0353 Jianyun Li 2011-05-11  480  			dev_err(&mhba->pdev->dev, "request ID from FW:0x%x,"
f0c568a478f0353 Jianyun Li 2011-05-11  481  					"cmd request ID:0x%x\n", request_id,
f0c568a478f0353 Jianyun Li 2011-05-11  482  					mhba->tag_cmd[tag]->request_id);
f0c568a478f0353 Jianyun Li 2011-05-11  483  			return -1;
f0c568a478f0353 Jianyun Li 2011-05-11  484  	}
f0c568a478f0353 Jianyun Li 2011-05-11  485  
f0c568a478f0353 Jianyun Li 2011-05-11  486  	return 0;
f0c568a478f0353 Jianyun Li 2011-05-11  487  }
f0c568a478f0353 Jianyun Li 2011-05-11  488  
bd756ddea18e02c Shun Fu    2012-09-23  489  static int mvumi_check_ob_list_9143(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu    2012-09-23  490  			unsigned int *cur_obf, unsigned int *assign_obf_end)
f0c568a478f0353 Jianyun Li 2011-05-11  491  {
bd756ddea18e02c Shun Fu    2012-09-23  492  	unsigned int ob_write, ob_write_shadow;
bd756ddea18e02c Shun Fu    2012-09-23  493  	struct mvumi_hw_regs *regs = mhba->regs;
f0c568a478f0353 Jianyun Li 2011-05-11  494  
f0c568a478f0353 Jianyun Li 2011-05-11  495  	do {
bd756ddea18e02c Shun Fu    2012-09-23 @496  		ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu    2012-09-23 @497  		ob_write_shadow = ioread32(mhba->ob_shadow);
bd756ddea18e02c Shun Fu    2012-09-23  498  	} while ((ob_write & regs->cl_slot_num_mask) != ob_write_shadow);
f0c568a478f0353 Jianyun Li 2011-05-11  499  
bd756ddea18e02c Shun Fu    2012-09-23  500  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  501  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li 2011-05-11  502  
bd756ddea18e02c Shun Fu    2012-09-23  503  	if ((ob_write & regs->cl_pointer_toggle) !=
bd756ddea18e02c Shun Fu    2012-09-23  504  			(mhba->ob_cur_slot & regs->cl_pointer_toggle)) {
bd756ddea18e02c Shun Fu    2012-09-23  505  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  506  	}
bd756ddea18e02c Shun Fu    2012-09-23  507  	return 0;
f0c568a478f0353 Jianyun Li 2011-05-11  508  }
f0c568a478f0353 Jianyun Li 2011-05-11  509  
bd756ddea18e02c Shun Fu    2012-09-23  510  static int mvumi_check_ob_list_9580(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu    2012-09-23  511  			unsigned int *cur_obf, unsigned int *assign_obf_end)
bd756ddea18e02c Shun Fu    2012-09-23  512  {
bd756ddea18e02c Shun Fu    2012-09-23  513  	unsigned int ob_write;
bd756ddea18e02c Shun Fu    2012-09-23  514  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  515  
bd756ddea18e02c Shun Fu    2012-09-23 @516  	ob_write = ioread32(regs->outb_read_pointer);
bd756ddea18e02c Shun Fu    2012-09-23  517  	ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu    2012-09-23  518  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  519  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  520  	if (*assign_obf_end < *cur_obf)
bd756ddea18e02c Shun Fu    2012-09-23  521  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  522  	else if (*assign_obf_end == *cur_obf)
bd756ddea18e02c Shun Fu    2012-09-23  523  		return -1;
bd756ddea18e02c Shun Fu    2012-09-23  524  	return 0;
bd756ddea18e02c Shun Fu    2012-09-23  525  }
bd756ddea18e02c Shun Fu    2012-09-23  526  
bd756ddea18e02c Shun Fu    2012-09-23  527  static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu    2012-09-23  528  {
bd756ddea18e02c Shun Fu    2012-09-23  529  	unsigned int cur_obf, assign_obf_end, i;
bd756ddea18e02c Shun Fu    2012-09-23  530  	struct mvumi_ob_data *ob_data;
bd756ddea18e02c Shun Fu    2012-09-23  531  	struct mvumi_rsp_frame *p_outb_frame;
bd756ddea18e02c Shun Fu    2012-09-23  532  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  533  
bd756ddea18e02c Shun Fu    2012-09-23  534  	if (mhba->instancet->check_ob_list(mhba, &cur_obf, &assign_obf_end))
bd756ddea18e02c Shun Fu    2012-09-23  535  		return;
bd756ddea18e02c Shun Fu    2012-09-23  536  
f0c568a478f0353 Jianyun Li 2011-05-11  537  	for (i = (assign_obf_end - cur_obf); i != 0; i--) {
f0c568a478f0353 Jianyun Li 2011-05-11  538  		cur_obf++;
f0c568a478f0353 Jianyun Li 2011-05-11  539  		if (cur_obf >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li 2011-05-11  540  			cur_obf -= mhba->list_num_io;
bd756ddea18e02c Shun Fu    2012-09-23  541  			mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li 2011-05-11  542  		}
f0c568a478f0353 Jianyun Li 2011-05-11  543  
f0c568a478f0353 Jianyun Li 2011-05-11  544  		p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li 2011-05-11  545  
f0c568a478f0353 Jianyun Li 2011-05-11  546  		/* Copy pointer may point to entry in outbound list
f0c568a478f0353 Jianyun Li 2011-05-11  547  		*  before entry has valid data
f0c568a478f0353 Jianyun Li 2011-05-11  548  		*/
f0c568a478f0353 Jianyun Li 2011-05-11  549  		if (unlikely(p_outb_frame->tag > mhba->tag_pool.size ||
f0c568a478f0353 Jianyun Li 2011-05-11  550  			mhba->tag_cmd[p_outb_frame->tag] == NULL ||
f0c568a478f0353 Jianyun Li 2011-05-11  551  			p_outb_frame->request_id !=
f0c568a478f0353 Jianyun Li 2011-05-11  552  				mhba->tag_cmd[p_outb_frame->tag]->request_id))
f0c568a478f0353 Jianyun Li 2011-05-11  553  			if (mvumi_check_ob_frame(mhba, cur_obf, p_outb_frame))
f0c568a478f0353 Jianyun Li 2011-05-11  554  				continue;
f0c568a478f0353 Jianyun Li 2011-05-11  555  
f0c568a478f0353 Jianyun Li 2011-05-11  556  		if (!list_empty(&mhba->ob_data_list)) {
f0c568a478f0353 Jianyun Li 2011-05-11  557  			ob_data = (struct mvumi_ob_data *)
f0c568a478f0353 Jianyun Li 2011-05-11  558  				list_first_entry(&mhba->ob_data_list,
f0c568a478f0353 Jianyun Li 2011-05-11  559  					struct mvumi_ob_data, list);
f0c568a478f0353 Jianyun Li 2011-05-11  560  			list_del_init(&ob_data->list);
f0c568a478f0353 Jianyun Li 2011-05-11  561  		} else {
f0c568a478f0353 Jianyun Li 2011-05-11  562  			ob_data = NULL;
f0c568a478f0353 Jianyun Li 2011-05-11  563  			if (cur_obf == 0) {
f0c568a478f0353 Jianyun Li 2011-05-11  564  				cur_obf = mhba->list_num_io - 1;
bd756ddea18e02c Shun Fu    2012-09-23  565  				mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li 2011-05-11  566  			} else
f0c568a478f0353 Jianyun Li 2011-05-11  567  				cur_obf -= 1;
f0c568a478f0353 Jianyun Li 2011-05-11  568  			break;
f0c568a478f0353 Jianyun Li 2011-05-11  569  		}
f0c568a478f0353 Jianyun Li 2011-05-11  570  
f0c568a478f0353 Jianyun Li 2011-05-11  571  		memcpy(ob_data->data, p_outb_frame, mhba->ob_max_size);
f0c568a478f0353 Jianyun Li 2011-05-11  572  		p_outb_frame->tag = 0xff;
f0c568a478f0353 Jianyun Li 2011-05-11  573  
f0c568a478f0353 Jianyun Li 2011-05-11  574  		list_add_tail(&ob_data->list, &mhba->free_ob_list);
f0c568a478f0353 Jianyun Li 2011-05-11  575  	}
bd756ddea18e02c Shun Fu    2012-09-23  576  	mhba->ob_cur_slot &= ~regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu    2012-09-23  577  	mhba->ob_cur_slot |= (cur_obf & regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu    2012-09-23  578  	iowrite32(mhba->ob_cur_slot, regs->outb_read_pointer);
f0c568a478f0353 Jianyun Li 2011-05-11  579  }
f0c568a478f0353 Jianyun Li 2011-05-11  580  
bd756ddea18e02c Shun Fu    2012-09-23  581  static void mvumi_reset(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li 2011-05-11  582  {
bd756ddea18e02c Shun Fu    2012-09-23  583  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu    2012-09-23  584  
bd756ddea18e02c Shun Fu    2012-09-23  585  	iowrite32(0, regs->enpointa_mask_reg);
bd756ddea18e02c Shun Fu    2012-09-23 @586  	if (ioread32(regs->arm_to_pciea_msg1) != HANDSHAKE_DONESTATE)
f0c568a478f0353 Jianyun Li 2011-05-11  587  		return;
f0c568a478f0353 Jianyun Li 2011-05-11  588  
bd756ddea18e02c Shun Fu    2012-09-23  589  	iowrite32(DRBL_SOFT_RESET, regs->pciea_to_arm_drbl_reg);
f0c568a478f0353 Jianyun Li 2011-05-11  590  }
f0c568a478f0353 Jianyun Li 2011-05-11  591  

:::::: The code at line 407 was first introduced by commit
:::::: bd756ddea18e02ccea8b29496b2fe3bd91af8eb7 [SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580

:::::: TO: Shun Fu <fushun@gmail.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--r5Pyd7+fXNt84Ff3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICIO9m18AAy5jb25maWcAlBzbctu28r1foUlf2oe2vsVN5kweQBKUUBEEDIC6+IWj2kqi
qW15bLk9+fuzC/ACUKDS05lOzN3F4rKLvQHQjz/8OCFvh/3j5rC72zw8fJt82T5tXzaH7f3k
8+5h+59JJialMBOaMfMrEBe7p7f//rZ5eP66mbz/9cOvZ5P59uVp+zBJ90+fd1/eoOlu//TD
jz+koszZtE7TekGVZqKsDV2ZT+9s018ekM0vX+7uJj9N0/TnycdfL389e+c1YroGxKdvLWja
M/r08ezy7KxFFFkHv7i8OrP/dXwKUk479JnHfkZ0TTSvp8KIvhMPwcqClbRHMXVTL4WaAwQm
9+NkapfpYfK6Pbw999NNlJjTsobZai691iUzNS0XNVEwYsaZ+XR5AVzafgWXrKCwQtpMdq+T
p/0BGXdTFCkp2lm8excD16TyJ5JUDNZFk8J49BnNSVUYO5gIeCa0KQmnn9799LR/2v7cEegl
8aai13rBZHoEwH9TUwC8m5YUmq1qflPRivrT6giWxKSzehyfKqF1zSkXal0TY0g6i9JVmhYs
iawcqUBt+6HOyIKCCKBPi8ARk6Lo8QOoFTQIfvL69ufrt9fD9rEX9JSWVLHU6oVUIvFUxUfp
mVjGMaz8g6YGJRpFpzMmQ+3LBCesDGGa8RhRPWNU4TzXx8y5Zkg5ijjqxx9VRpNqmmsr5O3T
/WT/ebA+w0YpKOmcLmhpdLugZve4fXmNralh6Ry2DoVF84RWinp2i1uE27XqhA5ACX2IjKUR
ybtWLCvogFPAgk1ntaIaeuawj0LdauZ3NNyWm1SUcmmAq7UTdm6prH4zm9e/JgdoNdkAh9fD
5vA62dzd7d+eDrunL4PZQoOapKmoSsPKqbeBdYZqlVLQf8CbcUy9uOyRhui5NsQutgcCuRVk
3TLqpm9RK4RGd5XULLoi/2KSdjFUWk10TMrlugZcP0T4qOkKhOlNUwcUtk0DCoYPolMkpZaF
oiSreRIdcziWbsfM3R/eHpp30hWpD54Bc1CRT4+99UUzm8MOZ7n5dHHWqwUrzRxsb04HNOeX
bl303dft/dvD9mXyebs5vL1sXy24GWkEO3BPwP/84oPntaZKVFL7SwMmM51GhZoU86ZB3OJa
VK3TGc1OEUiW6VN4lXFyCp/D5rml6hRJRhcsHfELjgIUcVR523FSlZ/CJ/Ik2tq7mHUBP6kl
KJ630Sqj6zKQAnrFUkeag79SA1pY0AFthyqpibMBIaVzKUAf0IgZoajP0crQxgXj4gZfl2uY
JdiylJhQ5O3mRNPhmZ8CrcnCBhEqCyMcRThw06JSKfUCDJXV01vrzbp+AZQA6CLWX1YXt5x4
1iGrV7fBZ3ErBsyK26s4q1ttvEEmQpi62/K9sNNaSHAB7JbWuVBWaYTipAzVb4Rawx9BNOSi
ID/kkKmWc+BbEIOMvQHJ3B+IM4KRPjkEaAy1JugIF3sYwuQzUgZOzwVhzsF5UGul/IDRM4K0
yGGVlM9kdAJEwypUwQgqCPQHn6DeHnspfHrNpiUpck9MdrA+wAYQPkDPwMJ5cRvzYl8m6koF
zpRkCwbDbNbKWwVgkhClmL+ucyRZ82BztrAa/o1Ip0Pb1cANY9iCBlI+FhRK0wbedl69CvCE
Zll0JzpVglZ1GFA1CZjcvnzevzxunu62E/r39gk8MgGXkqJPhgimd8Ahi65na+scEsZWLzgM
V6RRb/ove2w7XHDXXW3jnEAPdVElrmfPn0E2RAykUvPAnBUkFuEjgyEZyFVNaZvYRBsBEbqg
gmmwnbBjBD9i0uFnRGUQzsZEomdVnkPiJgn0Z9eLgBkONqmhvM6IIZiGspwBAQvjWIg0cgbJ
5jS61GGe2Wl0IWeeiby+Svw0h3MvdOoicQIpkgIj74LBnuAW4tc68y1uF/FrEiLk1JAEpluA
OGEfXQZ5k02sWp3UNtDqsuNusnbgbQdRl+QoSAEG6AR+VZxAgpmfn59iviAQbtcjyaSjSUkC
uUVB49GFo8nkxfXVCTxNzr+Dv76Sp4cBJNffQcc9e4Nn0zDICrDFCsbnq2IDXperEzw5USD9
UwQM1P0kfk70KYISghZWVPFoqCERGIKdXrtSKGbIPB5COhKZnpaQvJifwCqynLHsFH8F5oGR
8hTF6vQI9PfwuCFP4cF6nZoDLBBRp4RhYA1PTWDJiixnKhYpgf3w3LIzJjXxQ4FGSxfvh6CU
kQjV9RAm1yumjw3XbAmKPzND6hvKq2N114rHdghWiTgkzU0AV+eZlw9abMY0fBo2hTCipiUK
YtjjEhLXoJSRUd1kg7/34wDPkAhwudwG9NG1nt3Wl7FoGeDhFgYAJIdjPC7ex60Jtjq7iOuZ
5Xh2Fu380/VVn7DjIiwgQe5TWd8JdOXGivM1BuFaFF3dpPVym5e7r7vD9g7z3l/ut8/ACMKK
yf4Zi8peCGOFIpznjFTeNJe29FObGRYFhgVAzWsusqZyqgO/WU+JmWFyJjAsmNKByG37kjOX
3qdcrtLZdECzBOdiUz9JFMZRTd02HMOCKTMo/uDoB1QwSsdTS5pi8OCNVWRVAcqEoRrG6xh1
hpstqXS42USW1dArxNtkUHgUWCxmU11BP6W3XE0kdnkB4YWNygdThVVqqmBeG5gUwCkYvpRh
0JfnQZiJBUE/HAysvFOGVCx++XPzur2f/OUCzeeX/efdg6uedYyQrJ5TVQ6dURs5nWIzDK++
o3hdRmkgFYN8xs/7bdCvMVruTxga6QzFhfliimUhXycbVFVGwa5Fh+wrPL0CR3dt01yrtDsh
KOJOu6Vk8YJRg0ZVUFTHyhANBYa/S3DuWqMydxWSmnEpVJhqVCWoLajcmieiiLE0ivGWat5k
Y2FbC63B/xobpHvlhnZnGNBMWGoxr7xCeoLqF1YzdKoZbJ+bimoTYrDOkehpFAjBdKwoYugU
go5ovaRB1eb87BiNQXggX1un4xkeQjlDEgvjkGiZmGE7ANX8ZoTepXm5Ho7BQeMDwQUXksRy
X0S7szKw/qlay9CyRNF1DrqSkLQ7TJObl8MOd9rEfHtuyqFtykEURCBWf7MFVmRiaZjQeU/o
2SgOpi6G4DoTOoagOQvAnZ0YjtCfH7+B+ICFcwYYmnhbl3DHSKKv7HqODOiYcJW6DDxVeObo
IefrxC9StOAkv/EdbthJtwy6PPcLdVYaWrLSmhWwxsFxUIO3xXSHP4WLtl2CntOxxj6yaW0X
iP53e/d22Pz5sLUHzxNbWTh4S5WwMucGnV1QqQoLVfiFIYbsjjXRObbF+28DXjpVTB6dD4rK
HFGGQNC3q8Y5BlulGSH/cB3bKQ4LBjLtTxFwvDhcX9fGVsIuE98+7l++TfjmafNl+xgNjvy4
1KvDFcTYABSrXhDZekaxpKBKtsQowY7bIDWokeHpK4NwjYSbRcsCwgJprCTB7etPV4NGCfqE
sNrRgNzq2TAkVmLtkF7tAUssiqIvCYp7sMfVYGBu9q4e4zGYrSEgyjJVm2HBJIFAJPW0yEZn
RmAIFUaHpTAQhtmd2BcHdSx/aNWPw0rDGEvb86ers4/XwapLiDUxYpp7kkoLCoaOwAb3u8kV
zAqP4mPrZYs0fT0b0qyxk4sO53sABBLY1RqykgZ0K4Uoej29TarMWpr2+zKHoDHC/1bzwbq3
kK56BCsiAxF2FHh06U/ExvBW8HjKNx/UyNpNy0GdmVJ+3S1XWB1Y0NRV43pvQhWutj0ijbCa
4okQ+KkZJ03xsdmS47uul6Z/eDlParoytGwTDLt1y+3hn/3LXxB/Hu9ZUPe5z8F9w1Ym3jpV
JVuFX2DBgsKlhWGjaChnorHWKvcL+vgFO2canLBYYKVHzussFuMblZORAztLoquklqJg6Xqc
xu3mWDHBsQDBQbTHUj0YMeRbYDN6fcUzszld+5NoQLEu+jFkstZ4YyGqHiwQMpPOZqZEh0or
u1ClVuA2opEbEMlSBszgu85mqRzwQjCeW8XLfA2BIiqOx0kzyWJGw6Gm6C8pr1bh2gFfU5WQ
WvleoqEfUiKLREF+0qyEtz52/v3djSFmOFXGITVfnI+sl8NeBIX6NXoSMWc0Ji83vIVh4Yir
LD65XFRDfQFQvxTxRAuVoibxOqTFQRo0oktHWmuBVp+b8YWY4aAtMDQRji6VMTDOOwJWZBkD
Iwg0QxslvHQGWcOf007FI6jEr1N00LSKw5fQxVKIrJ9rh5qZVEZazPQIfJ34NZAOvqBToiNw
W6waAvGUzlbyPGfXIYuYJL1+ShHpZk3JLAJmBYTDgsUGlqUmNAP9ImYxD9ivfKL8cbcxSDJy
1NLirWhOUqAkThPg2p+ksFL4DkUpTkRSR6vSItTpdu3qfHp3f3e4e34XLivP3g8qH53FWVyH
9mlx3dhzLHrFr41YInc7AL1UnZH4LRrcYdenrMb10GwMsM5yjI+BMxmv9FosmMSRGdeamaNZ
A6y+VrFoz6JLTDhs2mDWkh61dlZrfDDT+NkBogYW2c2szVNsMDliky2hFdY4XtPpdV0svzc8
SwYBYXyDOK2QRZRRQ8NlYK+sdbWwgdl1sEbvAti8wvvDeDtYBy4LLyTDANMmXPUclzQSbz9r
zfL1cRNIhWw5F8Ip3oTivtvLWWFGYr1EnkCCp8zSNOrt8EqZCXYvftdZAsl08kdaxo9ZHU1r
payft6LAXfv/NdAzEgsrRumbS50+2aD/o7n8i+6s6F2fTvLeHaZoGdRdtO4NFh4rcAqN0ZmP
NKhtmc33RAi0HXbujhgefICuMOm7jhaGpXyWjlgaJCpIGdu+iErUxfWHqyFXBwWNOFakhqq4
MF5MhF9dxurxsvDFZUyoxtttXPnVX8WyaWChHKRmUw4aWgoh4zlmQ7aA2dZu3OFtXYcO+nJH
RRhI+aegLeAx2HAIAnuGpyofLy9jmuMTJSrlbUz9OEYwjkHvZY95ohRTvWQyjnLjjiDoKIab
eRwx17dxhDLFVT3CTaS0ECaOu0lHFxWE9vHy7DKqwj6d/oOcn5+9/87qG0VYQVU/CqsUH84u
zm98xeqh9XShYnvVo+ALNYhs0pJGX4IUXggNHxf+LiaFt9h4qEAk+MkG3O8bI+OuLBUymvTK
LPNTFPzEWr5fQFxdvA+6IDJ2VUvOhEugO8LrQiwliVUAGaUU1+b9ldd1B6vLovnD3pgET1bC
NINQoad1+XzML5O06yJQiKPbz+2apt6ZT1ZqvHUr8AWOZwnAxBF7VhEWPVto++ciZmQ8qoKM
tM9IbCoeQZnGRlPzMDn3OQ6rgUNcFGOvn3oVcbAoCzAdxl4B6wbugUfivICClnQRZF6LSDHG
FxWkUPOjelcXOhVhtGQhYOA812ghGCeiOQ/sSqmDicx0zFNZZbFjh+0W9lVcgn5pTBYcquN0
o0w8erK9psM3F+3mdPfRbWinmPgejQv9YjpsM/4VVrbXdXgPN7np3jw1lcrJYfsavlmx/c8N
3lQYGlslIJkSEKcO7+01JdQjngOEXxbtfShXJOsP0eTm7q/tYaI297s9nuYf9nf7h+C4kIAp
ilW9iX88ACqsyNI7hAFAkvKQYjog+OP84+VHALnewGhl2793d9tJ9rL72x3p9YLADZ5G7ZpF
rXA4AXNduBEGLEBx4nK2ODyvdU8k4u+WIkPsJO0bArxoS7OgSg4wlWOAEbM0QF9SzyE0ADAw
TWQ04GSRUgkj6lN5halnLIuHmYiLeSaA+5d/7GemAwDXuX11Gg6psXhjnWla5MOXmFa8ycPb
9rDfH75O7t3C3h/LHgebssTobGSXOoKKRO/5O+QC/g8WmKtF4W+4BlQPO/HQZo7IkIuZY7f+
gfHojLqoIgdroWQaRPENzKaqsdi/w9snjnUhdHD7o8MfnVH16dBqTmLWC5rO/Y2qjaKENxck
/D6WTNFicF3FQ3KyinBX+Zz5FtF9D7SqAbJSVoFeNfCpjIoETeRHGbqIj7K/IxDY0o/jD49S
wnJfFvh9Yh0tGlgOTImPrXTi2SIqZ7W72tLzaGCYNxizHh1ZS4Y30uLBUZmnwQd47ikbBG4I
LtO4E0TcLMQ17mrzMsl32wd8e/D4+Pa0u7Ov0Cc/QYufG9X2DtuQT/ByFgGyfH95GQHV7CI9
Bl/Udit9893YvxpEFwxrAsHH8CwlD5LTEzWlTIOTb46IGxB4fxBCMQx6QPQYJXlno5C/iIWf
wVAzM0IUbUDVetsjB9d5ZXsj1rvx4i6pBaDhR/OsWIfA/lVMf0SbMnvIn1Qxm49YoiUftkDY
iQcfHYkUS6o0WdAoA4utdSUdTVQJe+KTr8SQrJaGh/Plmh0Boo+uEXdTMTXXg4Ge2OyIBXNo
T9LddWT7+i8+ODCd4cMZhOE7JQCPtAieFSOAicURBxWrLFsMgYA0CKmFkUVlkUc7GmF3+6fD
y/4BX8L2frZRzNfdl6fl5mVrCdM9/KHfnp/3LwfvRB0FkC2DESPA/s7BMZTKYxg+d4tDR5hY
1IBTzcEOBnfJTg3f3fHZ/wnz3T0gejucXn8nYZzKBSSb+y2+zLLofjHxKfsRr+/Tdhfh4pLp
pEaf7p/3u6dQEKCOmX2nOlSXFt48yhyJySwl6OYwKAsG1XXcDeX1n93h7mtcj/yNsGxyOENT
X0ynWfijS0n0cEQRyTL/ZWIDsBe0bP0dL5Vdng3Rzd6FLM2s6vbu7JAFJ0A3Da4Ldrgwae/Z
VhwvKzPv+lmLwxsv5XETe3O3TjGDbRIftXne3eM1Q7cwRwvatjSavf99FelI6nq1Ou4J6a8/
+JGN3wLyzYt4nNgQqZUluoxqx8iY+4cHu7vGyU1Edy+nv1Lj7qrPaCGj1WpYHMNlPnhK6WCQ
EFdjRxuGlBkpRDniZZTrNmeKLwlesMBfdDmyk/nu5fEfNCQPe9jBL70c8qW9Ze5HXx3I3qjK
8IcJeiQkSYp0vXm3qftW9tG6W4YYUw/t3+/tZtRTxq6Sd8IazqjtyL6qwKKmd2OyTQrsxfM4
bgD1JGTzZ8UWIwlpl2CrkTNGR4AmqWEDvpeLRTQW4PWN0N4pnnc2g+2JXpdpy8X9mEy3cVyj
FkcHzbvHnbKqF1UBHyRhBTPMv8Gp6DS47um+w7i2gS3PvS3rQJwHJqxp69/6bWA6Dcqj3L09
c4qWh9kZInMKgZP79Y6oIozsTJeIv70eR/V8xuyFTT+99ei6PEVASG3vBXrGZlrGXzb4Px4A
H80R7OPw1vrz5uU1vNZt8OHO7/YuuQ5ZeJf6w0cRiITlsr9RYJFxV3fUqR1LBX9CRIA3v90j
bPOyeXp9cBlIsfl2NLqkmINyD8bmXkc8HoFq5alAboJaRAnf0aPO3ASpdFbn4a9DaZ1nsV/u
0bzpwhuFEHIwVOl+7yKgsj9UFUC6u/x4wdmWY9vkRhH+mxL8t/xh8woO/uvuOVbNsQLLYyEt
Yv6gGU0H+xXhsCu7bTxkZYvnwj6DGNE4vB8Lfrqc10uWmVl9Hk58gL04ib0a6B70z84jsIsI
rDS0wNrZ4xBDeIa/qhGZGzg1MjIpROOr3pAdSGEAEDwcCkk0+EF/U5+QnIueN8/PWExugHh9
3lFt7sAOHItXYB6+am8lj7ymQl2arTWPXr/+H2fX1uQ2jqv/ip9O7VRtai35Jj/kgZZkm2nd
WpRtuV9UvUnPma5NMlNJzzm7//4ApGQRFNieOlOVTAxAvF9AEPiIXN1c3RkjB2u3afBYAKVm
5/O90ppo+pevv35AJfT59fvLlxmkObVA2vnl8WoVTEqhqYj0sZec9cuScTRIPbcy7Cs6BY8T
EvxxuxR+d03ZiMwApdge8D0XNi2MoENuEEa00Hr5CbHCruqTvP7814fy+4cYG8tvi8dEkjI+
8Krh/YY1BibQ1dxEYU1BsqchkdWlcYyni6OAPVTfL5EEGBFY+/i7WTNXLp2b42h9whLqImZV
ktSz/zL/D+EUk8++Ge91dqxoMToHH2HtLq0FrM/ifsJ2IqedpKkCobtkOiJXHcsscUeCFtil
ux4ecQTUGnh7WL+JHjMwDtkp5XIbYv1IKx6voKDuPNgC5Z7pThMJjvHkt1hw2FbwZEROs4bE
aX+2n7d28taaYw4aMOjht+iAyrrOGvZQJcjHfbDghNAVpyzDH+Seo+ftuSEaJ7jQfnPTQTuG
UjiNZbUI9Tntlt6Ts4I5n54w2GiSYAYb97S4SNUxMToA+GPk8o0Dk/52kmJS74gVCX93A65l
j6j4TjGLXTJNUz1MIh41ueXj6Af+ZEm3GxevSePkzLt/IhwMmmDR8soKmHsBzOmdupiWcImq
bQcFtTjn6dQwhlQH3unWOsCyLNIoaNwtRUNuwzXneMnZptbMPcKn2FEahho7BHSM/Oak24j6
4MKuDKucXSGz2b/+/GwdBcYWTlbhqu2SquSP3waFALErOT8VOGva06OR+3xoMcsXD4ibtmX9
/GK1XYRqObeOU3DcyUp1gqM8HJT1ta1d8yOcqTLOVCuqRG2jeSgyC3tQqizczufWdYWhhPNR
BtQmVdaqa4CzWjGM3THYbKxQ5IGuc9zOLSPNMY/Xi5Xla5SoYB2FdvkVvzoQGx89uraIedR2
KtmnNqwBmsbg7GOZjuJQr7X9mE5T2Jhyy4Y5NK+mw8wKLZ23J2bpQcTXCTkX7TrarCb07SJu
13blejpo1F20PVap4tSnXihNg/l8ae+bTolv1dptgrkzDw3NhcMaiZ1Q6pSbw8OwbzQv/37+
OZPff779+PObxuD6+dvzD1Bm3vAEiFnOvoJyM/sCM+X1D/ynDcXZKXKJ9f9IzBoD/QDKpNK3
ZtxoRgcAgeeEagTY/f728nWWyxh0ix8vXzX09KR7z7BjmMP9SCCRz+8kYh3z0+LyyFlo0vhY
OoNQI1DRa6zb4NRke/YKOHOJTvB4qWSNus0pVCVkQt3lKZaQUf3RI6jXSSetoqELcjt2phYy
QaRkG6kUpeivHtXL8l9WUiOedvspHIcuQZ/17O0/f7zM/gbd/6+/z96e/3j5+yxOPsDw/oX4
QAwbKKt6HGvDbJiN2NJEb3JEcb5RPchPuia3pZb1+AYB+DfaX23TjKZn5eFAHHs1VaHDjbbR
DUNWN0kzTImfToeoSt66gBZsHxuGr1xS/810X6cQltxDz+QO/jfJzHzCncdvbLzFokDlhlVX
VgWGo5JTZ6fhLhoTzt6QkG72d0LS9i3jPUirEreH3cIIMZwly9kVbegydmnoUvrhtbh0Lfyn
J8mkuY6VB5NMc+HTLXz6roAS3o4VeEXklF0cRbAK20lBNH3JgT0Ztoj78hOqjEEXsXbNnoDm
RqWjzI2vGMLOOxJwHtNuAogQnauPK8TPH/WoXsgAyg/3A9zK3guafWqChkW4uVAPH5lM6vTQ
O5kYfFJ/a+MX25bbhgf2dtmSpu1JXscas5SezUSa0G57Mi2G4SEOdcZ6GPdCp3yy/lZwXAlL
txMxphKmhkuu41zVk3GSQt4hf3mRg8Kjd4IivcCex9koBoleN/rGfKw88XqmVlWzuCcQviug
clE31SNnXNX8014dY3ecG6K7/w6sLrnEsOa4LgVcAgOS7SR5OL4V6j3+kMcoMS3HTnnHmM7C
idDpFyDQ6yp3gTsp2JRkPN1KMqGOWq9+pwuuNQuZ2vMme0lhXw3fSAxiUK9DtItgG7g9tO9d
WVhq33EcR9oxJJpzSODU6ZD6+64irleLaO5wZeVWCVGppTvNgChASXeriqjFDumarxZxBKtG
6OVoSMMkwftMNOCBMpZ+DHyyQ0SqOKiPwdojBccSI7FeujNmlMk93qV9O/DLgmY+6vGE1jTf
0OglglA3sPu1MPut7+MkXmxX/3ZXMCz3drN0yJdkE2zdRjcrLaVVObfnVXk0t0/Ymth7VDpp
Ht2xe+zqRLijHahwDleXKTnNpzMQyCI7CVbl57T2217Y2AMdTUGOMxGSMIK4OFC3WYMhrJEi
U4Q74XZhkNHOeGSrQmpFY/iMum45+vzv69tvwP3+Qe33s+/Pb6//8zJ7RRjnX58/WydGnZYg
/smalJc7fMAm0050CPExYuHdPuEWVeTBfIyDddg6ZK0zDXnRyiiZhRzgu+bt9zc1Hary2a3j
5z9/vv3+babfJ7DqNxpyE1DSndcL7Lwflbk7JuVpraGNhF1uTlimGKiFs2XRYmPj6n6S0m0I
2HAmLYCbEKI2vlNQFHFMCTf6mWPkZyfjwiWgIUOqlOsPXymUVG5jnS8O5ZS5w+ksxSSTs2xg
kZ2ekKu7zWsZ6XFcZbx3sWHm3JnVsOqmJNZKQ22gw/i4hZ5fResNf3DQAqCgr5ecJmu4V+0q
MzaPpsI+Ujsk0B4W6zVD3LSTMiO5DXlQ31GAC63VXNlEYbBwstLE1iF+ymVcl8WkAAZCmhsz
ml2kDToyTz4rZPFJsDC4hq2izTJYOWWAWdLPKZoY3sH7HinRArAQhPNw4+0aXCjwHstNGCOW
QIn3fVYn8eQTx5pBWCk0VY1R++4ggEm3tlWgajLdzE5SqqPciUmeTS33WeqtnZmBNuUii12p
w4bNtJPlh9+/f/2PO/Um800P8LlHJzdjx9xz0exyuhJaPTxn+9LfkY+JN+f6CRTBaXp9Vbtz
tpssN4Nf0q/PX7/+8/nzv2b/mH19+e/nz8z9KibVa6yTLMy5iz+9cUuQuRVx7MVNnHfScdpB
GqIiy5LKVdQmgiR02bM0W7xwQ6+9Pi+7yL01h7mZGVboXfUee39Szr2cMf2maToLFtvl7G/7
1x8vF/jzy9TKiejiGM9jF2igdeXREyxyk4CicUvGjV+kliVypJbqSgzM7xV1+NpE2kjyLFAu
LQtyMelCHGfE5KhvpsYCYWEOJ1GTG8ob0WvOSB9PsM892VEeGs+KwElorKiUvbjJRYzx6ePX
SGgECQSnAgi0Jcj+eG4zNgZyGua7E3V68kT/HRrW5UbEKo1J5eIeUpyhdcm1ELkNPwU8Gv2q
I1uBosEja/iH7eVay5JAv5nf6J5981qhnLpl/FmaE9capFFBpDvrQaJfPrRNaOe0sU4x/QUx
GbtFRlDW1Kk4pDm6LZFTRO2BFkBsDuNm6pw6cjMkPZ84N7g9JIh7E2Jx04JbjZGDc88E9Lkp
PsFf3gTh9KBg6fEkKpNmswlXoZvkQH8nnoaI1fHZ8/oPEcPgN2h4+4kDYIt8J5QSiX1woHRX
U0fusazlE9WeLPK9gnPnAt3KsPyE83lKSzJQdQV6gyYtzU2iQUNtU18tCwbhm5rMSU2c3I6p
3VCk3DBdS8/LcjrU0YxQzhvs7cfrP//Ee7/ez19YkO7TvXm3WpAVaLWAfReDJyYu4bYEulca
CfdjVYvd+x/DZpukiq7HCCqyg51Y7ckAHVi4I3MeFgMbn7F59EG25M1mtZhzyebnKErX8zX3
psNNBjV3fIQUoVpGtJlpWrbcdrnZ/NU0o812xRRaF62ltvsJsztk5U5kfEzIIH0XS+cxFhED
T4MhdE360KlccoVQuYoHSBn3lvt94ZyP1h5k+/Ntd1bxZtG204I5AtQCPcSW/cV5cNMT8LUL
srflJGQJ8z6nBa5Qi9j2zU0z6wS4iFf2uetc1uYJuHHru1bHkvcWGjMQiaga2xmkJ6C7QI2b
A1sscUhtTtoEi8BpvEEyEzGCj8e2NTCTcamUR75JCZx8nBa2DmF+d2WuH8c4wJJMXrbRng6N
Sl2Na0g9F08lfwYnUrwHmS0Cqh6sA/xJ1par2XdyLQEcC6Wz+2ec7gzkwF7Rs8C+64OflmYm
Mk9vnOqyJl4IhtIVuyhin5uxPjZws/TRtt2Sf78G1lfUOFm4haK1PN9jcv+he5TsEYYy9Xsb
c4LkPFfE+h0410HU/pArHq1wLBL73FAIdjqgVBH7Bl0szvLE6fu2zDHNlL0G9ISuIS7lI7UL
WDyAgW+tEzfakk1piQhL/N5/EzlzLroDG5ELvvEVl3XNBpQTGRUTLAac3nc+0Wj0Vk8kZC21
JJOUnj5A1c+kE5IWBnPWEmhE7ZGIhC6/cJp0z8sprIShFqLiPknSZUsAvAb7R7Tk5mGSb4M5
0Vcg8VW45oe+3QaILnBPKM1PjlmKlXpCPeKe1KEsDxnnrWDJHE/ikkrPfJFRuGLdDGwZjPyw
NiC8WiS/5mRMIYEFPD2QsQs/31lpgMtOBNkeLDQP/GUtGfqnSZR4nWmyM/Ns3tmKE5XLOXVZ
W8693wr3Q/I7ts4E+zyYP9DacxPvU86rAL052dJhzlSLUQ/2S174a3IzgjTcJpSNyKwervbN
L/xyv7NLAUUQRWn5zeZZu+zsR716AgWS00RqFNIkNwhnENPR0IS+Mp/bPhxI3FcHXim4fdLx
viFZqy4Tf+eR+s64tIRQmcjZJ4OMEPEEMCQSkWpIJjJf7lxRQ2/DCb1K46Y+5T563/ROgXNZ
SG9Z9xdWf8HDTEoCGh9UFC35MwmyVgGkxgMN43EoWraujZxbkW5nqPcXJS2m0ty3sOVXFqhj
D2efgtfXCtH06Q28njAKq2gRhZMT5/B9iqip984A8M+6LMqcKjD7uyt9cbfhosV2fjeVs0zu
K9LlA9d0cJIqY0/d+9c8DGDDHS2kSguFDxKTVbZ0NBEuE+O2cVfqhI7NLLSbJVXbj13W6/ly
7hlH/WH5Xq41rqweZzBbDNEe/eiIvZQSOdo236+BStNHdpnGd4zqPfyhPhJ7NhR5j44y0F7E
9DFSOycwkS2t5K3gRMTec6TaEuckqYLtnK9KrqxuUnm8DbaWI0JayZj6OYH8Ngha+xugLENP
8mWM1uyWV2hVo9cY0ohNjuDXTlAT8+mJPHRZVdc8FfaL8NpybaccI5ylb47L053srkVZoVul
rWxf4q7NDg6s+/TbJj2eGmvRu/3mutpzCWlJnFmzrCVwkU/kBGF+d5cV0Spv1IXdvT0V3/1M
ZA37Hb0yujFlYdhsYS05UfD3k1ZxTRAPf/+WJHxzwN5V+RtK7VBB5nZiA22jnZiJscp5pasX
q1OXiHbWE+7z1iHfMGSzE+RJMY07o4/KDhHR/ZyvUWmhFJhTMV77uR83x1ORUCAMTW+rmPUW
OF41Gts3QrAUR3Uxdzv9zyxN8FL/cECgEM0wEXJSzuCnN2Bc7ekFToJemkf2uifXQfBEurc9
+b5oo2izXe86UlDoCO3ubdIaidGGIZqLOafmg/lnIr1aBuhq4OQWLaMooNRYxiIRDs0c5ikx
gWEw5DQSK9R0Qpo9Eps4CgJGdhm593CavN54Gs5wtzSDvWzTxE1HxlUGc9VJZmRrWIL2Iq5e
kQx9yZtgHgSxpzRZ29A69QcunhjMDw5Da8pTmrkK8JCbgOGgvknbpNBP/wkn9aKFBBDN3R1Q
oonmi5YKP05THa4AHKLWYejHqLFMq6HN/k5HqQaO/h5PMTQVwziX8aQje4HB9E9y6SMoDzDD
wxr/Jk4mFXdCUI7NCX/f8JhYzHMtoV31idG80p7O+l/rYaU5/v7z7cPP1y8vs5Pa3SLGMMmX
ly8vXzS0BXIGJGjx5fmPt5cfBI9u2IUcncmEfn7Xb2JeXhG99W9T2OhfZm+/g/TL7O23QYqB
dLl4XrO3EOOZS8ahH/IW+smyaEJ9ls4tvPYBQXhR6nkxom5aXjWJJ4CaKBhnWH2cSPA+cPKP
P9+8sYEDQK3900DZfqO0/R6f68yIl6HhoD8EwRswZKXhdh8MFoO10iAvF7AFtQ8OTsoNoujr
8/cvo9vtT6e0CJcGozA9k0YiHMRNPXEGOUdMwZKTFl37EZ+1f1/m+nGzjtz8PpVXHjPXsNOz
KaVDNJ7rVuf4IFTNBw/pdVc6rj0DDTbiarUK+SMrFYp4mAJHaMtUZhRpHnZ8MR5hZ1jdKQXK
bO7KhMH6jkzSw/nX64h/3ucmmT1Aed8XcYGYeQk9xtM7STWxWC8D/j0tWyhaBne6wkyPO3XL
o0XIv1ZCZBZ3ZGD92yxW2ztCMX8oHwWqOgiD92WK9NJ4DII3GXznAe2Cd7JTTXkRoK3ckToV
d/u/ycOuKU/xESjvS7bN3cTyBpSB3GNdsZaVd/iwouCTcByghxHQ75mRM5uh4B6Dd82x5y05
W0pWPmOMJXUUBWyCnidiR7GHHfy4J1Thq37sxVovpNJagnp2EaBlLN2dRPePWYatI/ZIxICD
Kq0pnKHNF8kGDhjWpe2ER89nhN/koJXmLXF0ZQW6ZrHhG8KWPsFiIttYcv4/tuDuFIKyvSAd
7bJDbrW2peJrFDe5gNMOXznDPwSBl980qhruDfwC3tYz/OUUFoWR4bEgbMlEbOeLJd/HyLPB
RwjvWojKBie0mUeRV+oofTVMU/thWMI5iEy0/dD1iLTxYj73NO7+9Ek26sSX6lCWif2MMymx
TFIbPtrmgbIPA8PzoVqr62Yd8MU5nIqnlP8ufWj2YRBufFMgzTzaMhXi3JpsCT37uwsN15sK
kPsfmw1bWRBE88A30GAXW/FWIyKVqyBY8gWAmb6Hs10uq6U3E/3jTh6ySFttIuKTeNgEnD8N
GQNNXHmXw7TQiMKezkxAmW9W7XzN8/W/awQy85VP//si73f5X1roLkmjTTpmDWHTwS0Ej5+l
kuyj35PCyYaEHhE+nLlxynpWA2CH83nrRlBMJDyrkGFueCY+2Kx8dVQyS31bNxFTXndCItcE
IRsDRYXyfaP4dlJttF55R3lTqfVqzkY92WJPabMOQ09PPJkQVJZXl8e83+MWvhaTj2rlwdro
dS2puB2lzuXS2dI0iWximqLynUPZ22haA6UfT1QyTHqkI1c+CCaU0KUsyEVaT+NCWQ1rtXQT
WK1u5pbnH180Urb8RzlzcWjoPGAgDB0J/bOT0XwZukT4uwfgIuQqlpUKXWomd0h1kjCvbY1W
J03sPSRBnDM7mTxUiPhzbiZQnY7J25znFPVM0iwmg4PI0x7D0aF0hYLj8pj4jZ4tGeE0PwXz
h4Dh7PNhx+p9c7kOG/GrGFuOMVv99vzj+TPaySaI101jWQPPVlXiPuylqUWhMjHghd0kBwHr
Fu4ypYHcSO520glUOhWy3UZd1dCbNRPYpsm8uVm/foAPkyAc/MRKpF5+vD5/Za4pzDkiFXV2
jUmYi2FE4WrOErskrWo4PDVpMuAu83IEatNmBOvVai66swBSQTG7bbE92tq5450tNGlkUtJc
eIpmo5DZjLQVta88uVaMWAAQS6qo9UtG6uOS49agbMg8vYmwGaVtkxaJx4hC6ne5K1I3YRS1
k1FR/P79A/KBooeHtixP4dBMQljYDPQJuj5YjLHSgSNBlQOL6O24Tyqf0FQcF23lrniaEayl
2vDARUakXxU/NeLQP9bG8u/xUGU2T4e4/WoL7cQpqWFmfAyCFWg3rmQdT7OApRdazyTttl5d
hZO2ANrY3CP4VM/dq6zLKrYymiULjFFm+Ti8n4LFyo5+cBYP94u4qc0DbZNSFgYQLjHG2GHD
1W+PukC/8TXORMJ68eRlK8yNW0bPAJqhL1F8sC3XInadYx0WQWnrad3BtvDb4b1wjkgyGuzZ
HRTr9VM+lcStC7GEcWexlTN8pUG/k8pGNxm2Iq+M9Q2LdnZyP2/RdXdATm4L97GN/Yzj7GVV
LtGKlZAgTU3VLzAlCLHi0AWGaug3VcilxchTTc2//a1ljOOB7tx6L2wXBM1WcpKqUnLPq7DI
vQh8NLb05qdfIiv3e+uOocp302LYIJQX0LOKpOQ6OWnst6HxXWjpRE9AynnKB1kC68HhDTNE
XMZwuGGsi9bQ8XWJcLUm6XggspsY/lQ24i4SzIHImOHIaLSYsEDAkZv1KrTFitO5bOzn0pE5
JGyRhuQo9dwgrE1dtleuGKpZLJ6qcGLmugm2MsuuE8jx4eWtiXo3Ni52Jkyuk2o0auL/UXZt
zXHjOvqv+GlrpnanIpKiRD2qJbWtsdSttOR2Jy8uH8cz41pfUrZzNtlfvwSpCy+gkn2IK40P
4p0gSILAHNBHXzDJ3PxLP/MEBSqujq/Bn7s1PiUAu240lLQCL+RX1sWfJLZXs2Pp9tvj+8PX
x/vvsthQDuWDHysMfOQYzUzUZihiFiU+0BV5xmMSAr77wKE694ltcyq60T3H5Ih1rdh284yB
jALx84BDbiGv5lAwkFr++PfL68P7P09vdhPkzfl+Uw92YwKxK7YYMTf3DE7Cc2bzXgJC3Cwt
P8Y+O5OFk/R/Xt7eV8Of6Uxrwpn1/GMmJ/gV04yjPmIU2pYpT7w021IQgjrMhqksIuJ+UeOe
UQAC9yCx3e07de5A3aGurXrlMMTsBFVX1nLHZ75GHYkJi+wOAtvM5GTTwFGKS9BH0ss0/fH2
fv909i+IRjSG+fjtSfbN44+z+6d/3X8B44gPI9cfUtOF+B+/271UgEGerboAWeoh9flOBQiz
zz0cUG4Cj1XwU8yVocuCem8BpnF2Wx+qnbjplN+NCW7wXlZt1+B7B4D33qWhOQaKHHEqpnuq
tZ6SAk3by0xTtvouhe6z1BYl9EHPl9vRIAWdJ0O+76UC0U7f79//0WJk/NjoXfvDqqkuB/O0
aCo5eDx0pjo6ra16QdROu6Z+1yrS6JDcnQzamSM0arDJR1fjUhj9hCW0pplL01wuZjsxQx+i
9Z2piV6YCu2Fch28LGb6CKyvHddDC/nxAfyXm5Y/kASsbJitZWcd38qfvnsFLVu7fkoas1uC
D6VmDpH7LmHjHMhr4lFnIYaB54KMs2rO82/wOnT7/vLqS/uhkyV6uftvfwGW0A3hQshELRdB
YF2YjHaSTzgzXGTYTeLA5SBox1AfYR5nYT1R9ws8f1nvYE+wjABJAK3D/A3/Mw7bRn+gC2Bo
mzBExySxYmpE7go7yvpI2LqTi/pIfyI8OiFfgJJm+M6CnrSMV0eCimcDgTXGgDecUJejPnwE
20K/VkHbFiV4lXNt7MgTwMkf1WQdrCP4PN1+/SoXIZWuJ8TUd+V13lkvpxQVzp/CBZl7ZxTR
oTK1G5H06cluItjgf9ZXk1bl6v3JIY1y3f4ajJW3xYWl/oXrOi/Vinr//evt8xfHblCnumJv
pQsNRjcRbue0MFDsAEgfX4OOy05eQ490N2IJwpRi16AjvBU89dMeurqggkRBWe40ih442/KX
GosGi5MrNzbOTLnZlLIKpL22bAD1CFR2AKHU/sx3n28GM26gImvtwkur6VgWY8JrREXKTt5H
emaHm/9Q8IGLYKr6Zk0kXroKyEiwoUacOlUbPrYnkTjE61ZkWWyqFUhHzRGSvQ60emIQJ2wg
1jcq5K5tD+ewVJrHjMWim6gsmHYTaYVZdstnDZPzc7m/yy0NSneHXF2uDL8319bu4ZrAAZK3
fpM//udhVK/aW6lvm7WWn+gYkcpMb39ykhuxsqexwIahyUKuW7NgE2DvhBd6f16bTYIU0ix8
/3j7bzvakUxJ63zq0S1eNs3QW2G6ZjJUKuIhQDgtYUJgK1+C18C1XIGVsHAq2FCyOMybZhMQ
EQ+myrAJZXOQQI1ZuKyM3RQH/JzH5hM/yR2UBzT31HTqaQOB8ooqikMISZGRNY4gQ7uD48ab
/BiIv65QFScCU6QU2l91XWM9eDDpQT+FFtPkmmDC4IEO4NapGwRMVlQkNdDu4fkTrDxRYlzK
bvJBzrNPN8U1jYg1ZCYE2jdgn2yyCGxQWQxGH1l0iuXabzBFbaqGRM0GbfNdPpJXy7n5SNNQ
rJK5SGBwt1oXx+rOoBMzmthEBxOtVL8TxhEaQCyvwVPNpaoiO5AxH5HfCFl0H4BFmxr2ORPd
lrlLMqotffZmYAl3HN3MOadpkmHru1W4LA2UOhM+IPsqJtxaZi0o8Gbd5KEc87lmcqSMBzLg
Mu/1j7kwHx/PI7PdsDjFEtVaTqDYU8ef51fnFZwA0yzGjgMnvsPAI1sWT9kchizmfK3oZZZl
pvmMI1zUz5tjXbqk8YBE77v05bP2ho+YJIwB88o0Nu0KLbqwr+cnpCVRwKre5sHfQdg82Opp
c2Tm/ZsBMGugmxBBHfkZHBmNkZiCeTmkJ4IFFZRAHAYInlScULyAEkL3OTYHR9u+Z+uf9kWa
ULxhThCFdje5iF1NpKuqEqnUcOqI3wiF/JPXhxsIJu5/pG7YwH0YAvWJ7XBjAUjykwGmJbxs
Klybmdhqfgl+Sld5timRmhh+3WnyCLpF4+LMLJylvPfb57zhRPStX38J0Mi2wBgBuZjnKJn6
1Iv6IiEMGZz1ps2rFmtfiXQBL1UzyyDW5tCfRYwURWo2B0KxOJ5NvavkkoUVRgvSdVGhedLg
JaXFFxDfBo9ctNZHF/BQgkloi4NSbI4qKP7pxwnWTApA5AkoG0mUoDJBYQR/KmXxJPjRj8mT
rXW6ZGAkxYYaBCMFsYOXLkkY9iLE4sCGkwJ4KDtTU7FLmCEt2xYdi/ASDkXCMSPWuVPahCFd
1aY4laODvF1dkiQssMQEUnl4PYfycpQ3xahYC0kqRakMTYFT88mLBcTIANYAUsSuEClLkHoC
EFOkk3dDoY8KaieYzYQXgxzqSBsBkOL9IyG5O8JteUeOTjl+wD5WR5MZpgp2rTYf8j9pN+i7
M1OLoXhRN+CNYItGB13E+02x3VrxxCZo13dXB4g1Zt8ZzfiBcUqxqhgcIkqQrq8PXc/jCFEQ
6r5JBGHoSKRyp5QEl4V0XWJJHiZWxfQoNxH9VkvEKCSzaJSiO0ybheOiWsogwXEkjjHNE3ZY
iRDIJDhVUrZjgbG7PpbbUkRqSoSzxHxXOCFXRZlFETLVAKAYcCq7Si7oflKfm4TYriEnpL8Y
VntE4rh+KgH2fbW7JUexNjQnSwivGmVbyXULESVVW5A4QgScBCiJEBkigQSOYdCqt30Rp+1q
EUcWTNRqbMOyFG2eYehTvp52K5dLbC9SECpKQQSWbl72qaDYed/MIass8KWz3uU0WlvbgcH0
Bm7QGaXI7BmKNMaKOVy0BV+bkEPbgV9XbH0HBDv4sBiQySfpqDwDOj6GJcLJWlbHOk9EkmPf
HgdCUfOihUFQhhTnWrA0ZedYmgAJErJtX3iyX+Ghv8CzVnfFgMxOTYe9qX1/buCNlKcDsrXS
UGIFvV6ghKYXW3+IaaS6MG7iR3efHgGcnzTaMng5wx2hfsiHGh7Fo+/HR6aqrQ7n1Q6elIw2
sUus4shP0/NN6uDXh1q9TAdXWV2PlWqK0nm+hyDlVXdzXffo20SEfwu7+P4id95EI5zwMAk8
qRRrSf88yV8tJPCBk7Ob0dMZmtBqmcrquD1UH8MdDY6b1VMjM/kVO+ce3Afs+77WkaKX2dBj
b1Y2RZub7AbZ/qWDmsM1Jc4942aeC9DvsZeFCteWzvZjHBMAb4I3RbvzEp7wkNWGZkLtjZTJ
6l/fnu/Aw1HQh1u7LX1/vZIGZ12oQARfFtP9/FIZ9Uk+UJFGrkNiiYB7tSw6nRyqcV9vJnPq
aOSwaprj5XdbehYzC819Oqzq2cdpQ/DDjhlnP8ED/mVmPHAAsuBoEEJoVHWxYpoFTURO7VqP
x2+6NawcFBIuIMAJ7mZ4hrFFZAT17Y31iVTh2Ek/1A5813Y0oZn53QWEwM77usBNhAGWyTmW
nSPYdBJUUThmfiA5tr5WEeuPfYJazQCobD+Kdm/5/AbAt/4AqhAqcnAwL42HO0DhSYSf/unB
eyIxR48rRlhdJLmzQFJF7FNFFqXuEFFkim0SZjRLkZQy4aU0JAwNBDSBmZ95tdtSsmlDg+VQ
DVd23v513kQB1doyM5zorrA00x+NSKws5qsik6YNcmzGviocW2lFreM0OaFCtG95hMlQhV1+
ErKrqf8N+kA935x4FHm55BtGRnIon099YS+sQB0gsjZj/ATeCZxzfINNGzu5swDuSwW2aRlT
btor95Mub1o0bDhc+pGIW0c7+iIQtWqafAzYXTDbR/3wqZmzSkH5tJGW2yTALpKQpJhMrZA8
MkJxKiaiJSYlCMOPwIfrRu6I/f40GcCl9lqHXzeEpgwZqE3LOHOGtGsJBrTjSXDurMmjwd0P
hBhcaSkeVEeVseUEPfCbQBK57abM03BfSjOMH1iNcLwityXMiLeKeSw8WlnoDPs5k1qUGYtx
gX9QZlUd0tvmq6OQCjflDfE8G9vIbSa5kSAWQHuEPe6bQd8MeQzwlPJKPWHe9VdthaYOWr9S
+hcuJCW56J2LxJpvC5gXgxAJthwZPCVnpgWEgWiV0xx+BqiURrzlZ6ZJNV0tAKKpGk2s1bYA
YhrCWAg1RYmDELTH8h1n3JyZC+a+pFmQum8yFq23LxwR05TkWMpSaCR47WBtSEkQoVgdlKVN
IDWR4nWDc2YushCUpAmWEyhSXK0ISKOoE98YOzpzeMxrQhsCzSoE4X3uqVYuhI5wX+NzMEET
9LtOCJ4Fqi91M3RvZ7NQFv6cY8u/zYJXFQzNYx6YsZMKt5p2t736XFnBCQzsKESUhFIHUOCL
gMMV2MQZXNfoo+YZ/whOycY3ScjnCgYPVkfvIZTHG7YNN3gcFXZBetp2eYROU4B6gkO8FWmC
jvBZb8Ww5pwT65JjweBmhMhBFcA8JdBGKQtYWNpsPKLrDWXoj8EkBGYV5TJlEd6zCiUM32Q7
bLjhvseENvWobSCIGltNvqk3pqOqwjmWkQTthXn83dQH42xl020VRbnqptZXZVVI2sE4D64h
9s4MLHnWauzOdPM1ISDJhCBtIBn+PBaBT/v97tP6t32++7RHCwSnoZ2BmOm2Uo+53JRY0ibb
qe3Wc6+1LSCWxaFo29X0VQODowbUuNfbfwJltx/qbW0qaG0Fj5YBO9jbj5kOVtO4PwXNM+L+
xyMg1cdmCFRhYtyUh6N6Bd9XjRMyZHw/9uXhdlJq3398Nd1TjSXNWzjJWwpjofkub/ZyR3QM
MZT1eT1IDTbMccjhqUkA7MtDCJpepYVwZWlutuH8jMyrstEUdy+viDP2Y11WKiyJ1797P9p8
edwsRwRWplbiKtPjw5f7l7h5eP72fXKD7+Z6jBtj8i80+yDWoEOvV7LXO2vd0wx5eQza8msO
vSdp6x2saPnuvLIuWVQG2ybvL1S8kkL+D/Wzr9iud/vSagWstlbbz64OlrZwJ87c4NDO+IYt
lNgYafzvh/fbx7PhiGUCfdc63u8NyIrto3jz0xjmWArjJaA6QODbFg6PVVPawYsArcDJRS/n
ZC0FVbPve/kH9+kM7FdNhQWMn6NGe3UyZ7cfRGGcQUWNCSFja1yqZ4C6ekE5pYOLG87ZVE53
L09PsF9WmQfG9uZqS50lcaEj417R26rddz36RZs3zd4KqQUmEfluf9OWw9G6pJqRwGMgmfsi
YZCAEhajLBKV/1b5oBd/KUEQeWuMumfb4kMP8chhEox+D0zTdqieiqR0ODrTV8vFULrbh9f7
a3hi9BvE0zgjLIt/nwJ9eBMFYnrLdl2ZhNb7XE26fb57eHy8ff2BXIPpJWUYcjPEtxZLsKTT
+dlz/u3Lw4uU4Xcv8ODwv86+vr7c3b+9wfN6iFDx9PDdKa5OZDjmV2XgEm/kKPM0Rt2zzngm
zFcyI7mCCAPc8AVg0E1rYE1u+47FkUcuesYi4VM5izlGbRjNvZI0R0ajvC4os+LRavSqzAmL
w9WTCq02D/SoLPNTO3Y07dsOO7bRDEpJ3AxbuRE+mevAr3Wf6r9D2c+M7srY53nChTBTttiX
FTaYhFwPwfbdbUVNZuj6mSYRfqa6cIiVJt4MgmRuC0siT9xCSGLiES/7yHpUPw6oRiSyYEnq
sssmSi0n8ib55NdPHfOk6NPqaQp1nMQnb9gBmUdIgscujdBT5hG/psJ8/ThRs8w0SjOoXosA
lSA5H7sTo/bzdWNAwDi7tYahLy5UK6GulMc5eKJcjKE1TQ0HHYH3z8FBnBKKd5zwpqIamKnX
n5rMsWHMYoZxswwlc0L8eT4CsGkJtkVeZkxkGy/NSyHIyU9yuOgFde8CrDac28tow4cnKSn+
ff90//x+Bk6WkD676sokjhjB4jSaHEJfqFlZ+skvi80HzSK1mq+vUlTBVcBUAk8mpZxe9J68
C6ag/eaWh7P3b89SVfIqBgoBGNvKDkbby/1UL7YPb3f3cp19vn8BT2L3j1+NpN2uSFnE/D5q
OU0z7HBkXJH97UcPrr27uhytECdVIFwUXc3bp/vXW5nBs1wBfC/J40DqdGw/M0y4Ri5qbrsq
G4vXyhZbE9SKATt+XmAuPDVEUm3zzIW+1lbtiflSH6ic+4ntj1SO0JWiAwMPFx1gf01TVE+g
7I88ib31ZH9Uz04Q3hRJV1K5L3+BnuFWGBNDSlFz3hmGawok3dRpHQ/GCpmmvtq2Pwpk3d0f
sySOsG7JEtQAd4IJE1wgC1GfJIFr2HGiDVkbRfhltMEROM9cOHDffDPeRabt7EwerKgeC5kQ
79hBko8RwbiPsnSIBJHAWqH6Q8SirmBex+z2+11EUKjl7b5xt383hzIvWl/RPvzJ451X3p5f
Jnnud5Sih1UfCcdVce7pPpLON/nWJVeDqC4t5RQXdEoGNpLmb4impZULiig4+WXKUuxScTyt
us5SgogqoAfewc0MIkpvjkWLLjdWUfWm8fH27R9DcHvqQ0cSjtuZaQ4wikCNmGY4iROzJe0c
9QLa1e4yt6yQLuacFF7tFr+sxbe395enh/+9h9MUtax6O1TFDy4KO9M41cTkNpEoj/amSYaN
CxoyUnT5UA3Uz828BnbQTJiP4CywynmaWC8bfBg1hDO42oHadqUOZr5t8zAWyluiNMFugRwm
Yko1E4OwhubWx8ROBY2oCGHcCg1lY7HG8CKfGvkpDx+VmWypf2Kt0SKOe2G+vLFQUAQTvjbs
SKBe2yKyhLeHUTxVhbGVoQx5BgxaDcYqDgQGt7KSOleg6VshDn0i00BuRMaiXOVZhNv6WfOW
Ep7iedRDRlhgJB+kEB4CRTs1LCKHLY5+bElJZBvGgfZV+CbSoYuWxQKRQ6aAertXZ3/b15fn
d/nJ7DxTmSu9vcv97e3rl7Pf3m7fpe798H7/+9lfButYDDjF64dNJDLDxcRITIg90DX5GGXR
d6SFZ9S0qBmJCSHRd/cAXNOxzlLn6nKK2N7LFFWIsmfOUyas1ncq0vB/nr3fv8q91jtEFQjW
vzycTN+akjLJ04KWpVOZ2p58qlA7IWLT0mYhsmlRkaQ/+mBnWHUsTjQmrjM/F0cv2FW+AyPU
bbbPjexKhsc/XXD8+byqNb8gMeoIcOp1ar7cnMaPZYMwc2YZPhLWks/clGBdjOzzuanjItx0
YPrK8i0AxGPVk5N5GKI4R2lQksifBBrU/YRrNUtm2NKt08jH56Ne1yd2UTQxRYjUn55yeAYc
R6lMe7nohdpZTiyvw8CxZ04SrwFUM6fEm4UwzIez34Kzzi5sJ7WS8DhXcKj5ZP1pijSfJFK7
pdTYtfcm46TH3/IB2MgdsQhJJl35+OSmuDsNSRSwbh1nJur9cpqAjDOvkPUG+qTF3lOZeGFX
WZJTINutM1I7jzfDhriuJL5LAIZ8m0XoM08AqyKwdLAEtx3WvVdSucJi5hwzHBPTkgTIh6Gh
gnmZaXKouZUUF3ZCn0sil3C4lt3Dg5N5OBfjYrIykEGCiOC80k1JiSfAgOqIHS0g0/mWa+hl
9ruX1/d/znK5dXy4u33+cPnyen/7fDYsc+xDoVa7cjiuFFIOTwifGCjk/sDh6a3bjEAOmVEB
vinkxi0ouZvzcmAs8mbKSMePhgyGBPfVqjncaOTulI8chSa/EpxSjHajr4Z9+jFunPULElat
pP0N9+W6uDM/zajXunLuiVWJAdKXRv4lrcrYVif+4/9VmqEAm2hHUiqVJWazg/3JqMBI8Ozl
+fHHqIx+6JrGThXOZpFVVFZTLhZREFJGfHoLXxWT2ca0tz/76+VVa0+e0say06c/7VSb3eaC
coTm6RyS2gX8a81weNyDrXaM2nPPqDvhNZE5A01QV/Nozntx3jgqpiKevImUDxupEaNOOkYZ
kyT8u51+faI84ken62FrRa1N7yTkmadkXewPVz3D7lfUN32xH2jlfVQ11a7yRnKhjURqOUhf
/7q9uz/7rdrx/2PsWZobx3m8769wzWFr+jA7iZ04zmEOskTb7OgVUnLsvqgyaXd3atJxV5Le
/frfL0BSEh+gM4c8BIDgmwRBEDibTs8/0HFPgh3j7JpSg2v5YUocp4JTk2LaHI9Pr5M3vLj7
38PT8cfk+fB/8aU0a4ti360ir0UiRg6Kyfrl/se3xwcy9ECypoyOtuukS4Tlfd4AlOHRum4d
oyNhb/loPFLDUrazogGN1UCscpQoWb5CixCqFYHoppAmlo7LGuGrJYlaKesz+zV5gKy2TGhT
HdgE3VJhkKQODscZWpcUGLuEnoW6evSNJCKbxmuMrUgKsrxAScLXrOjkBs16KOzWYy/TDRsE
B3yfZO4vJ7B+BWpJK50O1wSSWeR4Zkgkz8/nlIuunqDc1UrTd72wXnYESKORtHzDx4qpBRBR
OGrd/jrTAttZiSRzYm+NMPVIqW68NkyKDIawS69hOiBbCE75DQkf2TstZ7BrjJWohvsq3EyT
tJ78rg1S0mPdG6J8gI/nL49ff77co+Ga32sYnQATUivAv2NottjXH0/3vybs+evj8+H9LH1X
j4P53wk2LpeyarcsoQIpqUG9tr2LKwhMdK+DZOMCinWydlwnIfB2l7tUyyrdSL9/TKRAOrIT
EtRJyfJBiWKqWd8/H56cAelhnHwFz9bMLZziOmIc5uNWtHx5/Pz1EExYbfHMd/DP7mrhn7a9
AoXc7HKwpky2fOs2lAFafjqc7FMuYPvtbmF9jbSZDuDrp2uyFSn84xQ9tzXhpku9YWAHyVLL
XbJN6GatBAbAUUt/d9tycTNYhK5e7r8fJn///PIFVpnMv+aH3SQtMvSSOXIFmDKs39sgu2b9
HqF2DKJ6wCDLUodhukLDxTwXLG0CRFrVe2CXBAheQHWXOXeTyL2keSGC5IUImteqEoyvy46V
GU+cp+KAXFbNxmDoWi7hD5kSsmlydjKtqoVjUovNxlZMCJZ1tk8GJAYBBMPhfLczT9KbHKOT
O1B8tWK2Tpd1w3NV/UaHow7Hxrc+ihYh+GF/qClAbpeArQvq2I/J9ksmpp6yw4bjUIlxTWAD
xujRMTwvZEPJUFjddeLlCEuwpORnQFU1K1XENC+JPM+Ujw86lY6Q57S+CZrnvX0fEYQxeUAz
9Cudq+Bbv2YIirzO7rH9Y+gg2Tu58SvbbSCOLx3k41cA6gqYkqzkbUEi97Lhty3zimCw0SYx
+HjdtOzzKwARXWAQZIUJuth7DRyWzd5ZvAeQNSd/uUj/u0sbr3gI7EM/5WlkWVVEOyLlu7WS
tM4cMWpTiWI5da+Ko5VVsKLy1GmGm71wF64ZbIBecREEYlzK8lieiiLa59uqyqrq3Ml32yzm
tloPFwAQNHTcYqulxI1DUxdumhRkbL0VOkuVhsJuC2cZtk0oF+YOTdrKxo0hiDNpCYebXXNx
SV7HYh201wF3tjEY/2VVBPNmCfWNrUu+iQSCiqvzqX0IIaUCteIv7x/+eXr8+u1t8t8THIfm
yVbwOAtw+iGSebU3lhsxYXzJYYS6qX6FeN9Zx4ip70iGvvcoF3PpxRDpceqx6F3OqKk2Uo3u
vggWgFwsovFPHKrInYtVt/gDcIuVcfpAt9p8Zntv91DXVMvl9eLykmy58K3ziHODg1jcttBS
V3lNN9Yym5+fUUYtVvVEukvL0h6o7wxHS0GDfhGtUbjJ1At0o/B6fj0+gWRjDgjmeVT44HCd
9AHUHcMvEO1hR5DVCtolxXdwkdBNRWan74V0pbgyYPibt0Up/1qc0XhR3WEA8GHuwnoCG9Fq
hXefPmcCCdOqAbG4qwXIu2J/mlZUTeB6kOZppNImuWGoRSJPX+808pgFHOQqkkOgqBvTyKot
nYmqQ5bC8SPoRADaEx4+x8BBjWDluqGCIwOZSO7G9mo1G4tJHwPSaJvkj8MDKuexDIEJIdIn
F9ATG5dHkop2R4C6lWXIqKA1LuFeNZIWDjb0rqlqyfIbXkbRKRxtxf4EmsPXCXzVriNhKxFd
JGmS53u6ZeGMyRxRWcH2NUjc0gVCJ6yrUnDpVH6EQkNFsmCoG135TYbvryvKX4VCfrphe7+T
iyUXfs+v3CjPCpbDkbuKHIiQAFg3VRtxzqcI9pQbK8TcJXlT1W4Ztpzdyaq05S1VjL3QU9gr
Hk9Bio2w500wsj4mS0GdjRDX3PFyk5RuvjeslHCQbMKc8zSIM+biGW0CoHFltaUfCip0teY4
pyIFVeJoAX0SVK+ABhVVfGoUyV69ro4SwOKnhmAsZw67Am4PbiMVVQnLjj/EijZvuBoaLrxs
uAuoRMNuXFANh2GYxjD2rCFqAYN1pGZNku9Lb82pYarDZkoCta6HgBNnGxuN/GgEyySNSbnw
EHmC78xhlEu/C9WGRhvZIFomMDJuTqAL2ZbUcU5hMeyQcrfsNIhsWBLMewCyXMJGwOJTH7Kq
czLMghpLhdfPa8FYmUh7fRxAukNd7rCxNx+rvZ+FQ9TwE/MIFhfJTkzDZgNTO7ZoNhsBxxsd
gtNuHBseX6Vb3GW7Ws7cJrjjvKgc6Q2AO14WlQv6xESF9bYz7mHxTD/tM9hlK28J0265u40d
Gt6C60Oc+Qp24rymg7hTUsFwOeWKKwNDvCva8IzkFyTrETZwkFnksqs2KXfVj5ZMA3jCvQmC
0a0EnJhpRQwStHnNw9D1FgH8W8b8jyIeZPtNt0lkt1ELhZ02kkK7jFYthURYVUvSGuD1t1+v
jw/Q5vn9L/rauqxqxXCXMr6NVkCFx406pWqSzbbyCzv0xolyeJkk2ZrRSppmXzNaE4oJBQri
8o435PZXFLZ36CLtlip2fQjq/WIseozyV9DCimJZUQMxXk73kq72eqAdH2yOr28o6fdGAhnh
5aJIo8ozxMkMhqhj194DscdPJYL9oVkVftK7paSXMkQmeVpRxm2qjnwF8ztzK54urxxHpwDa
Ko84uokd5i2Uis+hZyJPSoAEBXbYmE7ULL3VzWGBNvLWr2RTyQ1fJif4FM0N3ag7EKoowaUA
ibnhqRNjoIfF/KqrWPDy7fHhH9q/iUndljJZMYx92xakr1ZZi8qMUbvMUsNO5hsfgX4pVP8W
zl4x4D4qka3sZouIQ+qeUFySXstH/NjBYyeW7M4Te/BLK74sPdkA0759SIySFkFccvcgRbAU
KI2VcIbqNndob1KuWXhGRnmb6CvFIZGz+cUlbfCnCJQqjtJXjthpUC6tvzuRCIOufQ+AZ3ZI
WwU1nhh9/uhH8ZI0M1Vo3yGozgC9OVOWHAP20i+TysZ1zGfD44EJBqr5jNLQKrTvOXUAhsWw
dZ4KMnq9DUZENqWDieneNqpMP1WTJugYMJasydPL6/Nd2BDGq+ep0aHs4LxhqIwL/356fP7n
9/MPaucU6+XEHAt/Yix7Soqa/D5Kph8sLbSqNsrufisV+Q4aKig02qxEa6r8dxvPStSwnk+v
omPIcuRog+W6mJ2rO7ShGZqXx69fnSVLM4DpvHZubW0wFM7xMezgKlgENlUTSZlx6SzyDrJo
6M3TIdowEBCWLKEuCR1C4ozo4NO6jWCSFI4s3L4oc9BqUsfq0EeIcbc51d6PP97QTPt18qYb
fRxj5eHty+PTG5peKcudye/YN2/3L18Pbx+ClXLoBZGUEk0t3msJ7cAv0l9wYudppKYlaxyP
d15CVGSWsTZEN0v2uMVbNozmwuFAQGv2RJNG3cllGE5EOWS0lNkDzPevbWG2PUrb+BRJaHcC
QDierB27E4QNrrdhNyuZ/eIct1mRwH6+BrqxXXnZsLzjALNjA9b5DtnZI2YHjVDu4CxY3qIX
yxqLFdZZXQptkF1XrAtLKB4Rlo3OHWbiuxc1UMcUyBDS0htgWWYH5DEAJLf4ylVX6+yHZk2f
Hg/Pb1azJnJfgrDYV35sWCPPB63fiUQF8+5ZLttV6DVOMV1xL+DQnYJTZzfNx2kABemKasuM
bRFtd6nJeuvYiEs3TQRrUuQM7lXDmg7tDtbCOk8oNXVr32nBR5fylQuo0avnmpVc3LqIDM1V
KUTCnPAACILtJ60kJR2pLEBeH+8ZnISwLlDShEolWluuRFCxmk8d/05i8D5nWTUrQ0D/GyOV
tM71lwbTg7dHFrYNowEu0drY3UkNhpd1Sy2hfQkKqlgFdoo2VuvGhWlkndWk+yEVoIpXTW67
SVJAgaZQLswnMW3hwNAdpV0lHQErlZwcrhqN+mFpFDLGVjA85Tw+vBxfj1/eJptfPw4vf2wn
X38e4LBjq4wG5z6nSS094l5Hgu1nbZOsuR22DpY1lnH/21/cB6jeaNUk5Z/QZ/Bf07OLxQky
EBJtyjOPtOAyDQemQS6r0jqdG6BZyYb2NeA6EVGPmoaEyz6oGOlh2PCBGTiWx2exmF5eRiaC
oUgy+NXHbyM4KHyCuZzHXMuElJeR90oE5Tlt0U5QkobtId3c9jERoKdntlvzED21X7cE6Jn3
mjYkoIMIhXQ799n6QJBjb82nZ/SbSpfsakee11yixfn8Ip7Ttfe2Pk72ToG2SHZ+FXmR7pOR
zyADohnREz3uguwGgyXf/LlEXebK5z22qPMUcTAO/HlD09bpdDZ/Z4r1hPOZG1bQw/OpvQUG
yNkZUeAUr+zSvkbxMmSJPFuQuWfN7IwY9OiXWLXmGTlS17AMbursZAPBnr6jHVr1C1xaa33R
qXLfLqtEZL5FrkF/FLPTbX+DFiwtXmsGFU+Vxh4aZk4NpgF7qgKGKKP2cYekAEaRAhSQPGj9
gvkOZAYENsmpMpW8m19OKS2HTUAskgifn1GdjZgr8lXwSJAnyzp1tYojEhuJnG8aV5wauaLJ
Lqfh+JTz6TyoQoGmAkS9QBwDQSzAwO54QQEvSWAnkwB+o/86pu72jKMKo1qKaiVHth3BomqN
Dbx1CpaXsT1CW09e0guxEae0Y5lAoEueP78cHz87j7gMyOLPBbuDHzwZcNK2dC27Vb1OllXl
XtuVXO6lrCNGOUb06zCZqIqTNBvyGUeP7R8ZBMlyMkLtiK1q1AfZZe5xgYmIh0dTLCLDLV8K
VHyeSKnfF2VdvbFUST3SaJE8qA7i5pfQVrv2QJlR6dXtmTlCr+9f/zm8Uc/3PMx/Dd3P8gy5
OEqfG9jdztw49wYUC3/Xo53K9ECtNhhY3eYRe+91lWcrHrGDMQ7n05yyfNzcyZqX5tJRa8+e
jg//TOTx5wsVe5fDCjDr3EtK4LzMM436y35ETHHqExUJz5f2g4ReT+QAOZS9te6+dV8dntG7
w0QhJ/X914PSFU5keN56j9S6zFc5xZ49isP349sBHW+HTSIYmkDUonJURyO0S2GIkAoPgqvO
7cf3169ERnUh3eUPAerBMq0jVGilAFujph0BxBDQZINOYSydUwptO1mlk9/lr9e3w/dJ9TxJ
vz3++DB5RaX/F2jkzL3jT74/Hb8CWB5T5yKrX1EJtE4HDA+fo8lCrDZ/fznef344fo+lI/GK
oNzVf65eDofXh3sYGbfHF34bY/IeqVZd/0+xizEIcAp5+/P+CQNAxFKR+EEzUOGNeD83do9P
j8//8RgZSqNJ3aatbahNpRisYv5Vfw/K26IPmz4oJvXnZH0EwuejXZg+wLoK6a4ePnRVmbEi
sVUHNlHNBD5MSMrUdZdgk+DuJJPtqYDufeR3FQMyyiiRkm9DBwx9fQjribHyHdvS9wxs16TK
aFulY/95ezg+Gw17eBuuibuVTK4vbB9/Bu6a8htgkexmM1tqG+FeQD4b4URhHhEq8J+1+RhM
3ZToup5ccAyJaBbXV6TLC0Mgi8tL2/OUAffGPJZRBSyiwnmcy0kRuWws20f46ArpRPNBEM+o
PkGMts5pmLUBIxj2xXVd2To3hDZVlfuscWhGeENBtObLS6Luo6KKry0cb5akISKKN7+sD3yO
unI0XgiMmfEgboiPbMHUpffish+aXNwqvwahjX4fqF7c2ktIQD9s3zDJbrAm9kBS59iuwaM8
+aRKy9OQtkob+1mVYJI1bggpa7dF3FKkhYTGha80Ym+vCRtuYkwHMxzETxAO/n5Va95Y7/6B
n5ZOx6qkRXeD8YRh6E4RSbX5Zt/Vu6SbLsqi20j3gsBBIhNSTnALNTDG1S61A+IVqRPEpNAH
a8oKBjB5PTyJqA8vX44v3++fYSH6fnx+fDu+UMrrU2RWC5Mxs6FuF3129vGqF/7KTFQRU8rh
6GVo4ZBZbjNe2E/KcrR82nq3GWWGCGfoka+ONTc0/LcvTJOd0Sc7MGsx2GJm7ucwG11gXcB4
y5RNsn7+cjd5e7l/eHz+SpmVyoY+9Okb02ZDNhLBcjipwBk0ELNrAROsj8w3nmmBtCvWoqdK
t5SXHUU1+IMY+1CngS2QfWIGT6Q2UkgtVFDBtnaCwSnWgq0dTzgKmK3sF5YG0q0KRkOxFhGM
Kblf7R6tc49VG6mSVUuwdlQ+IA1UtTUzJa8cOxz87vqTLbUG5rxw738AoEX5tBG5zQqHhYD/
Sy9g4XD601o/e12oZEMOIk8W0a4GHkHS1SuP66w8yXmWNAwkFLzDoa1zAAfnKnuJgq1+CmBn
70dAt0sa1yNNj6grie5DUkrD0tNIlrZCG6HY6WfdilqLAHPR2dPUAMasQpSVg43xrtsU7KYt
eaM2fSuLj8vMcTSL3/Gn6hKOwWmSbpi7x3FoZcCRlfqoEGO7fqTr8zHSWgiPOzlQqfDNIdpO
UrnvdO622QZAbtuqocTAHV02BLsW7gipSnVxLFPRLsnCIdFdIuhXQjuqXv2mvpLuWDQApd5A
7WCWO4/Bq1TjCVbLRvTtb202GnZyBA9E0NkgKuFkXvt9M9CItsQ4sYDu4mYWmjpWZ42F4w1z
W3rMg6062PQ8S49+P+O5aTP75ek0NiY/VSULBgYWLiFfwEcmIErJ7mzVEGMY77pi4XCONN1n
yUUgXqD6ce/j7UKxMhV7FZSRLhs2iuMPogf5i8CIWLY8bzj0GV+XSdMK2yBrJX1fPZkP4Bqg
jqtOYZMTpjixOafgaAKhNEFq01gl9jt+RZA2VtNjINyVdJdKDXNAqxafd7q37gCKW4m4tPgu
OU/2HaF1S+8fvrkupVZSLYvk7mWoNXn2h6iKP7NtpjYwYv/isrqez8+8bEclfbYKUH0+NG+t
IKjkn6uk+ZPt8HfZeLkPHdg4LVhISOdAtj4JfvfmGRiKuUZ/UhezKwrPK1QJwjnnr98eX4+L
xeX1H+e/2cNnJG2b1YLcIU3+310IkcPPty8Li3nZBIvBKF6cahx9EHk9/Px8nHyhGk2pUr2j
LoJuIop1hcRTnj2kFRDbDt94cjTFdlHphueZYJbwecNEaXeEJ+E3RR18UsuYRgRCjgZzjPxL
mnXA8WGVdalgiXuhh3/GlbU/n4WtN/BBcx1c/KD4DSusElcqarE3pZOMBnTCemmfrDwiphZQ
d9j0IKiJlJ4J08YTWeBbvwe0YEu2IgDeirsMNhkWF5P8Tb+HGKaWg80BcwerufGtEBGPkFC2
BbpuOEHRj4ATJCDhq9f1fAwRHK3FJ7xu/eXCBJqbO7eNSx5ri1Qkhd1/+ltvq86tlkEUjXV1
LG/bRG7cVu9hepsNVmqSKuOuO7gBi6fDou7wtbpnwOpRBJYTpylRW5e6LhTDBEE3+QSm7cOU
+SdqHlvoiqjr7hPJ65NsqPvdAX+htB6o/EBTPZIFK5Ysy0hfOWM/iGRdsLLRPaZ5zYadaOdN
wIKXsLi5om5VxMbYpvYWidtyd+FxBNA8kJ4NMCbHCpOlpR5UELy4Zlm33A8vKcfzk0cQe0ER
MKpIxyOaDB2TubehtWy0VsX5xq0zx+NyP8EDAhgZNnLc5Hr0xYCmdruBapPG81hcjCuMs5Fq
NI63f5GJxeF0HXt5gcjKrm1PRvYGWbF/k8KuK0VP12ko8m+fD1+e7t8OvwWEnjMfA/fvZg0Y
Vs54png+CvpIqywDGP7govybXyDE3eANrpq38wsCjd6vQYSQVfnXlEDXp1ObGvsUIElsnZnd
ehNSf+vN06UKnBoyURFiYy9SsuauEje2+EIdTe03J/AxdqQlA1voXojuQIi2p5uDu5pR9mMu
iRvM08EtyPiXHol1D+ZhTjF+t1wLO4ychzmPYqKFmc+ijbQgJVeP5DKa5Txeyznlrd4huZ7N
o+W6fr/1r2fTaO7XF3SIJ7eIV7RhJxLBCRPHXUcdsBwm517oQx9JWVIjTSJTzt127fM8p8FB
bXsE9a7Fxl+446IHX9LZzGnwFc3kOlKFWaywkTjFDgkVbQIJbiq+6ITPWUEpD9GIxAdgsNnb
npR6cMrwkbffdxpTNqwV9EPjgUhUSfP/lR3Lcts48ldcc9pDJmU5tuMccgBJSGLEl0HSkn1h
KbbGUcWSXZZc4+zXbzfABx4NJnuZjLubEAgCjX63VWjYJboVcZLEdIWJjmjG+G9JBOdUBFiH
j+FlVPCF82ic1TF91xrr87s3qWqxsILUNAo0RWiRH4lRLwL+9IqCdRbjadGuGAVoMgwXSeI7
VV27S07T7Gt5s7zWFWjD16ECnjb3b6/b4y83t671Fg5hfvA3XLLXNS8rV/UZxAIuyhjuMJC2
4QlMZPJYcdshifetsF4Pj9QMBk1bmS87uGa/uG2iOVZKVgXHdFNG6wfAPLhSusYrEZv1bTsS
WltqkbTgz254I1tpZDCnWqbPFbeN7GPBDMOLQ6RPwB1hytwyjprvFF4ylMRYUFvV0yajgZQh
a1gCpuf1lunXvzB48eH53/2HX+vd+sPT8/rhZbv/cFj/s4Fxtg8ftvvj5hH3xofvL//8pbbL
YvO63zzJitybPfpih22j1cM42e63x+36afvfrnVBtyHRcQSvEC5g75rlbCUKdrFcP0/itEOM
rlgvbd+BhZxSh/a/UR8jZh+R7m1WuVC6kbZL5R7NuziT8PXXy/H55P75dTN01BiWQxHDK89Y
oedr6OAzF85ZRAJd0nIRxsXcSIkwEe4jc6z3QQFdUmGk6/UwklDTlKyJe2fCfJNfFIVLvdC9
0d0IqPS4pMDJQfBwx23h7gPSP7GjqbGIAQtAe7D8oS3VbDo5u0rrxEFkdUIDDRGmhct/KBNH
96J1NQf+6MxRL5ZUvH1/2t7//XPz6+RebstHLGr6y9mNwsh+ULDI3RI8DAmYJLRnz0MRkQXu
u7erxQ0/u7iYfOkDaN6OPzb74/Ye9NOHE76XE4azd/LvFnvfHQ7P91uJitbHtfMGYZi634GA
hXO4xdjZaZEnt5NPpxfE1BmfxSV8Qf/kS34d3xArMWfApG46RhDISPHd84NeaqCbRhBSn3xK
VR/rkKaRvYfSRtB2RoEzy0QsnS2TT40QqxZawCT9Y6+qkngGLualYFR8Tbfb5/3K27NgmI5c
1SkxLNqOjWhzFXGEDeA965syd6vOKeBKfQoTeKMo264wj5vD0f0FEX46c5+UYPdHVnOjpFIL
DhK24GcB8VkVZuTTwu9Uk9Monrq7nuTm2n63WFp0TsCoc5HGsMF5gv+SF3THS9Jo9PAg/vKU
GB8QZxdU394B/8nIFWsP45xNnDcAIIxF/AggLiZUUaIB/4l6LKU7FnToCoSSgExA6rjyTEy+
nDmTXxYXshS+khy2Lz+McOmeIbl3DMCaKiaOCsvqIPbkNbYUIiSTrbudly8x64bYrApBVCTq
9iRLOSh1Y1yfoR6hnndODuDc7YnQS2cuEbEiU/kv8e0Wc3bHaKt49/lYUjI6bdm8NaidwUk/
RI8VhdH3od9P58RYFaern3XoZW7nQ7UF5Xcvr5vDwRC7+5WS1mv3GtBdNi3s6tzdoMmdyx6k
2dqhRDt7t5PFev/wvDvJ3nbfN68qX8nSCvrdWsZNWFBSZSSCmVXxQseQzFxhFP+zV0/iQtIB
plE4Q36LscgRx/js4tbBopTYUIJ8h6Bl6x7bC+vuaeppBFkq2KZqNQSXM7ExCQFnB5rV1NZe
nrbfX7F15evz23G7Jy7YJA5IvoTw9vLqa8eM0JA4ddpGH1ckNKqXLMdHGARQCk1xGIR39yiI
zOg5mIyRjP289z4e3s4QUl0i7xU3XxLfm5W3KfZviUNpPMHyrsOoGrKog6SlKevAS1YVqUHT
M4PVxemXJuSiiqdxiG4zFUareZYWYXmFBbRvEItj2BTd2C18pz/5uQ25oMf9LJWfRtXR18KS
Z2hrKbjyzcs4QJxbTGRKhJvXI6aBgaKh+g4fto/79fENdPn7H5v7n9v9o16JCv02uulKGKEg
Lr7UPF0tlq8qjEkfVsx53qFQTqvz0y+XhtkqzyImbu3p0BYlNTIcQqyQV1Y0cRca9gdrosoJ
epkG1vW6bAqjkGwHawLQYoGbC8qOi1GyTDQynEd3zTIrGDKIQQLDMjna8nXpLSCcZSHa2ESe
dmGHBEnCMw824xhTFuu+uDAXkZX0IuKUgzKfBnRFH2WoZIk7PJb3sALKZXlqjEAM02IVzmcy
ulNwQ9gPQeeFu8kATS5NCldFCJu4qhvzKVNhgT8Hs/LOggNv4MHtlcl1NIynIogiYWIJu3eE
IvAY5AFL1wcCSdaYouaMARbpqmihVrOh1cn0WAqWRXmqvT7xk0awwU6HqnAcE44BNXi9miLY
nbpgLKgRKmFAtZE1+DlJTUdKIDU1ihEboU0bwRT96g7B9t/N6urSgclErsKljY3SiC2Q6W2r
B1g1h+PkILDIhDtuEH5zYFadwf6FmtldrJ02DZHcGaUKB4QMZqLocxIuhWHnpBN+AhmzfMOS
BjVI/aot8zAGlnHDYSEE0yRPrFoP7EJP01IgDCBvDDaCcLv2ohlanoH20pQKkchuRBZO1p5k
RaP6WZkMCnEsikRTNZfnQWzoXhJXxF7/VjlL1HJox1MmC/Rh5dqsr3WumeSGwQT/HjuwWdKG
p3ZHQdRNl4XS/XBy11RM22ixuEYBTfvVtIiNuMRctmGZwdVptLXKs0qr66BBS4vo6v3KgejM
W4Iu3ycTC/T5fWIojhJYwBWZ4JAk85QkDC6szCbRCTAArjl/v3QGh0mQLQIRNzl9n1w5T5R1
hi/jewjQk7P3szPrzeAYTC7f9auoxGzQPLE2XZY3qjxErJkQ4DTY+XUlbEjjMADXMNzdefCN
zbSKi+gnzGa6R7WXgBzBph8zidLpstOderdSJydK6Mvrdn/8eQIa8cnDbnN4dL2uIDpk1aKx
g1xbMHayIt19YRvClOSzBGSfpHe3fPZSXNcxr76eD8umZGlnhHPNZ5vnVTeViNPVSrGcWBqH
ThFeHdy0dWk1GTQNctQ1uBBAR6c/eBevN3xsnzZ/H7e7VhY9SNJ7BX91l1pNpVV4HRh2VqpD
bujRGrbj7p5mNRplWSQeUUYjipZMTGmBaRYFmBsWF6TuzjPpfEprNKYh09SOEjbMk4ljRilM
3NsFXCqYy5saHn7BWSRHAyTl8OaYG4/B/HAB6AxRvQdoHTIMIY3LFKtMasfPwsg5Ydrbrbu4
01yEMGnOFhhJ0DhxzH1Lvz/82kY9nfZQRpvvb4+P6OuN94fj69vOLFUsu3WhWiSuNa4yAHuH
s1r7r8D4KCqV5U+P0FYAKDGaAst9DJpguwolsTKlvCSX+N+R7YTRh3GpKFNMjSWDA4wBW1d8
i6yD0uwaLgFYz4Fy5ShkgE0QS2sMmZPhDsQSuNVTq4DIkC+CSrskJL/7H31J8zUxv4U7u7Wd
mx600A+mcWPkiKBzY085sxulGgXxUnKhQ2GkbSKPsTueR/lWw8D1w2nnXZnUQUekX2gIluY8
d04qvKIufa2TS2ATUUvFs0hxjZHJ3VC8oF1EWb1ERmNoElQoZU2MaMU7NMtlQidW2kX5sIvL
NoMzhqV33maOtTds04ykP8mfXw4fTpLn+59vL+r4z9f7R7NoDdazx0iRPC/IgG8djynfNZxn
E4lXcV5Xet4MNtRDLbwu2q6mOZ3x0rY8ndcZtmkq6VVeXvdVef0nQv0anXQ2uhYqyAs45MOb
7Enj7nG1H6zrWgHbu9HcOo4VeQiUIX7G3DC4lgvOC2WvUYYidIwP5/g/h5ftHp3l8Da7t+Pm
fQP/sznef/z40eh9oMZDJaeu+MrT8q7dQm39txGS3w8ilqUVlm0RdCnV0pI/WiZeJvXClkHF
pvFoKsulmhMtgv4fS9YPiFcusCrsgAS6HHxcZeFw+cdCcSPPmfupGO/D+rg+QY57j7Y/R6hC
OyLBLRE89qHGeKTMCI5pe5pij03EKuxyLERd9M2DjUPimbz9UyGIfnA/wQ1N1MkLa+MQDcJT
WMsySc4XNSh8n90gwgx1rO/zGzK4kUOaxSOWX5P1DrrSd8Zr2AsALEnJYYKQwAxKlaEONyTm
adFTLbGwsedsqXhMfBauEmet108vP9YUy2JJMWdtsXq8yUSl3S29uFXNeVrrm8AeT1fUqs3h
iIcJOWeIxdzWjxstFrY2rjhVAKMtpWiDzRBcBeMruQhOoSyFxWPpZxfdxkfdKBfAk78pcZpW
8FX2MkVjXs9wKYf5jdpDjW6aEyAyovUaJ6QKyJo9F5JF5Cnfoy4q9CCUvrJfkiSNM9kjw0/h
fR7DYtWUkS+OHI8ATWgjeGnqypMc64Z6qQx7nJ9MpVv6ODmrctB7L89NTq6/7ZyvojodWw5l
jVCxvmTAdEtVhoXh7VIeMEBUOVWPQqKlOj91nlIWE/+cAC8LxI4I8bVd7krHrqQl04/HoglT
UE78FAJN9hVqYH6aua91ssTGER1iodZFmohGNvqCkou7tUHDqr2kN6mjKhjrVcrG9oXWlFmN
VkxtCLrq5mjMwXw5vcxTjBXBgKOMudHkENNYpCAScGeSqp4ApYlIBMnjlNdQRwzcQvfZ+Y4I
zLh0umeoNfFZmdodL2Ph2zQBa9en+cjug9smZPCNfSPb9sDu51DEi90TDMMhnPw9wLmcw4w9
p+8eJ0BdWRL/B8rssmHiqwEA

--r5Pyd7+fXNt84Ff3--
