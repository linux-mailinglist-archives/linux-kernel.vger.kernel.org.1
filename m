Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C852E2E44
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgLZNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 08:31:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:30771 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgLZNbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 08:31:43 -0500
IronPort-SDR: x1793CJ833a4p+GBgezCPbYwZKGFJyqROWlUotuRZkcIUslMcJ1+3OfcFg/Mi47AG/iQYyXj/T
 9EUpFF7LGu6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="194732506"
X-IronPort-AV: E=Sophos;i="5.78,450,1599548400"; 
   d="gz'50?scan'50,208,50";a="194732506"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2020 05:31:01 -0800
IronPort-SDR: 4qkWfZqzeSRQB9EIv/8k98KaYLkJCC/5kTgr3k6tTV3oNsDKMdtC+yAe5JpcoWDU0ls1F6uUCe
 7BoYfA+9MrMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,450,1599548400"; 
   d="gz'50?scan'50,208,50";a="394498784"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Dec 2020 05:30:59 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kt9es-00022D-R7; Sat, 26 Dec 2020 13:30:58 +0000
Date:   Sat, 26 Dec 2020 21:30:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/usb/host/fhci-hcd.c:59:16: sparse: sparse: cast to
 restricted __be16
Message-ID: <202012262146.t2jTAoa0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   40f78232f97344afbbeb5b0008615f17c4b93466
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   1 year, 1 month ago
config: powerpc-randconfig-s032-20201225 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

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
   drivers/usb/host/fhci-hub.c:187:34: sparse: sparse: restricted __le16 degrades to integer
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
   drivers/usb/host/fhci-hub.c:274:21: sparse:     expected unsigned short [usertype] val
   drivers/usb/host/fhci-hub.c:274:21: sparse:     got restricted __le16 [usertype] wHubStatus
>> drivers/usb/host/fhci-hub.c:274:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:274:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: cast from restricted __le16
>> drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wHubChange @@
   drivers/usb/host/fhci-hub.c:276:21: sparse:     expected unsigned short [usertype] val
   drivers/usb/host/fhci-hub.c:276:21: sparse:     got restricted __le16 [usertype] wHubChange
   drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:276:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wPortStatus @@
   drivers/usb/host/fhci-hub.c:281:21: sparse:     expected unsigned short [usertype] val
   drivers/usb/host/fhci-hub.c:281:21: sparse:     got restricted __le16 [usertype] wPortStatus
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:281:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:283:21: sparse: sparse: cast from restricted __le16
   drivers/usb/host/fhci-hub.c:283:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] wPortChange @@
   drivers/usb/host/fhci-hub.c:283:21: sparse:     expected unsigned short [usertype] val
   drivers/usb/host/fhci-hub.c:283:21: sparse:     got restricted __le16 [usertype] wPortChange
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
   drivers/usb/host/fhci-sched.c:404:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-sched.c:405:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-sched.c:406:41: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/host/fhci-sched.c:412:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:412:36: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:412:36: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:438:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/host/fhci-sched.c:438:28: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/host/fhci-sched.c:438:28: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/host/fhci-sched.c:440:42: sparse: sparse: invalid assignment: &=
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

236dd4d18f293e3 Anton Vorontsov           2009-01-10  56  
236dd4d18f293e3 Anton Vorontsov           2009-01-10  57  u16 fhci_get_sof_timer_count(struct fhci_usb *usb)
236dd4d18f293e3 Anton Vorontsov           2009-01-10  58  {
cf61fdb944534ff Guilherme Maciel Ferreira 2012-06-23 @59  	return be16_to_cpu(in_be16(&usb->fhci->regs->usb_ussft) / 12);
236dd4d18f293e3 Anton Vorontsov           2009-01-10  60  }
236dd4d18f293e3 Anton Vorontsov           2009-01-10  61  

:::::: The code at line 59 was first introduced by commit
:::::: cf61fdb944534ffa84a824bb8c31a3826cdc169d USB: FHCI: Reusing QUICC Engine USB Controller registers from immap_qe.h

:::::: TO: Guilherme Maciel Ferreira <guilherme.maciel.ferreira@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--82I3+IH0IqGh5yIs--
