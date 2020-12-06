Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7D2D0712
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 21:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgLFUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 15:14:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:22231 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgLFUOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 15:14:22 -0500
IronPort-SDR: xNanuqXeOCuDQKg4xr/fruHV8SGZ4fxjdOoQ4wQ4CUmoYqW+N6AXjNrnjOsHpbzMTLd0y+Eagu
 A/NTUhKGzdhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="235213156"
X-IronPort-AV: E=Sophos;i="5.78,397,1599548400"; 
   d="gz'50?scan'50,208,50";a="235213156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 12:13:37 -0800
IronPort-SDR: ADJyAA4YSHZ2wavR96wxwM+B9EoqEPj8I6VhXHB94u6H72qIM7yKhfwWPdouKbOW1ZJTmqODb5
 tj28Rv4P1dmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,397,1599548400"; 
   d="gz'50?scan'50,208,50";a="369541778"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2020 12:13:35 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1km0PW-0000uX-Jh; Sun, 06 Dec 2020 20:13:34 +0000
Date:   Mon, 7 Dec 2020 04:12:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/usb/gadget/udc/fsl_qe_udc.c:837:33: sparse: sparse: non
 size-preserving integer to pointer cast
Message-ID: <202012070447.RNwU76Yy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7059c2c00a2196865c2139083cbef47cd18109b6
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   12 months ago
config: powerpc64-randconfig-s031-20201207 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-179-ga00755aa-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 const [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     expected unsigned int [usertype] offset
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     got restricted __be32 const [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:837:33: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:965:33: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:1491:25: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:2071:28: sparse: sparse: context imbalance in 'setup_received_handle' - unexpected unlock

vim +837 drivers/usb/gadget/udc/fsl_qe_udc.c

3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  807  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  808  static int qe_ep0_rx(struct qe_udc *udc)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  809  {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  810  	struct qe_ep *ep = &udc->eps[0];
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  811  	struct qe_frame *pframe;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  812  	struct qe_bd __iomem *bd;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  813  	u32 bdstatus, length;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  814  	u32 vaddr;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  815  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  816  	pframe = ep->rxframe;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  817  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  818  	if (ep->dir == USB_DIR_IN) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  819  		dev_err(udc->dev, "ep0 not a control endpoint\n");
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  820  		return -EINVAL;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  821  	}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  822  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  823  	bd = ep->n_rxbd;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  824  	bdstatus = in_be32((u32 __iomem *)bd);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  825  	length = bdstatus & BD_LENGTH_MASK;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  826  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  827  	while (!(bdstatus & R_E) && length) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  828  		if ((bdstatus & R_F) && (bdstatus & R_L)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  829  			&& !(bdstatus & R_ERROR)) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  830  			if (length == USB_CRC_SIZE) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  831  				udc->ep0_state = WAIT_FOR_SETUP;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  832  				dev_vdbg(udc->dev,
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  833  					"receive a ZLP in status phase\n");
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  834  			} else {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  835  				qe_frame_clean(pframe);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  836  				vaddr = (u32)phys_to_virt(in_be32(&bd->buf));
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02 @837  				frame_set_data(pframe, (u8 *)vaddr);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  838  				frame_set_length(pframe,
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  839  						(length - USB_CRC_SIZE));
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  840  				frame_set_status(pframe, FRAME_OK);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  841  				switch (bdstatus & R_PID) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  842  				case R_PID_SETUP:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  843  					frame_set_info(pframe, PID_SETUP);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  844  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  845  				case R_PID_DATA1:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  846  					frame_set_info(pframe, PID_DATA1);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  847  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  848  				default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  849  					frame_set_info(pframe, PID_DATA0);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  850  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  851  				}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  852  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  853  				if ((bdstatus & R_PID) == R_PID_SETUP)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  854  					ep0_setup_handle(udc);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  855  				else
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  856  					qe_ep_rxframe_handle(ep);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  857  			}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  858  		} else {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  859  			dev_err(udc->dev, "The receive frame with error!\n");
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  860  		}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  861  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  862  		/* note: don't clear the rxbd's buffer address */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  863  		recycle_one_rxbd(ep);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  864  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  865  		/* Get next BD */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  866  		if (bdstatus & R_W)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  867  			bd = ep->rxbase;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  868  		else
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  869  			bd++;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  870  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  871  		bdstatus = in_be32((u32 __iomem *)bd);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  872  		length = bdstatus & BD_LENGTH_MASK;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  873  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  874  	}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  875  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  876  	ep->n_rxbd = bd;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  877  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  878  	return 0;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  879  }
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  880  

:::::: The code at line 837 was first introduced by commit
:::::: 3948f0e0c999a6201e9898bb8fbe3c6cc1199276 usb: add Freescale QE/CPM USB peripheral controller driver

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICIE5zV8AAy5jb25maWcAnFxbc+O2kn7Pr1AlVVvn1KlJJPkynt3yAwiCEkYkwSFIyZoX
lGJrJq7jsX1kO5d/v90ALw0SUmY3lczY6Mat0ej+utHMTz/8NGFvr0/fdq/3t7uHh78mX/eP
+8PudX83+XL/sP+fSawmuaomIpbVz8Cc3j++/fnL89Mf+8Pz7eTi54ufp+8Ot7PJan943D9M
+NPjl/uvbzDA/dPjDz/9AP/+BI3fnmGsw39Pmn6X5+8ecJx3X29vJ/9YcP7PyYefz36eAjdX
eSIXhnMjtQHK9V9tE/xi1qLUUuXXH6Zn02nHm7J80ZGmZIgl04bpzCxUpfqBCEHmqczFiLRh
ZW4yto2EqXOZy0qyVH4WMWFUua7Kmleq1H2rLD+ZjSpXfUtUyzSuZCaMuKlYlAqjVVn19GpZ
ChbDOhIFf5iKaexspbawB/Ewedm/vj33ksHlGJGvDSsXJpWZrK7P5ijkdmFZIWGaSuhqcv8y
eXx6xRHa3qniLG1F9eOPfT9KMKyuVKCz3YzRLK2wa9O4ZGthVqLMRWoWn2XR741S0s8ZO0Yh
R+OP0y2ODEKXNaaHVh2LhNVpZZZKVznLxPWP/3h8etz/s9uB3uq1LDidkJdKa5OJTJVbw6qK
8WVg5FqLVEaDbbGSL0GAcF1gXJBp2p4nKMfk5e3Xl79eXvff+vNciFyUklvd0Uu1IQo/oJhU
rEUapmdyUbIKD9VTxlhlTA7atMz8hkSVXMSNKsp80VN1wUotkIkKh84bi6heJNo/lf3j3eTp
y2DDw1XbS7HuZTQgc1DIFew3r8j9srLFC1pJvjJRqVjMma5O9j7Jlilt6iJmlWhPqbr/tj+8
hA7KzqlyAUdBhsqVWX7GW5dZ2XdCgsYC5lCx5EGVdf1knIqAYjliUlPBwF8V2BBTlYyvvFMa
UtyB0sXY8YLLWMrF0pRC2+Mow+c4EknfvSiFyIoKJshD+2jJa5XWecXKLV1UQzzRjSvo1R4M
L+pfqt3LvyevsJzJDpb28rp7fZnsbm+f3h5f7x+/9ke1liX0LmrDuB3DE1eAiApBl4aabfWz
ZwlKr9AyKLHvWGt3eLAQqVXaXl6715LXEx3QQJCLARpdKvwKrgVULSRI7Zhp90ET+BttvCYc
UFdwJ3ulJpRcgKXQYsGjVNIbZWmKR7gfu7xGEv5OfEcSyXxO/LtcuR9oyxIskqAeNlXYOwF7
KJPqevaetqMoM3ZD6fNepWRercB3JWI4xpmTub79bX/3Bihl8mW/e3077F96wdcAMbKi9c5+
Y1SDpQEz45T1ot96YMABzIAlzeZX5CIvSlUXZLcFWwg3sCj7VnBLfDHsZTRfUoCSMFmaIIUn
YBNZHm9kXC09Vapoh6DCE0E43iBXs6JCxjqglA21jC0iGHZKQEk/izI8bgEetzoxZizWkouR
aKAfXOQqMJt1X6HxloKvCgUHhMYRQB4Z1ErHQiQ7BiFsNYg2FmC+OHiU+DjFrOfk6oiUeYYx
Sle4E4v0yji0Om5UAfYJICnaenQ08FfGct/qD9k0/BAYzaIWuI4xAlGuYmHAHzIjEFvmA0zx
nWzo1asU7BIXBVKsayIidAaLrjUDhCbhdMMHrxeiylDnGrgQMnVWxCM4kSxB01NPLIXS8ibg
7zxLQRE8uWsRAzjk++WkBuc7+BVUn84oCuWvud+YXOQsTcKXzS4xCSmARTYJVbAlGAU6JZMq
OKZUpi4H7qztEq8l7K4RofbsTcTKUlIbtEKWbabHLcaTf9dqJYeqXsm1dxxRkYSOtTc5oBQW
wAcl0SHCfpEGh4oACpHFAYr1IKy997Y1JN0sEnFM76+9InjLzBCRFnw2PW/ddhMDF/vDl6fD
t93j7X4ift8/guNn4BI4un4AUg7NNN37MYNA4jtH7KBN5gZrfQZZKMaFrAIwvKJy0CmLwoqZ
1lHolqUqGvYH0ZfgppowKzzask4SCEqtP4PTgVgTbGoYUpUqkekIcDXy8GPi7hAKftkdQnF4
ut2/vDwdALA+Pz8dXj15F9xESq3OtLk8D13+li6MHXEYLxQe9hIXF9MpNgZ3Ii4D1NE8xCgC
O1Es4MCWjPttSUGwWqJT1FarRh5Uw7HFoCPwdlP2AlluURSRDMFHCPThsg4WkGWI9ODKLf32
RmxAJmYpI+4xL60Dx2wF6RYrVUbCmozulMdH2Cl4rNUZ8Z0I+SKUXR5LRvZvd0QsGF2UNRlZ
xgCC5AhCAbsBaiTLCjFAED27CjO0N6sdqAelJ/hwvJlnXgDZIGYSpYtNIBYnokPU3ZKseTKJ
LDXc82WdrzwRQ+iiry964Jtn0kjrjtozqcA0Wn9sdF0UfjbKNsMQScoWekzHqBpQzJjQXpDl
RkBAWXmaMVCTxkjnShdUtQQr0+3I+RYsb1IFqgaoftUn96wwPcSBOZxxuwVrKpMVIEsGEZ0F
ddST4aLqOFqY2SVcZ6ImmMKxRzjepocJ2vxSLTMwb8NkhYxE6eARAg8to3TI0ggTExGlioT2
lwZeufVWYnGUJhnX1/MwLT5FWwNtSmkx2xDhfIa43sQ0dVcsXBrT5qL09Tk1RRxwci4AMvMi
68zxw+4VfVfIGms4rVAGiQypFQ8Zs08CrFBjMEnq003fnFI4UwguclGHc6OiYAWAaVYyTBF4
VhKmVAkuxGZZMsBzMpzwAEYwegBnb0DtvHuXFZL7vzmA51vzvt1s2ErUXhrUEjO98DxnmxyZ
JIf9f972j7d/TV5udw9ePgTNBgRWn3zDiS1modaY4CzR/hwhj5NbHRmMSdjjdxzt7cCBSJzy
f+ikNgBkwEKGAqFQBwSMumCDWCjEqfJYwGrC6DvYA2gw+tqC2O/vZY1QXckwwPVkfUREQdZW
MEeOjcohRG93f/TU+60eYen2RXJ0ky9DNZzcHe5/d7i3H8TJyNe4ps0UECRA/NvTPqlSfmo5
KFAIq327FHn3sG8m716ioAM2UytkM3CDPKw3g+tAWujA/TifhFkUR8IuMEmmrHhwipGFpLHE
0zM+pHkxw/KzmU2n4WzuZzO/mAYUBwhnvrF0o4R5r8njWsaqJUCOuktQ9tbIo9ioODDagGu5
wRe1rEhFBnEKjbHS2GC2D0xKHUEIV1G/u1RVkdaLBn9T54mHZ90mxpYCYswBXeTWWzUvOc04
f8dTwk9+kLoSN4IHdmfbAYuNnDqGpI5Y1OUCo52tl/HBCIh5WIA02sc7cjVKANsmrimYxgy1
zdEiou7xX01dda5ioZssZ4ddwSqgkUG5IbdlAvUfxLpOFqnQ2o0yhCwga161EsuAIx1y2Jcj
YGik6yG1HvIs64Wo0iihb6hpKhYsbYGaWbO0FtfTPy/u9ru7X/f7L1P3z2CXgBSNqpYWWcZD
EHW+sqHnoNVGo8NEcfMg2zR38EbYF5Yhs82ADRvt64tNRCN6UmUMPn525gNSnfnZyCxGQIEA
I3SHGjJ5dIXFlMxUDALvSpP2gjztFQ228oBMhuAPvUt8NPcJPDz1sgSbT87ZGJEkkktMMASi
/XZpAL4WvVIMUxmtQbMWLXp7IRbOh30+LkojTgejHXtFyBGOAERyz8E0ioCDVkmCEGf65+3U
/6e/y/YRGcYoT7FhxCw56xmHDO5xu03F0CwdNmaZVH7LOhm2DIOYbkS89dG2YFoHiGsbN+pt
zo1UvCL7RzhbYwXDIE0LvfyJLdI2y7XfKm4gEMI8Mn1Fs4Q2P+HBa0SpQe+0xhf45mndBewG
rzrfjuBsm+bZHW5/u3/d3+Lrybu7/TOc/v7xdawyzkJyL03vrG+oTaTJQHwQuTnaoF25bBQZ
4SNYYZOyiKpXp3Vo2WBw33rbgfqLU+dwEIscXxA4F3poWdE84+tYJXMT6Q0bllNI2A8mFGBh
IwUZho+utRRVkKCKcHszjEGXPkjbW3pS59y6clGWqjQy/yi4r1Z9GYTtvwSlGofQGCUh6moM
bsB9gh2tZLIFW1CXo1Vg8Q6YmKZgZbgHDJUNQFuX7GgkbRgNxxyfpjGRbXKmj7aQHC1mU0JU
PzTv2xGCN2vw3XcvopBCubXx2jg0gE9iR4k51g2Bj5RNEYPnxSFIBuyBTtH5Ovl5jFOAD3NE
9mWUZ8UNXw7x0UawVQuvQJafalkOh9kwUG1pfSoWjLQFRgGmJgv2XbwqjQl/SHpacGRABOYl
dVxGDQWPF0VgmRbBU+711SfbEoZBlizQd9BJV6WiVtGp0NFKDUs+WZxwjKOpUPBMwbhIYXj+
Km7RmOAy8fIPKq4B3ll7AybLvswExremH+66rRvCrQfuqe0Ol01lnnr1h+SlUgcD+LQ+xRro
TfKnxwahLIP0KlfFtgV3VTq8rXaYfF2yDOwifTVJMQGGj0kbVsaEgKqp5ULXIFovhHYraMiM
D4Omhn42j5xPDUX5nWRtcr5SZvBSjllY+s6jx/6Tq/W7X3cv+7vJvx3sej48fbn3k0LINIJK
3dyW2ri/5kmvj2YHtMAeLIvNZFTm3Lyn2O3U4jqQBVEaeEAEDJxf//j1X//y6w2xFtTxkDPx
GxtB8Mnzw9vXez+E7jkN37qkcYqqvg3upOOFGBaFDv+VoE2+RDomvAquNDT8gkVXNHzW+hu8
04WKEHrhMzP13fZ9VWd4UlMSo7trHoRjEerRieqrXIH7ld4jYsEw4iHaovNZ/xuWytowRhcg
hzrH8YdhYRv4QUScAQooM1LvaPfkOoPJUZucWvRyA+HkMaK9EUdo/QsxIO8NqdbsfreaIf7c
37697n592Nu654l9b30lGDOSeZJVPnjs7M2YBL802LMXuGPTvJTBsreGnknt16LCMIgegup0
bNl2T9n+29Phr0m2e9x93X8LIueTkXwfxGcshwAiQCHZBnyjsmUchYUl8QhZNpOAfmmRV6Fp
MKyFH0KkNfyBZr5LJ/SvCEOeYzUuWCJgNcXmPLIRtk4YhCcLWtFjdWclRNH1JerjdkNr9/pr
56WbQu/oRQr2v6jscmwO53zgI6znCOXTxoW+iDdwsfiuTu4qOg8Wx6WpAs+h3e32ojednaif
tuKHINAOen0+/XDZe0nBcs74kiaKaSYKfulyEcMmmvvBRnz5BO/9oV/W52KQFukpUR0qCvls
7aDyblH7bgWbKML1L20vG8+NAxb3QNnEXz0ZpAOBEKZ0rM13QBsrt0hGK25LH8aI0D1KrluU
SQtDEADiUkJPY6ClJhI5X2asDGGyohIO9DEvB3PcIJBaYRGyTS6KxVqdj7IryY33v9/f7ifx
ML/vAiDu1UDBryFfwzngKp8vg1WPEE3B393uDneTXw/3d19taWafKLi/bZYwUeNsee2A0lKk
xZHislisq6wY1rD3eD+PWToob6Y1zHb4RIInA811la2j1Sf3h29/7A77ycPT7s6+RrTHvwHf
hSWuRCPaJqsyMVaqEq9i837tbCTx1/eyMafbbmhQQgaD5wqlqPx7TjRDYKrDhUnDHZHKM7hD
G1u/GHZcndTt+3Mp1/6x+GSxLq0bGXTDDEvT17hkfTiP+Ulps6rxgxk/J0PqeWwhp015hMnr
OoVfWCTBYEvq0uzLNE2+l2LhWQb3u5G0xrlp28xGTX5esO1bkvQERAFGL1npdCKhx4ukBMyB
6AotfWg5viFd+vXO3mHvymj7PoPyg/0FT592JCA41yFblVVxazCK3eH1Hhcwed4dXjybAVxg
vt5jUoDGd9jcZsdbUu9mgagS1x6eGAQZ21f7wLAtKZalNb9bh4iv3838GbwhbP7OPtSIkOcZ
82PAqfJ0S89kLAYrnRp+nGRPWDPu6vuqw+7x5cF+SjdJd38Nagft7iFaPbIMnF4iUEBYBsjG
6ov7uoBlv5Qq+yV52L38NoGI43n8RGvlnkhfYh9FLPjgrmA7vm4GmqG/LTVRtgZ4dHJIzhXm
OIMGomWJwKhu0Z1tgsiuZUsJW2imhVCZqMpQhIcseNsilq+MrYo3M38nA+r8JPV8LAU5C7TN
R6pcnZYEvodBmBpyz524M4g949D+wZGxEx2bV3yqxiwbjgNKc3SBLEJQH7QWJ/TNhSm752dS
J4AxjOPa3WIZ4EApXaze4riRViHsDccAlgpYvd1Yi4n+Znb3ccj+4cu726fH19394/5uAkM1
9o/cHG8ZOoVpji1i6ZZAVaiKh22Yi6pUhQ9NmFejeLuhglvSTVJ3Nr9qINn9y7/fqcd3HHdw
DJ/hjLHiizOSPsC3dHxAMxl59exbKxugtF+2/K006Ew5s5m5cmAdwDDlXvUJacSkMKb+N6Ws
wt1aHz26Qw351F1qeeY3aLUWxw/KcgkOEcEGMG3mP4AdYTCaVuy6i7QxzU69ZdDOkf99qTPT
uz9+Af+we3jYP0yQefLFXSAQ/OEJWsdaZ4eMBT4xmfiYnbBMtnLYPaqGSDIZSdbSshsZKoPo
6FgAExgSrx0mAwMkDljTfbfibMH9y62vqJYL//C+W+13K/VKQSBEPzwOEJsikfbx+/t4Y4S/
fXnkcVb8ivL0kFFUtcps95kWMPrkv9zfcwhvssk3F5wFXbFl82f4ZL8Zb91udzf/fmD/WOso
FJchZbmFGMFDuHFF9EUlVEMAhiHOPvLVOVCTFKsM6UMWNLqYOkhaqeij1xBvc5ZJbwHdEdE2
DzMrfNnAMjYEQTRb5QgqXfuzQiRRuq+xaESdYU1zG9UisPKLn/uGPi50TcAeDhsbMru5unr/
4fIkD5j285FtyNeZmGhSUducvtfeXSgC8luIL3KtSm1Sqc/S9XRO31/ji/nFjYkL5e2INGNI
E47p6izb4gEEVEBy/eFsrs+nBArBxU+Vrkssfi/xyz36sFPE+sPVdM7oW43U6fzDdHpGF+ba
5uGCuHafFTBdXJzmiZaz9+9DBXEtg13Sh+kNnX2Z8cuzi3kogtWzyyuCFLXn4G/wG5cbo+OE
Fh1g6tdA1OBNUaxtFXyoLmje6J3LYIsCAVpfZ91K2bYbVs0JMm0aXf3FqDljN5dX7y9G7R/O
+M3lqBVQr7n6sCyEvhnRhJhN7QdSfcbaX6b76H7/5+5lIh9fXg9v3+znTS+/7Q4ALV4xAkK+
yQNAjckdKPP9M/5Ilf7/0Tt0D5pInSQyIGZiCJyLdHQB5eMreGWwR2BqD/sH+/9LCVS4r1Vx
NIg+NUQnRb5UAfUwtY48DEsvuZeFk3HncjTXssVpIyVBIqb/6aihDt1SGIdwRGFdok3DkEu6
kXmcsLL7AkA+Pr+9Hp1Y5kXtGRrbAIoZ/HbYEZMEjXnqWX5HwQ8tvdJh1+yeCFZeesZRMogH
5E1D6aLwB/xk/x6/rfuy8+xm00nVWgSmadtNoVl9c5SqOTi73Nxcz6bz89M82+v3l1c+y0e1
DUwt1q5xIEaxHtT4kRM5Fh24niuxjZTLzTbtbQu4guLiYj49Rrm6Okr5EKJUqyg0y6dqNr3w
SpY90vuwMSc889llyJp3HJhUWmH25/LqIjB/ugqvy4e4XrNVPxHqVHF2eT67DFOuzmdXwX06
5Ty1hzS7OpufhVYPhLMQAUz7+7OL0EFkXIdai3I2nwWXl4tNFXyj6jhUAS5elSI0sGaZrr2K
wo5SqQ3bUBTWk+rcncp4NbrKinCSvl8OXPPQV5/kMM5ASW9Cx5TNIRqv+RJagtPfoBqfnp6z
Yja7uTnNFPFQNNofR7UyhQeDieEgnkLZOm89DzT9L2NX0hy5jaz/io52hD3mvhzmwCJZKraI
KjbBqqJ0qZAl2VaMWupQy/M8//4hAS5YEqQO3ZLyS6wEEplAIsEWtkbdNpmQzS3ehJmjPlxX
7GeDbrBMXJTp6k1XyQMKAZmpLMwLpJz8Fjl7MLj4eRp3FF9hLOts35VoECepYnAjoVa9pKaS
+LevOry2WwietZ4/UawpATDNdzykU+hZ09QlL9WaJxsqYRoHeo75bdZkOhE6QFdwVMSq1Wts
vBXWOp1o3/eZUby2LyBaPo0D5YhEB4Wqoy+BFKIxyY0ZaZdsn7FBirZk5vHxcT4zFNUyQ37Y
tNh+6sRwvfWkg9mZ3MobFQr5Qhq0QddHuBJBDphhPTHxuxKZGuNkAinTAkErQ0/aJq6OFDma
vOI3Gpb74wzXeg+L+cPt2LqWb2nPFYRraod2Y4M2SkyJGQOfR/kcbG7LuSrYH2hz7nblfndc
/HjFJsU/RUbKHF3y5pKP7Qb2FLc9Uq2Mho7rIgAodYqD8IT0jewcrZCZHmxDQH1GW9D0LWZJ
TviWVlmkhHgQU447T2AjcIBBUAmdda6SRIR9Kgj5opygynhWxEmsdLqJ6hIKY2yZTu3qgk7h
6EhZX0iPrxgK55EpdFWfV7jbgMy6OXqu4/orleNcXop3AOwSgq9ple8T300sTLdJ3pFr13Vs
eNfRRttsRxgUgWviwWoOwVIXF1nqqFsiOBuI+BaL2Chz7TLS0F2letLJDGXZ4bJaYbrO6gzX
vEy2YU1eqVjZ576j3qmU4e3xS9VRLPaHzHV9OBRVj/f0jkntssGxqq7YWOpthdOI3saRu1b4
cX9n79abbuu5XrzeZ0ykr3VVfcCbcc4gAsA5ceRdQZPBOlyZMeO6iS0xM2hCx7FMFUKo6wa2
1jMZsQWX0Uq1F3Bem5amfDDSR8f60lFLS6p92VeWXiI3setZxGq5J0OQRKzfi+6y7cLeiXCc
/96qATsM/Fztbb1kSkfsExZdEvf9ksA4M2PVxexcmYnpgfzw90CVM0H1g7t+nPg4COnF/Lbj
Tbb/Ulk6A3Cf2LGqWwBLrhbY2g8cfDJ+ogsKksMosq0AvCYtpywwFCWYKzeL9YHz1ay+GIPb
nuLQHfBDV53zC7ijrC3lvNtsgoODXmUH727hZk5lmW3ikzC1JQ/CcSvVwsbn5WeqmtHbhW7n
v1ed5/q2wthH5QsPHkBA4/QcB9vIMLlivDotuXQWTYxWtXIfT8WoXRjTzvV8i5yiHdlaC4SN
G+tKdmwDbBdP4emTKLSK8q6hUejEa+Llruwiz7PIjjsjoq7SmYcdGZS7NRWw+krDXlm2h+2b
imLzoSXVpItNKTjRZqxzkJnodnDrYJXkkFcMByJzL4gkrmtUYOtih14C8h2T3ccXUgGGi2Bo
bGDv7t8fufdp9dvhCs4TlKPNVl5IkQNcjYP/eakSJ/B0YpO1yiawoNbVRtlZE9Q2O8utFsTh
mK9vKOwAWY4fgXE4bFpmYijBL90PmbT5BalZ1mD1FRvWVPFCOxoCaADA8NUifg2Uy56GYYLQ
a+XUD/ti80EYckAkTtH+un+/f/h4esfcVDv1upbsz01K3FGNQTcaJvUJW+3g6EXbk+QhydCd
k6bRz1waUl1EwFHcZmQMmyFIrdix2WZonJ/debhRKec+EUV8qOqAt2Rmg2uk8kDn9xvnP1lF
r3mcWz0OVZezf3IkCalkmcz5Kqobi4KqCMuBEbYPuf2NSUmJp2KUfaleqZHx/fF0wE8egIuX
oNbnxOoNWxD9rVl72vn+XSOfjeuIrrqySV3f2k51zSErybOhE9sj7axhIxUmcCQW7vjmIR5b
AczTVCWgtgex07K2AE8hZZx6Y6A8fJQCvGPpypMVJ0fcmgZsuF1geURi2kP+9//mhmQvf769
P3/89e2H0hYmFq8PG3XXfSQ3+dZaA4Fn6AfSipuqMEkocG6fO3buax7C/Op3cH0fXEV/+vb2
4+Plf1dP335/enx8erz6beD69e31V/Ah/VltTc5aPW6FK/UtSggEzC+QjK5ylp4rSXny9OR6
2CkJuilJUxd6AtJg2gYgh/G4TuFnfblWsfbG79WhRyvSldpwFOvhv6c7l2yevN6/QP/+xsYE
69r7x/vvfPKYbrW8o6oDnEMcLdoPZ6n3mGbCm2E6aklktq4zLcGab3vYHLrt8e7uwixQ+9Dr
qv0tGATGfD18/MXaNbdUGkjqKNnSSl45rWNT6es6UwNWTcTBEcfSI+I6jSrAZzpMI3OoAmL1
aZGE0pSfLw2CvNhToMxXEsal+aySZ9WnwRwUaaNE4qDqH4rYExojrTTH2Zn88gxOQ9L1NZYB
yL85y0YJyt/Q6TKjuNXS0DETUyIDd17z0C832jorQaZP4YwNAmMqanig6e3dEFNN17CKvD38
RwfKV35DuNndMt2Vv0exLzt4qAjc5fnyT7uM8HuRH2+sm5+u2GBlc/GR31JhE5Tn+uNfsteV
WdhU92qfdy3ypssAXIxnDqo9kf1lJH5GnyLOqCngN7wIAUhKH4zYoWzc1XKoV0b92MMV8ImF
YNd+RpTkjedTJ1ErCghlfSvHEZrovRs6PUJnBrPqBTgWkfVxHHmYTTyyNFnNphGWuL1JnHAh
5SEvazmu0EivD/lun11nLZZp+fXIpPqmrY6YlIHRqzySNBD4besGggOKN6ykkMWHrXZePCap
2q+Do7f2cS0LIDdx+MMAal7S5QGZyl1jnGl1Gi7Lfrv//p0t7bwIQ17zdHHQ9+P9valiHBFW
na1ms+u7mqo4M4sNHYUc3nbww3GxISC3DvG6F3Br9u5lV58LvTs2SUTjXqeW+zvXi41KM5Ui
6Xtsl0V8hYxkYeGxQXPYHLUsIfq/fJ+dEydNQelPUly2+U5eHhe+0qS6cerTP9+Z4NN0CpGr
8FqzVT0r9o3R3Osz615MFEgjycHGl9ebXSfoFsdpYafnWRr6ZtKBvpx0m4TGZ+yaKvcS19E1
Da2rxETYFp/qQosPtmBoq7vD3joVNkUaxi45n7RqiqNEjBjqRKb2Gd0jtF9boXXjp4Gv5VM3
SRxGIfqRLHJXwkP9m0+yWCa2ediFiV7yuA+qfCbdIW34eLClmUQYOYnMUcKBFN2wE/hX0hu5
iUMZk5imysYOMjiEGy1TgZFBM6RCULU3D/mNHIiDX5jmGbi//t/zoAiT+x8fijQ+u4P+eCmo
F6SOnF5GZLd8GXHPBANUcTnT6bWiqCM1k2tMX+7/+6RWVijoEJ9N2eiZEIrv8Ew4tMUJlapJ
QILmKSB+LRmu/q9l7/q27CNr9uouOMqDqyFKLr5jKdl3bYCtrr5/ydvcWl8fE/0yh6KhyUCc
WCoZJ66tuKREj25UFjdGRtYwgiQNjAdlzU7oM0Ycg8tP6sWkmYyouwiTvl2hY/x9rAx9fU5m
rbvcS2VJLoOki4QXM1oKUgDKJ9SIT7IJ0mG7Rerdlvz+PgRDkjbNRTIUg1tXBIdEyRD2qr7F
qUiQXhndnQm609kUmWBUxhmX2Txe3RHz0B3wMd1A5dE0jLzAAr6G4cWWdgf1JdlkHRODt5cs
75I0CJUYdSMGcwF1w5cZ5Fmk0F0L3TPpdCPHERrqrhBHzs1XL+7VQzgNsjia6Vy74itSP01j
GengqhI7gYMVO2DYVFRYPHk9HttY0QYSmwBLkqSObwKg4nixSden+pwRs/1sT/KNeXZ+FGKD
ZGQoyiFkJrQkiMIIL0koUYtFCaYUO8UcWdgXCtwQ6SwOyIqBDHgh0ikAxH6I1ZZBTDnDBvc0
/sjGD5BMhQKH1YMjnhtjw+Q6O16XQpIGLtpFI2fbhY6/1EFtxyYs2qhjTl3HwYYil0TSNhv8
eTkpoeM5adhTFIa6uK16/8EsMtN6ni5WFnHgSiNYoScYnYCbp7JLqEAh2jsqT4Q0UeVILSXL
CogEpJ46u2eoY81YvFjKOSztYVCEfQ6FI3awKgEQIgBb9zF+mjMDB68FbUo03s3E0PUNmrKg
uM00464oU6dzMcrakFswpF3bOPTjkJrA4BeG53Zdh25CCQp4DgqwFS1DyR5C5Vs2stf7iOyq
XeT6yIf4kgce1pdsiW5db7E7IU6S8gjVBGA7eBPIRQqmkascMZKvAPQjUgVGRaTEwUQ1MgIA
8FzkM3PAQ3uIQ8Hy7Oc8qEqiciBVgqUrctTNAQVz04VsOUeEiDMAUqRv4RY2Ojk44CPiiQMB
Mgo5ECJjjQOWwn03TlGJRvLGZ/J3sZu7PLJ49UzdTCJsiZrh2Ee/MYkXRyqJsWFKYqTja5Kg
7YPLk4tFJOgQYPR4MRnem4xuc/qZGJarwwwrP7BkHXoBppapHMgs23e52JmoqBoAfcTzjunt
6CwEKEWN3ImjyUmsquCTkIPtyhSrcqPfFpySWG6kyYu2hy2Em7K+NFtEWlYbcsm32wZZS6o9
bY5M625og1amav3Q85a6nHEkToSoO1Xb0FAEyDCzpXWUsFVs8VN6zFCLUIHppej4FwBEG4T3
mbDPzFj8BJPCgyxEmsEQz4kxkS5kCj55AAsC1NdTYkmiBGlH05dM9qKTi+nTAbOslhQoxhL6
kXr5aMSOeZHir2TJHJ6DSNa7mlUJodNd56I9wIDFccNw/x80vxwdMiVTewLU2VPi8FwHlbIM
is6es1gfQvMgJm6KrDe06yg6BCghEb6AMuXM9ZIicbHduJmJMus/QdOzGicri1K1zzxnaY0G
hr7HZn3me9hS3OUxMgW6HclDfDySxkWtK4UB/SQcSZYXXdIEi98MGNBmkCZ00VLPiR/HPhrD
WuJI3MKWOHXxu7YKj7dkXHAO36w0p6NjSSCgdlvP/CXWmokk/f1tlCtC40ZPPNqBCV895aDp
A0G8F0TV6/EjVvLHtPf57bRByezpOru9ECrH9R/Zjd1Bg+OAuyqNMAQlE0/OtRUaSnRkVN6z
7Mrmcq6o6hGPMG6zqhUxaxcrob/eKS79fjrJsA2++Kz4mM5eK4RxsZ3AsMn21/y/1TI/2azP
NifngeOHVEgrivLEX9O0jkH5RUcN0j0ZxpPPpeKYRR55UmnzjjQ85Fgc0HkDF66MJ5GpfN0f
WIYwz+oh3AYixUuJ5x0wBhiud+Tvl4/nP/5+feCRdI3AnWM7t0aYym2Bbm5zOvVjFxO1I+jJ
hx3w1sUcNkfNKOu8JHZ40bbs+J3lbV32+YFo1ePQrs7lrQ0AeHAIR17LOFU6Z1dr0TeeY2x8
KywE3JAzFObtg0HgYw4gEyrvi0OOwyaPGv5hpIcmLULSR77eFEZ10UdQOSjcBORm5a7f6/00
EI2IGQzaVczCdnmj0L5g6tilyWiVY5oXgCxP4ZIrZWq66QI1SRpmoeK74TOOb3dMeOTgntri
k/ZuEMaYVTHAfOZrfWN4OsxU2YtgpqbGN+L0JMC6aICT1ImRVElq2dyd8HShNQxNtAp2kZ+a
BZX7reduiH0ynCoIjgleppbS2rI76tky25ZZaOjGPE/Cd+3V+hmuIpx4k6in+5y4D7sIVZ4B
pcZbiJxaBXHUYwAJ5VvVE0kP5AL0m9uEDSJPrw+YB2j3ZZs+dBbl3egJI8LWdeT54f3t6eXp
4eP97fX54ceVCPVUjfHZpBBms+IGLKY4GyPbfT5PpV6jo5rS0A7Cbvt+2MOVS2bFWBo1eRsp
ieEsLsGV+iHvmmBBBPhw0nyL4OzIdeRjL3HOpFrGC/cheYmGb9FMTR2Eqh1WjbVm7UIXAwnX
3KykHG2jGPNwmugpesYiwR5Se0Y11x+GMLHrK1Z1d66ZMW0OW5khcoIFBsj5XLte7C+N/Zr4
oS4EDC8wTtSctnhiaZdfXtyF8x1KNFuf0yCu5ftQvOIkdB1jjgPV2uvcV8wYG5xq+74MDBxH
L1k1q2YatjoDEjqWA/ypfK1x4gJvEbtJbwytEWOKilW2dqAM6OJycOAeSC3352rmy7yj+9yS
ajolNvfnJpL+rtIMbKu+ZAvVoe6UE6GZYXgWmEd4Pyo3E2YesFu42bLIxRSNa21aziBo0EmE
r9oqF+jZa2xF6Ke4vJSY9pktFIHEZPN+mllMHVrCpuGCQIiSLX0wIzwOzhKiX1tTgzXEtyCe
ugZoGGbGSOMo24d+qHoLzKjF9X5mqGid+g7aGNjU9mI3wzBElEkgW0tjF68Qx5a7lzvAoJ+O
L0uWlg5L1nLOQlSjWTMoiiM8b1DE2cK2mLepjetYaMOSKEitBSdRhJsYKhfTxz/DZQn8pHGh
K4DeHHl107EUHenCrHDQ+TGadEY4BYUjRk/+VJ4ktRTQuOwT4BgzM1zLgBXej8uljlaKgeg6
oIRsj3elcgIhYackcSKLSOBggq3qGk+K5v0VIjap1/Nm0DBnJGgwakxgNIuQulKPNJmDb/qr
XHRFytGQJHGE9jFm4Uhofc1UI/SMSGLSVQQJYpk7ESoDGZR4ASqo4NDKjXx0sEl2AFJfQD0f
dYBQmdhQRj/UaEDYswf74RPZ4+OHY669ZYPBgWNCCcExYQDgVebq/sooOlnPEmYeayQrhSXA
Z6Wumra6yd7m6quldaV6tbdwPTc/FExlw+uZD8En0PitZVFl4wO9o/HN1dNvT4/P91cPb+9I
+HaRKs8ID5U/JVZQEZH10p1sDEV1XcFDR3aONivghgwO0qKVoFl7F1Ur8xHErTLBdYA3nesa
jfNxqorycFGCrgvSKag9jKYbJgKBp9C4so7WQ/AInZ1Ue5B72f4a/VLFaWOsYkCzvH3Loaxn
5WdNB5H63UiGhndVRKFUz7Mo4QYuLfkFXKaUUXAlw1sA7Me6NNs43KaEQWRuuvPuhwBa2sg7
P/3+cP8Ni/sCzKK38jpDXxzk0chokyub9kAkYeTg+gmvQXdyIkt8bp5lnVg0palAeJT16woL
I5QLhQiepspweTTzFF1ONS9fhKvsDgSXBjMPRFtpqrU6fSnhSuaXNa7ac5xwk+OHvjPfDStT
fyLdZIIQbrhJODORzCLuJJY2jX3XWctpf04sm+Uzz+EUql5+OI8l3JXGc1nLiVnenkXvVphi
f2FcS1zu2qCiZWBRpySefcpq5eFWuM621p+UfeIev+2sMa2NPPgvtJyW6FyrTeRc+J6FzoU/
36RzrfYWcEWfqZcbrnf913S98sCD79ArTP76J+xuHHdtvDMm1/VXKwUiOFn9hsd9U+sRSAyu
LnLXhCN/+XeV58iWzZs1rlMS+mtT8JQ7vrfWm0w/y/DoZTNPX7X88ZK8WpOgd7m/sKI1Z3wA
DMsrW4TsTbpr/ShYyJt98HO5WWoL9Twktl/2ev/y9udVd+KXhJH1X1SuObUMx6snOHYF41nA
WfJTRSuL/4zg4aM2gk19ojnaSHX97fH5z+eP+5fVOmdHJ7HMXcHQkUizJIdHPdfy57qXGnRI
RS4nSVMdadk2dfwQoe9vqfwc30Q/Rpqb5YTcsYrj69TIkpfM7MSszpGhzN0owTIHvQsz3ke8
JqUXygFxR4D0teu6dItlyn4yu34h17vC9TVfXEJF0vZkSbfxcm/w02jUhyswVN+6B56MimMW
SQf+Bb77T/fKUPt5eaCVxEvUqSmOUt/++OBhpB6f/uAvt77fPz6/2bLi37VqaYOHWQR4l+U3
LXaFlllBU/gR84WwQbyY4U+GaWLcNpoZWL6EtQ7u2w7ZWvmkR+JtVhRSxflrM6tSx80eFfYw
PIJL8t8oM1LHCGaSjSOM18n8kg12YdZWQWxZZGeGhbWMtDYnET7I6AaXgkPeu6zFFzcJt68C
N2W5x487AW2ztmRy077Ekiy17d7x0rsyC+PIEh1W1C/L4tiJ8BDVYybbKIks+9KcQxzLGl/X
fFgQGJN/rrZksGSvfqLd1e/3P54ef15+kXApoTotupOI2CaPk+E1JGaotQSiBNo2KTbHraft
Gc10ZLeC09lcOjT67BQpCPdCtEuxBfmmREgTxv/968Pzy8v9/BTt1U8ff7+yn7+whrz+eINf
nr0H9tf351+u/nh/e/1g/fnjZ+WV42GXasOEMI8wSctasyOV3qzaYTNmCgZUvj68PfJCH5/G
34bieWS0Nx6n76+nl+9P4iHwKVhc9jdIyznV9/c3eCF8TPjt+R/NCWX8oNmxsIT1HjiKLA4s
2uPEkSYBPskHjhJemLMo9BKLJUiP4CC08QOLLBmENvV9iy0zMjC7FlfzZ4ba93BbfKhoffI9
J6tyz8ctw0GBKzLXD5a67UySOF6qDDD4uBE+bOc1XkxJg0vnQUc8/D9nT9bcOM7jX/HTVk9t
zY4tX/JuzYOsw9ZEV0T56heVJ+3udk0Spxz3903vr1+AlGQeoDK1L6kYAA+RIAiCIJAd6mUV
1RqZSOIdsI5jTNYA4TXTIk9xou35y+nSU84LtvORS+8IgmJZuRYzRYef0gfXDj/rwz+woS05
SMNKoLRt57NZHw3Kbs1/hKToG/1qW0xHkw8pLDEFOor50GJAaSh2jjukt6GWYLEY9k0IJ+gb
USToHYttsR9rr38lZkEJdFQEFMlu89G8b6z8vTPV5IzUxum1t+ZefuAUbt9a5ExtSespU3xU
x3jSNw+cYtFL8eC6/Sy3Zq5DHNP848vpemw2E7tynm+dWa8oR4Jp3+LNtzNbkIyWYDpb9I1T
vp3PLZaIjuCjTs5nvZOFTXxQw6K/iS2bzZy+RZdWi3RkMWl2FNVo1LeygWI7/KiObX8rrByO
h4U/7vuY8o/pJBsZPJMAs0i3IhwWPR/fv0v8I63A8wsoHf86oU7Z6Sb6rlgEMKzjUd8GK2hc
U+PlKs5voq2nCzQG+g06plnawv1rPnXWxMEoKAdcuTOL4sEK34hqK7nLVn8CHfH1dPnxrith
5jKcj3tlbjp15ou+SbH5B/8/9UTx5UVsdrz1O9Zx6jVYtcm4f5341h/vt8vL+X9PePwXerJ+
bcbpMc52Ib+gkXGgN45cR/HVV7Gus+hDynEjzXrnIyt24bpzC5If6WwlOdJSMq2coeagqWFJ
rwaDaNxThWPRejSykcVbQCbDLNWWDV0m2xt3KSSRmslMxU2suHSfQEE5JoqJnRsX6g3Wn0yY
KweQUrC4gjUHboNBaEduiSzyh0pCTAPn9OAsPWuatpQM7YMV+aD82AbSdUuGxlnLYFUbb6Fk
sVNXqDOaWpg6rhajsZWpS1A0qMOtNovj4aiM6Pof01EwgtGaWMaD45fwYUpUT0r4yFLp/TSA
E/8gas/o7S7F/UXebyAfj9cvg0/vxxtI8/Pt9Mv9OH8XYmgzYNVy6C4kh8kG2LydV8y2eDm0
GP5tseVxrG4FBuAMThh/U9CRXj8uB8Jqqn3TEw+l/p+D2+kKu+PtekZrrPx1Sp1BuadibCKq
laG+EwRa/+Jmacmdy1x3MneMPnOwuZED7ldmnQClCtD5J7QXf4dVgzPydquxRa1C7OcEpm9M
+YDdsQtjeqfrkc080U6wQ4ZpbnlGWdldEZO7OE+YlAuT5XATHJIuoe0MDpW3Mm0ZJXwQArch
G+1lp1VO2UiAYDQkmuZIMTm0knNvjPI4E3V41EISldqmR2DnalcFG+iDBnyqbsi8UQYbmo2d
AqYnTeXctHRnnrVDYpjnXQhg5O1q8Mm6AOUeFqCH6L1GmNFr+EBnTnpx3rHaFRpn2LEGhAUf
6HUns8nctd1gia+bGB3K9pV+Gaiuv6nWMi6r8dRYqUG8xCG3pISTKagnMw1+jnjtQwW0MKAL
ipnFR9oWb+iPqKU7ns3NaQoc2BMpN70OPRkpiUXaW7U6MjzmxB0fOrnlASlC/Ube94hPXNmu
ld/FhzvGXtPAbZJFCK55y/FexaAn2eV6+z7wXk7X89Px9beHy/V0fB1U92Xwm8/3pqDa9vQX
+MoZWq6bEJ+X05FjOe62+JHFWM1vAfx0PLXovXwxrIJqrDmVmGht90tWsCPqHILLb6gJd2/j
Th1jlxTQGgbG0mpDsJ0kRBujTvLELPjnomfhjIy14dqEnzM0z9C8NXUT/4+Pu6CymY9vjajX
MJ3yMBl3GS9aPwOp7sHl9flnowH+ViSJ+o0AoHY0+FCQ10Mrih85xWE59Nu0PK3BY/D1chXq
i9oWCNbxYn/4Q2OMbLl2dGZB2MKAFfp8cJjBK/goaWLxnurwljhDd7xtYeOB2xDRyYq5q8Te
JMeTuTV4ldUSTidjfbgDbzabaopvvHemw+lWBfKjjWPoTtw5RFNY1nm5YWPPWF7MzyuHupXk
hcIkzLrn3P7l5eXyKj20/hRm06HjjH6R8jOZfsKtcB8a2lzRuUtUl8vzOyYwAk46PV/eBq+n
f9tWZ7BJ00O7I6iHHuNswytfXY9v3/Gh+N0F/j4GpSXdJHoOFOiCbhraoIhsIW66IIMFnV8M
PomLR/9StBeOv8CP16/nbz+uR3w3qtTwjwoIO+P1+HIa/Pnj61cY8cA0V0eaytC0QBbj5ZbH
p7+ez9++30BOJX6gp/TsJgBwwne7eY5wn1HESGlruq5gRHOenk0pR3bvo060dMaEtn1g+SZT
o1llpnKwjgPzu9ZKMOQ4uAcnr8owW1VruVbAl96OWDMbUY1M2Kb0Mc2sb6cnlNLYHWPNYEFv
UoVyTmoO88vNXm+BA+uIjhbFCYoioT09OJaRIRg5alOGcggiPjBh8hBnKsxfh2V50Pvlr2P4
RbsgcXxeMo9MQi+wG+UJKcJSz/cSORo/J+Q2EQ0mvC5UIEzaKs9KERSqW+ctDAZQJQ9TZsKS
0NdSuyL080NI+aOJ6U+Xcakx1yqSUzshBCpoU5ArVT8cyCSzgNl5SZUXOv02Dnfock0dCHjL
h7KNHaWUi9Gly1ImrkK1s394y1Ib8GoXZ2sv0z8qw+Rpldlc4vNQWZYGk1AbL9iF8m2uwfJV
bC6QFoo/CmV0OgyZOAKx5SZdJmHhBY4y74haLSZDA7hbh2HS8Ijydam3iv003zDbiKYwd2We
6cx9iEBCGixQhoJJresojf0yZ3lEWRs5Psd8xaG2bDAddaylvUd4VsV6D/JS86KWcIWXYeyw
JC8VySeB6QHnZcPKSw5yqjAOBakB0l/vRAPGfcZWXUsRBoyssvZjTaDAhoWvxzIloB9HlHHq
aR0DYQXjoPeLeSnbkNEFORb9IdHhW6uqCr3UAAE3wVYRal1pXOYNtkhjK0esMGO9x2IqaRev
MvXK6o/80NTbbpYS1JB8VawvQJA+LNRXarWGBW8IyGqNKZFF7iVLlza4pdYFG+tld3Gc5pVt
Je3jLNX69Tksc33AWpidFz8fAthH9TUpAkTW682ShPvwVfhkmv8ytuWkYKSaQ+38XeItVTvp
KuQuuzHtWSs43FR02uqWF4CCPnm7POFZTdc1uC/oUppH7t2J0kvWsD+oTCdTcsHzPLiU1sVT
Tjcqk5wzV6bt0tDLtUo9zdd+XC/hR5iBGoA5LJivfotO0URJ1CmSuKqSsCFS8cbrVe4Vzx8W
yLPOPdrDAANyUvIA0ZukiJs09UpVWabF5+Iu3CVuZB6r1746PRpZloHe64d1Fu7aV8LtwUq9
lcfZubzhMUKb/zYmZxGWLGbahxrPTOWRq1b6CACo3q1BVCZQE8mwLdUy4WcDVuECswwY0kUs
JYaZ8XHmiU/YUn8kLA8PuppuQBBngQjI+ruj1kU9D+F8fHm/4eGrPdkG1MrxZ/P9cGjMUL1H
lqKh1CmJv6JoithGYr9xRsN1YdaKeYRGs72JiGD0oIyJyMnetdC6KHxM5boMjbnVKBJKLhOE
1noY+fJFrcHIhcqXZOKORs0nKFV3CBgWKrwNd2530cKymJtD0PTJBPInCU2CsI5DxBF64D8f
34mM4PyZVhlnSrJsBO4C7WOqtPNzzmCv+++BeIWVg94Xwin4DW0Zg8vrgPkshuP7bbBMHnCl
1ywYvBx/tle4x+f3y+DP0+D1dPpy+vI/A8wGLde0Pj2/cRvdCwYEOL9+vbQl8WPil+O38+s3
ybYhr5HAd2UzE2f9IGNjAlSvvGAV6tKSY9Y5q/QJS/kQByV1ZOHiZ+drrSCES1K9Ko7ANqxi
h1OI/vU0VwcYXKvMk262i+fjDUbuZbB6/tFGGGyfkGiiFMvD0uh8e/T2KZMuH6F1DLt46Gnj
1kCJRdShNoH9MSjPMTYzPR5xxrHzEtsq5TaMzQmPVSym7ikk24dpPHMM+ZbGZOomLqSDTSXn
EedsG25ZuFJhSbjKKzUHHgfr67h9duEf5v5MZ9JDm7dTHqfgrvLIErQKYjj1e/Tpi/ccjSsB
DDPsLFaixP6mvio92Lu3MRypbSGjef/ynVeWcU7pz7ya0FxZ4RqzJnLJFcX7amOJbijYBE10
0c5KcIDSlBmbt/OZD9Xe0cTmhj/Hc6ajvS5QGagT8M94OhzTmMlMzovHhxBfzcIYc1czXUXx
117OHvgRt2PT4vvP9/MT6NnJ8Sdll+bieS2dirPmbd/eD+OtPpY8GdR2aXm6XHnrba4/4zTW
4Vh/MCUpzZbeyp3txKraMQ41Q3dYSOpI0+AaJH4aWsN2vzsEttlB6myTgvYaRfgYzpGG+nQ9
v30/XaH7d31JHemIJZwZjAXWqCgbMvoq70KJSLXT7QauQou9p7g98t1l25RW9xyAjm2KFssK
7SVWC4WauDpiVIedscn1JRQSXVB3EnL3wGF61FrOwspx5sbINeA6SHuCY4jpExnZbRsev09p
NSmZJclZVdfkEk5BRc4UEyH/ju5cpx5z4N/I/vofj+kffEtP6QgOQWjb7CFZtQqZjdeobsNx
xv4avjoUoY1zUYGo2S6uVLtuagtOHaaYWoKytOHJTjVr8QMQv1FRjJwdtOa2RLIdTrQsUeBn
uEeudyg/s1VomhCA1BScvLyXjYfOdOEZrS/9dDa2PJW/E0wpfxKO5lF0h9qHcqBjtCUi7vbU
pGRU64ALOYIkh3ZpjGVg4XsLqtUGboufyWnUw7xoGaNIT8xvADAZU7TBTqc88qFua+iwlvvs
O94+PoCdGeNTuFP17XwLdkkX7fuIqFHrZLgxUibVjIw4zdFNxGBMvbLRF0CXmkCtsQvMZqtz
GThaBjTxldV4SiZsEyzfZYFQWEeEntSgle9hpD0dmvjTheZ3Jyrpy57bsfr0bzs+ZuNRlIxH
C+s4NhQiSZK2uvmp8M/n8+tfn0YiQEG5WnI8VPbj9Qsedkyr5eDT3eT7iyYflqivpcaHmpm+
lWFI9qWs8XMgxjHWx5HHVreuClzic1KWVdfzt2+mMGsMSTp3tfalKk7NLjS4HEToOq+MTrT4
tKLUDIVkHXpltQy9ytJEd4NubcQvqEDzCokHW+M2rg7WOvqkWUvTmgn5oPNBPb/d0HHtfXAT
I3vnl+x0+3p+vuF7Ge6/MPiEE3A7Xr+dbjqzdAMNZyEWh5ltJESwQusnFB598akR4cW+yTXd
QFlffHu+H2LaGlCmKuq6Nww8vwapg7ZS5pfynQFHGVbksvJRhVIBmPpt5o5cE2Ps9ghc+1UO
i4rsMOIBV+VrWuFAvD2sIWKzLSglxkoCzODcegEplgMsA/pVhM1GlFdBRyBiMpoF0aq1iUOe
5chSHuMHNEfA7noBu2QoKi2xt1xOP4fq1dIdF+afqbxyd4K9O9yTRa1hyBuCgMGRb04VFZja
B1bflBQvyYTzia2K+aTeBZQhSyKaqSeHFrM+pO6UzOLaUmB+2YUS7vSOaFK8UIiFSzXXhoXu
ac9IjdIh2NQf03HBG4qYJSNHCUGsIOR8ThpmZmL2AJ+aYJ7dVAmrKyPU+O0yZmzFWBEugUgn
o8qlJoPDkQ1M3PJx7DwQbeiBp9s1RaTokHA9gXbbiRIhonsmioG+vpAzcLeIKB0rCbW7KmHx
jWj41B2R3AIlHDLUe0MQpnByIbi33AKcZkAMmd37WdOUKscCWORmiAh8SmqVV3gl6mXoOBC3
8g3p8dmqKecIoQDHmL6VAvzljKxfv/CJlSIwIl+hYcTolbt+mhNsBjLJcWcWkTalY31LBFNi
caCYczFpZBonB0vNM0sEA4WkbyMAgrmjZsCVUZOP65+7bh9j8lqICQiYM5GtoR1cy8umwAkJ
ZqSZaNm0ehjNK48Qn+nErVxCRCJ8TI4EYiwBEDoSls6cSR+TLh8naiaAlhOLqT8kFz2yKBkW
vcF3mWiMkp8P2WNaGGv08vorKtW97N14dlK1NgHSenoUVfCflt+pGyGR76B3FFm2telXvAo9
7UA7hHMRGa/zhGUi5AX5oQHmDWzdCboe3KGWeNFokAz0S0SPHTK/rvZ1mPGkpWhxysLkbh67
1w4kqzgLVViX8UaUYyo2l7yVvKTCiOYpWwFGItvV3j5GasmWjOZWhQoBoQJBc2GC10OenDGb
p0pYI7ROV6lyMrujiPmBXmAPNPtyA5VrYVFdBERCTIT5z2eMTCZvAN3w2qzBAEedmapvuYlM
rxBeXxSrN5hsx+G0ebWpifhmjqhZmETYBSbbmbXmpQ/a7Psu1eCoF1Lng42aABV+wjCKtRqX
lvDeQBNgVEKTRqLgjJEsfTgn+6nehIJEw/x+OiJterw/5Ub2TIYm6+WhQJNt6mXeKlQcyZDt
eyIhIlo2NIrfmARxo9cC4CXGhCOtLw1BnBWbyqwtpZoAIGzw6NsYmk5HT9fL++XrbbD++Xa6
/rodfPtxer8pfm1tEq0PSNtWV2V4UNymGkAdMuV4wyoPZAd9oF3lSRDFqlG8QfnJAx48YXQe
NtKzyDWm/gIczFlYePKKFaYnxP2uvo7xny9Pf4mHFv++XP+6L6h7CWI3QuiaBZTpXypn5tZR
kYuJOyVxWoIWCcPi6XiibKkackrpYyrNaGIvP6GDAKlEc2rrlkj8wA/nQ/qzEbdwppYe+Px1
VO3TGcXkXljzzCD2MS/jR7J5OdcVVa84a/V/3ta3db/JVPZR55vUE6lut2ofR9Gcea9qvYMj
RoZ5qY3tQRRilx9XJe/yvW4KL11peXGyzOkPiOEDNlSCD2FjOr1cbieM00ied0L0CS7KnA4C
RBQWlb69vH8jFLoClAVJV8Kfd9F6r1UpLckcfHW0i1XvCnFyg/59Yj/fb6eXQQ4z8P389svg
HQ3pX89Pkj+heC/28nz5BmB28amRptCiHFR4+mItZmLFg6/r5fjl6fJiK0fihYfavvgtup5O
70/H59Pg8XKNH7VKZOWq8DTtCiH4YMh/ADmtopawARqOLAqi9oqYWEz81lwqTIGxqA0FuwaT
dNDHTez7hhb6GDaut90YfTQSwkL+X+neNsgGjiMffxyfYeStU0PiZXYERTA2eHF/fj6//k3P
lPAPAEG0kT+PKtH5sP8jzm7rL9I2rX27WzY/B6sLEL5e1NXdIGHD3jZudHWeBSFMF+1GJdMX
YYnOoh59+lIo0Y2MwQ6vHG4kgi6B5kcVge4Wb0P90wx34fso1OFWueQI95V/N66Ef9+eQF43
zqVEhmRBDjzswY5P7Z0NgXoJ3QBBTxiPZfPAHa4l52sQurmwBVcZxuaUB6/BlJW7mI+p009D
wNKpkmyvAbduVncExjcuD+qqxZMTaNi1H6nwOFLOT7HlEqfYmfcZqPVjUDfigUL5iF6WcsVw
Bo1iS+w5vZ6uGuCiB9XtvwzRNw9+NMmrdEwV33NWC5Pb+jBgP/5852vu3sPGCKF6si3hFPKA
GYLR46pB3UdgfWjtEyCM6UFSSNbUBYVMwuKwlB8EIo5PSbp308dOakrYFDSWBP4WcV/9xd6r
HTdLuVegXkWH3NhySfCGvKJY53BESYN0NrPER0bC3A+THHaCsAzIzF1Iw0/2wktR742EIq8g
kaYC/KhN59qwjDqrHTWKJl/OF5f6yhjCzzopLLd6nhmPwnv9cr2cvygWgywoc/1FUas0NOSd
tJOfwvE7Qe2nuO9TbFlN1mQREd3o0Ho3uF2PT+hvbiw6VknVww84feUVnl4FFxgIaLuuVAT3
aVNBoKWVTS7kXLNq3LHdVTytsXJTULUmx4z4ok48FStpdTT2qaIEsWAkgzOQ3N+QUnmgTnTi
CuQE0U1p2GLCz+Ed29Xe7PNFyZMNbgo6aR6vugxXsfwaLo9oOAcGUaKobA2sjlJq7+zQXrSR
ZbiinsXta6Y6E48uJIx4SKjtFRJCea4nwUV2ChXFtPfcHLYMoziivCFgC8/VZ8UszimPG5bE
6VJ9g4ggISes2Si5ayL8r+dX6458G/UxSQSc+7jxAphNxaimag4iYsQZVFQhZiSVZOslceBV
IXw27POl4mmDoJzF+9rzpRAA4R6PaxEzIfUST5C1SEhwH88YtDdExOQbWSgGW0h5KCqVq1i9
hW1NdVfpgD1OC3ea5SZOqhiUjXiVeej7Tkn1iGV5FUeSqAg6gDQrHMT1QbpRT1AQDTxu8kre
GdH7VADrnVdm4gh0Nx1zhM2V+zFKq3qrGGsEiLI08qr8SlmX+BIuYpPa4iAr0DZstMEYCdQg
5jDiiXeo1Q3gDsUX7HA69qs6IKM9UJResvNArEegG+U7S7UxnAmotSeR7GHu+HdZqkhDGKRc
TZMjNsnj03ctpArzPTi20haW/6vsWJbbxpH3/QpXTnvITEWy7NgHH0ASkhiRIsOHJfvCUmyN
R5VYdslyzWa/frsbBAkQDSV7SDnqbuKNfqHRUNRKT3vbvj++nP0F+63fbr2uUIB1xo4iYUDZ
TCLQb/sVs5DF0txtWtC2P6s0t4edAP3GZSpSFGtRVfaV5XomqyRg2wYSfho1YQGC0fKB4h9a
MZZK4w5AV05cqkMFjEqSqdGPjJ5M1WVpzkKMYbCuOiC0qiwdb29L9WU6LcdWYRrSPm/yyYGv
gG1IdbnBrK/H4yEGMpcpfyShCEvQPERxikIPvrfVGFKPl5fw2daMGGPpNug+ibmbkwqZ3Gfu
FwWGMZ5oV1EHMXc20DYK7z6CLF5Kt2SFy/F20iAyjiUs4/tT7VBEU3ELKhl0hJODhUjtRaEg
nmBL0D8HC0tBMK5SRk1wh98NkWgRV3ZKC7wEw+kzS/M0En7oMMmbD7u3l6uri+s/Rh9MND7z
nONtmsn5Z/vDDvP53Aobs3GeZxQsoqsLzi8wIBl7ar8y3QMDjK/FV/ab9AMc51gfkIxPfM7F
3gxIJt52XZwomItHG5Bcewq+Pr/0YS78Q3HtSb9oE024OBS7XXZQIOLiMsPF1nA3K6xvR1ZW
+SFqZKNEGcaxDdIVjXjwmAef8+AJD77gwZe+TvPvl5gUviHteuNp4Mg70CMumAcJFll81RR2
cQSrh0VhKADwG8HxXY0PJeixoV2agoMxUBcZgykyUVlJLDrMXREnie1M0biZkAnru+gIwKxc
uGXGId6PjRjEso4rF0z9ZVsHWvoiNh3xiKirqXF0WS/jUNmD/QG8AoFsKlIwZ+4pv1UXbcDq
a5YxpE5qtg/vh93xpxsIsZB3BnvHXySg7UuABC7k1xpPExw9UQsQlVwDpg3pwRKYWTIsaMvh
VDZMnyOjQVtaw8mBw68mmoPqIFWuL1N7lGGtLChQnsjVWBVxaHVFk/jMALD10BhSDhOWBG/q
0C1eWaAon8skZ/0M+jZB3ygzNCcp05sPeLr4+PLP/uPPzfPm44+XzePrbv/xbfPXFsrZPX7E
KPQnnLeP317/+qCmcrE97Lc/zv7eHB63e3THOFM6C/EaZz1D6xCGFqwkKbpz/HT7/HL4ebbb
7467zY/df/s0jZ05GNOJEdi6qA4xHWPL1/dY+nAEliq4KySfye8EPZhLvEOB/waU2CAr+cmj
3sH+oecDjQsfTDc1Kbqb7KshfXgHP5ga7Z+q7pxpuC97HRCWfqYnLTz8fD3iuzeH7dmLftrF
iL0gYujTzDoEtMBjFy5FxAJd0nIRxvnc9J4MEO4nc+vI0QC6pIV5UNrDWMJO+XQa7m2J8DV+
kecu9SLP3RKQI7qkfTwTC/d+0ERxSUGCOlzMpppNR+OrtE4cxLJOeKBbU05/HTD9YSa9rubA
bR14d0SsLP/3bz92D3983/48e6D1+IR5Sn86y7AohVNS5K4FGTIVhixhETFFAlO9leOLi9G1
bqB4P/693R93Dxt89lbuqZX4RtQ/O8xO/vb28rAjVLQ5bpxmh2HqTgUDC+cg/8T4U54ldyOV
Dtyw09pNNIsxCpy17dS+kV/tHAxdX+cC+I6VDFzFM1AgyvPLoxl0qlsUuCMZTgMXVrlrNWQW
oAzdb5Ni5cCyacB0IYfm+Du+rkrmGxDpq0Lk/s+Wc2O4B4ON+cyq2p0odDHc6rUxx4fLPMNn
hcxqTjWIV9XNP9m5W/XRv9qM5du3o1tZEZ6PmekicHObpyXTE8JyrVnPBR/vp/BBIhZy7E6m
grsTD/VUo09RPPVjfE1UYOJoDEecsdLAO6VpNGFgHN0FJuBy4TFsIzqA5eawSKOTexPxZkb/
Hjy+uOTLO2ej8/Ven4uRUxoC2bYDQlXjgC9GjGCei3MXmDKwCrSYIHMFbTUrRtduwatcVafU
D8qT4e4cId01BLDGTrGqEcs6iHmlW1MUoSecUi/bbDUMcB3S4BVasAC56IyOAm0YfbXaxbnL
DKHujERM56da7DoMbi7uBee809MjklKM3UWnhQ1TZOl7ib7DFznYYifqTCdMsZU8MXbVKpvG
zE5u4f2w6pBh/Uyjs3RAjUtsb3srZ+4zB3Y1cddncu+yCIDN3Q11X5LGowIkN/vHl+ez5fvz
t+3hbLbdbw+O/dMt1zJuwrxg3e+6E0Uw08HoDGbOCRaF4dghYTgZjQgH+CXGe94S42vyOweL
FYABMx1aED923w74zPnh5f242zPCMIkDdlsjvBUb3MUgl8o/akik1rVRko+ER3Wq3y/a0hOe
bg63lxGuJRTotPG9vBmdIjnVlxO6Yt/VXqU83ViPhJi7ChqGF1BMmRCpj+WZNEzzrCJ8J7cc
7RdmHZt48g/hoF6frjNeVnwcENvHdu/mfO5o7hNBW4WPu+Xo80XYhtqeLBZN1V8WWokkrjJ3
6Rk4l/NRzMjaU/9y3R2vna5aVCle+2JU0R7LWWg9Fpfhp4nwNESFl59uQymmch1K16ZFZBiC
wsJXn2J2+rCZrRNP5QbFiVgKUd6lqUQHIbkUMdOVe06+PRwx5BfMRvX8z9vuab85vh+2Zw9/
bx++7/ZP5p0yPPU10v62btC+Fw4FLT78382HD8Z5+2/UqnK+uOy8P88TvqCUIAZlEG9cGeOr
4yxBT1yG+V0zLSjgz9TlTZJELh2HX5gVEetgV25a86ENyvyMARdhmq/D+YwiaApp2R0hLAGQ
cRZodGlTuNZK2MRV3dhfnY8HPzvvub1+CJPEoQzu+PxeFolPVSUSUawEm9Rd4YN4WPXlhCce
qGjhZ4YM09Q5ZmVonCooO9EsqRDLKEuNkWCKBbWrYyZ9WQjF6LohHA/sUeOwtbp7JV0HUFDy
mJIRypUMah1LDcoeD+fbB2ogQ05gjn5936iwM+t3s7av9rdQCmj1xKu2JLFgp7jFCjtddg+t
5rXnfcSWpswFm1q4RQfhF6Zgz4zrHU7Occwv1ncfmHHUlFmSWTqECcXzGnN/Wjio1MQF5pVo
+EFhqxWG6AkzaobiBW9F0lSWLBBlmYUxMJVbCUNUCPPlD1HixSszgFeBMIYPo6VtuHUTekkN
VheuE/0okomj29AipwMgsznIzBAnoqhoquZyEpjngoiB7ieiwOjcOens5pTQlxgo7lGuylmi
JsQYF7papg6ejD2f16koF002ndLxjcG5k8zy1OHvUzs/TO5B/zD8RniJF5RTg4OneWwlcIIf
UzNHS0Yvu8xAspkXHLqM/zkGVVuHFR2qVnmommlSl3M6azxBlIaoRBgCFjseyTyzAqZRCNs8
vxW0jvy0T9i0fCfo62G3P36nTCWPz9s389zNCH+DJbtovJFILR5feWKPDEMVvY3P7yQgoZPu
tOOzl+JrHcvqZtLNCwWNMSV0FPq5AxUnZp6M3qVBBrKtkUUBJHwPVJJd+McesrXD6h2qzi2w
+7H947h7bvWZNyJ9UPADN7CqWjRo2Va1SRfSGl07ePeOi4UF3iIpKvUG9NYrc3XkwFIwxt/k
PYUUERUq7NcZ5gAH1QnaAmst4QIQMaYtBcsGSJJ4ael/qhulpDyuGC6YCis7xBBDzW2ypZ31
pU10nGFE/woPPHM3R555O/b3RpuGm1wiuwe9BaLtt/cnypof79+Oh/fnNi+DXmz4EBQqtYVx
e9gAdqeman5uPv1nxFHhq0CmdugmcqaL6rT5F7PIYmX4m5mDnlEEpViCPraMK5wSkVg2A2GZ
z9VXYIHNlqlm1/pxvt8ZIbsnGOMqnf5hsOiNfSjfFWZcqsPNLNcVPjVmSl5VBmK1bBgsjw6l
N0c7F1zgBtaRrZamMCFYnsX42JodxG1jmmWmRteXx8IiHiZAtlqcBV9kaB8PWYhTEssmnCp1
wVMMpbvkHdE24SorFr9BVoQ1cYXfIIWNCvtUX3T4ZT/smevdT7Qd2rUFgrQN77DX3C/gGPMM
E5MljfJs4YPew1Z3tF3wA/u81IAYw9GbMhTOYlUxJTWKJ4PjAbuOWhS+YEPce/jlbepC6LCt
1Q4G7QZk4XlTXOPzGZgkM85H0nGOllbl5XHq58HqQidFjjhbVfFoVCCHjM0YHozdn6orAe7Y
ucgwpKYuBLIrxwGpwEoXHDlBKz2zGVQ1j4v+HjMSnWUvr28fz5KXh+/vr0p6zDf7p4G3YQn8
HCO6s5wN/zfxeC+nln2MOlr/dQ71V7DsTasDX/3zIoMsq8hiMMmont+hadsw6juP5TfzeonP
HZTWGlSrv0MRB8lq2JBjY8/0VfWEuSdjq5d2ODKrr6ACgCIQZTNTCJ2eFhXxB7L+8Z3edTKk
Sh94xKDtdYCdXEiZK/av3E0Yg9BLvH+/ve72GJcArXh+P27/s4X/bI8Pf/75p5kBF29NUZEz
UsO7LLHmpZFb9hJVR0FloNnlZT9o3dWVXJuO/HY9t7k/nL3Kk69WCtOUsNNyYb+M29a1KmXK
LXKFpsYOLDaEgVkyrMwD1kl2E8l/EivnspVyyhwp2CZ4I2yQLqLvGWcJ/R9TaxlbVSHMZ5JJ
YYXON/USDyiBtytXkyOHlIyz+cx3pVM9bo6bM1SmHtDlaSZsUyMQ2467lr8On2OzF4GjhNOV
tthKik2id9lEohLozCzqvHtK1tp3nmba5YcF9H5ZgWLb5Y0CRYFT8Qaz1fvoQK/AdA8+bw3i
+ZlGDMoaslA6bjUe2WXTzHnKlV/1RSIzQYzV/uEEAKtSJknBGCO9i6KZA+tLlEirpM4QwDSD
RKN+80I11nzd1MLOCpHPeRpt7k4HC1UVQMAmJYUMTL4ws54ypjved2VIo4iUoMkuq6H4DtsP
VSk9Er/wcLypb+wXtaU60M/B5CqYXAtKHGLj9KJGEz4rQA/5ogxKQ69PeSLDczOl/vjLszpC
krGrh7VAB+4U08VSbd+OyG5QdoWYKmXztDVyKmpVbBFmt47SA7oNgNW8NLllASE9t7BhemAv
0JjhxNgn98kiMi/mU+IcOqMpraTmKqGOBQo0GyTO6u7jAN2X3l1suknt2bTcnwOcEhGXE5OZ
my2cy3VUp/mw3coVpjyHpYssQzOWgKALAFeZdd5IcHJl8ZHchA/iKhV8+g2Nh5WVcDExhK9r
88l6Aq0Hzl4CukoxgQs88ajI6zAYGCv0gkBxZOZwisEKgcY1gVyG81QUC6fr07hIQc5x+xe5
RZXY+7bXYuhMsEP5x6amdzx9I+OxQNQLjjINBUyOM7V0GBgPVwmQ21AADFtdEqP5halESTLi
ktSelezibV5f/tkeXh9Yx0YednHQK2IvBpOia+TKKAT1CHSwy4n5HSbPF5WyG634Vbqnifry
wOHb4r/AjmgSEcikmUq6NK/szfLXJJ007Dk45qUDa4I7S0zLuN0Anos6RmfQt47GSUPOe98p
wHrwEshanar4XDoKDcNbgqoa2O5D89OmyOjVT5/iZIW309CLIrkbDsYAQavQupeDBC2wAVUk
ryvldph8ur7kaChRZ+uZGF/Z45VXyNh4v7O73AZCiBU4/wNJQ9WFalgBAA==

--oyUTqETQ0mS9luUI--
