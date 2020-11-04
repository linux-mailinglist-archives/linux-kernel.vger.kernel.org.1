Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4402A64AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgKDMvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:51:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:4904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbgKDMvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:51:44 -0500
IronPort-SDR: MheO3JNNZtxCTf8t440SZVHofW4sncFlO4GEuXKf0dN3rkvMSzbxqgFjZpM7T+/ZifUB1RiNFH
 0Nzsgex7Dubg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="253920478"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="gz'50?scan'50,208,50";a="253920478"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 04:51:34 -0800
IronPort-SDR: XblXp/jHRAhMcqQAl7x3nqHDHWRM58/hZBlMk/WKaBq9cJ0SYXoICnXDEYcfHkojNaQSXNvjiA
 gCUYV2Px7p2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="gz'50?scan'50,208,50";a="325607245"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2020 04:51:32 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kaIGB-0000v0-UB; Wed, 04 Nov 2020 12:51:31 +0000
Date:   Wed, 4 Nov 2020 20:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh2a/clock-sh7264.c:44:33: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202011042038.mbt7PFKd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ef8451b332662d004df269d4cdeb7d9f31419b5
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   10 weeks ago
config: sh-randconfig-s032-20201103 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-76-gf680124b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> arch/sh/kernel/cpu/sh2a/clock-sh7264.c:44:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh2a/clock-sh7264.c:44:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:44:33: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:93:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:94:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:95:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:96:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:97:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:98:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:99:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:100:20: sparse: sparse: Using plain integer as NULL pointer
   arch/sh/kernel/cpu/sh2a/clock-sh7264.c:101:20: sparse: sparse: Using plain integer as NULL pointer
--
>> arch/sh/kernel/cpu/sh2a/setup-sh7264.c:474:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
>> arch/sh/kernel/cpu/sh2a/setup-sh7264.c:474:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7264.c:474:9: sparse:     got unsigned int
--
   drivers/hwmon/w83793.c:1372:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/hwmon/w83793.c:1372:37: sparse:     expected char const *__gu_addr
   drivers/hwmon/w83793.c:1372:37: sparse:     got char const [noderef] __user *
>> drivers/hwmon/w83793.c:1372:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> drivers/hwmon/w83793.c:1372:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1372:37: sparse:     got char const *__gu_addr
   drivers/hwmon/w83793.c:1425:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1425:21: sparse:     expected int const *__gu_addr
   drivers/hwmon/w83793.c:1425:21: sparse:     got int [noderef] __user *
>> drivers/hwmon/w83793.c:1425:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hwmon/w83793.c:1425:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1425:21: sparse:     got int const *__gu_addr
   drivers/hwmon/w83793.c:1435:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1435:21: sparse:     expected int const *__gu_addr
   drivers/hwmon/w83793.c:1435:21: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1435:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hwmon/w83793.c:1435:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/w83793.c:1435:21: sparse:     got int const *__gu_addr
--
   drivers/net/tun.c:3227:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/tun.c:3227:21: sparse:     expected int const *__gu_addr
   drivers/net/tun.c:3227:21: sparse:     got int [noderef] __user *
>> drivers/net/tun.c:3227:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/net/tun.c:3227:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/tun.c:3227:21: sparse:     got int const *__gu_addr
--
   drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/media/rc/lirc_dev.c:378:23: sparse:     expected unsigned int const *__gu_addr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/media/rc/lirc_dev.c:378:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int const *__gu_addr
--
   drivers/usb/class/usbtmc.c:584:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *arg @@
   drivers/usb/class/usbtmc.c:584:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:584:13: sparse:     got unsigned int [noderef] [usertype] __user *arg
>> drivers/usb/class/usbtmc.c:584:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/usb/class/usbtmc.c:584:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/class/usbtmc.c:584:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:1963:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:1963:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:1963:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:1963:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/class/usbtmc.c:1963:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/class/usbtmc.c:1963:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:2143:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/class/usbtmc.c:2143:26: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/class/usbtmc.c:2143:26: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/class/usbtmc.c:2143:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/usb/class/usbtmc.c:2143:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/class/usbtmc.c:2143:26: sparse:     got unsigned char const *__gu_addr
--
   drivers/usb/gadget/function/rndis.c:1126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     expected char const *__gu_addr
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     got char const [noderef] __user *buffer
>> drivers/usb/gadget/function/rndis.c:1126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> drivers/usb/gadget/function/rndis.c:1126:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     got char const *__gu_addr
--
   net/atm/common.c:795:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/atm/common.c:795:13: sparse:     expected int const *__gu_addr
   net/atm/common.c:795:13: sparse:     got int [noderef] __user *optlen
>> net/atm/common.c:795:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/atm/common.c:795:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/common.c:795:13: sparse:     got int const *__gu_addr
--
   net/atm/resources.c:203:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *iobuf_len @@
   net/atm/resources.c:203:13: sparse:     expected int const *__gu_addr
   net/atm/resources.c:203:13: sparse:     got int [noderef] __user *iobuf_len
>> net/atm/resources.c:203:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/atm/resources.c:203:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:203:13: sparse:     got int const *__gu_addr
   net/atm/resources.c:236:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *sioc_len @@
   net/atm/resources.c:236:13: sparse:     expected int const *__gu_addr
   net/atm/resources.c:236:13: sparse:     got int [noderef] __user *sioc_len
   net/atm/resources.c:236:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/atm/resources.c:236:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:236:13: sparse:     got int const *__gu_addr
--
   net/core/pktgen.c:720:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:720:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:720:21: sparse:     got char const [noderef] __user *
>> net/core/pktgen.c:720:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
>> net/core/pktgen.c:720:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:720:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:738:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:738:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:738:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:738:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:738:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:738:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:764:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:764:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:764:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:764:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:764:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:764:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:781:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:781:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:781:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:781:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:781:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:781:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:815:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:815:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:815:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:815:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/core/pktgen.c:815:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/pktgen.c:815:21: sparse:     got char const *__gu_addr
--
   net/dccp/proto.c:535:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [addressable] val @@
   net/dccp/proto.c:535:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:535:52: sparse:     got int [addressable] val
   net/dccp/proto.c:620:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:620:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:620:13: sparse:     got int [noderef] __user *optlen
>> net/dccp/proto.c:620:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/dccp/proto.c:620:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/dccp/proto.c:620:13: sparse:     got int const *__gu_addr
   net/dccp/proto.c:718:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:718:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:718:57: sparse:     got int cmsg_type
--
   net/ipv6/ip6mr.c:1837:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv6/ip6mr.c:1837:13: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1837:13: sparse:     got int [noderef] __user *optlen
>> net/ipv6/ip6mr.c:1837:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/ipv6/ip6mr.c:1837:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ipv6/ip6mr.c:1837:13: sparse:     got int const *__gu_addr
   net/ipv6/ip6mr.c:405:13: sparse: sparse: context imbalance in 'ip6mr_vif_seq_start' - different lock contexts for basic block
   net/ipv6/ip6mr.c: note: in included file (through include/linux/mroute6.h):
   include/linux/mroute_base.h:427:31: sparse: sparse: context imbalance in 'mr_mfc_seq_stop' - unexpected unlock
--
   net/nfc/llcp_sock.c:308:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/nfc/llcp_sock.c:308:13: sparse:     expected int const *__gu_addr
   net/nfc/llcp_sock.c:308:13: sparse:     got int [noderef] __user *optlen
>> net/nfc/llcp_sock.c:308:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/nfc/llcp_sock.c:308:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:308:13: sparse:     got int const *__gu_addr
--
   net/sctp/socket.c: note: in included file (through include/net/sctp/sctp.h):
   include/net/sctp/structs.h:329:41: sparse: sparse: array of flexible structures
   net/sctp/socket.c:7814:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/sctp/socket.c:7814:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:7814:13: sparse:     got int [noderef] __user *optlen
>> net/sctp/socket.c:7814:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/sctp/socket.c:7814:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/sctp/socket.c:7814:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:8210:20: sparse: sparse: context imbalance in 'sctp_get_port_local' - unexpected unlock
--
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@

vim +44 arch/sh/kernel/cpu/sh2a/clock-sh7264.c

51ce30684e0d1ae Phil Edworthy 2012-05-09  40  
51ce30684e0d1ae Phil Edworthy 2012-05-09  41  static unsigned long pll_recalc(struct clk *clk)
51ce30684e0d1ae Phil Edworthy 2012-05-09  42  {
51ce30684e0d1ae Phil Edworthy 2012-05-09  43  	unsigned long rate = clk->parent->rate / pll1_div;
51ce30684e0d1ae Phil Edworthy 2012-05-09 @44  	return rate * pll1rate[(__raw_readw(FRQCR) >> 8) & 1];
51ce30684e0d1ae Phil Edworthy 2012-05-09  45  }
51ce30684e0d1ae Phil Edworthy 2012-05-09  46  

:::::: The code at line 44 was first introduced by commit
:::::: 51ce30684e0d1ae50a154e1026de57d15d096286 sh: Add sh7264 device

:::::: TO: Phil Edworthy <phil.edworthy@renesas.com>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OXfL5xGRrasGEqWY--
