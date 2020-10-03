Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF34128259B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJCRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 13:32:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:58080 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgJCRcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 13:32:46 -0400
IronPort-SDR: xLM+qT6SXfBvI74TQvCFsduL+OCGue3MRwwUSay3e1vbL/pYEvHE8IQeEWiOi4ih4Ob4n4Bfb7
 0Hj69MRYNHBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="224850787"
X-IronPort-AV: E=Sophos;i="5.77,332,1596524400"; 
   d="gz'50?scan'50,208,50";a="224850787"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 10:32:36 -0700
IronPort-SDR: 8Z37QKl16SHqwP87VMF/PQbyFrm5JO8KomL0XgQUkVb+ov7aoCfd+Un/2HbAEs2hCG7Y0xDDpH
 rS6I/CUg4R6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,332,1596524400"; 
   d="gz'50?scan'50,208,50";a="309351677"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2020 10:32:33 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOlOa-0000B0-Gb; Sat, 03 Oct 2020 17:32:32 +0000
Date:   Sun, 4 Oct 2020 01:32:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/usb/host/fhci-hcd.c:59:16: sparse: sparse: cast to
 restricted __be16
Message-ID: <202010040114.SHKbAwWn-lkp@intel.com>
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

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3d45f8220d60a0b2aaaacf8fb2be4e6ffd9008e
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   10 months ago
config: powerpc-randconfig-s031-20201004 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-201-g24bdaac6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

	echo
	echo "sparse warnings: (new ones prefixed by >>)"
	echo
   drivers/usb/host/fhci-hcd.c:39:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:39:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:39:23: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:41:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:41:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:41:23: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:59:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:59:16: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:59:16: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/host/fhci-hcd.c:59:16: sparse: sparse: cast to restricted __be16
   drivers/usb/host/fhci-hcd.c:89:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:89:36: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:89:36: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:90:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:90:36: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:90:36: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:110:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:110:36: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:110:36: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:120:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:120:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:120:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:121:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:121:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:121:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:275:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:275:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:275:23: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:278:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:278:23: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:278:23: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:289:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:289:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:289:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:292:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:292:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:292:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:744:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:744:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:744:23: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c:745:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hcd.c:745:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hcd.c:745:23: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hcd.c: note: in included file:
   drivers/usb/host/fhci.h:448:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci.h:448:29: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci.h:448:29: sparse:     got restricted __be16 [noderef] <asn:2> *
--
   drivers/usb/host/fhci-hub.c:96:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hub.c:96:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hub.c:96:28: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/host/fhci-hub.c:101:42: sparse: sparse: invalid assignment: &=
>> drivers/usb/host/fhci-hub.c:101:42: sparse:    left side has type restricted __le16
>> drivers/usb/host/fhci-hub.c:101:42: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:102:42: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:102:42: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:102:42: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:122:42: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:122:42: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:122:42: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:123:42: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:123:42: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:123:42: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:161:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hub.c:161:29: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hub.c:161:29: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hub.c:162:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hub.c:162:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hub.c:162:23: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-hub.c:167:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-hub.c:167:23: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-hub.c:167:23: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/host/fhci-hub.c:187:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-hub.c:230:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:230:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:230:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:235:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:235:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:235:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:239:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:239:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:239:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:244:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:244:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:244:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:248:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:248:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:248:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:253:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:253:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:253:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:257:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:257:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:257:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:261:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:261:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:261:59: sparse:    right side has type int
>> drivers/usb/host/fhci-hub.c:274:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:274:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wHubStatus @@
>> drivers/usb/host/fhci-hub.c:274:21: sparse:     expected unsigned short [usertype] val
>> drivers/usb/host/fhci-hub.c:274:21: sparse:     got restricted __le16 [usertype] wHubStatus
>> drivers/usb/host/fhci-hub.c:274:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:274:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wHubChange @@
   drivers/usb/host/fhci-hub.c:276:21: sparse:     expected unsigned short [usertype] val
>> drivers/usb/host/fhci-hub.c:276:21: sparse:     got restricted __le16 [usertype] wHubChange
   drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wPortStatus @@
   drivers/usb/host/fhci-hub.c:281:21: sparse:     expected unsigned short [usertype] val
>> drivers/usb/host/fhci-hub.c:281:21: sparse:     got restricted __le16 [usertype] wPortStatus
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:283:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:283:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wPortChange @@
   drivers/usb/host/fhci-hub.c:283:21: sparse:     expected unsigned short [usertype] val
>> drivers/usb/host/fhci-hub.c:283:21: sparse:     got restricted __le16 [usertype] wPortChange
   drivers/usb/host/fhci-hub.c:283:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:283:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:299:59: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:299:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:299:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:304:59: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:304:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:304:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:309:59: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:309:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:309:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:312:59: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:312:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:312:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:314:59: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-hub.c:314:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:314:59: sparse:    right side has type int
   drivers/usb/host/fhci-hub.c:318:59: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-hub.c:318:59: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-hub.c:318:59: sparse:    right side has type int
--
   drivers/usb/host/fhci-sched.c:146:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:146:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:146:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:340:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:340:37: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:340:37: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:348:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:348:53: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:348:53: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/host/fhci-sched.c:404:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-sched.c:405:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-sched.c:406:41: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-sched.c:412:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:412:36: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:412:36: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:438:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:438:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:438:28: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/host/fhci-sched.c:440:42: sparse: sparse: invalid assignment: &=
>> drivers/usb/host/fhci-sched.c:440:42: sparse:    left side has type restricted __le16
>> drivers/usb/host/fhci-sched.c:440:42: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:441:42: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-sched.c:441:42: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-sched.c:441:42: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:472:50: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-sched.c:472:50: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-sched.c:472:50: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:475:50: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-sched.c:475:50: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-sched.c:475:50: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:490:50: sparse: sparse: invalid assignment: &=
   drivers/usb/host/fhci-sched.c:490:50: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-sched.c:490:50: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:492:50: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-sched.c:492:50: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-sched.c:492:50: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:494:50: sparse: sparse: invalid assignment: |=
   drivers/usb/host/fhci-sched.c:494:50: sparse:    left side has type restricted __le16
   drivers/usb/host/fhci-sched.c:494:50: sparse:    right side has type int
   drivers/usb/host/fhci-sched.c:553:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:553:37: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:553:37: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:554:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:554:37: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:554:37: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:557:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:557:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:557:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:571:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:571:44: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:571:44: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:609:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:609:44: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:609:44: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c: note: in included file:
   drivers/usb/host/fhci.h:448:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci.h:448:29: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci.h:448:29: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci.h:448:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci.h:448:29: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci.h:448:29: sparse:     got restricted __be16 [noderef] <asn:2> *
--
>> drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
>> drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse:     got int
   drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
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
>> drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     expected unsigned short [usertype]
>> drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     got restricted __le16 [usertype]
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
>> drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 const [usertype] @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     expected unsigned int [usertype] offset
>> drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     got restricted __be32 const [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:837:33: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:965:33: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:1491:25: sparse: sparse: non size-preserving integer to pointer cast
>> drivers/usb/gadget/udc/fsl_qe_udc.c:2071:28: sparse: sparse: context imbalance in 'setup_received_handle' - unexpected unlock

vim +59 drivers/usb/host/fhci-hcd.c

236dd4d18f293e Anton Vorontsov           2009-01-10  56  
236dd4d18f293e Anton Vorontsov           2009-01-10  57  u16 fhci_get_sof_timer_count(struct fhci_usb *usb)
236dd4d18f293e Anton Vorontsov           2009-01-10  58  {
cf61fdb944534f Guilherme Maciel Ferreira 2012-06-23 @59  	return be16_to_cpu(in_be16(&usb->fhci->regs->usb_ussft) / 12);
236dd4d18f293e Anton Vorontsov           2009-01-10  60  }
236dd4d18f293e Anton Vorontsov           2009-01-10  61  

:::::: The code at line 59 was first introduced by commit
:::::: cf61fdb944534ffa84a824bb8c31a3826cdc169d USB: FHCI: Reusing QUICC Engine USB Controller registers from immap_qe.h

:::::: TO: Guilherme Maciel Ferreira <guilherme.maciel.ferreira@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--
