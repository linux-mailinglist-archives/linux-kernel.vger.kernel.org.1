Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F9297DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762484AbgJXRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 13:09:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:57343 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760048AbgJXRJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 13:09:57 -0400
IronPort-SDR: vYNy2sswPHoQdzR92qdqXvSU3j67JHgIpMDp4BoIRfBfSNX4UV6WXE4tgBVhzJTBWHhKVZKH+X
 MVp7w9u65Ffg==
X-IronPort-AV: E=McAfee;i="6000,8403,9784"; a="231977724"
X-IronPort-AV: E=Sophos;i="5.77,413,1596524400"; 
   d="gz'50?scan'50,208,50";a="231977724"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2020 10:09:53 -0700
IronPort-SDR: hoPXIeChtkMTjNI+eOTvb39jqEmVMFw5VZY0H2x0nW/lQsmeZwCpjj3m4Ybp7xbFJRHOaQKmfw
 EMEK4XRY6CXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,413,1596524400"; 
   d="gz'50?scan'50,208,50";a="322068097"
Received: from lkp-server01.sh.intel.com (HELO cda15bb6d7bd) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2020 10:09:50 -0700
Received: from kbuild by cda15bb6d7bd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kWN38-0000aC-7a; Sat, 24 Oct 2020 17:09:50 +0000
Date:   Sun, 25 Oct 2020 01:09:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/usb/host/fhci-hcd.c:59:16: sparse: sparse: cast to
 restricted __be16
Message-ID: <202010250157.qnrFo8l0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f11901ed723d1351843771c3a84b03a253bbf8b2
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   11 months ago
config: powerpc64-randconfig-s031-20201024 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-17-g2d3af347-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
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

vim +59 drivers/usb/host/fhci-hcd.c

236dd4d18f293e Anton Vorontsov           2009-01-10  33  
236dd4d18f293e Anton Vorontsov           2009-01-10  34  void fhci_start_sof_timer(struct fhci_hcd *fhci)
236dd4d18f293e Anton Vorontsov           2009-01-10  35  {
236dd4d18f293e Anton Vorontsov           2009-01-10  36  	fhci_dbg(fhci, "-> %s\n", __func__);
236dd4d18f293e Anton Vorontsov           2009-01-10  37  
236dd4d18f293e Anton Vorontsov           2009-01-10  38  	/* clear frame_n */
236dd4d18f293e Anton Vorontsov           2009-01-10 @39  	out_be16(&fhci->pram->frame_num, 0);
236dd4d18f293e Anton Vorontsov           2009-01-10  40  
cf61fdb944534f Guilherme Maciel Ferreira 2012-06-23  41  	out_be16(&fhci->regs->usb_ussft, 0);
cf61fdb944534f Guilherme Maciel Ferreira 2012-06-23  42  	setbits8(&fhci->regs->usb_usmod, USB_MODE_SFTE);
236dd4d18f293e Anton Vorontsov           2009-01-10  43  
236dd4d18f293e Anton Vorontsov           2009-01-10  44  	fhci_dbg(fhci, "<- %s\n", __func__);
236dd4d18f293e Anton Vorontsov           2009-01-10  45  }
236dd4d18f293e Anton Vorontsov           2009-01-10  46  
236dd4d18f293e Anton Vorontsov           2009-01-10  47  void fhci_stop_sof_timer(struct fhci_hcd *fhci)
236dd4d18f293e Anton Vorontsov           2009-01-10  48  {
236dd4d18f293e Anton Vorontsov           2009-01-10  49  	fhci_dbg(fhci, "-> %s\n", __func__);
236dd4d18f293e Anton Vorontsov           2009-01-10  50  
cf61fdb944534f Guilherme Maciel Ferreira 2012-06-23  51  	clrbits8(&fhci->regs->usb_usmod, USB_MODE_SFTE);
236dd4d18f293e Anton Vorontsov           2009-01-10  52  	gtm_stop_timer16(fhci->timer);
236dd4d18f293e Anton Vorontsov           2009-01-10  53  
236dd4d18f293e Anton Vorontsov           2009-01-10  54  	fhci_dbg(fhci, "<- %s\n", __func__);
236dd4d18f293e Anton Vorontsov           2009-01-10  55  }
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

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/4wXFn9ZOJuK3UD/A0OuRB2JOgIA

--cNdxnHkX5QqsyA0e--
