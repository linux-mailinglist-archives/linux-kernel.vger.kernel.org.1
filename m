Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03B72A0E27
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgJ3S4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:56:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:21056 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3S4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604084158;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=MxueVNAOkPg9jGtRZurxIj0xkU/i73xArpnyrVRIDI8=;
        b=YTXFWplwH4IyRlG9SeYRTLFazhToUzP5FXR8Cnk2YxbR/gEdWU7+T05OJKeyNh5gxm
        Mabbz3lSc+cGjy2qusj0PloRrx7+qR4V8LDfLkCog4OnBQ6kY/Ggoo3k3YaIAACgF050
        irPNlbQPXVsl56+AuM/j60/kNiTDN13u3GteOQEn3XvPviJZdUhmCLS+MabQx6goQmEs
        uWPs9e4M4K7DdI3FEIeHOb2Jr6QJHPLf/HSdb1NBVaNqIUmMcOJAyomMF3225JxO8FB8
        Yauvg1/LeaKy+jr5R5lgUxu6cjDifnqwB6J320wb4TKzqn0P78EcCabn0hM3KQdbwzaW
        Ycyw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch6kExc"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bew9UItk5uM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 30 Oct 2020 19:55:46 +0100 (CET)
Subject: Re: net/can/isotp.c:1240:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <202010290720.uQ3pTGrT-lkp@intel.com>
 <146bb489-abaf-c763-44b2-ac1200560885@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4d092e3f-052d-7593-131c-a9629136f07f@hartkopp.net>
Date:   Fri, 30 Oct 2020 19:55:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <146bb489-abaf-c763-44b2-ac1200560885@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 29.10.20 08:33, Marc Kleine-Budde wrote:
> Hello,
> 
> looks like sh is missing the some __user annotations so that sparse spwes these
> warnings. Adding sh maintainers to Cc.
> 
> regards,
> Marc
> 
> On 10/29/20 12:01 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   23859ae44402f4d935b9ee548135dd1e65e2cbf4
>> commit: e057dd3fc20ffb3d7f150af46542a51b59b90127 can: add ISO 15765-2:2016 transport protocol
>> date:   3 weeks ago
>> config: sh-randconfig-s031-20201028 (attached as .config)
>> compiler: sh4-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-56-gc09e8239-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e057dd3fc20ffb3d7f150af46542a51b59b90127
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout e057dd3fc20ffb3d7f150af46542a51b59b90127
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> "sparse warnings: (new ones prefixed by >>)"
>>>> net/can/isotp.c:1240:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
>>>> net/can/isotp.c:1240:13: sparse:     expected int const *__gu_addr
>>>> net/can/isotp.c:1240:13: sparse:     got int [noderef] __user *optlen
>>>> net/can/isotp.c:1240:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>>>> net/can/isotp.c:1240:13: sparse:     expected void const volatile [noderef] __user *ptr
>>>> net/can/isotp.c:1240:13: sparse:     got int const *__gu_addr
>>
>> vim +1240 net/can/isotp.c
>>
>>    1229	
>>    1230	static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>    1231				    char __user *optval, int __user *optlen)
>>    1232	{
>>    1233		struct sock *sk = sock->sk;
>>    1234		struct isotp_sock *so = isotp_sk(sk);
>>    1235		int len;
>>    1236		void *val;
>>    1237	
>>    1238		if (level != SOL_CAN_ISOTP)
>>    1239			return -EINVAL;
>>> 1240		if (get_user(len, optlen))
>>    1241			return -EFAULT;
>>    1242		if (len < 0)
>>    1243			return -EINVAL;
>>    1244	

Sorry but there are tons of identical items in the networking subsystem 
in getsockopt functions.

And I don't get the sparse warning with make C=1 for none of the 
occurrences of

if (get_user(len, optlen))
     return -EFAULT;

So why did this show up here?

Thanks for your work & best regards,
Oliver

ps. Using sparse 0.6.2 (Debian: 0.6.2-2) here.


>>    1245		switch (optname) {
>>    1246		case CAN_ISOTP_OPTS:
>>    1247			len = min_t(int, len, sizeof(struct can_isotp_options));
>>    1248			val = &so->opt;
>>    1249			break;
>>    1250	
>>    1251		case CAN_ISOTP_RECV_FC:
>>    1252			len = min_t(int, len, sizeof(struct can_isotp_fc_options));
>>    1253			val = &so->rxfc;
>>    1254			break;
>>    1255	
>>    1256		case CAN_ISOTP_TX_STMIN:
>>    1257			len = min_t(int, len, sizeof(u32));
>>    1258			val = &so->force_tx_stmin;
>>    1259			break;
>>    1260	
>>    1261		case CAN_ISOTP_RX_STMIN:
>>    1262			len = min_t(int, len, sizeof(u32));
>>    1263			val = &so->force_rx_stmin;
>>    1264			break;
>>    1265	
>>    1266		case CAN_ISOTP_LL_OPTS:
>>    1267			len = min_t(int, len, sizeof(struct can_isotp_ll_options));
>>    1268			val = &so->ll;
>>    1269			break;
>>    1270	
>>    1271		default:
>>    1272			return -ENOPROTOOPT;
>>    1273		}
>>    1274	
>>    1275		if (put_user(len, optlen))
>>    1276			return -EFAULT;
>>    1277		if (copy_to_user(optval, val, len))
>>    1278			return -EFAULT;
>>    1279		return 0;
>>    1280	}
>>    1281	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
> 
