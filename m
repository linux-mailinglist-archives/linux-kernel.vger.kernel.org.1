Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779DC2E2EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLZSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 13:46:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:20312 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLZSqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 13:46:37 -0500
IronPort-SDR: 9R5DC+CRwApjekO70lD0R3wum5ZYTCdVFf3IcRaszJId0NARghEggJC1G9W4jXVm1FvChtJMnf
 LRe5zggGshyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9846"; a="176426360"
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="gz'50?scan'50,208,50";a="176426360"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2020 10:45:56 -0800
IronPort-SDR: rSXTgWq5w5o/pdi07b3BlbzCRNQEB1VYNIHsN8ARgump2OGrX/gUb7kt43hKBqB8ItAbCPnrwO
 Td7DKIsp8LFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="gz'50?scan'50,208,50";a="493861043"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Dec 2020 10:45:53 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktEZd-00027s-AH; Sat, 26 Dec 2020 18:45:53 +0000
Date:   Sun, 27 Dec 2020 02:45:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/kgdb.c:49:26: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202012270221.qS2Mytuy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   40f78232f97344afbbeb5b0008615f17c4b93466
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   4 months ago
config: sh-randconfig-s032-20201225 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> arch/sh/kernel/kgdb.c:49:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long pc @@
   arch/sh/kernel/kgdb.c:49:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:49:26: sparse:     got unsigned long pc
>> arch/sh/kernel/kgdb.c:146:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got long @@
   arch/sh/kernel/kgdb.c:146:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:146:26: sparse:     got long
>> arch/sh/kernel/kgdb.c:160:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long static [assigned] [toplevel] stepped_address @@
   arch/sh/kernel/kgdb.c:160:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:160:17: sparse:     got unsigned long static [assigned] [toplevel] stepped_address
>> arch/sh/kernel/kgdb.c:310:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/kgdb.c:310:38: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/kgdb.c:310:38: sparse:     got unsigned long
--
>> arch/sh/kernel/ftrace.c:50:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/ftrace.c:50:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:50:9: sparse:     got unsigned char *
   arch/sh/kernel/ftrace.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/ftrace.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:57:9: sparse:     got unsigned char *
--
   kernel/bpf/cgroup.c:1439:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   kernel/bpf/cgroup.c:1439:21: sparse:     expected int const *__gu_addr
   kernel/bpf/cgroup.c:1439:21: sparse:     got int [noderef] __user *optlen
>> kernel/bpf/cgroup.c:1439:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   kernel/bpf/cgroup.c:1439:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/cgroup.c:1439:21: sparse:     got int const *__gu_addr
--
   drivers/tty/sysrq.c:1110:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buf @@
   drivers/tty/sysrq.c:1110:21: sparse:     expected char const *__gu_addr
   drivers/tty/sysrq.c:1110:21: sparse:     got char const [noderef] __user *buf
>> drivers/tty/sysrq.c:1110:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/sysrq.c:1110:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/sysrq.c:1110:21: sparse:     got char const *__gu_addr
   drivers/tty/sysrq.c:148:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
   net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/atm/ioctl.c:125:25: sparse:     expected unsigned short const *__gu_addr
   net/atm/ioctl.c:125:25: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/atm/ioctl.c:125:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:125:25: sparse:     got unsigned short const *__gu_addr
   net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *const *__gu_addr @@     got void [noderef] __user *[noderef] __user * @@
   net/atm/ioctl.c:180:29: sparse:     expected void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user *[noderef] __user *
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user *const *__gu_addr @@
   net/atm/ioctl.c:180:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *const *__gu_addr @@     got void [noderef] __user *[noderef] __user * @@
   net/atm/ioctl.c:203:29: sparse:     expected void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user *[noderef] __user *
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user *const *__gu_addr @@
   net/atm/ioctl.c:203:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/atm/ioctl.c:205:29: sparse:     expected int const *__gu_addr
   net/atm/ioctl.c:205:29: sparse:     got int [noderef] __user *
>> net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/atm/ioctl.c:205:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:205:29: sparse:     got int const *__gu_addr
--
   net/decnet/af_decnet.c:1540:12: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1540:12: sparse:     expected int const *__gu_addr
   net/decnet/af_decnet.c:1540:12: sparse:     got int [noderef] __user *optlen
>> net/decnet/af_decnet.c:1540:12: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/decnet/af_decnet.c:1540:12: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1540:12: sparse:     got int const *__gu_addr
   net/decnet/af_decnet.c:250:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:250:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:250:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
   net/decnet/af_decnet.c:1519:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1519:21: sparse:     expected int const *__gu_addr
   net/decnet/af_decnet.c:1519:21: sparse:     got int [noderef] __user *optlen
   net/decnet/af_decnet.c:1519:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/decnet/af_decnet.c:1519:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1519:21: sparse:     got int const *__gu_addr
   net/decnet/af_decnet.c: note: in included file:
   include/net/dn.h:192:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] sport @@     got restricted __le16 [usertype] addrloc @@
   include/net/dn.h:192:24: sparse:     expected restricted __be16 [usertype] sport
   include/net/dn.h:192:24: sparse:     got restricted __le16 [usertype] addrloc
   include/net/dn.h:193:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got restricted __le16 [usertype] addrrem @@
   include/net/dn.h:193:24: sparse:     expected restricted __be16 [usertype] dport
   include/net/dn.h:193:24: sparse:     got restricted __le16 [usertype] addrrem
   net/decnet/af_decnet.c:2167:9: sparse: sparse: context imbalance in 'dn_socket_get_idx' - wrong count at exit
   net/decnet/af_decnet.c:2187:9: sparse: sparse: context imbalance in 'dn_socket_seq_next' - unexpected unlock
   net/decnet/af_decnet.c:2196:17: sparse: sparse: context imbalance in 'dn_socket_seq_stop' - unexpected unlock
--
   net/ieee802154/socket.c:837:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ieee802154/socket.c:837:13: sparse:     expected int const *__gu_addr
   net/ieee802154/socket.c:837:13: sparse:     got int [noderef] __user *optlen
>> net/ieee802154/socket.c:837:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ieee802154/socket.c:837:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ieee802154/socket.c:837:13: sparse:     got int const *__gu_addr
--
   net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected int const *__gu_addr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int [noderef] __user *optlen
>> net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int const *__gu_addr
--
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
>> net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr

vim +49 arch/sh/kernel/kgdb.c

ab6e570ba33dbee Paul Mundt 2008-12-11   45  
ab6e570ba33dbee Paul Mundt 2008-12-11   46  /* Calculate the new address for after a step */
ab6e570ba33dbee Paul Mundt 2008-12-11   47  static short *get_step_address(struct pt_regs *linux_regs)
ab6e570ba33dbee Paul Mundt 2008-12-11   48  {
2bcfffa42309b6f Paul Mundt 2009-05-09  @49  	insn_size_t op = __raw_readw(linux_regs->pc);
ab6e570ba33dbee Paul Mundt 2008-12-11   50  	long addr;
ab6e570ba33dbee Paul Mundt 2008-12-11   51  
ab6e570ba33dbee Paul Mundt 2008-12-11   52  	/* BT */
ab6e570ba33dbee Paul Mundt 2008-12-11   53  	if (OPCODE_BT(op)) {
ab6e570ba33dbee Paul Mundt 2008-12-11   54  		if (linux_regs->sr & SR_T_BIT_MASK)
ab6e570ba33dbee Paul Mundt 2008-12-11   55  			addr = linux_regs->pc + 4 + OPCODE_BTF_DISP(op);
ab6e570ba33dbee Paul Mundt 2008-12-11   56  		else
ab6e570ba33dbee Paul Mundt 2008-12-11   57  			addr = linux_regs->pc + 2;
ab6e570ba33dbee Paul Mundt 2008-12-11   58  	}
ab6e570ba33dbee Paul Mundt 2008-12-11   59  
ab6e570ba33dbee Paul Mundt 2008-12-11   60  	/* BTS */
ab6e570ba33dbee Paul Mundt 2008-12-11   61  	else if (OPCODE_BTS(op)) {
ab6e570ba33dbee Paul Mundt 2008-12-11   62  		if (linux_regs->sr & SR_T_BIT_MASK)
ab6e570ba33dbee Paul Mundt 2008-12-11   63  			addr = linux_regs->pc + 4 + OPCODE_BTF_DISP(op);
ab6e570ba33dbee Paul Mundt 2008-12-11   64  		else
ab6e570ba33dbee Paul Mundt 2008-12-11   65  			addr = linux_regs->pc + 4;	/* Not in delay slot */
ab6e570ba33dbee Paul Mundt 2008-12-11   66  	}
ab6e570ba33dbee Paul Mundt 2008-12-11   67  
ab6e570ba33dbee Paul Mundt 2008-12-11   68  	/* BF */
ab6e570ba33dbee Paul Mundt 2008-12-11   69  	else if (OPCODE_BF(op)) {
ab6e570ba33dbee Paul Mundt 2008-12-11   70  		if (!(linux_regs->sr & SR_T_BIT_MASK))
ab6e570ba33dbee Paul Mundt 2008-12-11   71  			addr = linux_regs->pc + 4 + OPCODE_BTF_DISP(op);
ab6e570ba33dbee Paul Mundt 2008-12-11   72  		else
ab6e570ba33dbee Paul Mundt 2008-12-11   73  			addr = linux_regs->pc + 2;
ab6e570ba33dbee Paul Mundt 2008-12-11   74  	}
ab6e570ba33dbee Paul Mundt 2008-12-11   75  
ab6e570ba33dbee Paul Mundt 2008-12-11   76  	/* BFS */
ab6e570ba33dbee Paul Mundt 2008-12-11   77  	else if (OPCODE_BFS(op)) {
ab6e570ba33dbee Paul Mundt 2008-12-11   78  		if (!(linux_regs->sr & SR_T_BIT_MASK))
ab6e570ba33dbee Paul Mundt 2008-12-11   79  			addr = linux_regs->pc + 4 + OPCODE_BTF_DISP(op);
ab6e570ba33dbee Paul Mundt 2008-12-11   80  		else
ab6e570ba33dbee Paul Mundt 2008-12-11   81  			addr = linux_regs->pc + 4;	/* Not in delay slot */
ab6e570ba33dbee Paul Mundt 2008-12-11   82  	}
ab6e570ba33dbee Paul Mundt 2008-12-11   83  
ab6e570ba33dbee Paul Mundt 2008-12-11   84  	/* BRA */
ab6e570ba33dbee Paul Mundt 2008-12-11   85  	else if (OPCODE_BRA(op))
ab6e570ba33dbee Paul Mundt 2008-12-11   86  		addr = linux_regs->pc + 4 + OPCODE_BRA_DISP(op);
ab6e570ba33dbee Paul Mundt 2008-12-11   87  
ab6e570ba33dbee Paul Mundt 2008-12-11   88  	/* BRAF */
ab6e570ba33dbee Paul Mundt 2008-12-11   89  	else if (OPCODE_BRAF(op))
ab6e570ba33dbee Paul Mundt 2008-12-11   90  		addr = linux_regs->pc + 4
ab6e570ba33dbee Paul Mundt 2008-12-11   91  		    + linux_regs->regs[OPCODE_BRAF_REG(op)];
ab6e570ba33dbee Paul Mundt 2008-12-11   92  
ab6e570ba33dbee Paul Mundt 2008-12-11   93  	/* BSR */
ab6e570ba33dbee Paul Mundt 2008-12-11   94  	else if (OPCODE_BSR(op))
ab6e570ba33dbee Paul Mundt 2008-12-11   95  		addr = linux_regs->pc + 4 + OPCODE_BSR_DISP(op);
ab6e570ba33dbee Paul Mundt 2008-12-11   96  
ab6e570ba33dbee Paul Mundt 2008-12-11   97  	/* BSRF */
ab6e570ba33dbee Paul Mundt 2008-12-11   98  	else if (OPCODE_BSRF(op))
ab6e570ba33dbee Paul Mundt 2008-12-11   99  		addr = linux_regs->pc + 4
ab6e570ba33dbee Paul Mundt 2008-12-11  100  		    + linux_regs->regs[OPCODE_BSRF_REG(op)];
ab6e570ba33dbee Paul Mundt 2008-12-11  101  
ab6e570ba33dbee Paul Mundt 2008-12-11  102  	/* JMP */
ab6e570ba33dbee Paul Mundt 2008-12-11  103  	else if (OPCODE_JMP(op))
ab6e570ba33dbee Paul Mundt 2008-12-11  104  		addr = linux_regs->regs[OPCODE_JMP_REG(op)];
ab6e570ba33dbee Paul Mundt 2008-12-11  105  
ab6e570ba33dbee Paul Mundt 2008-12-11  106  	/* JSR */
ab6e570ba33dbee Paul Mundt 2008-12-11  107  	else if (OPCODE_JSR(op))
ab6e570ba33dbee Paul Mundt 2008-12-11  108  		addr = linux_regs->regs[OPCODE_JSR_REG(op)];
ab6e570ba33dbee Paul Mundt 2008-12-11  109  
ab6e570ba33dbee Paul Mundt 2008-12-11  110  	/* RTS */
ab6e570ba33dbee Paul Mundt 2008-12-11  111  	else if (OPCODE_RTS(op))
ab6e570ba33dbee Paul Mundt 2008-12-11  112  		addr = linux_regs->pr;
ab6e570ba33dbee Paul Mundt 2008-12-11  113  
ab6e570ba33dbee Paul Mundt 2008-12-11  114  	/* RTE */
ab6e570ba33dbee Paul Mundt 2008-12-11  115  	else if (OPCODE_RTE(op))
ab6e570ba33dbee Paul Mundt 2008-12-11  116  		addr = linux_regs->regs[15];
ab6e570ba33dbee Paul Mundt 2008-12-11  117  
ab6e570ba33dbee Paul Mundt 2008-12-11  118  	/* Other */
ab6e570ba33dbee Paul Mundt 2008-12-11  119  	else
ab6e570ba33dbee Paul Mundt 2008-12-11  120  		addr = linux_regs->pc + instruction_size(op);
ab6e570ba33dbee Paul Mundt 2008-12-11  121  
ab6e570ba33dbee Paul Mundt 2008-12-11  122  	flush_icache_range(addr, addr + instruction_size(op));
ab6e570ba33dbee Paul Mundt 2008-12-11  123  	return (short *)addr;
ab6e570ba33dbee Paul Mundt 2008-12-11  124  }
ab6e570ba33dbee Paul Mundt 2008-12-11  125  
ab6e570ba33dbee Paul Mundt 2008-12-11  126  /*
ab6e570ba33dbee Paul Mundt 2008-12-11  127   * Replace the instruction immediately after the current instruction
ab6e570ba33dbee Paul Mundt 2008-12-11  128   * (i.e. next in the expected flow of control) with a trap instruction,
ab6e570ba33dbee Paul Mundt 2008-12-11  129   * so that returning will cause only a single instruction to be executed.
ab6e570ba33dbee Paul Mundt 2008-12-11  130   * Note that this model is slightly broken for instructions with delay
ab6e570ba33dbee Paul Mundt 2008-12-11  131   * slots (e.g. B[TF]S, BSR, BRA etc), where both the branch and the
ab6e570ba33dbee Paul Mundt 2008-12-11  132   * instruction in the delay slot will be executed.
ab6e570ba33dbee Paul Mundt 2008-12-11  133   */
ab6e570ba33dbee Paul Mundt 2008-12-11  134  
ab6e570ba33dbee Paul Mundt 2008-12-11  135  static unsigned long stepped_address;
2bcfffa42309b6f Paul Mundt 2009-05-09  136  static insn_size_t stepped_opcode;
ab6e570ba33dbee Paul Mundt 2008-12-11  137  
ab6e570ba33dbee Paul Mundt 2008-12-11  138  static void do_single_step(struct pt_regs *linux_regs)
ab6e570ba33dbee Paul Mundt 2008-12-11  139  {
ab6e570ba33dbee Paul Mundt 2008-12-11  140  	/* Determine where the target instruction will send us to */
ab6e570ba33dbee Paul Mundt 2008-12-11  141  	unsigned short *addr = get_step_address(linux_regs);
ab6e570ba33dbee Paul Mundt 2008-12-11  142  
ab6e570ba33dbee Paul Mundt 2008-12-11  143  	stepped_address = (int)addr;
ab6e570ba33dbee Paul Mundt 2008-12-11  144  
ab6e570ba33dbee Paul Mundt 2008-12-11  145  	/* Replace it */
ab6e570ba33dbee Paul Mundt 2008-12-11 @146  	stepped_opcode = __raw_readw((long)addr);
ab6e570ba33dbee Paul Mundt 2008-12-11  147  	*addr = STEP_OPCODE;
ab6e570ba33dbee Paul Mundt 2008-12-11  148  
ab6e570ba33dbee Paul Mundt 2008-12-11  149  	/* Flush and return */
ab6e570ba33dbee Paul Mundt 2008-12-11  150  	flush_icache_range((long)addr, (long)addr +
ab6e570ba33dbee Paul Mundt 2008-12-11  151  			   instruction_size(stepped_opcode));
ab6e570ba33dbee Paul Mundt 2008-12-11  152  }
ab6e570ba33dbee Paul Mundt 2008-12-11  153  
ab6e570ba33dbee Paul Mundt 2008-12-11  154  /* Undo a single step */
ab6e570ba33dbee Paul Mundt 2008-12-11  155  static void undo_single_step(struct pt_regs *linux_regs)
ab6e570ba33dbee Paul Mundt 2008-12-11  156  {
ab6e570ba33dbee Paul Mundt 2008-12-11  157  	/* If we have stepped, put back the old instruction */
ab6e570ba33dbee Paul Mundt 2008-12-11  158  	/* Use stepped_address in case we stopped elsewhere */
ab6e570ba33dbee Paul Mundt 2008-12-11  159  	if (stepped_opcode != 0) {
ab6e570ba33dbee Paul Mundt 2008-12-11 @160  		__raw_writew(stepped_opcode, stepped_address);
ab6e570ba33dbee Paul Mundt 2008-12-11  161  		flush_icache_range(stepped_address, stepped_address + 2);
ab6e570ba33dbee Paul Mundt 2008-12-11  162  	}
ab6e570ba33dbee Paul Mundt 2008-12-11  163  
ab6e570ba33dbee Paul Mundt 2008-12-11  164  	stepped_opcode = 0;
ab6e570ba33dbee Paul Mundt 2008-12-11  165  }
ab6e570ba33dbee Paul Mundt 2008-12-11  166  

:::::: The code at line 49 was first introduced by commit
:::::: 2bcfffa42309b6f73042c62459bf5207762a271d sh: Rename opcode_t to insn_size_t.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
K+H9D/2IS56tQAEA

--45Z9DzgjV8m4Oswq--
