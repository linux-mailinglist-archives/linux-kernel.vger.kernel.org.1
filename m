Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207C42F697E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbhANSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:25:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:28145 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbhANSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610648539;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=aTVq1JWvHkaFebuORQskHWFVfvRdl/LKZDwfOKu1rao=;
        b=Ls0xtx3NXbqGVY0Pcm7YYKdoWLThgHHwVARICfwFLTwm54Ozp7qlVnA0zZwt6cuHNf
        NtEEts0lYiKbfDCABMfmRupm1m8xzm83esYSwt0l93FEM5toLv5Y3/szyyBzK5yo7vaG
        NkjJGz86Dr3CGdy1pW45eZL7cc8A2G6DsmjVbDKvax49HDBvaU6WCV3W+GR7UmUHYA5c
        zHYcXVCyTPANlwRKDPCTqraPNQlhyCBFhTWrzoqQx20UsIU6WYo6KsDwplKnrGzajpN6
        9/HSkanIccd3bJ3n7T2P8GPPU97NdNXLx8kWs+Xo3Y7mYTGV4tzn6bFJDlnVSX5LqG5k
        wEYA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh7kiA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0EIM9UxM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 14 Jan 2021 19:22:09 +0100 (CET)
Subject: Re: net/can/isotp.c:1240:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <202101141753.ropIZ9nh-lkp@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c179d70b-b09f-1f9f-04bc-007788c45722@hartkopp.net>
Date:   Thu, 14 Jan 2021 19:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202101141753.ropIZ9nh-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.01.21 10:47, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   65f0d2414b7079556fbbcc070b3d1c9f9587606d
> commit: e057dd3fc20ffb3d7f150af46542a51b59b90127 can: add ISO 15765-2:2016 transport protocol
> date:   3 months ago
> config: sh-randconfig-s032-20210114 (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-208-g46a52ca4-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e057dd3fc20ffb3d7f150af46542a51b59b90127
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout e057dd3fc20ffb3d7f150af46542a51b59b90127
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
>>> net/can/isotp.c:1240:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
>     net/can/isotp.c:1240:13: sparse:     expected int const *__gu_addr
>     net/can/isotp.c:1240:13: sparse:     got int [noderef] __user *optlen
>>> net/can/isotp.c:1240:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>     net/can/isotp.c:1240:13: sparse:     expected void const volatile [noderef] __user *ptr
>     net/can/isotp.c:1240:13: sparse:     got int const *__gu_addr
> 

This seems to be a problem with the sh4 arch and/or its cross 
compilation tools.

There are tons of similar code snippets in the kernel, e.g. in 
net/can/raw.c or net/bluetooth/hci_sock.c ...

And these code snippets do not trigger such sparse warnings?!?

Any idea?

Regards,
Oliver

> vim +1240 net/can/isotp.c
> 
>    1229	
>    1230	static int isotp_getsockopt(struct socket *sock, int level, int optname,
>    1231				    char __user *optval, int __user *optlen)
>    1232	{
>    1233		struct sock *sk = sock->sk;
>    1234		struct isotp_sock *so = isotp_sk(sk);
>    1235		int len;
>    1236		void *val;
>    1237	
>    1238		if (level != SOL_CAN_ISOTP)
>    1239			return -EINVAL;
>> 1240		if (get_user(len, optlen))
>    1241			return -EFAULT;
>    1242		if (len < 0)
>    1243			return -EINVAL;
>    1244	
>    1245		switch (optname) {
>    1246		case CAN_ISOTP_OPTS:
>    1247			len = min_t(int, len, sizeof(struct can_isotp_options));
>    1248			val = &so->opt;
>    1249			break;
>    1250	
>    1251		case CAN_ISOTP_RECV_FC:
>    1252			len = min_t(int, len, sizeof(struct can_isotp_fc_options));
>    1253			val = &so->rxfc;
>    1254			break;
>    1255	
>    1256		case CAN_ISOTP_TX_STMIN:
>    1257			len = min_t(int, len, sizeof(u32));
>    1258			val = &so->force_tx_stmin;
>    1259			break;
>    1260	
>    1261		case CAN_ISOTP_RX_STMIN:
>    1262			len = min_t(int, len, sizeof(u32));
>    1263			val = &so->force_rx_stmin;
>    1264			break;
>    1265	
>    1266		case CAN_ISOTP_LL_OPTS:
>    1267			len = min_t(int, len, sizeof(struct can_isotp_ll_options));
>    1268			val = &so->ll;
>    1269			break;
>    1270	
>    1271		default:
>    1272			return -ENOPROTOOPT;
>    1273		}
>    1274	
>    1275		if (put_user(len, optlen))
>    1276			return -EFAULT;
>    1277		if (copy_to_user(optval, val, len))
>    1278			return -EFAULT;
>    1279		return 0;
>    1280	}
>    1281	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
