Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A32F75BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbhAOJqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:46:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:10329 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbhAOJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:46:11 -0500
IronPort-SDR: RE3Tg4meKJCuYuNbIqILkvhZIrDewPMkKf+oiKelnhdQbqop3GyKvbBDIWKS4EHuSlDep0G9tG
 eab6ek/HUbvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="242595567"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="gz'50?scan'50,208,50";a="242595567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:45:37 -0800
IronPort-SDR: GR8/3jfq8AuoWJ1SVxMT5q3Q7luFK4/pqIY79gXlm19s8LaHYJ/I8Xa+h9DFavLYb+kvqSGH0h
 +17KziYh2DFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="gz'50?scan'50,208,50";a="425255873"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 01:45:35 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0Lfj-0000Ho-2A; Fri, 15 Jan 2021 09:45:35 +0000
Date:   Fri, 15 Jan 2021 17:45:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202101151758.lPF0Ywnf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ee88057889bbca5f5bb96031b62b3756b33e164
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s032-20210115 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int const *__gu_addr
--
   drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int [noderef] __user *
>> drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int [noderef] __user *
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int const *__gu_addr
--
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
>> drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
--
   net/atm/pppoatm.c:376:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/atm/pppoatm.c:376:24: sparse:     expected int const *__gu_addr
   net/atm/pppoatm.c:376:24: sparse:     got int [noderef] __user *
>> net/atm/pppoatm.c:376:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/atm/pppoatm.c:376:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/pppoatm.c:376:24: sparse:     got int const *__gu_addr
   net/atm/pppoatm.c:453:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/atm/pppoatm.c:453:21: sparse:     expected unsigned short const *__gu_addr
   net/atm/pppoatm.c:453:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/atm/pppoatm.c:453:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/atm/pppoatm.c:453:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/pppoatm.c:453:21: sparse:     got unsigned short const *__gu_addr
--
   net/packet/af_packet.c:3942:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/packet/af_packet.c:3942:13: sparse:     expected int const *__gu_addr
   net/packet/af_packet.c:3942:13: sparse:     got int [noderef] __user *optlen
>> net/packet/af_packet.c:3942:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/packet/af_packet.c:3942:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/packet/af_packet.c:3942:13: sparse:     got int const *__gu_addr
   net/packet/af_packet.c:1008:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2402:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
--
   net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/xdp/xsk.c:835:13: sparse:     expected int const *__gu_addr
   net/xdp/xsk.c:835:13: sparse:     got int [noderef] __user *optlen
>> net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/xdp/xsk.c:835:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/xdp/xsk.c:835:13: sparse:     got int const *__gu_addr

vim +361 drivers/vhost/vdpa.c

2cf1ba9a4d15cb78 Zhu Lingshan 2020-07-31  346  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  347  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
4c8cf31885f69e86 Tiwei Bie    2020-03-26  348  				   void __user *argp)
4c8cf31885f69e86 Tiwei Bie    2020-03-26  349  {
4c8cf31885f69e86 Tiwei Bie    2020-03-26  350  	struct vdpa_device *vdpa = v->vdpa;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  351  	const struct vdpa_config_ops *ops = vdpa->config;
aac50c0bd434794b Eli Cohen    2020-08-04  352  	struct vdpa_vq_state vq_state;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  353  	struct vdpa_callback cb;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  354  	struct vhost_virtqueue *vq;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  355  	struct vhost_vring_state s;
653055b9acd45d60 Jason Wang   2020-08-04  356  	u64 __user *featurep = argp;
653055b9acd45d60 Jason Wang   2020-08-04  357  	u64 features;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  358  	u32 idx;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  359  	long r;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  360  
4c8cf31885f69e86 Tiwei Bie    2020-03-26 @361  	r = get_user(idx, (u32 __user *)argp);
4c8cf31885f69e86 Tiwei Bie    2020-03-26  362  	if (r < 0)
4c8cf31885f69e86 Tiwei Bie    2020-03-26  363  		return r;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  364  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  365  	if (idx >= v->nvqs)
4c8cf31885f69e86 Tiwei Bie    2020-03-26  366  		return -ENOBUFS;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  367  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  368  	idx = array_index_nospec(idx, v->nvqs);
4c8cf31885f69e86 Tiwei Bie    2020-03-26  369  	vq = &v->vqs[idx];
4c8cf31885f69e86 Tiwei Bie    2020-03-26  370  
b0bd82bf729dbd05 Jason Wang   2020-08-04  371  	switch (cmd) {
b0bd82bf729dbd05 Jason Wang   2020-08-04  372  	case VHOST_VDPA_SET_VRING_ENABLE:
4c8cf31885f69e86 Tiwei Bie    2020-03-26  373  		if (copy_from_user(&s, argp, sizeof(s)))
4c8cf31885f69e86 Tiwei Bie    2020-03-26  374  			return -EFAULT;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  375  		ops->set_vq_ready(vdpa, idx, s.num);
4c8cf31885f69e86 Tiwei Bie    2020-03-26  376  		return 0;
b0bd82bf729dbd05 Jason Wang   2020-08-04  377  	case VHOST_GET_VRING_BASE:
23750e39d57433d0 Eli Cohen    2020-08-04  378  		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
23750e39d57433d0 Eli Cohen    2020-08-04  379  		if (r)
23750e39d57433d0 Eli Cohen    2020-08-04  380  			return r;
23750e39d57433d0 Eli Cohen    2020-08-04  381  
aac50c0bd434794b Eli Cohen    2020-08-04  382  		vq->last_avail_idx = vq_state.avail_index;
b0bd82bf729dbd05 Jason Wang   2020-08-04  383  		break;
653055b9acd45d60 Jason Wang   2020-08-04  384  	case VHOST_GET_BACKEND_FEATURES:
653055b9acd45d60 Jason Wang   2020-08-04  385  		features = VHOST_VDPA_BACKEND_FEATURES;
653055b9acd45d60 Jason Wang   2020-08-04  386  		if (copy_to_user(featurep, &features, sizeof(features)))
653055b9acd45d60 Jason Wang   2020-08-04  387  			return -EFAULT;
653055b9acd45d60 Jason Wang   2020-08-04  388  		return 0;
653055b9acd45d60 Jason Wang   2020-08-04  389  	case VHOST_SET_BACKEND_FEATURES:
653055b9acd45d60 Jason Wang   2020-08-04  390  		if (copy_from_user(&features, featurep, sizeof(features)))
653055b9acd45d60 Jason Wang   2020-08-04  391  			return -EFAULT;
653055b9acd45d60 Jason Wang   2020-08-04  392  		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
653055b9acd45d60 Jason Wang   2020-08-04  393  			return -EOPNOTSUPP;
653055b9acd45d60 Jason Wang   2020-08-04  394  		vhost_set_backend_features(&v->vdev, features);
653055b9acd45d60 Jason Wang   2020-08-04  395  		return 0;
b0bd82bf729dbd05 Jason Wang   2020-08-04  396  	}
4c8cf31885f69e86 Tiwei Bie    2020-03-26  397  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  398  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
4c8cf31885f69e86 Tiwei Bie    2020-03-26  399  	if (r)
4c8cf31885f69e86 Tiwei Bie    2020-03-26  400  		return r;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  401  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  402  	switch (cmd) {
4c8cf31885f69e86 Tiwei Bie    2020-03-26  403  	case VHOST_SET_VRING_ADDR:
4c8cf31885f69e86 Tiwei Bie    2020-03-26  404  		if (ops->set_vq_address(vdpa, idx,
4c8cf31885f69e86 Tiwei Bie    2020-03-26  405  					(u64)(uintptr_t)vq->desc,
4c8cf31885f69e86 Tiwei Bie    2020-03-26  406  					(u64)(uintptr_t)vq->avail,
4c8cf31885f69e86 Tiwei Bie    2020-03-26  407  					(u64)(uintptr_t)vq->used))
4c8cf31885f69e86 Tiwei Bie    2020-03-26  408  			r = -EINVAL;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  409  		break;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  410  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  411  	case VHOST_SET_VRING_BASE:
aac50c0bd434794b Eli Cohen    2020-08-04  412  		vq_state.avail_index = vq->last_avail_idx;
aac50c0bd434794b Eli Cohen    2020-08-04  413  		if (ops->set_vq_state(vdpa, idx, &vq_state))
4c8cf31885f69e86 Tiwei Bie    2020-03-26  414  			r = -EINVAL;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  415  		break;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  416  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  417  	case VHOST_SET_VRING_CALL:
265a0ad8731dc04f Zhu Lingshan 2020-07-31  418  		if (vq->call_ctx.ctx) {
4c8cf31885f69e86 Tiwei Bie    2020-03-26  419  			cb.callback = vhost_vdpa_virtqueue_cb;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  420  			cb.private = vq;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  421  		} else {
4c8cf31885f69e86 Tiwei Bie    2020-03-26  422  			cb.callback = NULL;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  423  			cb.private = NULL;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  424  		}
4c8cf31885f69e86 Tiwei Bie    2020-03-26  425  		ops->set_vq_cb(vdpa, idx, &cb);
2cf1ba9a4d15cb78 Zhu Lingshan 2020-07-31  426  		vhost_vdpa_setup_vq_irq(v, idx);
4c8cf31885f69e86 Tiwei Bie    2020-03-26  427  		break;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  428  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  429  	case VHOST_SET_VRING_NUM:
4c8cf31885f69e86 Tiwei Bie    2020-03-26  430  		ops->set_vq_num(vdpa, idx, vq->num);
4c8cf31885f69e86 Tiwei Bie    2020-03-26  431  		break;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  432  	}
4c8cf31885f69e86 Tiwei Bie    2020-03-26  433  
4c8cf31885f69e86 Tiwei Bie    2020-03-26  434  	return r;
4c8cf31885f69e86 Tiwei Bie    2020-03-26  435  }
4c8cf31885f69e86 Tiwei Bie    2020-03-26  436  

:::::: The code at line 361 was first introduced by commit
:::::: 4c8cf31885f69e86be0b5b9e6677a26797365e1d vhost: introduce vDPA-based backend

:::::: TO: Tiwei Bie <tiwei.bie@intel.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62--
