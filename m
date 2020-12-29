Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5312E6F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL2J0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:26:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:28164 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgL2J0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:26:21 -0500
IronPort-SDR: mvDlQvetyG28gYDL5R1MRAUwc4cvudeQWxlLrZdwUuUFhQlcFtBfyfceWIHXumnvesZhPenUuK
 mvBTU98fWKyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176573096"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="gz'50?scan'50,208,50";a="176573096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 01:25:36 -0800
IronPort-SDR: VvGERUhFFC8zjGjZkdV8TAud7lCMTgiBMRK/xJBEroP8oghcj85fqEOxAP5w0UL4NjY+U2r5xe
 ON64hStWNPXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="gz'50?scan'50,208,50";a="347322430"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2020 01:25:33 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kuBG0-0003Tv-VW; Tue, 29 Dec 2020 09:25:32 +0000
Date:   Tue, 29 Dec 2020 17:25:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202012291719.2ZSU9PnL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   5 months ago
config: alpha-randconfig-s031-20201223 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
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
   drivers/scsi/mvumi.c:407:40: sparse:     expected void const [noderef] __iomem *addr
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

vim +407 drivers/scsi/mvumi.c

f0c568a478f0353 Jianyun Li        2011-05-11  222  
f0c568a478f0353 Jianyun Li        2011-05-11  223  static int mvumi_internal_cmd_sgl(struct mvumi_hba *mhba, struct mvumi_cmd *cmd,
f0c568a478f0353 Jianyun Li        2011-05-11  224  							unsigned int size)
f0c568a478f0353 Jianyun Li        2011-05-11  225  {
f0c568a478f0353 Jianyun Li        2011-05-11  226  	struct mvumi_sgl *m_sg;
f0c568a478f0353 Jianyun Li        2011-05-11  227  	void *virt_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  228  	dma_addr_t phy_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  229  
f0c568a478f0353 Jianyun Li        2011-05-11  230  	if (size == 0)
f0c568a478f0353 Jianyun Li        2011-05-11  231  		return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  232  
750afb08ca71310 Luis Chamberlain  2019-01-04  233  	virt_addr = dma_alloc_coherent(&mhba->pdev->dev, size, &phy_addr,
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  234  				       GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  235  	if (!virt_addr)
f0c568a478f0353 Jianyun Li        2011-05-11  236  		return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  237  
f0c568a478f0353 Jianyun Li        2011-05-11  238  	m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
f0c568a478f0353 Jianyun Li        2011-05-11  239  	cmd->frame->sg_counts = 1;
f0c568a478f0353 Jianyun Li        2011-05-11  240  	cmd->data_buf = virt_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  241  
f0c568a478f0353 Jianyun Li        2011-05-11  242  	m_sg->baseaddr_l = cpu_to_le32(lower_32_bits(phy_addr));
f0c568a478f0353 Jianyun Li        2011-05-11 @243  	m_sg->baseaddr_h = cpu_to_le32(upper_32_bits(phy_addr));
bd756ddea18e02c Shun Fu           2012-09-23  244  	m_sg->flags = 1U << mhba->eot_flag;
bd756ddea18e02c Shun Fu           2012-09-23 @245  	sgd_setsz(mhba, m_sg, cpu_to_le32(size));
f0c568a478f0353 Jianyun Li        2011-05-11  246  
f0c568a478f0353 Jianyun Li        2011-05-11  247  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  248  }
f0c568a478f0353 Jianyun Li        2011-05-11  249  
f0c568a478f0353 Jianyun Li        2011-05-11  250  static struct mvumi_cmd *mvumi_create_internal_cmd(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  251  				unsigned int buf_size)
f0c568a478f0353 Jianyun Li        2011-05-11  252  {
f0c568a478f0353 Jianyun Li        2011-05-11  253  	struct mvumi_cmd *cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  254  
f0c568a478f0353 Jianyun Li        2011-05-11  255  	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  256  	if (!cmd) {
f0c568a478f0353 Jianyun Li        2011-05-11  257  		dev_err(&mhba->pdev->dev, "failed to create a internal cmd\n");
f0c568a478f0353 Jianyun Li        2011-05-11  258  		return NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  259  	}
f0c568a478f0353 Jianyun Li        2011-05-11  260  	INIT_LIST_HEAD(&cmd->queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  261  
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  262  	cmd->frame = dma_alloc_coherent(&mhba->pdev->dev, mhba->ib_max_size,
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  263  			&cmd->frame_phys, GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  264  	if (!cmd->frame) {
f0c568a478f0353 Jianyun Li        2011-05-11  265  		dev_err(&mhba->pdev->dev, "failed to allocate memory for FW"
f0c568a478f0353 Jianyun Li        2011-05-11  266  			" frame,size = %d.\n", mhba->ib_max_size);
f0c568a478f0353 Jianyun Li        2011-05-11  267  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  268  		return NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  269  	}
f0c568a478f0353 Jianyun Li        2011-05-11  270  
f0c568a478f0353 Jianyun Li        2011-05-11  271  	if (buf_size) {
f0c568a478f0353 Jianyun Li        2011-05-11  272  		if (mvumi_internal_cmd_sgl(mhba, cmd, buf_size)) {
f0c568a478f0353 Jianyun Li        2011-05-11  273  			dev_err(&mhba->pdev->dev, "failed to allocate memory"
f0c568a478f0353 Jianyun Li        2011-05-11  274  						" for internal frame\n");
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  275  			dma_free_coherent(&mhba->pdev->dev, mhba->ib_max_size,
bd756ddea18e02c Shun Fu           2012-09-23  276  					cmd->frame, cmd->frame_phys);
f0c568a478f0353 Jianyun Li        2011-05-11  277  			kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  278  			return NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  279  		}
f0c568a478f0353 Jianyun Li        2011-05-11  280  	} else
f0c568a478f0353 Jianyun Li        2011-05-11  281  		cmd->frame->sg_counts = 0;
f0c568a478f0353 Jianyun Li        2011-05-11  282  
f0c568a478f0353 Jianyun Li        2011-05-11  283  	return cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  284  }
f0c568a478f0353 Jianyun Li        2011-05-11  285  
f0c568a478f0353 Jianyun Li        2011-05-11  286  static void mvumi_delete_internal_cmd(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  287  						struct mvumi_cmd *cmd)
f0c568a478f0353 Jianyun Li        2011-05-11  288  {
f0c568a478f0353 Jianyun Li        2011-05-11  289  	struct mvumi_sgl *m_sg;
f0c568a478f0353 Jianyun Li        2011-05-11  290  	unsigned int size;
f0c568a478f0353 Jianyun Li        2011-05-11  291  	dma_addr_t phy_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  292  
f0c568a478f0353 Jianyun Li        2011-05-11  293  	if (cmd && cmd->frame) {
f0c568a478f0353 Jianyun Li        2011-05-11  294  		if (cmd->frame->sg_counts) {
f0c568a478f0353 Jianyun Li        2011-05-11  295  			m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
bd756ddea18e02c Shun Fu           2012-09-23  296  			sgd_getsz(mhba, m_sg, size);
f0c568a478f0353 Jianyun Li        2011-05-11  297  
f0c568a478f0353 Jianyun Li        2011-05-11  298  			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
f0c568a478f0353 Jianyun Li        2011-05-11  299  				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
f0c568a478f0353 Jianyun Li        2011-05-11  300  
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  301  			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
f0c568a478f0353 Jianyun Li        2011-05-11  302  								phy_addr);
f0c568a478f0353 Jianyun Li        2011-05-11  303  		}
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  304  		dma_free_coherent(&mhba->pdev->dev, mhba->ib_max_size,
bd756ddea18e02c Shun Fu           2012-09-23  305  				cmd->frame, cmd->frame_phys);
f0c568a478f0353 Jianyun Li        2011-05-11  306  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  307  	}
f0c568a478f0353 Jianyun Li        2011-05-11  308  }
f0c568a478f0353 Jianyun Li        2011-05-11  309  
f0c568a478f0353 Jianyun Li        2011-05-11  310  /**
f0c568a478f0353 Jianyun Li        2011-05-11  311   * mvumi_get_cmd -	Get a command from the free pool
f0c568a478f0353 Jianyun Li        2011-05-11  312   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  313   *
f0c568a478f0353 Jianyun Li        2011-05-11  314   * Returns a free command from the pool
f0c568a478f0353 Jianyun Li        2011-05-11  315   */
f0c568a478f0353 Jianyun Li        2011-05-11  316  static struct mvumi_cmd *mvumi_get_cmd(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  317  {
f0c568a478f0353 Jianyun Li        2011-05-11  318  	struct mvumi_cmd *cmd = NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  319  
f0c568a478f0353 Jianyun Li        2011-05-11  320  	if (likely(!list_empty(&mhba->cmd_pool))) {
f0c568a478f0353 Jianyun Li        2011-05-11  321  		cmd = list_entry((&mhba->cmd_pool)->next,
f0c568a478f0353 Jianyun Li        2011-05-11  322  				struct mvumi_cmd, queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  323  		list_del_init(&cmd->queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  324  	} else
f0c568a478f0353 Jianyun Li        2011-05-11  325  		dev_warn(&mhba->pdev->dev, "command pool is empty!\n");
f0c568a478f0353 Jianyun Li        2011-05-11  326  
f0c568a478f0353 Jianyun Li        2011-05-11  327  	return cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  328  }
f0c568a478f0353 Jianyun Li        2011-05-11  329  
f0c568a478f0353 Jianyun Li        2011-05-11  330  /**
f0c568a478f0353 Jianyun Li        2011-05-11  331   * mvumi_return_cmd -	Return a cmd to free command pool
f0c568a478f0353 Jianyun Li        2011-05-11  332   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  333   * @cmd:		Command packet to be returned to free command pool
f0c568a478f0353 Jianyun Li        2011-05-11  334   */
f0c568a478f0353 Jianyun Li        2011-05-11  335  static inline void mvumi_return_cmd(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  336  						struct mvumi_cmd *cmd)
f0c568a478f0353 Jianyun Li        2011-05-11  337  {
f0c568a478f0353 Jianyun Li        2011-05-11  338  	cmd->scmd = NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  339  	list_add_tail(&cmd->queue_pointer, &mhba->cmd_pool);
f0c568a478f0353 Jianyun Li        2011-05-11  340  }
f0c568a478f0353 Jianyun Li        2011-05-11  341  
f0c568a478f0353 Jianyun Li        2011-05-11  342  /**
f0c568a478f0353 Jianyun Li        2011-05-11  343   * mvumi_free_cmds -	Free all the cmds in the free cmd pool
f0c568a478f0353 Jianyun Li        2011-05-11  344   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  345   */
f0c568a478f0353 Jianyun Li        2011-05-11  346  static void mvumi_free_cmds(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  347  {
f0c568a478f0353 Jianyun Li        2011-05-11  348  	struct mvumi_cmd *cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  349  
f0c568a478f0353 Jianyun Li        2011-05-11  350  	while (!list_empty(&mhba->cmd_pool)) {
f0c568a478f0353 Jianyun Li        2011-05-11  351  		cmd = list_first_entry(&mhba->cmd_pool, struct mvumi_cmd,
f0c568a478f0353 Jianyun Li        2011-05-11  352  							queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  353  		list_del(&cmd->queue_pointer);
bd756ddea18e02c Shun Fu           2012-09-23  354  		if (!(mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC))
f0c568a478f0353 Jianyun Li        2011-05-11  355  			kfree(cmd->frame);
f0c568a478f0353 Jianyun Li        2011-05-11  356  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  357  	}
f0c568a478f0353 Jianyun Li        2011-05-11  358  }
f0c568a478f0353 Jianyun Li        2011-05-11  359  
f0c568a478f0353 Jianyun Li        2011-05-11  360  /**
f0c568a478f0353 Jianyun Li        2011-05-11  361   * mvumi_alloc_cmds -	Allocates the command packets
f0c568a478f0353 Jianyun Li        2011-05-11  362   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  363   *
f0c568a478f0353 Jianyun Li        2011-05-11  364   */
f0c568a478f0353 Jianyun Li        2011-05-11  365  static int mvumi_alloc_cmds(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  366  {
f0c568a478f0353 Jianyun Li        2011-05-11  367  	int i;
f0c568a478f0353 Jianyun Li        2011-05-11  368  	struct mvumi_cmd *cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  369  
f0c568a478f0353 Jianyun Li        2011-05-11  370  	for (i = 0; i < mhba->max_io; i++) {
f0c568a478f0353 Jianyun Li        2011-05-11  371  		cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  372  		if (!cmd)
f0c568a478f0353 Jianyun Li        2011-05-11  373  			goto err_exit;
f0c568a478f0353 Jianyun Li        2011-05-11  374  
f0c568a478f0353 Jianyun Li        2011-05-11  375  		INIT_LIST_HEAD(&cmd->queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  376  		list_add_tail(&cmd->queue_pointer, &mhba->cmd_pool);
bd756ddea18e02c Shun Fu           2012-09-23  377  		if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02c Shun Fu           2012-09-23  378  			cmd->frame = mhba->ib_frame + i * mhba->ib_max_size;
bd756ddea18e02c Shun Fu           2012-09-23  379  			cmd->frame_phys = mhba->ib_frame_phys
bd756ddea18e02c Shun Fu           2012-09-23  380  						+ i * mhba->ib_max_size;
bd756ddea18e02c Shun Fu           2012-09-23  381  		} else
f0c568a478f0353 Jianyun Li        2011-05-11  382  			cmd->frame = kzalloc(mhba->ib_max_size, GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  383  		if (!cmd->frame)
f0c568a478f0353 Jianyun Li        2011-05-11  384  			goto err_exit;
f0c568a478f0353 Jianyun Li        2011-05-11  385  	}
f0c568a478f0353 Jianyun Li        2011-05-11  386  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  387  
f0c568a478f0353 Jianyun Li        2011-05-11  388  err_exit:
f0c568a478f0353 Jianyun Li        2011-05-11  389  	dev_err(&mhba->pdev->dev,
f0c568a478f0353 Jianyun Li        2011-05-11  390  			"failed to allocate memory for cmd[0x%x].\n", i);
f0c568a478f0353 Jianyun Li        2011-05-11  391  	while (!list_empty(&mhba->cmd_pool)) {
f0c568a478f0353 Jianyun Li        2011-05-11  392  		cmd = list_first_entry(&mhba->cmd_pool, struct mvumi_cmd,
f0c568a478f0353 Jianyun Li        2011-05-11  393  						queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  394  		list_del(&cmd->queue_pointer);
bd756ddea18e02c Shun Fu           2012-09-23  395  		if (!(mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC))
f0c568a478f0353 Jianyun Li        2011-05-11  396  			kfree(cmd->frame);
f0c568a478f0353 Jianyun Li        2011-05-11  397  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  398  	}
f0c568a478f0353 Jianyun Li        2011-05-11  399  	return -ENOMEM;
f0c568a478f0353 Jianyun Li        2011-05-11  400  }
f0c568a478f0353 Jianyun Li        2011-05-11  401  
bd756ddea18e02c Shun Fu           2012-09-23  402  static unsigned int mvumi_check_ib_list_9143(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  403  {
bd756ddea18e02c Shun Fu           2012-09-23  404  	unsigned int ib_rp_reg;
bd756ddea18e02c Shun Fu           2012-09-23  405  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  406  
bd756ddea18e02c Shun Fu           2012-09-23 @407  	ib_rp_reg = ioread32(mhba->regs->inb_read_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  408  
bd756ddea18e02c Shun Fu           2012-09-23  409  	if (unlikely(((ib_rp_reg & regs->cl_slot_num_mask) ==
bd756ddea18e02c Shun Fu           2012-09-23  410  			(mhba->ib_cur_slot & regs->cl_slot_num_mask)) &&
bd756ddea18e02c Shun Fu           2012-09-23  411  			((ib_rp_reg & regs->cl_pointer_toggle)
bd756ddea18e02c Shun Fu           2012-09-23  412  			 != (mhba->ib_cur_slot & regs->cl_pointer_toggle)))) {
bd756ddea18e02c Shun Fu           2012-09-23  413  		dev_warn(&mhba->pdev->dev, "no free slot to use.\n");
bd756ddea18e02c Shun Fu           2012-09-23  414  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23  415  	}
f0c568a478f0353 Jianyun Li        2011-05-11  416  	if (atomic_read(&mhba->fw_outstanding) >= mhba->max_io) {
f0c568a478f0353 Jianyun Li        2011-05-11  417  		dev_warn(&mhba->pdev->dev, "firmware io overflow.\n");
bd756ddea18e02c Shun Fu           2012-09-23  418  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23  419  	} else {
bd756ddea18e02c Shun Fu           2012-09-23  420  		return mhba->max_io - atomic_read(&mhba->fw_outstanding);
bd756ddea18e02c Shun Fu           2012-09-23  421  	}
f0c568a478f0353 Jianyun Li        2011-05-11  422  }
f0c568a478f0353 Jianyun Li        2011-05-11  423  
bd756ddea18e02c Shun Fu           2012-09-23  424  static unsigned int mvumi_check_ib_list_9580(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu           2012-09-23  425  {
bd756ddea18e02c Shun Fu           2012-09-23  426  	unsigned int count;
bd756ddea18e02c Shun Fu           2012-09-23  427  	if (atomic_read(&mhba->fw_outstanding) >= (mhba->max_io - 1))
bd756ddea18e02c Shun Fu           2012-09-23  428  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23 @429  	count = ioread32(mhba->ib_shadow);
bd756ddea18e02c Shun Fu           2012-09-23  430  	if (count == 0xffff)
bd756ddea18e02c Shun Fu           2012-09-23  431  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23  432  	return count;
f0c568a478f0353 Jianyun Li        2011-05-11  433  }
f0c568a478f0353 Jianyun Li        2011-05-11  434  
bd756ddea18e02c Shun Fu           2012-09-23  435  static void mvumi_get_ib_list_entry(struct mvumi_hba *mhba, void **ib_entry)
bd756ddea18e02c Shun Fu           2012-09-23  436  {
bd756ddea18e02c Shun Fu           2012-09-23  437  	unsigned int cur_ib_entry;
bd756ddea18e02c Shun Fu           2012-09-23  438  
bd756ddea18e02c Shun Fu           2012-09-23  439  	cur_ib_entry = mhba->ib_cur_slot & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li        2011-05-11  440  	cur_ib_entry++;
f0c568a478f0353 Jianyun Li        2011-05-11  441  	if (cur_ib_entry >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li        2011-05-11  442  		cur_ib_entry -= mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  443  		mhba->ib_cur_slot ^= mhba->regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li        2011-05-11  444  	}
bd756ddea18e02c Shun Fu           2012-09-23  445  	mhba->ib_cur_slot &= ~mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  446  	mhba->ib_cur_slot |= (cur_ib_entry & mhba->regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu           2012-09-23  447  	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02c Shun Fu           2012-09-23  448  		*ib_entry = mhba->ib_list + cur_ib_entry *
bd756ddea18e02c Shun Fu           2012-09-23  449  				sizeof(struct mvumi_dyn_list_entry);
bd756ddea18e02c Shun Fu           2012-09-23  450  	} else {
f0c568a478f0353 Jianyun Li        2011-05-11  451  		*ib_entry = mhba->ib_list + cur_ib_entry * mhba->ib_max_size;
bd756ddea18e02c Shun Fu           2012-09-23  452  	}
f0c568a478f0353 Jianyun Li        2011-05-11  453  	atomic_inc(&mhba->fw_outstanding);
f0c568a478f0353 Jianyun Li        2011-05-11  454  }
f0c568a478f0353 Jianyun Li        2011-05-11  455  
f0c568a478f0353 Jianyun Li        2011-05-11  456  static void mvumi_send_ib_list_entry(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  457  {
bd756ddea18e02c Shun Fu           2012-09-23 @458  	iowrite32(0xffff, mhba->ib_shadow);
bd756ddea18e02c Shun Fu           2012-09-23 @459  	iowrite32(mhba->ib_cur_slot, mhba->regs->inb_write_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  460  }
f0c568a478f0353 Jianyun Li        2011-05-11  461  
f0c568a478f0353 Jianyun Li        2011-05-11  462  static char mvumi_check_ob_frame(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  463  		unsigned int cur_obf, struct mvumi_rsp_frame *p_outb_frame)
f0c568a478f0353 Jianyun Li        2011-05-11  464  {
f0c568a478f0353 Jianyun Li        2011-05-11  465  	unsigned short tag, request_id;
f0c568a478f0353 Jianyun Li        2011-05-11  466  
f0c568a478f0353 Jianyun Li        2011-05-11  467  	udelay(1);
f0c568a478f0353 Jianyun Li        2011-05-11  468  	p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li        2011-05-11  469  	request_id = p_outb_frame->request_id;
f0c568a478f0353 Jianyun Li        2011-05-11  470  	tag = p_outb_frame->tag;
f0c568a478f0353 Jianyun Li        2011-05-11  471  	if (tag > mhba->tag_pool.size) {
f0c568a478f0353 Jianyun Li        2011-05-11  472  		dev_err(&mhba->pdev->dev, "ob frame data error\n");
f0c568a478f0353 Jianyun Li        2011-05-11  473  		return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  474  	}
f0c568a478f0353 Jianyun Li        2011-05-11  475  	if (mhba->tag_cmd[tag] == NULL) {
f0c568a478f0353 Jianyun Li        2011-05-11  476  		dev_err(&mhba->pdev->dev, "tag[0x%x] with NO command\n", tag);
f0c568a478f0353 Jianyun Li        2011-05-11  477  		return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  478  	} else if (mhba->tag_cmd[tag]->request_id != request_id &&
f0c568a478f0353 Jianyun Li        2011-05-11  479  						mhba->request_id_enabled) {
f0c568a478f0353 Jianyun Li        2011-05-11  480  			dev_err(&mhba->pdev->dev, "request ID from FW:0x%x,"
f0c568a478f0353 Jianyun Li        2011-05-11  481  					"cmd request ID:0x%x\n", request_id,
f0c568a478f0353 Jianyun Li        2011-05-11  482  					mhba->tag_cmd[tag]->request_id);
f0c568a478f0353 Jianyun Li        2011-05-11  483  			return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  484  	}
f0c568a478f0353 Jianyun Li        2011-05-11  485  
f0c568a478f0353 Jianyun Li        2011-05-11  486  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  487  }
f0c568a478f0353 Jianyun Li        2011-05-11  488  
bd756ddea18e02c Shun Fu           2012-09-23  489  static int mvumi_check_ob_list_9143(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu           2012-09-23  490  			unsigned int *cur_obf, unsigned int *assign_obf_end)
f0c568a478f0353 Jianyun Li        2011-05-11  491  {
bd756ddea18e02c Shun Fu           2012-09-23  492  	unsigned int ob_write, ob_write_shadow;
bd756ddea18e02c Shun Fu           2012-09-23  493  	struct mvumi_hw_regs *regs = mhba->regs;
f0c568a478f0353 Jianyun Li        2011-05-11  494  
f0c568a478f0353 Jianyun Li        2011-05-11  495  	do {
bd756ddea18e02c Shun Fu           2012-09-23 @496  		ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu           2012-09-23 @497  		ob_write_shadow = ioread32(mhba->ob_shadow);
bd756ddea18e02c Shun Fu           2012-09-23  498  	} while ((ob_write & regs->cl_slot_num_mask) != ob_write_shadow);
f0c568a478f0353 Jianyun Li        2011-05-11  499  
bd756ddea18e02c Shun Fu           2012-09-23  500  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  501  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li        2011-05-11  502  
bd756ddea18e02c Shun Fu           2012-09-23  503  	if ((ob_write & regs->cl_pointer_toggle) !=
bd756ddea18e02c Shun Fu           2012-09-23  504  			(mhba->ob_cur_slot & regs->cl_pointer_toggle)) {
bd756ddea18e02c Shun Fu           2012-09-23  505  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  506  	}
bd756ddea18e02c Shun Fu           2012-09-23  507  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  508  }
f0c568a478f0353 Jianyun Li        2011-05-11  509  
bd756ddea18e02c Shun Fu           2012-09-23  510  static int mvumi_check_ob_list_9580(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu           2012-09-23  511  			unsigned int *cur_obf, unsigned int *assign_obf_end)
bd756ddea18e02c Shun Fu           2012-09-23  512  {
bd756ddea18e02c Shun Fu           2012-09-23  513  	unsigned int ob_write;
bd756ddea18e02c Shun Fu           2012-09-23  514  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  515  
bd756ddea18e02c Shun Fu           2012-09-23 @516  	ob_write = ioread32(regs->outb_read_pointer);
bd756ddea18e02c Shun Fu           2012-09-23 @517  	ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu           2012-09-23  518  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  519  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  520  	if (*assign_obf_end < *cur_obf)
bd756ddea18e02c Shun Fu           2012-09-23  521  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  522  	else if (*assign_obf_end == *cur_obf)
bd756ddea18e02c Shun Fu           2012-09-23  523  		return -1;
bd756ddea18e02c Shun Fu           2012-09-23  524  	return 0;
bd756ddea18e02c Shun Fu           2012-09-23  525  }
bd756ddea18e02c Shun Fu           2012-09-23  526  
bd756ddea18e02c Shun Fu           2012-09-23  527  static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu           2012-09-23  528  {
bd756ddea18e02c Shun Fu           2012-09-23  529  	unsigned int cur_obf, assign_obf_end, i;
bd756ddea18e02c Shun Fu           2012-09-23  530  	struct mvumi_ob_data *ob_data;
bd756ddea18e02c Shun Fu           2012-09-23  531  	struct mvumi_rsp_frame *p_outb_frame;
bd756ddea18e02c Shun Fu           2012-09-23  532  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  533  
bd756ddea18e02c Shun Fu           2012-09-23  534  	if (mhba->instancet->check_ob_list(mhba, &cur_obf, &assign_obf_end))
bd756ddea18e02c Shun Fu           2012-09-23  535  		return;
bd756ddea18e02c Shun Fu           2012-09-23  536  
f0c568a478f0353 Jianyun Li        2011-05-11  537  	for (i = (assign_obf_end - cur_obf); i != 0; i--) {
f0c568a478f0353 Jianyun Li        2011-05-11  538  		cur_obf++;
f0c568a478f0353 Jianyun Li        2011-05-11  539  		if (cur_obf >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li        2011-05-11  540  			cur_obf -= mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  541  			mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li        2011-05-11  542  		}
f0c568a478f0353 Jianyun Li        2011-05-11  543  
f0c568a478f0353 Jianyun Li        2011-05-11  544  		p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li        2011-05-11  545  
f0c568a478f0353 Jianyun Li        2011-05-11  546  		/* Copy pointer may point to entry in outbound list
f0c568a478f0353 Jianyun Li        2011-05-11  547  		*  before entry has valid data
f0c568a478f0353 Jianyun Li        2011-05-11  548  		*/
f0c568a478f0353 Jianyun Li        2011-05-11  549  		if (unlikely(p_outb_frame->tag > mhba->tag_pool.size ||
f0c568a478f0353 Jianyun Li        2011-05-11  550  			mhba->tag_cmd[p_outb_frame->tag] == NULL ||
f0c568a478f0353 Jianyun Li        2011-05-11  551  			p_outb_frame->request_id !=
f0c568a478f0353 Jianyun Li        2011-05-11  552  				mhba->tag_cmd[p_outb_frame->tag]->request_id))
f0c568a478f0353 Jianyun Li        2011-05-11  553  			if (mvumi_check_ob_frame(mhba, cur_obf, p_outb_frame))
f0c568a478f0353 Jianyun Li        2011-05-11  554  				continue;
f0c568a478f0353 Jianyun Li        2011-05-11  555  
f0c568a478f0353 Jianyun Li        2011-05-11  556  		if (!list_empty(&mhba->ob_data_list)) {
f0c568a478f0353 Jianyun Li        2011-05-11  557  			ob_data = (struct mvumi_ob_data *)
f0c568a478f0353 Jianyun Li        2011-05-11  558  				list_first_entry(&mhba->ob_data_list,
f0c568a478f0353 Jianyun Li        2011-05-11  559  					struct mvumi_ob_data, list);
f0c568a478f0353 Jianyun Li        2011-05-11  560  			list_del_init(&ob_data->list);
f0c568a478f0353 Jianyun Li        2011-05-11  561  		} else {
f0c568a478f0353 Jianyun Li        2011-05-11  562  			ob_data = NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  563  			if (cur_obf == 0) {
f0c568a478f0353 Jianyun Li        2011-05-11  564  				cur_obf = mhba->list_num_io - 1;
bd756ddea18e02c Shun Fu           2012-09-23  565  				mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li        2011-05-11  566  			} else
f0c568a478f0353 Jianyun Li        2011-05-11  567  				cur_obf -= 1;
f0c568a478f0353 Jianyun Li        2011-05-11  568  			break;
f0c568a478f0353 Jianyun Li        2011-05-11  569  		}
f0c568a478f0353 Jianyun Li        2011-05-11  570  
f0c568a478f0353 Jianyun Li        2011-05-11  571  		memcpy(ob_data->data, p_outb_frame, mhba->ob_max_size);
f0c568a478f0353 Jianyun Li        2011-05-11  572  		p_outb_frame->tag = 0xff;
f0c568a478f0353 Jianyun Li        2011-05-11  573  
f0c568a478f0353 Jianyun Li        2011-05-11  574  		list_add_tail(&ob_data->list, &mhba->free_ob_list);
f0c568a478f0353 Jianyun Li        2011-05-11  575  	}
bd756ddea18e02c Shun Fu           2012-09-23  576  	mhba->ob_cur_slot &= ~regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  577  	mhba->ob_cur_slot |= (cur_obf & regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu           2012-09-23  578  	iowrite32(mhba->ob_cur_slot, regs->outb_read_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  579  }
f0c568a478f0353 Jianyun Li        2011-05-11  580  
bd756ddea18e02c Shun Fu           2012-09-23  581  static void mvumi_reset(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  582  {
bd756ddea18e02c Shun Fu           2012-09-23  583  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  584  
bd756ddea18e02c Shun Fu           2012-09-23 @585  	iowrite32(0, regs->enpointa_mask_reg);
bd756ddea18e02c Shun Fu           2012-09-23 @586  	if (ioread32(regs->arm_to_pciea_msg1) != HANDSHAKE_DONESTATE)
f0c568a478f0353 Jianyun Li        2011-05-11  587  		return;
f0c568a478f0353 Jianyun Li        2011-05-11  588  
bd756ddea18e02c Shun Fu           2012-09-23  589  	iowrite32(DRBL_SOFT_RESET, regs->pciea_to_arm_drbl_reg);
f0c568a478f0353 Jianyun Li        2011-05-11  590  }
f0c568a478f0353 Jianyun Li        2011-05-11  591  

:::::: The code at line 407 was first introduced by commit
:::::: bd756ddea18e02ccea8b29496b2fe3bd91af8eb7 [SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580

:::::: TO: Shun Fu <fushun@gmail.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ikeVEW9yuYc//A+q--
