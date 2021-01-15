Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218762F7D49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbhAONyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:54:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11412 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbhAONya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:54:30 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DHM54117Nzj6H3;
        Fri, 15 Jan 2021 21:11:20 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 21:12:08 +0800
Subject: Re: drivers/scsi/myrs.c:2449:13: sparse: sparse: incorrect type in
 assignment (different base types)
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <202101151657.pWIXmPAS-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <4d577845-9f24-e0e4-aba7-ec368646f8c3@huawei.com>
Date:   Fri, 15 Jan 2021 21:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202101151657.pWIXmPAS-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/15 16:50, kernel test robot wrote:
> Hi Kefeng,
>
> First bad commit (maybe != root cause):

Hi, the commit in patchset[1], which make riscv random build happier, 
won't lead to the following problem.

I think the driver should fix the sparse error.


[1] https://lkml.org/lkml/2020/5/10/456

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5ee88057889bbca5f5bb96031b62b3756b33e164
> commit: ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'
> date:   8 months ago
> config: riscv-randconfig-s032-20210115 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-208-g46a52ca4-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> "sparse warnings: (new ones prefixed by >>)"
>     drivers/scsi/myrs.c:1532:5: sparse: sparse: symbol 'myrs_host_reset' was not declared. Should it be static?
>     drivers/scsi/myrs.c:1922:27: sparse: sparse: symbol 'myrs_template' was not declared. Should it be static?
>     drivers/scsi/myrs.c:2036:31: sparse: sparse: symbol 'myrs_raid_functions' was not declared. Should it be static?
>     drivers/scsi/myrs.c:2046:6: sparse: sparse: symbol 'myrs_flush_cache' was not declared. Should it be static?
>     drivers/scsi/myrs.c:2275:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:2> *base @@     got struct myrs_hba *cs @@
>     drivers/scsi/myrs.c:2275:34: sparse:     expected void [noderef] <asn:2> *base
>     drivers/scsi/myrs.c:2275:34: sparse:     got struct myrs_hba *cs
>     drivers/scsi/myrs.c:2434:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2502:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2427:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2502:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2413:9: sparse: sparse: cast from restricted __le32
>>> drivers/scsi/myrs.c:2449:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
>     drivers/scsi/myrs.c:2449:13: sparse:     expected restricted __le32 [usertype] val
>     drivers/scsi/myrs.c:2449:13: sparse:     got unsigned int [assigned] [usertype] __v
>     drivers/scsi/myrs.c:2549:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
>     drivers/scsi/myrs.c:2549:13: sparse:     expected restricted __le32 [usertype] val
>     drivers/scsi/myrs.c:2549:13: sparse:     got unsigned int [assigned] [usertype] __v
>     drivers/scsi/myrs.c:2552:18: sparse: sparse: restricted __le32 degrades to integer
>     drivers/scsi/myrs.c:2427:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2495:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2472:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2441:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
>     drivers/scsi/myrs.c:2441:13: sparse:     expected restricted __le32 [usertype] val
>     drivers/scsi/myrs.c:2441:13: sparse:     got unsigned int [assigned] [usertype] __v
>     drivers/scsi/myrs.c:2406:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2479:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] val @@     got unsigned int [assigned] [usertype] __v @@
>     drivers/scsi/myrs.c:2479:13: sparse:     expected restricted __le32 [usertype] val
>     drivers/scsi/myrs.c:2479:13: sparse:     got unsigned int [assigned] [usertype] __v
>     drivers/scsi/myrs.c:2457:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/myrs.c:2413:9: sparse: sparse: cast from restricted __le32
> --
>     drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:175:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:176:16: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:185:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:186:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:194:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:203:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:212:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:213:23: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:221:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:222:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:231:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:233:34: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:242:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:244:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:325:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:332:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:417:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: cast to restricted __le32
>     drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:488:25: sparse:     got void *
>>> drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse: sparse: cast from restricted __le32
>     drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:494:25: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:627:16: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:654:16: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:671:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:673:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:761:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:770:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:964:23: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:965:17: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:966:23: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:977:23: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:978:23: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:303:16: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:296:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse:     expected void const volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:297:16: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:270:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:264:9: sparse:     got void *
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: cast removes address space '<asn:2>' of expression
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     expected void volatile [noderef] <asn:2> *addr
>     drivers/isdn/hardware/mISDN/avmfritz.c:265:9: sparse:     got void *
> --
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:87:41: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:88:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] dummy_buffer_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:88:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] dummy_buffer_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:88:41: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:89:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:89:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:89:42: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:90:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:90:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] task_list_pbl_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:90:42: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:92:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] mtu @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:92:24: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] mtu
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:92:24: sparse:     got int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:109:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:109:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:109:41: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:110:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:110:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hash_tbl_pbl_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:110:41: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:113:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:113:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:113:40: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:114:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:114:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_hash_tbl_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:114:40: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:117:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:117:44: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:117:44: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:118:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:118:44: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] t2_ptr_hash_tbl_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:118:44: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:121:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] free_list_count @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:121:36: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] free_list_count
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:121:36: sparse:     got int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:128:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_lo @@     got unsigned int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:128:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:128:37: sparse:     got unsigned int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:129:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_hi @@     got unsigned int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:129:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] error_bit_map_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:129:37: sparse:     got unsigned int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:199:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] fcoe_conn_id @@     got unsigned short [assigned] [usertype] conn_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:199:32: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] fcoe_conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:199:32: sparse:     got unsigned short [assigned] [usertype] conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:202:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:202:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:202:30: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:203:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:203:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] sq_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:203:30: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:205:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:205:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:205:34: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:206:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:206:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_pbl_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:206:34: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:208:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:208:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:208:40: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:209:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:209:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] rq_first_pbe_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:209:40: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:212:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] rq_prod @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:212:27: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] rq_prod
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:212:27: sparse:     got int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:221:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tx_max_fc_pay_len @@     got unsigned short [usertype] maxframe_size @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:221:37: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tx_max_fc_pay_len
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:221:37: sparse:     got unsigned short [usertype] maxframe_size
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:223:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:223:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:223:30: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:224:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:224:30: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cq_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:224:30: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:226:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:226:33: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:226:33: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:227:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:227:33: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] xferq_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:227:33: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:229:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:229:35: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:229:35: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:230:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:230:35: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_db_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:230:35: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:239:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] vlan_tag @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:239:28: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] vlan_tag
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:239:28: sparse:     got int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:241:28: sparse: sparse: invalid assignment: |=
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:241:28: sparse:    left side has type restricted __le16
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:241:28: sparse:    right side has type int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:264:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tx_total_conc_seqs @@     got unsigned short [usertype] max_seq @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:264:38: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tx_total_conc_seqs
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:264:38: sparse:     got unsigned short [usertype] max_seq
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:267:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] rx_max_fc_pay_len @@     got unsigned int [usertype] mfs @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:267:38: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] rx_max_fc_pay_len
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:267:38: sparse:     got unsigned int [usertype] mfs
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:269:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] rx_total_conc_seqs @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:269:38: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] rx_total_conc_seqs
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:269:38: sparse:     got int
>>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:273:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_lo @@     got unsigned int [usertype] confq_dma @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:273:43: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:273:43: sparse:     got unsigned int [usertype] confq_dma
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:274:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:274:43: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_first_pbe_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:274:43: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:332:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:332:31: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:332:31: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:333:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:333:31: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lcq_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:333:31: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:335:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:335:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:335:42: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:336:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:336:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] confq_pbl_base_addr_hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:336:42: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:410:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:410:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:410:29: sparse:     got unsigned int [usertype] context_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:411:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:411:26: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:411:26: sparse:     got unsigned int [usertype] fcoe_conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:469:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:469:32: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:469:32: sparse:     got unsigned int [usertype] context_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:470:29: sparse:     got unsigned int [usertype] fcoe_conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] context_id @@     got unsigned int [usertype] context_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] context_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:504:32: sparse:     got unsigned int [usertype] context_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] conn_id @@     got unsigned int [usertype] fcoe_conn_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:505:29: sparse:     got unsigned int [usertype] fcoe_conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fr_crc @@     got restricted __le32 [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     expected unsigned int [usertype] fr_crc
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:613:28: sparse:     got restricted __le32 [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:696:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __le16 [usertype] ox_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:696:21: sparse:     expected unsigned short [usertype] xid
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:696:21: sparse:     got restricted __le16 [usertype] ox_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:731:27: sparse: sparse: cast from restricted __le32
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:732:26: sparse: sparse: cast from restricted __le32
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: cast from restricted __le16
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] ox_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse:     expected unsigned short [usertype] val
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse:     got restricted __le16 [usertype] ox_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: cast from restricted __le16
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:23: sparse: sparse: cast from restricted __le16
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] xid @@     got restricted __be16 [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:21: sparse:     expected unsigned short [usertype] xid
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:812:21: sparse:     got restricted __be16 [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:826:27: sparse: sparse: cast from restricted __le32
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:827:26: sparse: sparse: cast from restricted __le32
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:893:45: sparse: sparse: restricted __le16 degrades to integer
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:970:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] doorbell_cq_cons @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:970:33: sparse:     expected restricted __le16 [usertype] doorbell_cq_cons
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:970:33: sparse:     got int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:973:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1027:43: sparse: sparse: restricted __le16 degrades to integer
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1097:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] wqe @@     got restricted __le16 [usertype] wqe @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1097:22: sparse:     expected unsigned short [usertype] wqe
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1097:22: sparse:     got restricted __le16 [usertype] wqe
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1261:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] conn_id @@     got restricted __le32 [usertype] fcoe_conn_id @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1261:17: sparse:     expected unsigned int [usertype] conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1261:17: sparse:     got restricted __le32 [usertype] fcoe_conn_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1377:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] err_code @@     got restricted __le32 [usertype] completion_status @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1377:53: sparse:     expected unsigned int [usertype] err_code
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1377:53: sparse:     got restricted __le32 [usertype] completion_status
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1429:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wqe @@     got int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1429:18: sparse:     expected restricted __le16 [usertype] wqe
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1429:18: sparse:     got int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1430:18: sparse: sparse: invalid assignment: |=
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1430:18: sparse:    left side has type restricted __le16
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1430:18: sparse:    right side has type int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1448:9: sparse: sparse: cast from restricted __le32
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1532:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1532:46: sparse:     expected restricted __le32 [usertype] init_flags
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1532:46: sparse:     got unsigned int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1534:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] init_flags @@     got unsigned int @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1534:46: sparse:     expected restricted __le32 [usertype] init_flags
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1534:46: sparse:     got unsigned int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1537:63: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cleaned_task_id @@     got unsigned short [usertype] orig_xid @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1537:63: sparse:     expected restricted __le16 [usertype] cleaned_task_id
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1537:63: sparse:     got unsigned short [usertype] orig_xid
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1540:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] rolled_tx_data_offset @@     got unsigned int [usertype] offset @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1540:69: sparse:     expected restricted __le32 [usertype] rolled_tx_data_offset
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1540:69: sparse:     got unsigned int [usertype] offset
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1546:35: sparse: sparse: restricted __le16 degrades to integer
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1548:24: sparse: sparse: invalid assignment: -=
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1548:24: sparse:    left side has type unsigned int
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1548:24: sparse:    right side has type restricted __le16
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1553:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] lo @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1553:69: sparse:     expected restricted __le32 [usertype] lo
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1553:69: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1555:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] hi @@     got unsigned int [usertype] @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1555:69: sparse:     expected restricted __le32 [usertype] hi
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1555:69: sparse:     got unsigned int [usertype]
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cur_sge_off @@     got unsigned int [usertype] offset @@
>     drivers/scsi/bnx2fc/bnx2fc_hwi.c:1559:65: sparse:     expected restricted __le16 [usertype] cur_sge_off
>
> vim +2449 drivers/scsi/myrs.c
>
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2444
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2445  static inline bool DAC960_GEM_init_in_progress(void __iomem *base)
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2446  {
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2447  	__le32 val;
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2448
> 77266186397c6c78 Hannes Reinecke 2018-10-17 @2449  	val = readl(base + DAC960_GEM_IDB_READ_OFFSET);
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2450  	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_INIT_IN_PROGRESS;
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2451  }
> 77266186397c6c78 Hannes Reinecke 2018-10-17  2452
>
> :::::: The code at line 2449 was first introduced by commit
> :::::: 77266186397c6c782a3f670d32808a9671806ec5 scsi: myrs: Add Mylex RAID controller (SCSI interface)
>
> :::::: TO: Hannes Reinecke <hare@suse.com>
> :::::: CC: Martin K. Petersen <martin.petersen@oracle.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
