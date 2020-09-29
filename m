Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088D27BC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgI2F1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:27:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:34566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2F1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:27:11 -0400
IronPort-SDR: RnZLr2uHzFyUI0hqaFRIYpx2ModExR3YSc2xVc9TjcgEa1p+nhV7xb2x6mqvmApWifK5r0ueJM
 AZK4dV6mJQ5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="149775504"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="149775504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 22:26:55 -0700
IronPort-SDR: 7AnpQbV7Jp5ueTopG3L8NlCRFz1G7fBBD9VBsvc43i5aFwwqO1aBGlyRYk0uN75c5/NOy1DgPl
 +6SjpoHzbTag==
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="489058439"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 22:26:53 -0700
Subject: Re: [LKP] Re: [drm/dp] 6509ca051a: PANIC:double_fault
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200924143049.GJ28663@shao2-debian>
 <20200924164203.GL6112@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <90f391ac-e65c-c172-8fcb-ee1fe71de09a@intel.com>
Date:   Tue, 29 Sep 2020 13:26:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200924164203.GL6112@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/20 12:42 AM, Ville Syrjälä wrote:
> On Thu, Sep 24, 2020 at 10:30:49PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 6509ca051abf4ff60d63732badcb2173a715f741 ("drm/dp: Add drm_dp_downstream_{min,max}_tmds_clock()")
> That doesn't really do anything on its own. So can't see how it would
> make anything blow up.

Hi Ville,

The issue is 100% reproducible, could you try the reproduce steps:

To reproduce:

         # build kernel
	cd linux
	cp config-5.9.0-rc4-00881-g6509ca051abf4 .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage

         git clone https://github.com/intel/lkp-tests.git
         cd lkp-tests
         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email


Best Regards,
Rong Chen

>
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>>
>> in testcase: boot
>>
>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +-------------------------------------------------------+------------+------------+
>> |                                                       | fe7cf496e5 | 6509ca051a |
>> +-------------------------------------------------------+------------+------------+
>> | boot_successes                                        | 4          | 0          |
>> | boot_failures                                         | 0          | 7          |
>> | PANIC:double_fault                                    | 0          | 7          |
>> | double_fault:#[##]                                    | 0          | 7          |
>> | EIP:handle_exception                                  | 0          | 7          |
>> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 7          |
>> +-------------------------------------------------------+------------+------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> [   15.006925] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
>> [   15.007450] ac.o: No PCI boards found.
>> [   15.007720] ac.o: For an ISA board you must supply memory and irq parameters.
>> [   15.008278] toshiba: not a supported Toshiba laptop
>> [   15.010558] random: get_random_u32 called from arch_rnd+0x1c/0x40 with crng_init=0
>> [   15.011048] traps: PANIC: double fault, error_code: 0x0
>> [   15.011048] double fault: 0000 [#1] PREEMPT SMP PTI
>> [   15.011048] CPU: 1 PID: 147 Comm: modprobe Not tainted 5.9.0-rc4-00881-g6509ca051abf4 #1
>> [   15.011048] EIP: handle_exception+0x0/0x128
>> [   15.011048] Code: 24 10 36 89 48 fc 8b 4c 24 0c 81 e1 ff ff 00 00 36 89 48 f8 8b 4c 24 08 36 89 48 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 cf <fc> 0f a0 50 b8 d8 00 00 00 8e e0 58 81 64 24 10 ff ff 00 00 f7 44
>> [   15.011048] EAX: 2262d000 EBX: ffa2efbc ECX: 00000000 EDX: c28dacf6
>> [   15.011048] ESI: e2629ff0 EDI: ffa2f000 EBP: 00000000 ESP: ffa2e008
>> [   15.011048] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010006
>> [   15.011048] CR0: 80050033 CR2: ffa2dffc CR3: 02db2000 CR4: 000406b0
>> [   15.011048] Call Trace:
>> [   15.011048]  <ENTRY_TRAMPOLINE>
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80/0x80
>> [   15.011048]  ? sysvec_kvm_asyncpf_interrupt+0x50/0x50
>> [   15.011048]  ? restore_all_switch_stack+0x80
>> [   15.011048] Lost 217 message(s)!
>> [   15.011048] ---[ end trace 94527bd98e02a7a3 ]---
>> [   15.011048] EIP: handle_exception+0x0/0x128
>> [   15.011048] Code: 24 10 36 89 48 fc 8b 4c 24 0c 81 e1 ff ff 00 00 36 89 48 f8 8b 4c 24 08 36 89 48 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 cf <fc> 0f a0 50 b8 d8 00 00 00 8e e0 58 81 64 24 10 ff ff 00 00 f7 44
>> [   15.011048] EAX: 2262d000 EBX: ffa2efbc ECX: 00000000 EDX: c28dacf6
>> [   15.011048] ESI: e2629ff0 EDI: ffa2f000 EBP: 00000000 ESP: ffa2e008
>> [   15.011048] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010006
>> [   15.011048] CR0: 80050033 CR2: ffa2dffc CR3: 02db2000 CR4: 000406b0
>> [   15.011048] Kernel panic - not syncing: Fatal exception in interrupt
>> [   15.011048] Kernel Offset: disabled
>>
>> Kboot worker: lkp-worker30
>> Elapsed time: 60
>>
>>
>>
>> To reproduce:
>>
>>          # build kernel
>> 	cd linux
>> 	cp config-5.9.0-rc4-00881-g6509ca051abf4 .config
>> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> lkp
>>
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/i386 5.9.0-rc4 Kernel Configuration
>> #
>> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
>> CONFIG_CC_IS_GCC=y
>> CONFIG_GCC_VERSION=90300
>> CONFIG_LD_VERSION=235000000
>> CONFIG_CLANG_VERSION=0
>> CONFIG_CC_HAS_ASM_GOTO=y
>> CONFIG_CC_HAS_ASM_INLINE=y
>> CONFIG_CONSTRUCTORS=y
>> CONFIG_IRQ_WORK=y
>> CONFIG_BUILDTIME_TABLE_SORT=y
>> CONFIG_THREAD_INFO_IN_TASK=y
>>
>> #
>> # General setup
>> #
>> CONFIG_INIT_ENV_ARG_LIMIT=32
>> # CONFIG_COMPILE_TEST is not set
>> CONFIG_LOCALVERSION=""
>> CONFIG_LOCALVERSION_AUTO=y
>> CONFIG_BUILD_SALT=""
>> CONFIG_HAVE_KERNEL_GZIP=y
>> CONFIG_HAVE_KERNEL_BZIP2=y
>> CONFIG_HAVE_KERNEL_LZMA=y
>> CONFIG_HAVE_KERNEL_XZ=y
>> CONFIG_HAVE_KERNEL_LZO=y
>> CONFIG_HAVE_KERNEL_LZ4=y
>> CONFIG_HAVE_KERNEL_ZSTD=y
>> # CONFIG_KERNEL_GZIP is not set
>> # CONFIG_KERNEL_BZIP2 is not set
>> # CONFIG_KERNEL_LZMA is not set
>> # CONFIG_KERNEL_XZ is not set
>> # CONFIG_KERNEL_LZO is not set
>> CONFIG_KERNEL_LZ4=y
>> # CONFIG_KERNEL_ZSTD is not set
>> CONFIG_DEFAULT_INIT=""
>> CONFIG_DEFAULT_HOSTNAME="(none)"
>> # CONFIG_SYSVIPC is not set
>> CONFIG_POSIX_MQUEUE=y
>> CONFIG_POSIX_MQUEUE_SYSCTL=y
>> # CONFIG_WATCH_QUEUE is not set
>> CONFIG_CROSS_MEMORY_ATTACH=y
>> CONFIG_USELIB=y
>> CONFIG_AUDIT=y
>> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>> CONFIG_AUDITSYSCALL=y
>>
>> #
>> # IRQ subsystem
>> #
>> CONFIG_GENERIC_IRQ_PROBE=y
>> CONFIG_GENERIC_IRQ_SHOW=y
>> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
>> CONFIG_GENERIC_PENDING_IRQ=y
>> CONFIG_GENERIC_IRQ_MIGRATION=y
>> CONFIG_GENERIC_IRQ_INJECTION=y
>> CONFIG_HARDIRQS_SW_RESEND=y
>> CONFIG_GENERIC_IRQ_CHIP=y
>> CONFIG_IRQ_DOMAIN=y
>> CONFIG_IRQ_DOMAIN_HIERARCHY=y
>> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
>> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
>> CONFIG_IRQ_FORCED_THREADING=y
>> CONFIG_SPARSE_IRQ=y
>> CONFIG_GENERIC_IRQ_DEBUGFS=y
>> # end of IRQ subsystem
>>
>> CONFIG_CLOCKSOURCE_WATCHDOG=y
>> CONFIG_ARCH_CLOCKSOURCE_INIT=y
>> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
>> CONFIG_GENERIC_TIME_VSYSCALL=y
>> CONFIG_GENERIC_CLOCKEVENTS=y
>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
>> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
>> CONFIG_GENERIC_CMOS_UPDATE=y
>> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
>>
>> #
>> # Timers subsystem
>> #
>> CONFIG_HZ_PERIODIC=y
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ=y
>> # CONFIG_HIGH_RES_TIMERS is not set
>> # end of Timers subsystem
>>
>> # CONFIG_PREEMPT_NONE is not set
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_PREEMPTION=y
>>
>> #
>> # CPU/Task time and stats accounting
>> #
>> CONFIG_TICK_CPU_ACCOUNTING=y
>> CONFIG_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_SCHED_AVG_IRQ=y
>> # CONFIG_BSD_PROCESS_ACCT is not set
>> # CONFIG_TASKSTATS is not set
>> # CONFIG_PSI is not set
>> # end of CPU/Task time and stats accounting
>>
>> CONFIG_CPU_ISOLATION=y
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_TREE_RCU=y
>> CONFIG_PREEMPT_RCU=y
>> # CONFIG_RCU_EXPERT is not set
>> CONFIG_SRCU=y
>> CONFIG_TREE_SRCU=y
>> CONFIG_TASKS_RCU_GENERIC=y
>> CONFIG_TASKS_RCU=y
>> CONFIG_TASKS_RUDE_RCU=y
>> CONFIG_TASKS_TRACE_RCU=y
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_RCU_NEED_SEGCBLIST=y
>> # end of RCU Subsystem
>>
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> # CONFIG_IKHEADERS is not set
>> CONFIG_LOG_BUF_SHIFT=20
>> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>>
>> #
>> # Scheduler features
>> #
>> # CONFIG_UCLAMP_TASK is not set
>> # end of Scheduler features
>>
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
>> CONFIG_CGROUPS=y
>> CONFIG_PAGE_COUNTER=y
>> CONFIG_MEMCG=y
>> CONFIG_MEMCG_KMEM=y
>> # CONFIG_CGROUP_SCHED is not set
>> # CONFIG_CGROUP_PIDS is not set
>> # CONFIG_CGROUP_RDMA is not set
>> # CONFIG_CGROUP_FREEZER is not set
>> # CONFIG_CPUSETS is not set
>> CONFIG_CGROUP_DEVICE=y
>> CONFIG_CGROUP_CPUACCT=y
>> # CONFIG_CGROUP_PERF is not set
>> # CONFIG_CGROUP_BPF is not set
>> # CONFIG_CGROUP_DEBUG is not set
>> CONFIG_SOCK_CGROUP_DATA=y
>> # CONFIG_NAMESPACES is not set
>> CONFIG_CHECKPOINT_RESTORE=y
>> # CONFIG_SCHED_AUTOGROUP is not set
>> # CONFIG_SYSFS_DEPRECATED is not set
>> CONFIG_RELAY=y
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_INITRAMFS_SOURCE=""
>> CONFIG_RD_GZIP=y
>> # CONFIG_RD_BZIP2 is not set
>> CONFIG_RD_LZMA=y
>> CONFIG_RD_XZ=y
>> # CONFIG_RD_LZO is not set
>> CONFIG_RD_LZ4=y
>> CONFIG_RD_ZSTD=y
>> # CONFIG_BOOT_CONFIG is not set
>> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
>> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>> CONFIG_SYSCTL=y
>> CONFIG_HAVE_UID16=y
>> CONFIG_SYSCTL_EXCEPTION_TRACE=y
>> CONFIG_HAVE_PCSPKR_PLATFORM=y
>> CONFIG_BPF=y
>> CONFIG_EXPERT=y
>> CONFIG_UID16=y
>> CONFIG_MULTIUSER=y
>> CONFIG_SGETMASK_SYSCALL=y
>> CONFIG_SYSFS_SYSCALL=y
>> CONFIG_FHANDLE=y
>> # CONFIG_POSIX_TIMERS is not set
>> CONFIG_PRINTK=y
>> CONFIG_PRINTK_NMI=y
>> CONFIG_BUG=y
>> # CONFIG_ELF_CORE is not set
>> CONFIG_PCSPKR_PLATFORM=y
>> # CONFIG_BASE_FULL is not set
>> CONFIG_FUTEX=y
>> CONFIG_FUTEX_PI=y
>> CONFIG_EPOLL=y
>> CONFIG_SIGNALFD=y
>> CONFIG_TIMERFD=y
>> CONFIG_EVENTFD=y
>> CONFIG_SHMEM=y
>> CONFIG_AIO=y
>> CONFIG_IO_URING=y
>> # CONFIG_ADVISE_SYSCALLS is not set
>> CONFIG_MEMBARRIER=y
>> CONFIG_KALLSYMS=y
>> CONFIG_KALLSYMS_ALL=y
>> CONFIG_KALLSYMS_BASE_RELATIVE=y
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_USERFAULTFD=y
>> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
>> CONFIG_RSEQ=y
>> CONFIG_DEBUG_RSEQ=y
>> CONFIG_EMBEDDED=y
>> CONFIG_HAVE_PERF_EVENTS=y
>> # CONFIG_PC104 is not set
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> CONFIG_PERF_EVENTS=y
>> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>> # end of Kernel Performance Events And Counters
>>
>> CONFIG_VM_EVENT_COUNTERS=y
>> CONFIG_COMPAT_BRK=y
>> CONFIG_SLAB=y
>> # CONFIG_SLUB is not set
>> # CONFIG_SLOB is not set
>> CONFIG_SLAB_MERGE_DEFAULT=y
>> # CONFIG_SLAB_FREELIST_RANDOM is not set
>> # CONFIG_SLAB_FREELIST_HARDENED is not set
>> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
>> CONFIG_SYSTEM_DATA_VERIFICATION=y
>> # CONFIG_PROFILING is not set
>> CONFIG_TRACEPOINTS=y
>> # end of General setup
>>
>> CONFIG_X86_32=y
>> CONFIG_X86=y
>> CONFIG_INSTRUCTION_DECODER=y
>> CONFIG_OUTPUT_FORMAT="elf32-i386"
>> CONFIG_LOCKDEP_SUPPORT=y
>> CONFIG_STACKTRACE_SUPPORT=y
>> CONFIG_MMU=y
>> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
>> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
>> CONFIG_GENERIC_ISA_DMA=y
>> CONFIG_GENERIC_BUG=y
>> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
>> CONFIG_GENERIC_CALIBRATE_DELAY=y
>> CONFIG_ARCH_HAS_CPU_RELAX=y
>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
>> CONFIG_ARCH_HAS_FILTER_PGPROT=y
>> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
>> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
>> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>> CONFIG_X86_32_SMP=y
>> CONFIG_ARCH_SUPPORTS_UPROBES=y
>> CONFIG_FIX_EARLYCON_MEM=y
>> CONFIG_PGTABLE_LEVELS=3
>> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>>
>> #
>> # Processor type and features
>> #
>> # CONFIG_ZONE_DMA is not set
>> CONFIG_SMP=y
>> CONFIG_X86_FEATURE_NAMES=y
>> # CONFIG_X86_MPPARSE is not set
>> # CONFIG_GOLDFISH is not set
>> # CONFIG_RETPOLINE is not set
>> # CONFIG_X86_CPU_RESCTRL is not set
>> # CONFIG_X86_BIGSMP is not set
>> CONFIG_X86_EXTENDED_PLATFORM=y
>> # CONFIG_X86_GOLDFISH is not set
>> # CONFIG_X86_INTEL_LPSS is not set
>> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
>> CONFIG_IOSF_MBI=y
>> CONFIG_IOSF_MBI_DEBUG=y
>> # CONFIG_X86_RDC321X is not set
>> CONFIG_X86_32_NON_STANDARD=y
>> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
>> # CONFIG_STA2X11 is not set
>> CONFIG_X86_32_IRIS=y
>> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>> CONFIG_HYPERVISOR_GUEST=y
>> CONFIG_PARAVIRT=y
>> # CONFIG_PARAVIRT_DEBUG is not set
>> # CONFIG_PARAVIRT_SPINLOCKS is not set
>> CONFIG_X86_HV_CALLBACK_VECTOR=y
>> # CONFIG_XEN is not set
>> CONFIG_KVM_GUEST=y
>> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
>> # CONFIG_PVH is not set
>> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
>> CONFIG_PARAVIRT_CLOCK=y
>> # CONFIG_M486SX is not set
>> # CONFIG_M486 is not set
>> # CONFIG_M586 is not set
>> # CONFIG_M586TSC is not set
>> # CONFIG_M586MMX is not set
>> # CONFIG_M686 is not set
>> # CONFIG_MPENTIUMII is not set
>> # CONFIG_MPENTIUMIII is not set
>> # CONFIG_MPENTIUMM is not set
>> # CONFIG_MPENTIUM4 is not set
>> # CONFIG_MK6 is not set
>> # CONFIG_MK7 is not set
>> CONFIG_MK8=y
>> # CONFIG_MCRUSOE is not set
>> # CONFIG_MEFFICEON is not set
>> # CONFIG_MWINCHIPC6 is not set
>> # CONFIG_MWINCHIP3D is not set
>> # CONFIG_MELAN is not set
>> # CONFIG_MGEODEGX1 is not set
>> # CONFIG_MGEODE_LX is not set
>> # CONFIG_MCYRIXIII is not set
>> # CONFIG_MVIAC3_2 is not set
>> # CONFIG_MVIAC7 is not set
>> # CONFIG_MCORE2 is not set
>> # CONFIG_MATOM is not set
>> CONFIG_X86_GENERIC=y
>> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
>> CONFIG_X86_L1_CACHE_SHIFT=6
>> CONFIG_X86_INTEL_USERCOPY=y
>> CONFIG_X86_USE_PPRO_CHECKSUM=y
>> CONFIG_X86_TSC=y
>> CONFIG_X86_CMPXCHG64=y
>> CONFIG_X86_CMOV=y
>> CONFIG_X86_MINIMUM_CPU_FAMILY=6
>> CONFIG_X86_DEBUGCTLMSR=y
>> CONFIG_IA32_FEAT_CTL=y
>> CONFIG_X86_VMX_FEATURE_NAMES=y
>> CONFIG_PROCESSOR_SELECT=y
>> # CONFIG_CPU_SUP_INTEL is not set
>> CONFIG_CPU_SUP_CYRIX_32=y
>> CONFIG_CPU_SUP_AMD=y
>> CONFIG_CPU_SUP_HYGON=y
>> CONFIG_CPU_SUP_CENTAUR=y
>> # CONFIG_CPU_SUP_TRANSMETA_32 is not set
>> CONFIG_CPU_SUP_UMC_32=y
>> CONFIG_CPU_SUP_ZHAOXIN=y
>> CONFIG_HPET_TIMER=y
>> # CONFIG_DMI is not set
>> CONFIG_NR_CPUS_RANGE_BEGIN=2
>> CONFIG_NR_CPUS_RANGE_END=8
>> CONFIG_NR_CPUS_DEFAULT=8
>> CONFIG_NR_CPUS=8
>> CONFIG_SCHED_SMT=y
>> # CONFIG_SCHED_MC is not set
>> CONFIG_X86_LOCAL_APIC=y
>> CONFIG_X86_IO_APIC=y
>> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
>> CONFIG_X86_MCE=y
>> # CONFIG_X86_MCELOG_LEGACY is not set
>> CONFIG_X86_MCE_INTEL=y
>> CONFIG_X86_MCE_AMD=y
>> # CONFIG_X86_ANCIENT_MCE is not set
>> CONFIG_X86_MCE_THRESHOLD=y
>> CONFIG_X86_MCE_INJECT=y
>> CONFIG_X86_THERMAL_VECTOR=y
>>
>> #
>> # Performance monitoring
>> #
>> CONFIG_PERF_EVENTS_INTEL_RAPL=y
>> # CONFIG_PERF_EVENTS_AMD_POWER is not set
>> # end of Performance monitoring
>>
>> CONFIG_X86_LEGACY_VM86=y
>> CONFIG_VM86=y
>> CONFIG_X86_IOPL_IOPERM=y
>> CONFIG_TOSHIBA=y
>> CONFIG_I8K=y
>> # CONFIG_X86_REBOOTFIXUPS is not set
>> CONFIG_MICROCODE=y
>> CONFIG_MICROCODE_INTEL=y
>> # CONFIG_MICROCODE_AMD is not set
>> CONFIG_MICROCODE_OLD_INTERFACE=y
>> CONFIG_X86_MSR=y
>> # CONFIG_X86_CPUID is not set
>> # CONFIG_NOHIGHMEM is not set
>> # CONFIG_HIGHMEM4G is not set
>> CONFIG_HIGHMEM64G=y
>> CONFIG_VMSPLIT_3G=y
>> # CONFIG_VMSPLIT_2G is not set
>> # CONFIG_VMSPLIT_1G is not set
>> CONFIG_PAGE_OFFSET=0xC0000000
>> CONFIG_HIGHMEM=y
>> CONFIG_X86_PAE=y
>> # CONFIG_X86_CPA_STATISTICS is not set
>> CONFIG_ARCH_FLATMEM_ENABLE=y
>> CONFIG_ARCH_SPARSEMEM_ENABLE=y
>> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>> CONFIG_ILLEGAL_POINTER_VALUE=0
>> CONFIG_HIGHPTE=y
>> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
>> CONFIG_X86_RESERVE_LOW=64
>> # CONFIG_MTRR is not set
>> # CONFIG_ARCH_RANDOM is not set
>> CONFIG_X86_SMAP=y
>> CONFIG_X86_UMIP=y
>> # CONFIG_EFI is not set
>> CONFIG_SECCOMP=y
>> # CONFIG_HZ_100 is not set
>> # CONFIG_HZ_250 is not set
>> # CONFIG_HZ_300 is not set
>> CONFIG_HZ_1000=y
>> CONFIG_HZ=1000
>> CONFIG_KEXEC=y
>> CONFIG_CRASH_DUMP=y
>> CONFIG_PHYSICAL_START=0x1000000
>> # CONFIG_RELOCATABLE is not set
>> CONFIG_PHYSICAL_ALIGN=0x200000
>> CONFIG_HOTPLUG_CPU=y
>> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
>> CONFIG_DEBUG_HOTPLUG_CPU0=y
>> CONFIG_COMPAT_VDSO=y
>> # CONFIG_CMDLINE_BOOL is not set
>> # CONFIG_MODIFY_LDT_SYSCALL is not set
>> # end of Processor type and features
>>
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
>>
>> #
>> # Power management and ACPI options
>> #
>> CONFIG_SUSPEND=y
>> CONFIG_SUSPEND_FREEZER=y
>> # CONFIG_SUSPEND_SKIP_SYNC is not set
>> CONFIG_PM_SLEEP=y
>> CONFIG_PM_SLEEP_SMP=y
>> # CONFIG_PM_AUTOSLEEP is not set
>> # CONFIG_PM_WAKELOCKS is not set
>> CONFIG_PM=y
>> # CONFIG_PM_DEBUG is not set
>> CONFIG_PM_CLK=y
>> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
>> # CONFIG_ENERGY_MODEL is not set
>> CONFIG_ARCH_SUPPORTS_ACPI=y
>> CONFIG_ACPI=y
>> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
>> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
>> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
>> # CONFIG_ACPI_DEBUGGER is not set
>> CONFIG_ACPI_SPCR_TABLE=y
>> CONFIG_ACPI_SLEEP=y
>> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
>> # CONFIG_ACPI_EC_DEBUGFS is not set
>> CONFIG_ACPI_AC=y
>> CONFIG_ACPI_BATTERY=y
>> CONFIG_ACPI_BUTTON=y
>> CONFIG_ACPI_VIDEO=y
>> CONFIG_ACPI_FAN=y
>> # CONFIG_ACPI_TAD is not set
>> # CONFIG_ACPI_DOCK is not set
>> CONFIG_ACPI_CPU_FREQ_PSS=y
>> CONFIG_ACPI_PROCESSOR_CSTATE=y
>> CONFIG_ACPI_PROCESSOR_IDLE=y
>> CONFIG_ACPI_PROCESSOR=y
>> # CONFIG_ACPI_IPMI is not set
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
>> CONFIG_ACPI_THERMAL=y
>> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
>> CONFIG_ACPI_TABLE_UPGRADE=y
>> # CONFIG_ACPI_DEBUG is not set
>> # CONFIG_ACPI_PCI_SLOT is not set
>> CONFIG_ACPI_CONTAINER=y
>> CONFIG_ACPI_HOTPLUG_IOAPIC=y
>> # CONFIG_ACPI_SBS is not set
>> # CONFIG_ACPI_HED is not set
>> # CONFIG_ACPI_CUSTOM_METHOD is not set
>> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
>> CONFIG_HAVE_ACPI_APEI=y
>> CONFIG_HAVE_ACPI_APEI_NMI=y
>> # CONFIG_ACPI_APEI is not set
>> # CONFIG_DPTF_POWER is not set
>> # CONFIG_PMIC_OPREGION is not set
>> # CONFIG_ACPI_CONFIGFS is not set
>> CONFIG_X86_PM_TIMER=y
>> CONFIG_SFI=y
>> CONFIG_X86_APM_BOOT=y
>> CONFIG_APM=y
>> CONFIG_APM_IGNORE_USER_SUSPEND=y
>> # CONFIG_APM_DO_ENABLE is not set
>> CONFIG_APM_CPU_IDLE=y
>> CONFIG_APM_DISPLAY_BLANK=y
>> CONFIG_APM_ALLOW_INTS=y
>>
>> #
>> # CPU Frequency scaling
>> #
>> CONFIG_CPU_FREQ=y
>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>> CONFIG_CPU_FREQ_GOV_COMMON=y
>> CONFIG_CPU_FREQ_STAT=y
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
>> CONFIG_CPU_FREQ_GOV_USERSPACE=y
>> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>>
>> #
>> # CPU frequency scaling drivers
>> #
>> CONFIG_X86_INTEL_PSTATE=y
>> # CONFIG_X86_PCC_CPUFREQ is not set
>> # CONFIG_X86_ACPI_CPUFREQ is not set
>> CONFIG_X86_POWERNOW_K6=y
>> CONFIG_X86_POWERNOW_K7=y
>> CONFIG_X86_POWERNOW_K7_ACPI=y
>> CONFIG_X86_GX_SUSPMOD=y
>> CONFIG_X86_SPEEDSTEP_CENTRINO=y
>> CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
>> # CONFIG_X86_SPEEDSTEP_ICH is not set
>> # CONFIG_X86_SPEEDSTEP_SMI is not set
>> # CONFIG_X86_P4_CLOCKMOD is not set
>> CONFIG_X86_CPUFREQ_NFORCE2=y
>> CONFIG_X86_LONGRUN=y
>> # CONFIG_X86_LONGHAUL is not set
>> # CONFIG_X86_E_POWERSAVER is not set
>>
>> #
>> # shared options
>> #
>> # end of CPU Frequency scaling
>>
>> #
>> # CPU Idle
>> #
>> CONFIG_CPU_IDLE=y
>> # CONFIG_CPU_IDLE_GOV_LADDER is not set
>> CONFIG_CPU_IDLE_GOV_MENU=y
>> # CONFIG_CPU_IDLE_GOV_TEO is not set
>> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
>> CONFIG_HALTPOLL_CPUIDLE=y
>> # end of CPU Idle
>> # end of Power management and ACPI options
>>
>> #
>> # Bus options (PCI etc.)
>> #
>> CONFIG_PCI_GOBIOS=y
>> # CONFIG_PCI_GOMMCONFIG is not set
>> # CONFIG_PCI_GODIRECT is not set
>> # CONFIG_PCI_GOANY is not set
>> CONFIG_PCI_BIOS=y
>> CONFIG_PCI_CNB20LE_QUIRK=y
>> # CONFIG_ISA_BUS is not set
>> CONFIG_ISA_DMA_API=y
>> # CONFIG_ISA is not set
>> CONFIG_SCx200=y
>> CONFIG_SCx200HR_TIMER=y
>> CONFIG_ALIX=y
>> # CONFIG_NET5501 is not set
>> CONFIG_AMD_NB=y
>> CONFIG_X86_SYSFB=y
>> # end of Bus options (PCI etc.)
>>
>> #
>> # Binary Emulations
>> #
>> CONFIG_COMPAT_32=y
>> # end of Binary Emulations
>>
>> CONFIG_HAVE_ATOMIC_IOMAP=y
>>
>> #
>> # Firmware Drivers
>> #
>> CONFIG_EDD=y
>> # CONFIG_EDD_OFF is not set
>> # CONFIG_FIRMWARE_MEMMAP is not set
>> CONFIG_FW_CFG_SYSFS=y
>> CONFIG_FW_CFG_SYSFS_CMDLINE=y
>> # CONFIG_GOOGLE_FIRMWARE is not set
>> CONFIG_EFI_EARLYCON=y
>>
>> #
>> # Tegra firmware driver
>> #
>> # end of Tegra firmware driver
>> # end of Firmware Drivers
>>
>> CONFIG_HAVE_KVM=y
>> CONFIG_VIRTUALIZATION=y
>> # CONFIG_KVM_WERROR is not set
>> CONFIG_AS_AVX512=y
>> CONFIG_AS_SHA1_NI=y
>> CONFIG_AS_SHA256_NI=y
>> CONFIG_AS_TPAUSE=y
>>
>> #
>> # General architecture-dependent options
>> #
>> CONFIG_CRASH_CORE=y
>> CONFIG_KEXEC_CORE=y
>> CONFIG_HOTPLUG_SMT=y
>> CONFIG_GENERIC_ENTRY=y
>> CONFIG_HAVE_OPROFILE=y
>> CONFIG_OPROFILE_NMI_TIMER=y
>> # CONFIG_KPROBES is not set
>> CONFIG_JUMP_LABEL=y
>> CONFIG_STATIC_KEYS_SELFTEST=y
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
>> CONFIG_HAVE_IOREMAP_PROT=y
>> CONFIG_HAVE_KPROBES=y
>> CONFIG_HAVE_KRETPROBES=y
>> CONFIG_HAVE_OPTPROBES=y
>> CONFIG_HAVE_KPROBES_ON_FTRACE=y
>> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
>> CONFIG_HAVE_NMI=y
>> CONFIG_HAVE_ARCH_TRACEHOOK=y
>> CONFIG_HAVE_DMA_CONTIGUOUS=y
>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
>> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>> CONFIG_ARCH_HAS_SET_MEMORY=y
>> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
>> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
>> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>> CONFIG_ARCH_32BIT_OFF_T=y
>> CONFIG_HAVE_ASM_MODVERSIONS=y
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>> CONFIG_HAVE_RSEQ=y
>> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
>> CONFIG_HAVE_HW_BREAKPOINT=y
>> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_PERF_EVENTS_NMI=y
>> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HAVE_PERF_REGS=y
>> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
>> CONFIG_MMU_GATHER_TABLE_FREE=y
>> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
>> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
>> CONFIG_HAVE_CMPXCHG_LOCAL=y
>> CONFIG_HAVE_CMPXCHG_DOUBLE=y
>> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
>> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
>> CONFIG_SECCOMP_FILTER=y
>> CONFIG_HAVE_ARCH_STACKLEAK=y
>> CONFIG_HAVE_STACKPROTECTOR=y
>> CONFIG_STACKPROTECTOR=y
>> CONFIG_STACKPROTECTOR_STRONG=y
>> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_MOVE_PMD=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HAVE_ARCH_HUGE_VMAP=y
>> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
>> CONFIG_MODULES_USE_ELF_REL=y
>> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
>> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
>> CONFIG_HAVE_EXIT_THREAD=y
>> CONFIG_ARCH_MMAP_RND_BITS=8
>> CONFIG_ISA_BUS_API=y
>> CONFIG_CLONE_BACKWARDS=y
>> CONFIG_OLD_SIGSUSPEND3=y
>> CONFIG_OLD_SIGACTION=y
>> CONFIG_COMPAT_32BIT_TIME=y
>> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
>> CONFIG_STRICT_KERNEL_RWX=y
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>> CONFIG_STRICT_MODULE_RWX=y
>> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
>> CONFIG_ARCH_USE_MEMREMAP_PROT=y
>> # CONFIG_LOCK_EVENT_COUNTS is not set
>> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> CONFIG_GCOV_KERNEL=y
>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>> # CONFIG_GCOV_PROFILE_ALL is not set
>> # end of GCOV-based kernel profiling
>>
>> CONFIG_HAVE_GCC_PLUGINS=y
>> # end of General architecture-dependent options
>>
>> CONFIG_RT_MUTEXES=y
>> CONFIG_BASE_SMALL=1
>> CONFIG_MODULES=y
>> # CONFIG_MODULE_FORCE_LOAD is not set
>> # CONFIG_MODULE_UNLOAD is not set
>> # CONFIG_MODVERSIONS is not set
>> # CONFIG_MODULE_SRCVERSION_ALL is not set
>> # CONFIG_MODULE_SIG is not set
>> # CONFIG_MODULE_COMPRESS is not set
>> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
>> # CONFIG_UNUSED_SYMBOLS is not set
>> # CONFIG_TRIM_UNUSED_KSYMS is not set
>> CONFIG_MODULES_TREE_LOOKUP=y
>> # CONFIG_BLOCK is not set
>> CONFIG_PADATA=y
>> CONFIG_ASN1=y
>> CONFIG_UNINLINE_SPIN_UNLOCK=y
>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
>> CONFIG_MUTEX_SPIN_ON_OWNER=y
>> CONFIG_RWSEM_SPIN_ON_OWNER=y
>> CONFIG_LOCK_SPIN_ON_OWNER=y
>> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
>> CONFIG_QUEUED_SPINLOCKS=y
>> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
>> CONFIG_QUEUED_RWLOCKS=y
>> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
>> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
>> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
>> CONFIG_FREEZER=y
>>
>> #
>> # Executable file formats
>> #
>> CONFIG_BINFMT_ELF=y
>> CONFIG_ELFCORE=y
>> CONFIG_BINFMT_SCRIPT=y
>> # CONFIG_BINFMT_MISC is not set
>> CONFIG_COREDUMP=y
>> # end of Executable file formats
>>
>> #
>> # Memory Management options
>> #
>> CONFIG_SELECT_MEMORY_MODEL=y
>> CONFIG_FLATMEM_MANUAL=y
>> # CONFIG_SPARSEMEM_MANUAL is not set
>> CONFIG_FLATMEM=y
>> CONFIG_FLAT_NODE_MEM_MAP=y
>> CONFIG_SPARSEMEM_STATIC=y
>> CONFIG_HAVE_FAST_GUP=y
>> CONFIG_MEMORY_ISOLATION=y
>> CONFIG_SPLIT_PTLOCK_CPUS=4
>> CONFIG_MEMORY_BALLOON=y
>> # CONFIG_BALLOON_COMPACTION is not set
>> CONFIG_COMPACTION=y
>> CONFIG_PAGE_REPORTING=y
>> CONFIG_MIGRATION=y
>> CONFIG_CONTIG_ALLOC=y
>> CONFIG_PHYS_ADDR_T_64BIT=y
>> CONFIG_VIRT_TO_BUS=y
>> CONFIG_MMU_NOTIFIER=y
>> # CONFIG_KSM is not set
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
>> CONFIG_MEMORY_FAILURE=y
>> CONFIG_HWPOISON_INJECT=y
>> # CONFIG_TRANSPARENT_HUGEPAGE is not set
>> CONFIG_CLEANCACHE=y
>> # CONFIG_CMA is not set
>> CONFIG_ZPOOL=y
>> CONFIG_ZBUD=y
>> # CONFIG_Z3FOLD is not set
>> # CONFIG_ZSMALLOC is not set
>> CONFIG_GENERIC_EARLY_IOREMAP=y
>> CONFIG_IDLE_PAGE_TRACKING=y
>> CONFIG_HMM_MIRROR=y
>> # CONFIG_PERCPU_STATS is not set
>> # CONFIG_GUP_BENCHMARK is not set
>> CONFIG_GUP_GET_PTE_LOW_HIGH=y
>> CONFIG_ARCH_HAS_PTE_SPECIAL=y
>> # end of Memory Management options
>>
>> CONFIG_NET=y
>> CONFIG_SKB_EXTENSIONS=y
>>
>> #
>> # Networking options
>> #
>> # CONFIG_PACKET is not set
>> CONFIG_UNIX=y
>> CONFIG_UNIX_SCM=y
>> # CONFIG_UNIX_DIAG is not set
>> CONFIG_TLS=y
>> CONFIG_TLS_DEVICE=y
>> # CONFIG_TLS_TOE is not set
>> CONFIG_XFRM=y
>> CONFIG_XFRM_ALGO=y
>> CONFIG_XFRM_USER=y
>> CONFIG_XFRM_INTERFACE=y
>> CONFIG_XFRM_SUB_POLICY=y
>> # CONFIG_XFRM_MIGRATE is not set
>> CONFIG_XFRM_STATISTICS=y
>> CONFIG_XFRM_AH=y
>> CONFIG_XFRM_ESP=y
>> CONFIG_NET_KEY=y
>> # CONFIG_NET_KEY_MIGRATE is not set
>> # CONFIG_SMC is not set
>> # CONFIG_XDP_SOCKETS is not set
>> CONFIG_INET=y
>> CONFIG_IP_MULTICAST=y
>> CONFIG_IP_ADVANCED_ROUTER=y
>> CONFIG_IP_FIB_TRIE_STATS=y
>> CONFIG_IP_MULTIPLE_TABLES=y
>> CONFIG_IP_ROUTE_MULTIPATH=y
>> # CONFIG_IP_ROUTE_VERBOSE is not set
>> CONFIG_IP_PNP=y
>> CONFIG_IP_PNP_DHCP=y
>> CONFIG_IP_PNP_BOOTP=y
>> CONFIG_IP_PNP_RARP=y
>> CONFIG_NET_IPIP=y
>> CONFIG_NET_IPGRE_DEMUX=y
>> CONFIG_NET_IP_TUNNEL=y
>> # CONFIG_NET_IPGRE is not set
>> CONFIG_IP_MROUTE_COMMON=y
>> CONFIG_IP_MROUTE=y
>> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
>> # CONFIG_IP_PIMSM_V1 is not set
>> # CONFIG_IP_PIMSM_V2 is not set
>> # CONFIG_SYN_COOKIES is not set
>> # CONFIG_NET_IPVTI is not set
>> CONFIG_NET_UDP_TUNNEL=y
>> CONFIG_NET_FOU=y
>> CONFIG_NET_FOU_IP_TUNNELS=y
>> CONFIG_INET_AH=y
>> CONFIG_INET_ESP=y
>> # CONFIG_INET_ESP_OFFLOAD is not set
>> # CONFIG_INET_ESPINTCP is not set
>> # CONFIG_INET_IPCOMP is not set
>> CONFIG_INET_TUNNEL=y
>> CONFIG_INET_DIAG=y
>> CONFIG_INET_TCP_DIAG=y
>> CONFIG_INET_UDP_DIAG=y
>> # CONFIG_INET_RAW_DIAG is not set
>> CONFIG_INET_DIAG_DESTROY=y
>> CONFIG_TCP_CONG_ADVANCED=y
>> CONFIG_TCP_CONG_BIC=y
>> CONFIG_TCP_CONG_CUBIC=y
>> CONFIG_TCP_CONG_WESTWOOD=y
>> CONFIG_TCP_CONG_HTCP=y
>> # CONFIG_TCP_CONG_HSTCP is not set
>> CONFIG_TCP_CONG_HYBLA=y
>> CONFIG_TCP_CONG_VEGAS=y
>> CONFIG_TCP_CONG_NV=y
>> # CONFIG_TCP_CONG_SCALABLE is not set
>> CONFIG_TCP_CONG_LP=y
>> # CONFIG_TCP_CONG_VENO is not set
>> # CONFIG_TCP_CONG_YEAH is not set
>> # CONFIG_TCP_CONG_ILLINOIS is not set
>> # CONFIG_TCP_CONG_DCTCP is not set
>> # CONFIG_TCP_CONG_CDG is not set
>> CONFIG_TCP_CONG_BBR=y
>> # CONFIG_DEFAULT_BIC is not set
>> CONFIG_DEFAULT_CUBIC=y
>> # CONFIG_DEFAULT_HTCP is not set
>> # CONFIG_DEFAULT_HYBLA is not set
>> # CONFIG_DEFAULT_VEGAS is not set
>> # CONFIG_DEFAULT_WESTWOOD is not set
>> # CONFIG_DEFAULT_BBR is not set
>> # CONFIG_DEFAULT_RENO is not set
>> CONFIG_DEFAULT_TCP_CONG="cubic"
>> CONFIG_TCP_MD5SIG=y
>> CONFIG_IPV6=y
>> CONFIG_IPV6_ROUTER_PREF=y
>> # CONFIG_IPV6_ROUTE_INFO is not set
>> CONFIG_IPV6_OPTIMISTIC_DAD=y
>> CONFIG_INET6_AH=y
>> CONFIG_INET6_ESP=y
>> # CONFIG_INET6_ESP_OFFLOAD is not set
>> # CONFIG_INET6_ESPINTCP is not set
>> # CONFIG_INET6_IPCOMP is not set
>> # CONFIG_IPV6_MIP6 is not set
>> CONFIG_INET6_TUNNEL=y
>> # CONFIG_IPV6_VTI is not set
>> CONFIG_IPV6_SIT=y
>> # CONFIG_IPV6_SIT_6RD is not set
>> CONFIG_IPV6_NDISC_NODETYPE=y
>> CONFIG_IPV6_TUNNEL=y
>> CONFIG_IPV6_GRE=y
>> CONFIG_IPV6_FOU=y
>> CONFIG_IPV6_FOU_TUNNEL=y
>> CONFIG_IPV6_MULTIPLE_TABLES=y
>> # CONFIG_IPV6_SUBTREES is not set
>> # CONFIG_IPV6_MROUTE is not set
>> CONFIG_IPV6_SEG6_LWTUNNEL=y
>> # CONFIG_IPV6_SEG6_HMAC is not set
>> CONFIG_IPV6_SEG6_BPF=y
>> # CONFIG_IPV6_RPL_LWTUNNEL is not set
>> # CONFIG_MPTCP is not set
>> CONFIG_NETWORK_SECMARK=y
>> CONFIG_NET_PTP_CLASSIFY=y
>> CONFIG_NETWORK_PHY_TIMESTAMPING=y
>> # CONFIG_NETFILTER is not set
>> CONFIG_BPFILTER=y
>> # CONFIG_IP_DCCP is not set
>> CONFIG_IP_SCTP=y
>> CONFIG_SCTP_DBG_OBJCNT=y
>> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
>> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
>> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
>> CONFIG_SCTP_COOKIE_HMAC_MD5=y
>> CONFIG_SCTP_COOKIE_HMAC_SHA1=y
>> CONFIG_INET_SCTP_DIAG=y
>> # CONFIG_RDS is not set
>> CONFIG_TIPC=y
>> CONFIG_TIPC_MEDIA_UDP=y
>> CONFIG_TIPC_CRYPTO=y
>> # CONFIG_TIPC_DIAG is not set
>> CONFIG_ATM=y
>> CONFIG_ATM_CLIP=y
>> CONFIG_ATM_CLIP_NO_ICMP=y
>> CONFIG_ATM_LANE=y
>> CONFIG_ATM_MPOA=y
>> # CONFIG_ATM_BR2684 is not set
>> CONFIG_L2TP=y
>> CONFIG_L2TP_DEBUGFS=y
>> # CONFIG_L2TP_V3 is not set
>> # CONFIG_BRIDGE is not set
>> CONFIG_HAVE_NET_DSA=y
>> # CONFIG_NET_DSA is not set
>> CONFIG_VLAN_8021Q=y
>> # CONFIG_VLAN_8021Q_GVRP is not set
>> # CONFIG_VLAN_8021Q_MVRP is not set
>> CONFIG_DECNET=y
>> # CONFIG_DECNET_ROUTER is not set
>> CONFIG_LLC=y
>> CONFIG_LLC2=y
>> CONFIG_ATALK=y
>> CONFIG_DEV_APPLETALK=y
>> CONFIG_IPDDP=y
>> # CONFIG_IPDDP_ENCAP is not set
>> # CONFIG_X25 is not set
>> CONFIG_LAPB=y
>> CONFIG_PHONET=y
>> CONFIG_6LOWPAN=y
>> # CONFIG_6LOWPAN_DEBUGFS is not set
>> CONFIG_6LOWPAN_NHC=y
>> CONFIG_6LOWPAN_NHC_DEST=y
>> CONFIG_6LOWPAN_NHC_FRAGMENT=y
>> # CONFIG_6LOWPAN_NHC_HOP is not set
>> CONFIG_6LOWPAN_NHC_IPV6=y
>> # CONFIG_6LOWPAN_NHC_MOBILITY is not set
>> CONFIG_6LOWPAN_NHC_ROUTING=y
>> CONFIG_6LOWPAN_NHC_UDP=y
>> # CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
>> # CONFIG_6LOWPAN_GHC_UDP is not set
>> CONFIG_6LOWPAN_GHC_ICMPV6=y
>> CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=y
>> CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=y
>> # CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
>> CONFIG_IEEE802154=y
>> CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
>> # CONFIG_IEEE802154_SOCKET is not set
>> # CONFIG_IEEE802154_6LOWPAN is not set
>> CONFIG_MAC802154=y
>> # CONFIG_NET_SCHED is not set
>> CONFIG_DCB=y
>> CONFIG_DNS_RESOLVER=y
>> # CONFIG_BATMAN_ADV is not set
>> CONFIG_OPENVSWITCH=y
>> CONFIG_VSOCKETS=y
>> CONFIG_VSOCKETS_DIAG=y
>> CONFIG_VSOCKETS_LOOPBACK=y
>> CONFIG_VIRTIO_VSOCKETS=y
>> CONFIG_VIRTIO_VSOCKETS_COMMON=y
>> # CONFIG_NETLINK_DIAG is not set
>> CONFIG_MPLS=y
>> CONFIG_NET_MPLS_GSO=y
>> # CONFIG_MPLS_ROUTING is not set
>> CONFIG_NET_NSH=y
>> # CONFIG_HSR is not set
>> CONFIG_NET_SWITCHDEV=y
>> # CONFIG_NET_L3_MASTER_DEV is not set
>> # CONFIG_QRTR is not set
>> CONFIG_NET_NCSI=y
>> # CONFIG_NCSI_OEM_CMD_GET_MAC is not set
>> CONFIG_RPS=y
>> CONFIG_RFS_ACCEL=y
>> CONFIG_XPS=y
>> CONFIG_CGROUP_NET_PRIO=y
>> # CONFIG_CGROUP_NET_CLASSID is not set
>> CONFIG_NET_RX_BUSY_POLL=y
>> CONFIG_BQL=y
>> # CONFIG_BPF_JIT is not set
>> CONFIG_NET_FLOW_LIMIT=y
>>
>> #
>> # Network testing
>> #
>> # CONFIG_NET_PKTGEN is not set
>> # CONFIG_NET_DROP_MONITOR is not set
>> # end of Network testing
>> # end of Networking options
>>
>> CONFIG_HAMRADIO=y
>>
>> #
>> # Packet Radio protocols
>> #
>> # CONFIG_AX25 is not set
>> CONFIG_CAN=y
>> # CONFIG_CAN_RAW is not set
>> CONFIG_CAN_BCM=y
>> CONFIG_CAN_GW=y
>> # CONFIG_CAN_J1939 is not set
>>
>> #
>> # CAN Device Drivers
>> #
>> CONFIG_CAN_VCAN=y
>> # CONFIG_CAN_VXCAN is not set
>> CONFIG_CAN_SLCAN=y
>> CONFIG_CAN_DEV=y
>> # CONFIG_CAN_CALC_BITTIMING is not set
>> # CONFIG_CAN_JANZ_ICAN3 is not set
>> # CONFIG_CAN_KVASER_PCIEFD is not set
>> CONFIG_PCH_CAN=y
>> # CONFIG_CAN_C_CAN is not set
>> # CONFIG_CAN_CC770 is not set
>> CONFIG_CAN_IFI_CANFD=y
>> CONFIG_CAN_M_CAN=y
>> # CONFIG_CAN_M_CAN_PLATFORM is not set
>> CONFIG_CAN_PEAK_PCIEFD=y
>> # CONFIG_CAN_SJA1000 is not set
>> CONFIG_CAN_SOFTING=y
>>
>> #
>> # CAN USB interfaces
>> #
>> CONFIG_CAN_8DEV_USB=y
>> CONFIG_CAN_EMS_USB=y
>> CONFIG_CAN_ESD_USB2=y
>> CONFIG_CAN_GS_USB=y
>> CONFIG_CAN_KVASER_USB=y
>> CONFIG_CAN_MCBA_USB=y
>> CONFIG_CAN_PEAK_USB=y
>> CONFIG_CAN_UCAN=y
>> # end of CAN USB interfaces
>>
>> # CONFIG_CAN_DEBUG_DEVICES is not set
>> # end of CAN Device Drivers
>>
>> CONFIG_BT=y
>> CONFIG_BT_BREDR=y
>> CONFIG_BT_RFCOMM=y
>> CONFIG_BT_RFCOMM_TTY=y
>> # CONFIG_BT_BNEP is not set
>> CONFIG_BT_HIDP=y
>> # CONFIG_BT_HS is not set
>> # CONFIG_BT_LE is not set
>> CONFIG_BT_LEDS=y
>> # CONFIG_BT_MSFTEXT is not set
>> # CONFIG_BT_DEBUGFS is not set
>> CONFIG_BT_SELFTEST=y
>>
>> #
>> # Bluetooth device drivers
>> #
>> # CONFIG_BT_HCIBTUSB is not set
>> # CONFIG_BT_HCIBTSDIO is not set
>> # CONFIG_BT_HCIUART is not set
>> CONFIG_BT_HCIBCM203X=y
>> # CONFIG_BT_HCIBPA10X is not set
>> # CONFIG_BT_HCIBFUSB is not set
>> CONFIG_BT_HCIVHCI=y
>> CONFIG_BT_MRVL=y
>> # CONFIG_BT_MRVL_SDIO is not set
>> # CONFIG_BT_MTKSDIO is not set
>> # CONFIG_BT_MTKUART is not set
>> # end of Bluetooth device drivers
>>
>> CONFIG_AF_RXRPC=y
>> CONFIG_AF_RXRPC_IPV6=y
>> CONFIG_AF_RXRPC_INJECT_LOSS=y
>> # CONFIG_AF_RXRPC_DEBUG is not set
>> # CONFIG_RXKAD is not set
>> CONFIG_AF_KCM=y
>> CONFIG_STREAM_PARSER=y
>> CONFIG_FIB_RULES=y
>> CONFIG_WIRELESS=y
>> CONFIG_WEXT_CORE=y
>> CONFIG_WEXT_PROC=y
>> CONFIG_CFG80211=y
>> # CONFIG_NL80211_TESTMODE is not set
>> CONFIG_CFG80211_DEVELOPER_WARNINGS=y
>> CONFIG_CFG80211_CERTIFICATION_ONUS=y
>> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
>> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
>> CONFIG_CFG80211_EXTRA_REGDB_KEYDIR=""
>> CONFIG_CFG80211_REG_CELLULAR_HINTS=y
>> # CONFIG_CFG80211_REG_RELAX_NO_IR is not set
>> CONFIG_CFG80211_DEFAULT_PS=y
>> # CONFIG_CFG80211_DEBUGFS is not set
>> CONFIG_CFG80211_CRDA_SUPPORT=y
>> CONFIG_CFG80211_WEXT=y
>> # CONFIG_MAC80211 is not set
>> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
>> # CONFIG_WIMAX is not set
>> CONFIG_RFKILL=y
>> CONFIG_RFKILL_LEDS=y
>> # CONFIG_RFKILL_INPUT is not set
>> # CONFIG_RFKILL_GPIO is not set
>> CONFIG_NET_9P=y
>> CONFIG_NET_9P_VIRTIO=y
>> # CONFIG_NET_9P_RDMA is not set
>> CONFIG_NET_9P_DEBUG=y
>> CONFIG_CAIF=y
>> # CONFIG_CAIF_DEBUG is not set
>> CONFIG_CAIF_NETDEV=y
>> CONFIG_CAIF_USB=y
>> CONFIG_CEPH_LIB=y
>> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
>> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
>> CONFIG_NFC=y
>> CONFIG_NFC_DIGITAL=y
>> # CONFIG_NFC_NCI is not set
>> # CONFIG_NFC_HCI is not set
>>
>> #
>> # Near Field Communication (NFC) devices
>> #
>> CONFIG_NFC_SIM=y
>> CONFIG_NFC_PORT100=y
>> CONFIG_NFC_PN533=y
>> # CONFIG_NFC_PN533_USB is not set
>> CONFIG_NFC_PN533_I2C=y
>> # CONFIG_NFC_PN532_UART is not set
>> # end of Near Field Communication (NFC) devices
>>
>> CONFIG_PSAMPLE=y
>> CONFIG_NET_IFE=y
>> CONFIG_LWTUNNEL=y
>> CONFIG_LWTUNNEL_BPF=y
>> CONFIG_DST_CACHE=y
>> CONFIG_GRO_CELLS=y
>> CONFIG_SOCK_VALIDATE_XMIT=y
>> CONFIG_NET_SOCK_MSG=y
>> # CONFIG_FAILOVER is not set
>> CONFIG_ETHTOOL_NETLINK=y
>> CONFIG_HAVE_EBPF_JIT=y
>>
>> #
>> # Device Drivers
>> #
>> CONFIG_HAVE_EISA=y
>> # CONFIG_EISA is not set
>> CONFIG_HAVE_PCI=y
>> CONFIG_PCI=y
>> CONFIG_PCI_DOMAINS=y
>> # CONFIG_PCIEPORTBUS is not set
>> CONFIG_PCIEASPM=y
>> CONFIG_PCIEASPM_DEFAULT=y
>> # CONFIG_PCIEASPM_POWERSAVE is not set
>> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
>> # CONFIG_PCIEASPM_PERFORMANCE is not set
>> # CONFIG_PCIE_PTM is not set
>> # CONFIG_PCI_MSI is not set
>> CONFIG_PCI_QUIRKS=y
>> # CONFIG_PCI_DEBUG is not set
>> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
>> CONFIG_PCI_STUB=y
>> CONFIG_PCI_PF_STUB=y
>> CONFIG_PCI_ATS=y
>> CONFIG_PCI_LOCKLESS_CONFIG=y
>> CONFIG_PCI_IOV=y
>> # CONFIG_PCI_PRI is not set
>> CONFIG_PCI_PASID=y
>> CONFIG_PCI_LABEL=y
>> # CONFIG_HOTPLUG_PCI is not set
>>
>> #
>> # PCI controller drivers
>> #
>>
>> #
>> # DesignWare PCI Core Support
>> #
>> # end of DesignWare PCI Core Support
>>
>> #
>> # Mobiveil PCIe Core Support
>> #
>> # end of Mobiveil PCIe Core Support
>>
>> #
>> # Cadence PCIe controllers support
>> #
>> # end of Cadence PCIe controllers support
>> # end of PCI controller drivers
>>
>> #
>> # PCI Endpoint
>> #
>> CONFIG_PCI_ENDPOINT=y
>> # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
>> CONFIG_PCI_EPF_TEST=y
>> # end of PCI Endpoint
>>
>> #
>> # PCI switch controller drivers
>> #
>> CONFIG_PCI_SW_SWITCHTEC=y
>> # end of PCI switch controller drivers
>>
>> # CONFIG_PCCARD is not set
>> CONFIG_RAPIDIO=y
>> CONFIG_RAPIDIO_DISC_TIMEOUT=30
>> CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
>> # CONFIG_RAPIDIO_DMA_ENGINE is not set
>> # CONFIG_RAPIDIO_DEBUG is not set
>> CONFIG_RAPIDIO_ENUM_BASIC=y
>> CONFIG_RAPIDIO_CHMAN=y
>> CONFIG_RAPIDIO_MPORT_CDEV=y
>>
>> #
>> # RapidIO Switch drivers
>> #
>> # CONFIG_RAPIDIO_TSI57X is not set
>> # CONFIG_RAPIDIO_CPS_XX is not set
>> CONFIG_RAPIDIO_TSI568=y
>> CONFIG_RAPIDIO_CPS_GEN2=y
>> # CONFIG_RAPIDIO_RXS_GEN3 is not set
>> # end of RapidIO Switch drivers
>>
>> #
>> # Generic Driver Options
>> #
>> # CONFIG_UEVENT_HELPER is not set
>> CONFIG_DEVTMPFS=y
>> # CONFIG_DEVTMPFS_MOUNT is not set
>> CONFIG_STANDALONE=y
>> CONFIG_PREVENT_FIRMWARE_BUILD=y
>>
>> #
>> # Firmware loader
>> #
>> CONFIG_FW_LOADER=y
>> CONFIG_FW_LOADER_PAGED_BUF=y
>> CONFIG_EXTRA_FIRMWARE=""
>> CONFIG_FW_LOADER_USER_HELPER=y
>> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>> # CONFIG_FW_LOADER_COMPRESS is not set
>> CONFIG_FW_CACHE=y
>> # end of Firmware loader
>>
>> CONFIG_WANT_DEV_COREDUMP=y
>> # CONFIG_ALLOW_DEV_COREDUMP is not set
>> # CONFIG_DEBUG_DRIVER is not set
>> # CONFIG_DEBUG_DEVRES is not set
>> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
>> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>> CONFIG_GENERIC_CPU_AUTOPROBE=y
>> CONFIG_GENERIC_CPU_VULNERABILITIES=y
>> CONFIG_REGMAP=y
>> CONFIG_REGMAP_I2C=y
>> CONFIG_REGMAP_SPMI=y
>> CONFIG_REGMAP_W1=y
>> CONFIG_REGMAP_MMIO=y
>> CONFIG_REGMAP_IRQ=y
>> CONFIG_DMA_SHARED_BUFFER=y
>> CONFIG_DMA_FENCE_TRACE=y
>> # end of Generic Driver Options
>>
>> #
>> # Bus devices
>> #
>> # CONFIG_MHI_BUS is not set
>> # end of Bus devices
>>
>> CONFIG_CONNECTOR=y
>> # CONFIG_PROC_EVENTS is not set
>> CONFIG_GNSS=y
>> CONFIG_GNSS_SERIAL=y
>> # CONFIG_GNSS_MTK_SERIAL is not set
>> CONFIG_GNSS_SIRF_SERIAL=y
>> CONFIG_GNSS_UBX_SERIAL=y
>> # CONFIG_MTD is not set
>> # CONFIG_OF is not set
>> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
>> CONFIG_PARPORT=y
>> # CONFIG_PARPORT_PC is not set
>> # CONFIG_PARPORT_AX88796 is not set
>> # CONFIG_PARPORT_1284 is not set
>> CONFIG_PNP=y
>> CONFIG_PNP_DEBUG_MESSAGES=y
>>
>> #
>> # Protocols
>> #
>> CONFIG_PNPACPI=y
>>
>> #
>> # NVME Support
>> #
>> # end of NVME Support
>>
>> #
>> # Misc devices
>> #
>> CONFIG_SENSORS_LIS3LV02D=y
>> CONFIG_AD525X_DPOT=y
>> # CONFIG_AD525X_DPOT_I2C is not set
>> CONFIG_DUMMY_IRQ=y
>> CONFIG_IBM_ASM=y
>> # CONFIG_PHANTOM is not set
>> CONFIG_TIFM_CORE=y
>> # CONFIG_TIFM_7XX1 is not set
>> CONFIG_ICS932S401=y
>> # CONFIG_ENCLOSURE_SERVICES is not set
>> # CONFIG_CS5535_MFGPT is not set
>> # CONFIG_HP_ILO is not set
>> # CONFIG_APDS9802ALS is not set
>> CONFIG_ISL29003=y
>> CONFIG_ISL29020=y
>> CONFIG_SENSORS_TSL2550=y
>> CONFIG_SENSORS_BH1770=y
>> # CONFIG_SENSORS_APDS990X is not set
>> CONFIG_HMC6352=y
>> CONFIG_DS1682=y
>> # CONFIG_PCH_PHUB is not set
>> CONFIG_SRAM=y
>> CONFIG_PCI_ENDPOINT_TEST=y
>> # CONFIG_XILINX_SDFEC is not set
>> CONFIG_MISC_RTSX=y
>> # CONFIG_PVPANIC is not set
>> CONFIG_C2PORT=y
>> CONFIG_C2PORT_DURAMAR_2150=y
>>
>> #
>> # EEPROM support
>> #
>> # CONFIG_EEPROM_AT24 is not set
>> CONFIG_EEPROM_LEGACY=y
>> # CONFIG_EEPROM_MAX6875 is not set
>> CONFIG_EEPROM_93CX6=y
>> CONFIG_EEPROM_IDT_89HPESX=y
>> # CONFIG_EEPROM_EE1004 is not set
>> # end of EEPROM support
>>
>> CONFIG_CB710_CORE=y
>> # CONFIG_CB710_DEBUG is not set
>> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
>>
>> #
>> # Texas Instruments shared transport line discipline
>> #
>> CONFIG_TI_ST=y
>> # end of Texas Instruments shared transport line discipline
>>
>> CONFIG_SENSORS_LIS3_I2C=y
>> # CONFIG_ALTERA_STAPL is not set
>> CONFIG_INTEL_MEI=y
>> CONFIG_INTEL_MEI_ME=y
>> CONFIG_INTEL_MEI_TXE=y
>> # CONFIG_INTEL_MEI_HDCP is not set
>> # CONFIG_VMWARE_VMCI is not set
>>
>> #
>> # Intel MIC & related support
>> #
>> # CONFIG_VOP_BUS is not set
>> # end of Intel MIC & related support
>>
>> # CONFIG_ECHO is not set
>> # CONFIG_MISC_ALCOR_PCI is not set
>> CONFIG_MISC_RTSX_PCI=y
>> CONFIG_MISC_RTSX_USB=y
>> # CONFIG_HABANA_AI is not set
>> # end of Misc devices
>>
>> CONFIG_HAVE_IDE=y
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=y
>> # end of SCSI device support
>>
>> # CONFIG_FUSION is not set
>>
>> #
>> # IEEE 1394 (FireWire) support
>> #
>> CONFIG_FIREWIRE=y
>> # CONFIG_FIREWIRE_OHCI is not set
>> # CONFIG_FIREWIRE_NET is not set
>> CONFIG_FIREWIRE_NOSY=y
>> # end of IEEE 1394 (FireWire) support
>>
>> CONFIG_MACINTOSH_DRIVERS=y
>> # CONFIG_MAC_EMUMOUSEBTN is not set
>> CONFIG_NETDEVICES=y
>> CONFIG_NET_CORE=y
>> # CONFIG_BONDING is not set
>> # CONFIG_DUMMY is not set
>> # CONFIG_WIREGUARD is not set
>> # CONFIG_EQUALIZER is not set
>> # CONFIG_NET_TEAM is not set
>> # CONFIG_MACVLAN is not set
>> # CONFIG_IPVLAN is not set
>> # CONFIG_VXLAN is not set
>> # CONFIG_GENEVE is not set
>> # CONFIG_BAREUDP is not set
>> # CONFIG_GTP is not set
>> # CONFIG_MACSEC is not set
>> # CONFIG_NETCONSOLE is not set
>> # CONFIG_RIONET is not set
>> # CONFIG_TUN is not set
>> # CONFIG_TUN_VNET_CROSS_LE is not set
>> # CONFIG_VETH is not set
>> # CONFIG_VIRTIO_NET is not set
>> # CONFIG_NLMON is not set
>> # CONFIG_ARCNET is not set
>> CONFIG_ATM_DRIVERS=y
>> # CONFIG_ATM_DUMMY is not set
>> # CONFIG_ATM_TCP is not set
>> # CONFIG_ATM_LANAI is not set
>> # CONFIG_ATM_ENI is not set
>> # CONFIG_ATM_FIRESTREAM is not set
>> # CONFIG_ATM_ZATM is not set
>> # CONFIG_ATM_NICSTAR is not set
>> # CONFIG_ATM_IDT77252 is not set
>> # CONFIG_ATM_AMBASSADOR is not set
>> # CONFIG_ATM_HORIZON is not set
>> # CONFIG_ATM_IA is not set
>> # CONFIG_ATM_FORE200E is not set
>> # CONFIG_ATM_HE is not set
>> # CONFIG_ATM_SOLOS is not set
>> # CONFIG_CAIF_DRIVERS is not set
>>
>> #
>> # Distributed Switch Architecture drivers
>> #
>> # end of Distributed Switch Architecture drivers
>>
>> CONFIG_ETHERNET=y
>> CONFIG_NET_VENDOR_3COM=y
>> # CONFIG_VORTEX is not set
>> # CONFIG_TYPHOON is not set
>> CONFIG_NET_VENDOR_ADAPTEC=y
>> # CONFIG_ADAPTEC_STARFIRE is not set
>> CONFIG_NET_VENDOR_AGERE=y
>> # CONFIG_ET131X is not set
>> CONFIG_NET_VENDOR_ALACRITECH=y
>> # CONFIG_SLICOSS is not set
>> CONFIG_NET_VENDOR_ALTEON=y
>> # CONFIG_ACENIC is not set
>> # CONFIG_ALTERA_TSE is not set
>> CONFIG_NET_VENDOR_AMAZON=y
>> CONFIG_NET_VENDOR_AMD=y
>> # CONFIG_AMD8111_ETH is not set
>> # CONFIG_PCNET32 is not set
>> # CONFIG_AMD_XGBE is not set
>> CONFIG_NET_VENDOR_AQUANTIA=y
>> CONFIG_NET_VENDOR_ARC=y
>> CONFIG_NET_VENDOR_ATHEROS=y
>> # CONFIG_ATL2 is not set
>> # CONFIG_ATL1 is not set
>> # CONFIG_ATL1E is not set
>> # CONFIG_ATL1C is not set
>> # CONFIG_ALX is not set
>> CONFIG_NET_VENDOR_AURORA=y
>> # CONFIG_AURORA_NB8800 is not set
>> CONFIG_NET_VENDOR_BROADCOM=y
>> # CONFIG_B44 is not set
>> # CONFIG_BCMGENET is not set
>> # CONFIG_BNX2 is not set
>> # CONFIG_CNIC is not set
>> # CONFIG_TIGON3 is not set
>> # CONFIG_BNX2X is not set
>> # CONFIG_SYSTEMPORT is not set
>> # CONFIG_BNXT is not set
>> CONFIG_NET_VENDOR_BROCADE=y
>> # CONFIG_BNA is not set
>> CONFIG_NET_VENDOR_CADENCE=y
>> # CONFIG_MACB is not set
>> CONFIG_NET_VENDOR_CAVIUM=y
>> CONFIG_NET_VENDOR_CHELSIO=y
>> # CONFIG_CHELSIO_T1 is not set
>> # CONFIG_CHELSIO_T3 is not set
>> # CONFIG_CHELSIO_T4 is not set
>> # CONFIG_CHELSIO_T4VF is not set
>> CONFIG_NET_VENDOR_CISCO=y
>> # CONFIG_ENIC is not set
>> CONFIG_NET_VENDOR_CORTINA=y
>> # CONFIG_CX_ECAT is not set
>> # CONFIG_DNET is not set
>> CONFIG_NET_VENDOR_DEC=y
>> # CONFIG_NET_TULIP is not set
>> CONFIG_NET_VENDOR_DLINK=y
>> # CONFIG_DL2K is not set
>> # CONFIG_SUNDANCE is not set
>> CONFIG_NET_VENDOR_EMULEX=y
>> # CONFIG_BE2NET is not set
>> CONFIG_NET_VENDOR_EZCHIP=y
>> CONFIG_NET_VENDOR_GOOGLE=y
>> CONFIG_NET_VENDOR_HUAWEI=y
>> CONFIG_NET_VENDOR_I825XX=y
>> CONFIG_NET_VENDOR_INTEL=y
>> # CONFIG_E100 is not set
>> CONFIG_E1000=y
>> # CONFIG_E1000E is not set
>> # CONFIG_IGB is not set
>> # CONFIG_IGBVF is not set
>> # CONFIG_IXGB is not set
>> # CONFIG_IXGBE is not set
>> # CONFIG_I40E is not set
>> # CONFIG_IGC is not set
>> # CONFIG_JME is not set
>> CONFIG_NET_VENDOR_MARVELL=y
>> # CONFIG_MVMDIO is not set
>> # CONFIG_SKGE is not set
>> # CONFIG_SKY2 is not set
>> CONFIG_NET_VENDOR_MELLANOX=y
>> # CONFIG_MLX4_EN is not set
>> # CONFIG_MLX5_CORE is not set
>> # CONFIG_MLXSW_CORE is not set
>> # CONFIG_MLXFW is not set
>> CONFIG_NET_VENDOR_MICREL=y
>> # CONFIG_KS8851_MLL is not set
>> # CONFIG_KSZ884X_PCI is not set
>> CONFIG_NET_VENDOR_MICROCHIP=y
>> # CONFIG_LAN743X is not set
>> CONFIG_NET_VENDOR_MICROSEMI=y
>> CONFIG_NET_VENDOR_MYRI=y
>> # CONFIG_MYRI10GE is not set
>> # CONFIG_FEALNX is not set
>> CONFIG_NET_VENDOR_NATSEMI=y
>> # CONFIG_NATSEMI is not set
>> # CONFIG_NS83820 is not set
>> CONFIG_NET_VENDOR_NETERION=y
>> # CONFIG_S2IO is not set
>> # CONFIG_VXGE is not set
>> CONFIG_NET_VENDOR_NETRONOME=y
>> CONFIG_NET_VENDOR_NI=y
>> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
>> CONFIG_NET_VENDOR_8390=y
>> # CONFIG_NE2K_PCI is not set
>> CONFIG_NET_VENDOR_NVIDIA=y
>> # CONFIG_FORCEDETH is not set
>> CONFIG_NET_VENDOR_OKI=y
>> # CONFIG_PCH_GBE is not set
>> # CONFIG_ETHOC is not set
>> CONFIG_NET_VENDOR_PACKET_ENGINES=y
>> # CONFIG_HAMACHI is not set
>> # CONFIG_YELLOWFIN is not set
>> CONFIG_NET_VENDOR_PENSANDO=y
>> CONFIG_NET_VENDOR_QLOGIC=y
>> # CONFIG_QLA3XXX is not set
>> # CONFIG_QLCNIC is not set
>> # CONFIG_NETXEN_NIC is not set
>> # CONFIG_QED is not set
>> CONFIG_NET_VENDOR_QUALCOMM=y
>> # CONFIG_QCOM_EMAC is not set
>> # CONFIG_RMNET is not set
>> CONFIG_NET_VENDOR_RDC=y
>> # CONFIG_R6040 is not set
>> CONFIG_NET_VENDOR_REALTEK=y
>> # CONFIG_ATP is not set
>> # CONFIG_8139CP is not set
>> # CONFIG_8139TOO is not set
>> # CONFIG_R8169 is not set
>> CONFIG_NET_VENDOR_RENESAS=y
>> CONFIG_NET_VENDOR_ROCKER=y
>> CONFIG_NET_VENDOR_SAMSUNG=y
>> # CONFIG_SXGBE_ETH is not set
>> CONFIG_NET_VENDOR_SEEQ=y
>> CONFIG_NET_VENDOR_SOLARFLARE=y
>> # CONFIG_SFC is not set
>> # CONFIG_SFC_FALCON is not set
>> CONFIG_NET_VENDOR_SILAN=y
>> # CONFIG_SC92031 is not set
>> CONFIG_NET_VENDOR_SIS=y
>> # CONFIG_SIS900 is not set
>> # CONFIG_SIS190 is not set
>> CONFIG_NET_VENDOR_SMSC=y
>> # CONFIG_EPIC100 is not set
>> # CONFIG_SMSC911X is not set
>> # CONFIG_SMSC9420 is not set
>> CONFIG_NET_VENDOR_SOCIONEXT=y
>> CONFIG_NET_VENDOR_STMICRO=y
>> # CONFIG_STMMAC_ETH is not set
>> CONFIG_NET_VENDOR_SUN=y
>> # CONFIG_HAPPYMEAL is not set
>> # CONFIG_SUNGEM is not set
>> # CONFIG_CASSINI is not set
>> # CONFIG_NIU is not set
>> CONFIG_NET_VENDOR_SYNOPSYS=y
>> # CONFIG_DWC_XLGMAC is not set
>> CONFIG_NET_VENDOR_TEHUTI=y
>> # CONFIG_TEHUTI is not set
>> CONFIG_NET_VENDOR_TI=y
>> # CONFIG_TI_CPSW_PHY_SEL is not set
>> # CONFIG_TLAN is not set
>> CONFIG_NET_VENDOR_VIA=y
>> # CONFIG_VIA_RHINE is not set
>> # CONFIG_VIA_VELOCITY is not set
>> CONFIG_NET_VENDOR_WIZNET=y
>> # CONFIG_WIZNET_W5100 is not set
>> # CONFIG_WIZNET_W5300 is not set
>> CONFIG_NET_VENDOR_XILINX=y
>> # CONFIG_XILINX_AXI_EMAC is not set
>> # CONFIG_XILINX_LL_TEMAC is not set
>> # CONFIG_FDDI is not set
>> # CONFIG_HIPPI is not set
>> # CONFIG_NET_SB1000 is not set
>> # CONFIG_MDIO_DEVICE is not set
>> # CONFIG_PHYLIB is not set
>> # CONFIG_PLIP is not set
>> # CONFIG_PPP is not set
>> # CONFIG_SLIP is not set
>> CONFIG_USB_NET_DRIVERS=y
>> # CONFIG_USB_CATC is not set
>> # CONFIG_USB_KAWETH is not set
>> # CONFIG_USB_PEGASUS is not set
>> # CONFIG_USB_RTL8150 is not set
>> # CONFIG_USB_RTL8152 is not set
>> # CONFIG_USB_LAN78XX is not set
>> # CONFIG_USB_USBNET is not set
>> # CONFIG_USB_HSO is not set
>> # CONFIG_USB_IPHETH is not set
>> CONFIG_WLAN=y
>> # CONFIG_WIRELESS_WDS is not set
>> CONFIG_WLAN_VENDOR_ADMTEK=y
>> CONFIG_WLAN_VENDOR_ATH=y
>> # CONFIG_ATH_DEBUG is not set
>> # CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS is not set
>> # CONFIG_ATH5K_PCI is not set
>> # CONFIG_ATH6KL is not set
>> # CONFIG_WIL6210 is not set
>> CONFIG_WLAN_VENDOR_ATMEL=y
>> # CONFIG_ATMEL is not set
>> CONFIG_WLAN_VENDOR_BROADCOM=y
>> # CONFIG_BRCMFMAC is not set
>> CONFIG_WLAN_VENDOR_CISCO=y
>> # CONFIG_AIRO is not set
>> CONFIG_WLAN_VENDOR_INTEL=y
>> # CONFIG_IPW2100 is not set
>> # CONFIG_IPW2200 is not set
>> # CONFIG_IWLWIFI is not set
>> CONFIG_WLAN_VENDOR_INTERSIL=y
>> # CONFIG_HOSTAP is not set
>> # CONFIG_HERMES is not set
>> # CONFIG_PRISM54 is not set
>> CONFIG_WLAN_VENDOR_MARVELL=y
>> # CONFIG_LIBERTAS is not set
>> # CONFIG_MWIFIEX is not set
>> CONFIG_WLAN_VENDOR_MEDIATEK=y
>> CONFIG_WLAN_VENDOR_MICROCHIP=y
>> CONFIG_WILC1000=y
>> CONFIG_WILC1000_SDIO=y
>> CONFIG_WILC1000_HW_OOB_INTR=y
>> CONFIG_WLAN_VENDOR_RALINK=y
>> CONFIG_WLAN_VENDOR_REALTEK=y
>> CONFIG_WLAN_VENDOR_RSI=y
>> CONFIG_WLAN_VENDOR_ST=y
>> CONFIG_WLAN_VENDOR_TI=y
>> CONFIG_WLAN_VENDOR_ZYDAS=y
>> # CONFIG_USB_ZD1201 is not set
>> CONFIG_WLAN_VENDOR_QUANTENNA=y
>> # CONFIG_QTNFMAC_PCIE is not set
>> # CONFIG_USB_NET_RNDIS_WLAN is not set
>> # CONFIG_VIRT_WIFI is not set
>>
>> #
>> # Enable WiMAX (Networking options) to see the WiMAX drivers
>> #
>> # CONFIG_WAN is not set
>> CONFIG_IEEE802154_DRIVERS=y
>> # CONFIG_IEEE802154_FAKELB is not set
>> # CONFIG_IEEE802154_ATUSB is not set
>> # CONFIG_IEEE802154_HWSIM is not set
>> # CONFIG_VMXNET3 is not set
>> # CONFIG_FUJITSU_ES is not set
>> # CONFIG_NETDEVSIM is not set
>> # CONFIG_NET_FAILOVER is not set
>> # CONFIG_ISDN is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=y
>> CONFIG_INPUT_LEDS=y
>> CONFIG_INPUT_FF_MEMLESS=y
>> CONFIG_INPUT_POLLDEV=y
>> CONFIG_INPUT_SPARSEKMAP=y
>> CONFIG_INPUT_MATRIXKMAP=y
>>
>> #
>> # Userland interfaces
>> #
>> CONFIG_INPUT_MOUSEDEV=y
>> CONFIG_INPUT_MOUSEDEV_PSAUX=y
>> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>> CONFIG_INPUT_JOYDEV=y
>> # CONFIG_INPUT_EVDEV is not set
>> # CONFIG_INPUT_EVBUG is not set
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=y
>> CONFIG_KEYBOARD_ADC=y
>> CONFIG_KEYBOARD_ADP5588=y
>> CONFIG_KEYBOARD_ADP5589=y
>> CONFIG_KEYBOARD_ATKBD=y
>> # CONFIG_KEYBOARD_QT1050 is not set
>> # CONFIG_KEYBOARD_QT1070 is not set
>> CONFIG_KEYBOARD_QT2160=y
>> CONFIG_KEYBOARD_DLINK_DIR685=y
>> # CONFIG_KEYBOARD_LKKBD is not set
>> CONFIG_KEYBOARD_GPIO=y
>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
>> CONFIG_KEYBOARD_TCA6416=y
>> CONFIG_KEYBOARD_TCA8418=y
>> # CONFIG_KEYBOARD_MATRIX is not set
>> CONFIG_KEYBOARD_LM8323=y
>> CONFIG_KEYBOARD_LM8333=y
>> # CONFIG_KEYBOARD_MAX7359 is not set
>> # CONFIG_KEYBOARD_MCS is not set
>> CONFIG_KEYBOARD_MPR121=y
>> CONFIG_KEYBOARD_NEWTON=y
>> # CONFIG_KEYBOARD_OPENCORES is not set
>> CONFIG_KEYBOARD_SAMSUNG=y
>> CONFIG_KEYBOARD_STOWAWAY=y
>> CONFIG_KEYBOARD_SUNKBD=y
>> CONFIG_KEYBOARD_TM2_TOUCHKEY=y
>> CONFIG_KEYBOARD_TWL4030=y
>> CONFIG_KEYBOARD_XTKBD=y
>> # CONFIG_KEYBOARD_CROS_EC is not set
>> # CONFIG_KEYBOARD_MTK_PMIC is not set
>> CONFIG_INPUT_MOUSE=y
>> CONFIG_MOUSE_PS2=y
>> CONFIG_MOUSE_PS2_ALPS=y
>> CONFIG_MOUSE_PS2_BYD=y
>> CONFIG_MOUSE_PS2_LOGIPS2PP=y
>> # CONFIG_MOUSE_PS2_SYNAPTICS is not set
>> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
>> # CONFIG_MOUSE_PS2_CYPRESS is not set
>> CONFIG_MOUSE_PS2_TRACKPOINT=y
>> # CONFIG_MOUSE_PS2_ELANTECH is not set
>> # CONFIG_MOUSE_PS2_SENTELIC is not set
>> CONFIG_MOUSE_PS2_TOUCHKIT=y
>> # CONFIG_MOUSE_PS2_FOCALTECH is not set
>> # CONFIG_MOUSE_PS2_VMMOUSE is not set
>> CONFIG_MOUSE_PS2_SMBUS=y
>> CONFIG_MOUSE_SERIAL=y
>> # CONFIG_MOUSE_APPLETOUCH is not set
>> CONFIG_MOUSE_BCM5974=y
>> CONFIG_MOUSE_CYAPA=y
>> CONFIG_MOUSE_ELAN_I2C=y
>> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
>> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
>> # CONFIG_MOUSE_VSXXXAA is not set
>> # CONFIG_MOUSE_GPIO is not set
>> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
>> # CONFIG_MOUSE_SYNAPTICS_USB is not set
>> CONFIG_INPUT_JOYSTICK=y
>> CONFIG_JOYSTICK_ANALOG=y
>> CONFIG_JOYSTICK_A3D=y
>> CONFIG_JOYSTICK_ADI=y
>> CONFIG_JOYSTICK_COBRA=y
>> CONFIG_JOYSTICK_GF2K=y
>> CONFIG_JOYSTICK_GRIP=y
>> CONFIG_JOYSTICK_GRIP_MP=y
>> CONFIG_JOYSTICK_GUILLEMOT=y
>> CONFIG_JOYSTICK_INTERACT=y
>> # CONFIG_JOYSTICK_SIDEWINDER is not set
>> # CONFIG_JOYSTICK_TMDC is not set
>> CONFIG_JOYSTICK_IFORCE=y
>> # CONFIG_JOYSTICK_IFORCE_USB is not set
>> CONFIG_JOYSTICK_IFORCE_232=y
>> CONFIG_JOYSTICK_WARRIOR=y
>> CONFIG_JOYSTICK_MAGELLAN=y
>> # CONFIG_JOYSTICK_SPACEORB is not set
>> # CONFIG_JOYSTICK_SPACEBALL is not set
>> CONFIG_JOYSTICK_STINGER=y
>> CONFIG_JOYSTICK_TWIDJOY=y
>> CONFIG_JOYSTICK_ZHENHUA=y
>> CONFIG_JOYSTICK_DB9=y
>> CONFIG_JOYSTICK_GAMECON=y
>> # CONFIG_JOYSTICK_TURBOGRAFX is not set
>> # CONFIG_JOYSTICK_AS5011 is not set
>> CONFIG_JOYSTICK_JOYDUMP=y
>> CONFIG_JOYSTICK_XPAD=y
>> # CONFIG_JOYSTICK_XPAD_FF is not set
>> CONFIG_JOYSTICK_XPAD_LEDS=y
>> CONFIG_JOYSTICK_PXRC=y
>> # CONFIG_JOYSTICK_FSIA6B is not set
>> CONFIG_INPUT_TABLET=y
>> # CONFIG_TABLET_USB_ACECAD is not set
>> CONFIG_TABLET_USB_AIPTEK=y
>> CONFIG_TABLET_USB_GTCO=y
>> # CONFIG_TABLET_USB_HANWANG is not set
>> # CONFIG_TABLET_USB_KBTAB is not set
>> # CONFIG_TABLET_USB_PEGASUS is not set
>> # CONFIG_TABLET_SERIAL_WACOM4 is not set
>> # CONFIG_INPUT_TOUCHSCREEN is not set
>> CONFIG_INPUT_MISC=y
>> CONFIG_INPUT_88PM860X_ONKEY=y
>> # CONFIG_INPUT_88PM80X_ONKEY is not set
>> # CONFIG_INPUT_AD714X is not set
>> # CONFIG_INPUT_BMA150 is not set
>> CONFIG_INPUT_E3X0_BUTTON=y
>> CONFIG_INPUT_PCSPKR=y
>> CONFIG_INPUT_MAX8925_ONKEY=y
>> CONFIG_INPUT_MC13783_PWRBUTTON=y
>> # CONFIG_INPUT_MMA8450 is not set
>> # CONFIG_INPUT_APANEL is not set
>> CONFIG_INPUT_GPIO_BEEPER=y
>> CONFIG_INPUT_GPIO_DECODER=y
>> # CONFIG_INPUT_GPIO_VIBRA is not set
>> # CONFIG_INPUT_WISTRON_BTNS is not set
>> # CONFIG_INPUT_ATLAS_BTNS is not set
>> # CONFIG_INPUT_ATI_REMOTE2 is not set
>> CONFIG_INPUT_KEYSPAN_REMOTE=y
>> # CONFIG_INPUT_KXTJ9 is not set
>> CONFIG_INPUT_POWERMATE=y
>> # CONFIG_INPUT_YEALINK is not set
>> CONFIG_INPUT_CM109=y
>> CONFIG_INPUT_REGULATOR_HAPTIC=y
>> CONFIG_INPUT_AXP20X_PEK=y
>> CONFIG_INPUT_TWL4030_PWRBUTTON=y
>> CONFIG_INPUT_TWL4030_VIBRA=y
>> CONFIG_INPUT_TWL6040_VIBRA=y
>> CONFIG_INPUT_UINPUT=y
>> # CONFIG_INPUT_PCF50633_PMU is not set
>> CONFIG_INPUT_PCF8574=y
>> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
>> CONFIG_INPUT_DA9063_ONKEY=y
>> CONFIG_INPUT_ADXL34X=y
>> CONFIG_INPUT_ADXL34X_I2C=y
>> CONFIG_INPUT_IMS_PCU=y
>> # CONFIG_INPUT_IQS269A is not set
>> CONFIG_INPUT_CMA3000=y
>> # CONFIG_INPUT_CMA3000_I2C is not set
>> CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
>> CONFIG_INPUT_SOC_BUTTON_ARRAY=y
>> # CONFIG_INPUT_DRV260X_HAPTICS is not set
>> # CONFIG_INPUT_DRV2665_HAPTICS is not set
>> # CONFIG_INPUT_DRV2667_HAPTICS is not set
>> CONFIG_INPUT_RAVE_SP_PWRBUTTON=y
>> CONFIG_RMI4_CORE=y
>> # CONFIG_RMI4_I2C is not set
>> # CONFIG_RMI4_SMB is not set
>> CONFIG_RMI4_F03=y
>> CONFIG_RMI4_F03_SERIO=y
>> CONFIG_RMI4_2D_SENSOR=y
>> CONFIG_RMI4_F11=y
>> CONFIG_RMI4_F12=y
>> CONFIG_RMI4_F30=y
>> # CONFIG_RMI4_F34 is not set
>> CONFIG_RMI4_F55=y
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=y
>> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
>> CONFIG_SERIO_I8042=y
>> CONFIG_SERIO_SERPORT=y
>> CONFIG_SERIO_CT82C710=y
>> # CONFIG_SERIO_PARKBD is not set
>> CONFIG_SERIO_PCIPS2=y
>> CONFIG_SERIO_LIBPS2=y
>> CONFIG_SERIO_RAW=y
>> CONFIG_SERIO_ALTERA_PS2=y
>> # CONFIG_SERIO_PS2MULT is not set
>> CONFIG_SERIO_ARC_PS2=y
>> CONFIG_SERIO_GPIO_PS2=y
>> CONFIG_USERIO=y
>> CONFIG_GAMEPORT=y
>> CONFIG_GAMEPORT_NS558=y
>> CONFIG_GAMEPORT_L4=y
>> CONFIG_GAMEPORT_EMU10K1=y
>> # CONFIG_GAMEPORT_FM801 is not set
>> # end of Hardware I/O ports
>> # end of Input device support
>>
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> # CONFIG_VT is not set
>> CONFIG_UNIX98_PTYS=y
>> # CONFIG_LEGACY_PTYS is not set
>> # CONFIG_LDISC_AUTOLOAD is not set
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_8250=y
>> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
>> CONFIG_SERIAL_8250_PNP=y
>> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
>> CONFIG_SERIAL_8250_FINTEK=y
>> CONFIG_SERIAL_8250_CONSOLE=y
>> CONFIG_SERIAL_8250_PCI=y
>> CONFIG_SERIAL_8250_EXAR=y
>> CONFIG_SERIAL_8250_NR_UARTS=4
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>> # CONFIG_SERIAL_8250_EXTENDED is not set
>> CONFIG_SERIAL_8250_DWLIB=y
>> CONFIG_SERIAL_8250_DW=y
>> CONFIG_SERIAL_8250_RT288X=y
>> CONFIG_SERIAL_8250_LPSS=y
>> CONFIG_SERIAL_8250_MID=y
>>
>> #
>> # Non-8250 serial port support
>> #
>> # CONFIG_SERIAL_UARTLITE is not set
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_CORE_CONSOLE=y
>> # CONFIG_SERIAL_JSM is not set
>> # CONFIG_SERIAL_LANTIQ is not set
>> CONFIG_SERIAL_SCCNXP=y
>> # CONFIG_SERIAL_SCCNXP_CONSOLE is not set
>> CONFIG_SERIAL_SC16IS7XX_CORE=y
>> CONFIG_SERIAL_SC16IS7XX=y
>> CONFIG_SERIAL_SC16IS7XX_I2C=y
>> # CONFIG_SERIAL_TIMBERDALE is not set
>> CONFIG_SERIAL_ALTERA_JTAGUART=y
>> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
>> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
>> # CONFIG_SERIAL_ALTERA_UART is not set
>> CONFIG_SERIAL_PCH_UART=y
>> # CONFIG_SERIAL_PCH_UART_CONSOLE is not set
>> CONFIG_SERIAL_ARC=y
>> # CONFIG_SERIAL_ARC_CONSOLE is not set
>> CONFIG_SERIAL_ARC_NR_PORTS=1
>> CONFIG_SERIAL_RP2=y
>> CONFIG_SERIAL_RP2_NR_UARTS=32
>> CONFIG_SERIAL_FSL_LPUART=y
>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
>> # CONFIG_SERIAL_SPRD is not set
>> # end of Serial drivers
>>
>> CONFIG_SERIAL_MCTRL_GPIO=y
>> CONFIG_SERIAL_NONSTANDARD=y
>> CONFIG_ROCKETPORT=y
>> # CONFIG_CYCLADES is not set
>> CONFIG_MOXA_INTELLIO=y
>> CONFIG_MOXA_SMARTIO=y
>> # CONFIG_SYNCLINK is not set
>> CONFIG_SYNCLINKMP=y
>> CONFIG_SYNCLINK_GT=y
>> CONFIG_ISI=y
>> # CONFIG_N_HDLC is not set
>> CONFIG_N_GSM=y
>> CONFIG_NOZOMI=y
>> # CONFIG_NULL_TTY is not set
>> # CONFIG_TRACE_ROUTER is not set
>> CONFIG_TRACE_SINK=y
>> CONFIG_HVC_DRIVER=y
>> CONFIG_SERIAL_DEV_BUS=y
>> # CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
>> CONFIG_TTY_PRINTK=y
>> CONFIG_TTY_PRINTK_LEVEL=6
>> # CONFIG_PRINTER is not set
>> CONFIG_PPDEV=y
>> CONFIG_VIRTIO_CONSOLE=y
>> CONFIG_IPMI_HANDLER=y
>> CONFIG_IPMI_PLAT_DATA=y
>> # CONFIG_IPMI_PANIC_EVENT is not set
>> # CONFIG_IPMI_DEVICE_INTERFACE is not set
>> CONFIG_IPMI_SI=y
>> CONFIG_IPMI_SSIF=y
>> # CONFIG_IPMI_WATCHDOG is not set
>> CONFIG_IPMI_POWEROFF=y
>> # CONFIG_IPMB_DEVICE_INTERFACE is not set
>> # CONFIG_HW_RANDOM is not set
>> CONFIG_APPLICOM=y
>> # CONFIG_SONYPI is not set
>> CONFIG_MWAVE=y
>> CONFIG_SCx200_GPIO=y
>> CONFIG_PC8736x_GPIO=y
>> CONFIG_NSC_GPIO=y
>> CONFIG_DEVMEM=y
>> CONFIG_DEVKMEM=y
>> # CONFIG_NVRAM is not set
>> CONFIG_DEVPORT=y
>> # CONFIG_HPET is not set
>> CONFIG_HANGCHECK_TIMER=y
>> # CONFIG_TCG_TPM is not set
>> # CONFIG_TELCLOCK is not set
>> CONFIG_XILLYBUS=y
>> # end of Character devices
>>
>> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
>>
>> #
>> # I2C support
>> #
>> CONFIG_I2C=y
>> CONFIG_ACPI_I2C_OPREGION=y
>> CONFIG_I2C_BOARDINFO=y
>> # CONFIG_I2C_COMPAT is not set
>> CONFIG_I2C_CHARDEV=y
>> # CONFIG_I2C_MUX is not set
>> CONFIG_I2C_HELPER_AUTO=y
>> CONFIG_I2C_SMBUS=y
>> CONFIG_I2C_ALGOBIT=y
>> CONFIG_I2C_ALGOPCA=y
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # PC SMBus host controller drivers
>> #
>> CONFIG_I2C_ALI1535=y
>> # CONFIG_I2C_ALI1563 is not set
>> CONFIG_I2C_ALI15X3=y
>> # CONFIG_I2C_AMD756 is not set
>> # CONFIG_I2C_AMD8111 is not set
>> # CONFIG_I2C_AMD_MP2 is not set
>> CONFIG_I2C_I801=y
>> CONFIG_I2C_ISCH=y
>> CONFIG_I2C_ISMT=y
>> CONFIG_I2C_PIIX4=y
>> # CONFIG_I2C_NFORCE2 is not set
>> # CONFIG_I2C_NVIDIA_GPU is not set
>> # CONFIG_I2C_SIS5595 is not set
>> # CONFIG_I2C_SIS630 is not set
>> # CONFIG_I2C_SIS96X is not set
>> CONFIG_I2C_VIA=y
>> # CONFIG_I2C_VIAPRO is not set
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_I2C_SCMI is not set
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> # CONFIG_I2C_CBUS_GPIO is not set
>> CONFIG_I2C_DESIGNWARE_CORE=y
>> CONFIG_I2C_DESIGNWARE_SLAVE=y
>> CONFIG_I2C_DESIGNWARE_PLATFORM=y
>> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
>> CONFIG_I2C_DESIGNWARE_PCI=y
>> CONFIG_I2C_EG20T=y
>> # CONFIG_I2C_EMEV2 is not set
>> # CONFIG_I2C_GPIO is not set
>> CONFIG_I2C_OCORES=y
>> CONFIG_I2C_PCA_PLATFORM=y
>> CONFIG_I2C_SIMTEC=y
>> # CONFIG_I2C_XILINX is not set
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> CONFIG_I2C_DIOLAN_U2C=y
>> CONFIG_I2C_PARPORT=y
>> CONFIG_I2C_ROBOTFUZZ_OSIF=y
>> # CONFIG_I2C_TAOS_EVM is not set
>> CONFIG_I2C_TINY_USB=y
>> CONFIG_I2C_VIPERBOARD=y
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> CONFIG_I2C_CROS_EC_TUNNEL=y
>> CONFIG_SCx200_ACB=y
>> # end of I2C Hardware Bus support
>>
>> # CONFIG_I2C_STUB is not set
>> CONFIG_I2C_SLAVE=y
>> CONFIG_I2C_SLAVE_EEPROM=y
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> # end of I2C support
>>
>> # CONFIG_I3C is not set
>> # CONFIG_SPI is not set
>> CONFIG_SPMI=y
>> CONFIG_HSI=y
>> CONFIG_HSI_BOARDINFO=y
>>
>> #
>> # HSI controllers
>> #
>>
>> #
>> # HSI clients
>> #
>> CONFIG_HSI_CHAR=y
>> # CONFIG_PPS is not set
>>
>> #
>> # PTP clock support
>> #
>> # CONFIG_PTP_1588_CLOCK is not set
>>
>> #
>> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
>> #
>> CONFIG_PTP_1588_CLOCK_PCH=y
>> # end of PTP clock support
>>
>> CONFIG_PINCTRL=y
>> CONFIG_PINMUX=y
>> CONFIG_PINCONF=y
>> CONFIG_GENERIC_PINCONF=y
>> CONFIG_DEBUG_PINCTRL=y
>> CONFIG_PINCTRL_AMD=y
>> # CONFIG_PINCTRL_MCP23S08 is not set
>> CONFIG_PINCTRL_SX150X=y
>> # CONFIG_PINCTRL_BAYTRAIL is not set
>> # CONFIG_PINCTRL_CHERRYVIEW is not set
>> # CONFIG_PINCTRL_LYNXPOINT is not set
>> # CONFIG_PINCTRL_BROXTON is not set
>> # CONFIG_PINCTRL_CANNONLAKE is not set
>> # CONFIG_PINCTRL_CEDARFORK is not set
>> # CONFIG_PINCTRL_DENVERTON is not set
>> # CONFIG_PINCTRL_EMMITSBURG is not set
>> # CONFIG_PINCTRL_GEMINILAKE is not set
>> # CONFIG_PINCTRL_ICELAKE is not set
>> # CONFIG_PINCTRL_JASPERLAKE is not set
>> # CONFIG_PINCTRL_LEWISBURG is not set
>> # CONFIG_PINCTRL_SUNRISEPOINT is not set
>> # CONFIG_PINCTRL_TIGERLAKE is not set
>> CONFIG_PINCTRL_MADERA=y
>> CONFIG_PINCTRL_CS47L90=y
>> CONFIG_GPIOLIB=y
>> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
>> CONFIG_GPIO_ACPI=y
>> CONFIG_GPIOLIB_IRQCHIP=y
>> CONFIG_DEBUG_GPIO=y
>> # CONFIG_GPIO_SYSFS is not set
>> CONFIG_GPIO_GENERIC=y
>>
>> #
>> # Memory mapped GPIO drivers
>> #
>> # CONFIG_GPIO_AMDPT is not set
>> CONFIG_GPIO_DWAPB=y
>> # CONFIG_GPIO_EXAR is not set
>> # CONFIG_GPIO_GENERIC_PLATFORM is not set
>> # CONFIG_GPIO_ICH is not set
>> # CONFIG_GPIO_MB86S7X is not set
>> CONFIG_GPIO_VX855=y
>> # CONFIG_GPIO_XILINX is not set
>> # CONFIG_GPIO_AMD_FCH is not set
>> # end of Memory mapped GPIO drivers
>>
>> #
>> # Port-mapped I/O GPIO drivers
>> #
>> CONFIG_GPIO_F7188X=y
>> CONFIG_GPIO_IT87=y
>> # CONFIG_GPIO_SCH is not set
>> CONFIG_GPIO_SCH311X=y
>> CONFIG_GPIO_WINBOND=y
>> CONFIG_GPIO_WS16C48=y
>> # end of Port-mapped I/O GPIO drivers
>>
>> #
>> # I2C GPIO expanders
>> #
>> # CONFIG_GPIO_ADP5588 is not set
>> # CONFIG_GPIO_MAX7300 is not set
>> # CONFIG_GPIO_MAX732X is not set
>> CONFIG_GPIO_PCA953X=y
>> CONFIG_GPIO_PCA953X_IRQ=y
>> # CONFIG_GPIO_PCA9570 is not set
>> # CONFIG_GPIO_PCF857X is not set
>> CONFIG_GPIO_TPIC2810=y
>> # end of I2C GPIO expanders
>>
>> #
>> # MFD GPIO expanders
>> #
>> CONFIG_GPIO_ARIZONA=y
>> CONFIG_GPIO_BD9571MWV=y
>> CONFIG_GPIO_CS5535=y
>> # CONFIG_GPIO_JANZ_TTL is not set
>> CONFIG_GPIO_LP873X=y
>> CONFIG_GPIO_MADERA=y
>> # CONFIG_GPIO_RC5T583 is not set
>> CONFIG_GPIO_TIMBERDALE=y
>> # CONFIG_GPIO_TPS65086 is not set
>> # CONFIG_GPIO_TPS65910 is not set
>> CONFIG_GPIO_TPS65912=y
>> CONFIG_GPIO_TWL4030=y
>> # CONFIG_GPIO_TWL6040 is not set
>> # CONFIG_GPIO_WM8994 is not set
>> # end of MFD GPIO expanders
>>
>> #
>> # PCI GPIO expanders
>> #
>> CONFIG_GPIO_AMD8111=y
>> CONFIG_GPIO_BT8XX=y
>> # CONFIG_GPIO_ML_IOH is not set
>> CONFIG_GPIO_PCH=y
>> CONFIG_GPIO_PCI_IDIO_16=y
>> CONFIG_GPIO_PCIE_IDIO_24=y
>> CONFIG_GPIO_RDC321X=y
>> # end of PCI GPIO expanders
>>
>> #
>> # USB GPIO expanders
>> #
>> # CONFIG_GPIO_VIPERBOARD is not set
>> # end of USB GPIO expanders
>>
>> # CONFIG_GPIO_AGGREGATOR is not set
>> # CONFIG_GPIO_MOCKUP is not set
>> CONFIG_W1=y
>> CONFIG_W1_CON=y
>>
>> #
>> # 1-wire Bus Masters
>> #
>> # CONFIG_W1_MASTER_MATROX is not set
>> # CONFIG_W1_MASTER_DS2490 is not set
>> # CONFIG_W1_MASTER_DS2482 is not set
>> # CONFIG_W1_MASTER_DS1WM is not set
>> CONFIG_W1_MASTER_GPIO=y
>> # CONFIG_W1_MASTER_SGI is not set
>> # end of 1-wire Bus Masters
>>
>> #
>> # 1-wire Slaves
>> #
>> # CONFIG_W1_SLAVE_THERM is not set
>> # CONFIG_W1_SLAVE_SMEM is not set
>> # CONFIG_W1_SLAVE_DS2405 is not set
>> CONFIG_W1_SLAVE_DS2408=y
>> CONFIG_W1_SLAVE_DS2408_READBACK=y
>> CONFIG_W1_SLAVE_DS2413=y
>> CONFIG_W1_SLAVE_DS2406=y
>> # CONFIG_W1_SLAVE_DS2423 is not set
>> CONFIG_W1_SLAVE_DS2805=y
>> # CONFIG_W1_SLAVE_DS2430 is not set
>> CONFIG_W1_SLAVE_DS2431=y
>> # CONFIG_W1_SLAVE_DS2433 is not set
>> CONFIG_W1_SLAVE_DS2438=y
>> # CONFIG_W1_SLAVE_DS250X is not set
>> # CONFIG_W1_SLAVE_DS2780 is not set
>> CONFIG_W1_SLAVE_DS2781=y
>> # CONFIG_W1_SLAVE_DS28E04 is not set
>> # CONFIG_W1_SLAVE_DS28E17 is not set
>> # end of 1-wire Slaves
>>
>> # CONFIG_POWER_AVS is not set
>> CONFIG_POWER_RESET=y
>> # CONFIG_POWER_RESET_MT6323 is not set
>> # CONFIG_POWER_RESET_RESTART is not set
>> CONFIG_POWER_SUPPLY=y
>> CONFIG_POWER_SUPPLY_DEBUG=y
>> CONFIG_POWER_SUPPLY_HWMON=y
>> CONFIG_PDA_POWER=y
>> # CONFIG_GENERIC_ADC_BATTERY is not set
>> CONFIG_MAX8925_POWER=y
>> # CONFIG_TEST_POWER is not set
>> CONFIG_BATTERY_88PM860X=y
>> # CONFIG_CHARGER_ADP5061 is not set
>> # CONFIG_BATTERY_CW2015 is not set
>> # CONFIG_BATTERY_DS2760 is not set
>> # CONFIG_BATTERY_DS2780 is not set
>> CONFIG_BATTERY_DS2781=y
>> # CONFIG_BATTERY_DS2782 is not set
>> # CONFIG_BATTERY_SBS is not set
>> CONFIG_CHARGER_SBS=y
>> CONFIG_BATTERY_BQ27XXX=y
>> # CONFIG_BATTERY_BQ27XXX_I2C is not set
>> # CONFIG_BATTERY_BQ27XXX_HDQ is not set
>> CONFIG_BATTERY_DA9030=y
>> # CONFIG_AXP20X_POWER is not set
>> # CONFIG_AXP288_CHARGER is not set
>> CONFIG_AXP288_FUEL_GAUGE=y
>> # CONFIG_BATTERY_MAX17040 is not set
>> # CONFIG_BATTERY_MAX17042 is not set
>> CONFIG_BATTERY_MAX1721X=y
>> CONFIG_BATTERY_TWL4030_MADC=y
>> CONFIG_CHARGER_88PM860X=y
>> CONFIG_CHARGER_PCF50633=y
>> # CONFIG_BATTERY_RX51 is not set
>> CONFIG_CHARGER_ISP1704=y
>> # CONFIG_CHARGER_MAX8903 is not set
>> CONFIG_CHARGER_TWL4030=y
>> # CONFIG_CHARGER_LP8727 is not set
>> CONFIG_CHARGER_GPIO=y
>> CONFIG_CHARGER_MANAGER=y
>> # CONFIG_CHARGER_LT3651 is not set
>> CONFIG_CHARGER_MAX14577=y
>> CONFIG_CHARGER_MAX8998=y
>> CONFIG_CHARGER_BQ2415X=y
>> CONFIG_CHARGER_BQ24190=y
>> CONFIG_CHARGER_BQ24257=y
>> # CONFIG_CHARGER_BQ24735 is not set
>> # CONFIG_CHARGER_BQ2515X is not set
>> CONFIG_CHARGER_BQ25890=y
>> CONFIG_CHARGER_SMB347=y
>> CONFIG_BATTERY_GAUGE_LTC2941=y
>> CONFIG_BATTERY_RT5033=y
>> # CONFIG_CHARGER_RT9455 is not set
>> # CONFIG_CHARGER_CROS_USBPD is not set
>> # CONFIG_CHARGER_BD99954 is not set
>> CONFIG_HWMON=y
>> CONFIG_HWMON_VID=y
>> # CONFIG_HWMON_DEBUG_CHIP is not set
>>
>> #
>> # Native drivers
>> #
>> CONFIG_SENSORS_AD7414=y
>> CONFIG_SENSORS_AD7418=y
>> CONFIG_SENSORS_ADM1021=y
>> # CONFIG_SENSORS_ADM1025 is not set
>> # CONFIG_SENSORS_ADM1026 is not set
>> # CONFIG_SENSORS_ADM1029 is not set
>> # CONFIG_SENSORS_ADM1031 is not set
>> # CONFIG_SENSORS_ADM1177 is not set
>> # CONFIG_SENSORS_ADM9240 is not set
>> # CONFIG_SENSORS_ADT7410 is not set
>> CONFIG_SENSORS_ADT7411=y
>> CONFIG_SENSORS_ADT7462=y
>> CONFIG_SENSORS_ADT7470=y
>> CONFIG_SENSORS_ADT7475=y
>> # CONFIG_SENSORS_AS370 is not set
>> CONFIG_SENSORS_ASC7621=y
>> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
>> # CONFIG_SENSORS_K8TEMP is not set
>> # CONFIG_SENSORS_K10TEMP is not set
>> CONFIG_SENSORS_FAM15H_POWER=y
>> # CONFIG_SENSORS_AMD_ENERGY is not set
>> CONFIG_SENSORS_APPLESMC=y
>> CONFIG_SENSORS_ASB100=y
>> # CONFIG_SENSORS_ASPEED is not set
>> CONFIG_SENSORS_ATXP1=y
>> # CONFIG_SENSORS_CORSAIR_CPRO is not set
>> # CONFIG_SENSORS_DS620 is not set
>> CONFIG_SENSORS_DS1621=y
>> CONFIG_SENSORS_DELL_SMM=y
>> CONFIG_SENSORS_I5K_AMB=y
>> # CONFIG_SENSORS_F71805F is not set
>> # CONFIG_SENSORS_F71882FG is not set
>> CONFIG_SENSORS_F75375S=y
>> CONFIG_SENSORS_MC13783_ADC=y
>> CONFIG_SENSORS_FSCHMD=y
>> CONFIG_SENSORS_GL518SM=y
>> CONFIG_SENSORS_GL520SM=y
>> CONFIG_SENSORS_G760A=y
>> # CONFIG_SENSORS_G762 is not set
>> # CONFIG_SENSORS_HIH6130 is not set
>> CONFIG_SENSORS_IBMAEM=y
>> CONFIG_SENSORS_IBMPEX=y
>> CONFIG_SENSORS_IIO_HWMON=y
>> CONFIG_SENSORS_I5500=y
>> CONFIG_SENSORS_CORETEMP=y
>> # CONFIG_SENSORS_IT87 is not set
>> CONFIG_SENSORS_JC42=y
>> CONFIG_SENSORS_POWR1220=y
>> # CONFIG_SENSORS_LINEAGE is not set
>> # CONFIG_SENSORS_LTC2945 is not set
>> # CONFIG_SENSORS_LTC2947_I2C is not set
>> CONFIG_SENSORS_LTC2990=y
>> CONFIG_SENSORS_LTC4151=y
>> CONFIG_SENSORS_LTC4215=y
>> CONFIG_SENSORS_LTC4222=y
>> # CONFIG_SENSORS_LTC4245 is not set
>> CONFIG_SENSORS_LTC4260=y
>> CONFIG_SENSORS_LTC4261=y
>> CONFIG_SENSORS_MAX16065=y
>> # CONFIG_SENSORS_MAX1619 is not set
>> # CONFIG_SENSORS_MAX1668 is not set
>> CONFIG_SENSORS_MAX197=y
>> # CONFIG_SENSORS_MAX31730 is not set
>> # CONFIG_SENSORS_MAX6621 is not set
>> CONFIG_SENSORS_MAX6639=y
>> CONFIG_SENSORS_MAX6642=y
>> CONFIG_SENSORS_MAX6650=y
>> CONFIG_SENSORS_MAX6697=y
>> CONFIG_SENSORS_MAX31790=y
>> CONFIG_SENSORS_MCP3021=y
>> # CONFIG_SENSORS_MLXREG_FAN is not set
>> CONFIG_SENSORS_TC654=y
>> CONFIG_SENSORS_MENF21BMC_HWMON=y
>> # CONFIG_SENSORS_LM63 is not set
>> CONFIG_SENSORS_LM73=y
>> CONFIG_SENSORS_LM75=y
>> CONFIG_SENSORS_LM77=y
>> CONFIG_SENSORS_LM78=y
>> # CONFIG_SENSORS_LM80 is not set
>> CONFIG_SENSORS_LM83=y
>> CONFIG_SENSORS_LM85=y
>> # CONFIG_SENSORS_LM87 is not set
>> # CONFIG_SENSORS_LM90 is not set
>> CONFIG_SENSORS_LM92=y
>> CONFIG_SENSORS_LM93=y
>> # CONFIG_SENSORS_LM95234 is not set
>> CONFIG_SENSORS_LM95241=y
>> # CONFIG_SENSORS_LM95245 is not set
>> # CONFIG_SENSORS_PC87360 is not set
>> # CONFIG_SENSORS_PC87427 is not set
>> CONFIG_SENSORS_NTC_THERMISTOR=y
>> CONFIG_SENSORS_NCT6683=y
>> CONFIG_SENSORS_NCT6775=y
>> # CONFIG_SENSORS_NCT7802 is not set
>> CONFIG_SENSORS_NPCM7XX=y
>> CONFIG_SENSORS_PCF8591=y
>> CONFIG_PMBUS=y
>> # CONFIG_SENSORS_PMBUS is not set
>> CONFIG_SENSORS_ADM1275=y
>> # CONFIG_SENSORS_BEL_PFE is not set
>> CONFIG_SENSORS_IBM_CFFPS=y
>> # CONFIG_SENSORS_INSPUR_IPSPS is not set
>> # CONFIG_SENSORS_IR35221 is not set
>> # CONFIG_SENSORS_IR38064 is not set
>> # CONFIG_SENSORS_IRPS5401 is not set
>> # CONFIG_SENSORS_ISL68137 is not set
>> CONFIG_SENSORS_LM25066=y
>> CONFIG_SENSORS_LTC2978=y
>> CONFIG_SENSORS_LTC2978_REGULATOR=y
>> CONFIG_SENSORS_LTC3815=y
>> # CONFIG_SENSORS_MAX16064 is not set
>> # CONFIG_SENSORS_MAX16601 is not set
>> # CONFIG_SENSORS_MAX20730 is not set
>> # CONFIG_SENSORS_MAX20751 is not set
>> CONFIG_SENSORS_MAX31785=y
>> CONFIG_SENSORS_MAX34440=y
>> CONFIG_SENSORS_MAX8688=y
>> # CONFIG_SENSORS_PXE1610 is not set
>> CONFIG_SENSORS_TPS40422=y
>> # CONFIG_SENSORS_TPS53679 is not set
>> CONFIG_SENSORS_UCD9000=y
>> # CONFIG_SENSORS_UCD9200 is not set
>> # CONFIG_SENSORS_XDPE122 is not set
>> # CONFIG_SENSORS_ZL6100 is not set
>> CONFIG_SENSORS_SHT15=y
>> CONFIG_SENSORS_SHT21=y
>> CONFIG_SENSORS_SHT3x=y
>> CONFIG_SENSORS_SHTC1=y
>> # CONFIG_SENSORS_SIS5595 is not set
>> # CONFIG_SENSORS_DME1737 is not set
>> # CONFIG_SENSORS_EMC1403 is not set
>> CONFIG_SENSORS_EMC2103=y
>> # CONFIG_SENSORS_EMC6W201 is not set
>> CONFIG_SENSORS_SMSC47M1=y
>> CONFIG_SENSORS_SMSC47M192=y
>> # CONFIG_SENSORS_SMSC47B397 is not set
>> # CONFIG_SENSORS_STTS751 is not set
>> CONFIG_SENSORS_SMM665=y
>> CONFIG_SENSORS_ADC128D818=y
>> # CONFIG_SENSORS_ADS7828 is not set
>> # CONFIG_SENSORS_AMC6821 is not set
>> CONFIG_SENSORS_INA209=y
>> CONFIG_SENSORS_INA2XX=y
>> CONFIG_SENSORS_INA3221=y
>> CONFIG_SENSORS_TC74=y
>> CONFIG_SENSORS_THMC50=y
>> # CONFIG_SENSORS_TMP102 is not set
>> CONFIG_SENSORS_TMP103=y
>> CONFIG_SENSORS_TMP108=y
>> CONFIG_SENSORS_TMP401=y
>> CONFIG_SENSORS_TMP421=y
>> # CONFIG_SENSORS_TMP513 is not set
>> # CONFIG_SENSORS_VIA_CPUTEMP is not set
>> CONFIG_SENSORS_VIA686A=y
>> CONFIG_SENSORS_VT1211=y
>> # CONFIG_SENSORS_VT8231 is not set
>> CONFIG_SENSORS_W83773G=y
>> CONFIG_SENSORS_W83781D=y
>> CONFIG_SENSORS_W83791D=y
>> CONFIG_SENSORS_W83792D=y
>> # CONFIG_SENSORS_W83793 is not set
>> CONFIG_SENSORS_W83795=y
>> CONFIG_SENSORS_W83795_FANCTRL=y
>> CONFIG_SENSORS_W83L785TS=y
>> CONFIG_SENSORS_W83L786NG=y
>> CONFIG_SENSORS_W83627HF=y
>> # CONFIG_SENSORS_W83627EHF is not set
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_SENSORS_ACPI_POWER is not set
>> # CONFIG_SENSORS_ATK0110 is not set
>> CONFIG_THERMAL=y
>> # CONFIG_THERMAL_NETLINK is not set
>> # CONFIG_THERMAL_STATISTICS is not set
>> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
>> CONFIG_THERMAL_HWMON=y
>> CONFIG_THERMAL_WRITABLE_TRIPS=y
>> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
>> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
>> CONFIG_THERMAL_GOV_STEP_WISE=y
>> # CONFIG_THERMAL_GOV_BANG_BANG is not set
>> CONFIG_THERMAL_GOV_USER_SPACE=y
>> # CONFIG_THERMAL_EMULATION is not set
>>
>> #
>> # Intel thermal drivers
>> #
>> CONFIG_X86_PKG_TEMP_THERMAL=m
>> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>>
>> #
>> # ACPI INT340X thermal drivers
>> #
>> # CONFIG_INT340X_THERMAL is not set
>> # end of ACPI INT340X thermal drivers
>>
>> # CONFIG_INTEL_PCH_THERMAL is not set
>> # end of Intel thermal drivers
>>
>> # CONFIG_GENERIC_ADC_THERMAL is not set
>> # CONFIG_WATCHDOG is not set
>> CONFIG_SSB_POSSIBLE=y
>> # CONFIG_SSB is not set
>> CONFIG_BCMA_POSSIBLE=y
>> CONFIG_BCMA=y
>> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
>> CONFIG_BCMA_HOST_PCI=y
>> # CONFIG_BCMA_HOST_SOC is not set
>> CONFIG_BCMA_DRIVER_PCI=y
>> CONFIG_BCMA_DRIVER_GMAC_CMN=y
>> CONFIG_BCMA_DRIVER_GPIO=y
>> CONFIG_BCMA_DEBUG=y
>>
>> #
>> # Multifunction device drivers
>> #
>> CONFIG_MFD_CORE=y
>> CONFIG_MFD_CS5535=y
>> # CONFIG_MFD_AS3711 is not set
>> # CONFIG_PMIC_ADP5520 is not set
>> CONFIG_MFD_AAT2870_CORE=y
>> CONFIG_MFD_BCM590XX=y
>> CONFIG_MFD_BD9571MWV=y
>> CONFIG_MFD_AXP20X=y
>> CONFIG_MFD_AXP20X_I2C=y
>> CONFIG_MFD_CROS_EC_DEV=y
>> CONFIG_MFD_MADERA=y
>> CONFIG_MFD_MADERA_I2C=y
>> # CONFIG_MFD_CS47L15 is not set
>> # CONFIG_MFD_CS47L35 is not set
>> # CONFIG_MFD_CS47L85 is not set
>> CONFIG_MFD_CS47L90=y
>> # CONFIG_MFD_CS47L92 is not set
>> CONFIG_PMIC_DA903X=y
>> # CONFIG_MFD_DA9052_I2C is not set
>> # CONFIG_MFD_DA9055 is not set
>> # CONFIG_MFD_DA9062 is not set
>> CONFIG_MFD_DA9063=y
>> # CONFIG_MFD_DA9150 is not set
>> # CONFIG_MFD_DLN2 is not set
>> CONFIG_MFD_MC13XXX=y
>> CONFIG_MFD_MC13XXX_I2C=y
>> # CONFIG_MFD_MP2629 is not set
>> CONFIG_HTC_PASIC3=y
>> # CONFIG_HTC_I2CPLD is not set
>> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
>> # CONFIG_LPC_ICH is not set
>> CONFIG_LPC_SCH=y
>> # CONFIG_INTEL_SOC_PMIC is not set
>> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
>> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
>> CONFIG_MFD_INTEL_LPSS=y
>> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
>> CONFIG_MFD_INTEL_LPSS_PCI=y
>> # CONFIG_MFD_IQS62X is not set
>> CONFIG_MFD_JANZ_CMODIO=y
>> # CONFIG_MFD_KEMPLD is not set
>> CONFIG_MFD_88PM800=y
>> CONFIG_MFD_88PM805=y
>> CONFIG_MFD_88PM860X=y
>> CONFIG_MFD_MAX14577=y
>> # CONFIG_MFD_MAX77693 is not set
>> # CONFIG_MFD_MAX77843 is not set
>> CONFIG_MFD_MAX8907=y
>> CONFIG_MFD_MAX8925=y
>> # CONFIG_MFD_MAX8997 is not set
>> CONFIG_MFD_MAX8998=y
>> # CONFIG_MFD_MT6360 is not set
>> CONFIG_MFD_MT6397=y
>> CONFIG_MFD_MENF21BMC=y
>> CONFIG_MFD_VIPERBOARD=y
>> # CONFIG_MFD_RETU is not set
>> CONFIG_MFD_PCF50633=y
>> CONFIG_PCF50633_ADC=y
>> CONFIG_PCF50633_GPIO=y
>> CONFIG_MFD_RDC321X=y
>> CONFIG_MFD_RT5033=y
>> CONFIG_MFD_RC5T583=y
>> CONFIG_MFD_SEC_CORE=y
>> # CONFIG_MFD_SI476X_CORE is not set
>> CONFIG_MFD_SM501=y
>> CONFIG_MFD_SM501_GPIO=y
>> CONFIG_MFD_SKY81452=y
>> CONFIG_ABX500_CORE=y
>> CONFIG_AB3100_CORE=y
>> CONFIG_AB3100_OTP=y
>> CONFIG_MFD_SYSCON=y
>> CONFIG_MFD_TI_AM335X_TSCADC=y
>> # CONFIG_MFD_LP3943 is not set
>> CONFIG_MFD_LP8788=y
>> CONFIG_MFD_TI_LMU=y
>> # CONFIG_MFD_PALMAS is not set
>> CONFIG_TPS6105X=y
>> # CONFIG_TPS65010 is not set
>> CONFIG_TPS6507X=y
>> CONFIG_MFD_TPS65086=y
>> # CONFIG_MFD_TPS65090 is not set
>> # CONFIG_MFD_TPS68470 is not set
>> CONFIG_MFD_TI_LP873X=y
>> # CONFIG_MFD_TPS6586X is not set
>> CONFIG_MFD_TPS65910=y
>> CONFIG_MFD_TPS65912=y
>> CONFIG_MFD_TPS65912_I2C=y
>> # CONFIG_MFD_TPS80031 is not set
>> CONFIG_TWL4030_CORE=y
>> CONFIG_MFD_TWL4030_AUDIO=y
>> CONFIG_TWL6040_CORE=y
>> CONFIG_MFD_WL1273_CORE=y
>> CONFIG_MFD_LM3533=y
>> CONFIG_MFD_TIMBERDALE=y
>> # CONFIG_MFD_TQMX86 is not set
>> CONFIG_MFD_VX855=y
>> CONFIG_MFD_ARIZONA=y
>> CONFIG_MFD_ARIZONA_I2C=y
>> CONFIG_MFD_CS47L24=y
>> CONFIG_MFD_WM5102=y
>> # CONFIG_MFD_WM5110 is not set
>> CONFIG_MFD_WM8997=y
>> # CONFIG_MFD_WM8998 is not set
>> # CONFIG_MFD_WM8400 is not set
>> # CONFIG_MFD_WM831X_I2C is not set
>> # CONFIG_MFD_WM8350_I2C is not set
>> CONFIG_MFD_WM8994=y
>> # CONFIG_MFD_WCD934X is not set
>> CONFIG_RAVE_SP_CORE=y
>> # end of Multifunction device drivers
>>
>> CONFIG_REGULATOR=y
>> CONFIG_REGULATOR_DEBUG=y
>> CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
>> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
>> CONFIG_REGULATOR_88PG86X=y
>> CONFIG_REGULATOR_88PM800=y
>> CONFIG_REGULATOR_88PM8607=y
>> # CONFIG_REGULATOR_ACT8865 is not set
>> CONFIG_REGULATOR_AD5398=y
>> CONFIG_REGULATOR_AAT2870=y
>> # CONFIG_REGULATOR_AB3100 is not set
>> # CONFIG_REGULATOR_AXP20X is not set
>> CONFIG_REGULATOR_BCM590XX=y
>> CONFIG_REGULATOR_BD9571MWV=y
>> # CONFIG_REGULATOR_DA903X is not set
>> # CONFIG_REGULATOR_DA9210 is not set
>> CONFIG_REGULATOR_DA9211=y
>> # CONFIG_REGULATOR_FAN53555 is not set
>> # CONFIG_REGULATOR_GPIO is not set
>> # CONFIG_REGULATOR_ISL9305 is not set
>> CONFIG_REGULATOR_ISL6271A=y
>> # CONFIG_REGULATOR_LM363X is not set
>> CONFIG_REGULATOR_LP3971=y
>> CONFIG_REGULATOR_LP3972=y
>> CONFIG_REGULATOR_LP872X=y
>> CONFIG_REGULATOR_LP8755=y
>> CONFIG_REGULATOR_LP8788=y
>> CONFIG_REGULATOR_LTC3589=y
>> # CONFIG_REGULATOR_LTC3676 is not set
>> CONFIG_REGULATOR_MAX14577=y
>> # CONFIG_REGULATOR_MAX1586 is not set
>> CONFIG_REGULATOR_MAX8649=y
>> CONFIG_REGULATOR_MAX8660=y
>> CONFIG_REGULATOR_MAX8907=y
>> # CONFIG_REGULATOR_MAX8925 is not set
>> CONFIG_REGULATOR_MAX8952=y
>> CONFIG_REGULATOR_MAX8998=y
>> # CONFIG_REGULATOR_MAX77826 is not set
>> CONFIG_REGULATOR_MC13XXX_CORE=y
>> CONFIG_REGULATOR_MC13783=y
>> CONFIG_REGULATOR_MC13892=y
>> # CONFIG_REGULATOR_MP8859 is not set
>> # CONFIG_REGULATOR_MT6311 is not set
>> CONFIG_REGULATOR_MT6323=y
>> # CONFIG_REGULATOR_MT6358 is not set
>> CONFIG_REGULATOR_MT6397=y
>> # CONFIG_REGULATOR_PCA9450 is not set
>> CONFIG_REGULATOR_PCF50633=y
>> # CONFIG_REGULATOR_PFUZE100 is not set
>> CONFIG_REGULATOR_PV88060=y
>> CONFIG_REGULATOR_PV88080=y
>> CONFIG_REGULATOR_PV88090=y
>> # CONFIG_REGULATOR_QCOM_SPMI is not set
>> # CONFIG_REGULATOR_QCOM_USB_VBUS is not set
>> CONFIG_REGULATOR_RC5T583=y
>> # CONFIG_REGULATOR_RT5033 is not set
>> # CONFIG_REGULATOR_S2MPA01 is not set
>> CONFIG_REGULATOR_S2MPS11=y
>> # CONFIG_REGULATOR_S5M8767 is not set
>> CONFIG_REGULATOR_SKY81452=y
>> # CONFIG_REGULATOR_SLG51000 is not set
>> CONFIG_REGULATOR_TPS51632=y
>> CONFIG_REGULATOR_TPS6105X=y
>> CONFIG_REGULATOR_TPS62360=y
>> # CONFIG_REGULATOR_TPS65023 is not set
>> CONFIG_REGULATOR_TPS6507X=y
>> # CONFIG_REGULATOR_TPS65086 is not set
>> CONFIG_REGULATOR_TPS65132=y
>> CONFIG_REGULATOR_TPS65910=y
>> CONFIG_REGULATOR_TPS65912=y
>> # CONFIG_REGULATOR_TWL4030 is not set
>> CONFIG_REGULATOR_WM8994=y
>> # CONFIG_REGULATOR_QCOM_LABIBB is not set
>> # CONFIG_RC_CORE is not set
>> CONFIG_CEC_CORE=y
>> CONFIG_CEC_NOTIFIER=y
>> # CONFIG_MEDIA_CEC_SUPPORT is not set
>> # CONFIG_MEDIA_SUPPORT is not set
>>
>> #
>> # Graphics support
>> #
>> CONFIG_AGP=y
>> CONFIG_AGP_ALI=y
>> CONFIG_AGP_ATI=y
>> CONFIG_AGP_AMD=y
>> # CONFIG_AGP_AMD64 is not set
>> CONFIG_AGP_INTEL=y
>> # CONFIG_AGP_NVIDIA is not set
>> CONFIG_AGP_SIS=y
>> CONFIG_AGP_SWORKS=y
>> CONFIG_AGP_VIA=y
>> # CONFIG_AGP_EFFICEON is not set
>> CONFIG_INTEL_GTT=y
>> CONFIG_VGA_ARB=y
>> CONFIG_VGA_ARB_MAX_GPUS=16
>> # CONFIG_VGA_SWITCHEROO is not set
>> CONFIG_DRM=y
>> CONFIG_DRM_MIPI_DSI=y
>> CONFIG_DRM_DP_AUX_CHARDEV=y
>> CONFIG_DRM_DEBUG_MM=y
>> CONFIG_DRM_DEBUG_SELFTEST=y
>> CONFIG_DRM_KMS_HELPER=y
>> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
>> # CONFIG_DRM_FBDEV_EMULATION is not set
>> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
>> # CONFIG_DRM_DP_CEC is not set
>> CONFIG_DRM_TTM=y
>> CONFIG_DRM_TTM_DMA_PAGE_POOL=y
>> CONFIG_DRM_VRAM_HELPER=y
>> CONFIG_DRM_TTM_HELPER=y
>> CONFIG_DRM_GEM_SHMEM_HELPER=y
>> CONFIG_DRM_VM=y
>> CONFIG_DRM_SCHED=y
>>
>> #
>> # I2C encoder or helper chips
>> #
>> CONFIG_DRM_I2C_CH7006=y
>> # CONFIG_DRM_I2C_SIL164 is not set
>> # CONFIG_DRM_I2C_NXP_TDA998X is not set
>> CONFIG_DRM_I2C_NXP_TDA9950=y
>> # end of I2C encoder or helper chips
>>
>> #
>> # ARM devices
>> #
>> # end of ARM devices
>>
>> CONFIG_DRM_RADEON=y
>> CONFIG_DRM_RADEON_USERPTR=y
>> CONFIG_DRM_AMDGPU=y
>> CONFIG_DRM_AMDGPU_SI=y
>> # CONFIG_DRM_AMDGPU_CIK is not set
>> CONFIG_DRM_AMDGPU_USERPTR=y
>> CONFIG_DRM_AMDGPU_GART_DEBUGFS=y
>>
>> #
>> # ACP (Audio CoProcessor) Configuration
>> #
>> # CONFIG_DRM_AMD_ACP is not set
>> # end of ACP (Audio CoProcessor) Configuration
>>
>> #
>> # Display Engine Configuration
>> #
>> # CONFIG_DRM_AMD_DC is not set
>> # CONFIG_DRM_AMD_DC_SI is not set
>> # end of Display Engine Configuration
>>
>> # CONFIG_DRM_NOUVEAU is not set
>> CONFIG_DRM_I915=y
>> CONFIG_DRM_I915_FORCE_PROBE=""
>> # CONFIG_DRM_I915_CAPTURE_ERROR is not set
>> # CONFIG_DRM_I915_USERPTR is not set
>>
>> #
>> # drm/i915 Debugging
>> #
>> # CONFIG_DRM_I915_WERROR is not set
>> # CONFIG_DRM_I915_DEBUG is not set
>> # CONFIG_DRM_I915_DEBUG_MMIO is not set
>> CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
>> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
>> CONFIG_DRM_I915_DEBUG_GUC=y
>> CONFIG_DRM_I915_SELFTEST=y
>> CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
>> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
>> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
>> # end of drm/i915 Debugging
>>
>> #
>> # drm/i915 Profile Guided Optimisation
>> #
>> CONFIG_DRM_I915_FENCE_TIMEOUT=10000
>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
>> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
>> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
>> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
>> CONFIG_DRM_I915_STOP_TIMEOUT=100
>> CONFIG_DRM_I915_TIMESLICE_DURATION=1
>> # end of drm/i915 Profile Guided Optimisation
>>
>> CONFIG_DRM_VGEM=y
>> CONFIG_DRM_VKMS=y
>> # CONFIG_DRM_VMWGFX is not set
>> CONFIG_DRM_GMA500=y
>> CONFIG_DRM_GMA600=y
>> CONFIG_DRM_GMA3600=y
>> CONFIG_DRM_UDL=y
>> CONFIG_DRM_AST=y
>> # CONFIG_DRM_MGAG200 is not set
>> CONFIG_DRM_QXL=y
>> CONFIG_DRM_BOCHS=y
>> CONFIG_DRM_VIRTIO_GPU=y
>> CONFIG_DRM_PANEL=y
>>
>> #
>> # Display Panels
>> #
>> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
>> # end of Display Panels
>>
>> CONFIG_DRM_BRIDGE=y
>> CONFIG_DRM_PANEL_BRIDGE=y
>>
>> #
>> # Display Interface Bridges
>> #
>> CONFIG_DRM_ANALOGIX_ANX78XX=y
>> CONFIG_DRM_ANALOGIX_DP=y
>> # end of Display Interface Bridges
>>
>> # CONFIG_DRM_ETNAVIV is not set
>> # CONFIG_DRM_CIRRUS_QEMU is not set
>> # CONFIG_DRM_GM12U320 is not set
>> CONFIG_DRM_VBOXVIDEO=y
>> CONFIG_DRM_LEGACY=y
>> CONFIG_DRM_TDFX=y
>> CONFIG_DRM_R128=y
>> CONFIG_DRM_MGA=y
>> CONFIG_DRM_SIS=y
>> CONFIG_DRM_VIA=y
>> CONFIG_DRM_SAVAGE=y
>> CONFIG_DRM_EXPORT_FOR_TESTS=y
>> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
>> CONFIG_DRM_LIB_RANDOM=y
>>
>> #
>> # Frame buffer Devices
>> #
>> CONFIG_FB_CMDLINE=y
>> CONFIG_FB_NOTIFY=y
>> CONFIG_FB=y
>> # CONFIG_FIRMWARE_EDID is not set
>> CONFIG_FB_DDC=y
>> CONFIG_FB_CFB_FILLRECT=y
>> CONFIG_FB_CFB_COPYAREA=y
>> CONFIG_FB_CFB_IMAGEBLIT=y
>> CONFIG_FB_SYS_FILLRECT=y
>> CONFIG_FB_SYS_COPYAREA=y
>> CONFIG_FB_SYS_IMAGEBLIT=y
>> # CONFIG_FB_FOREIGN_ENDIAN is not set
>> CONFIG_FB_SYS_FOPS=y
>> CONFIG_FB_DEFERRED_IO=y
>> CONFIG_FB_SVGALIB=y
>> CONFIG_FB_BACKLIGHT=y
>> CONFIG_FB_MODE_HELPERS=y
>> CONFIG_FB_TILEBLITTING=y
>>
>> #
>> # Frame buffer hardware drivers
>> #
>> # CONFIG_FB_CIRRUS is not set
>> CONFIG_FB_PM2=y
>> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
>> CONFIG_FB_CYBER2000=y
>> # CONFIG_FB_CYBER2000_DDC is not set
>> CONFIG_FB_ARC=y
>> # CONFIG_FB_ASILIANT is not set
>> # CONFIG_FB_IMSTT is not set
>> # CONFIG_FB_VGA16 is not set
>> # CONFIG_FB_UVESA is not set
>> # CONFIG_FB_VESA is not set
>> # CONFIG_FB_N411 is not set
>> CONFIG_FB_HGA=y
>> CONFIG_FB_OPENCORES=y
>> CONFIG_FB_S1D13XXX=y
>> CONFIG_FB_NVIDIA=y
>> CONFIG_FB_NVIDIA_I2C=y
>> # CONFIG_FB_NVIDIA_DEBUG is not set
>> CONFIG_FB_NVIDIA_BACKLIGHT=y
>> CONFIG_FB_RIVA=y
>> # CONFIG_FB_RIVA_I2C is not set
>> # CONFIG_FB_RIVA_DEBUG is not set
>> # CONFIG_FB_RIVA_BACKLIGHT is not set
>> CONFIG_FB_I740=y
>> CONFIG_FB_I810=y
>> # CONFIG_FB_I810_GTF is not set
>> CONFIG_FB_LE80578=y
>> CONFIG_FB_CARILLO_RANCH=y
>> # CONFIG_FB_MATROX is not set
>> CONFIG_FB_RADEON=y
>> CONFIG_FB_RADEON_I2C=y
>> # CONFIG_FB_RADEON_BACKLIGHT is not set
>> CONFIG_FB_RADEON_DEBUG=y
>> # CONFIG_FB_ATY128 is not set
>> CONFIG_FB_ATY=y
>> CONFIG_FB_ATY_CT=y
>> # CONFIG_FB_ATY_GENERIC_LCD is not set
>> # CONFIG_FB_ATY_GX is not set
>> # CONFIG_FB_ATY_BACKLIGHT is not set
>> CONFIG_FB_S3=y
>> # CONFIG_FB_S3_DDC is not set
>> CONFIG_FB_SAVAGE=y
>> # CONFIG_FB_SAVAGE_I2C is not set
>> # CONFIG_FB_SAVAGE_ACCEL is not set
>> # CONFIG_FB_SIS is not set
>> # CONFIG_FB_VIA is not set
>> CONFIG_FB_NEOMAGIC=y
>> CONFIG_FB_KYRO=y
>> CONFIG_FB_3DFX=y
>> # CONFIG_FB_3DFX_ACCEL is not set
>> CONFIG_FB_3DFX_I2C=y
>> # CONFIG_FB_VOODOO1 is not set
>> CONFIG_FB_VT8623=y
>> CONFIG_FB_TRIDENT=y
>> CONFIG_FB_ARK=y
>> # CONFIG_FB_PM3 is not set
>> # CONFIG_FB_CARMINE is not set
>> CONFIG_FB_GEODE=y
>> CONFIG_FB_GEODE_LX=y
>> # CONFIG_FB_GEODE_GX is not set
>> CONFIG_FB_GEODE_GX1=y
>> # CONFIG_FB_SM501 is not set
>> # CONFIG_FB_SMSCUFX is not set
>> CONFIG_FB_UDL=y
>> # CONFIG_FB_IBM_GXT4500 is not set
>> CONFIG_FB_VIRTUAL=y
>> CONFIG_FB_METRONOME=y
>> CONFIG_FB_MB862XX=y
>> CONFIG_FB_MB862XX_PCI_GDC=y
>> CONFIG_FB_MB862XX_I2C=y
>> # CONFIG_FB_SIMPLE is not set
>> CONFIG_FB_SM712=y
>> # end of Frame buffer Devices
>>
>> #
>> # Backlight & LCD device support
>> #
>> CONFIG_LCD_CLASS_DEVICE=y
>> CONFIG_LCD_PLATFORM=y
>> CONFIG_BACKLIGHT_CLASS_DEVICE=y
>> CONFIG_BACKLIGHT_LM3533=y
>> # CONFIG_BACKLIGHT_CARILLO_RANCH is not set
>> CONFIG_BACKLIGHT_DA903X=y
>> CONFIG_BACKLIGHT_MAX8925=y
>> # CONFIG_BACKLIGHT_APPLE is not set
>> # CONFIG_BACKLIGHT_QCOM_WLED is not set
>> # CONFIG_BACKLIGHT_SAHARA is not set
>> CONFIG_BACKLIGHT_ADP8860=y
>> # CONFIG_BACKLIGHT_ADP8870 is not set
>> CONFIG_BACKLIGHT_88PM860X=y
>> CONFIG_BACKLIGHT_PCF50633=y
>> # CONFIG_BACKLIGHT_AAT2870 is not set
>> CONFIG_BACKLIGHT_LM3639=y
>> # CONFIG_BACKLIGHT_PANDORA is not set
>> CONFIG_BACKLIGHT_SKY81452=y
>> CONFIG_BACKLIGHT_GPIO=y
>> CONFIG_BACKLIGHT_LV5207LP=y
>> CONFIG_BACKLIGHT_BD6107=y
>> CONFIG_BACKLIGHT_ARCXCNN=y
>> # CONFIG_BACKLIGHT_RAVE_SP is not set
>> # end of Backlight & LCD device support
>>
>> CONFIG_VGASTATE=y
>> CONFIG_HDMI=y
>> # CONFIG_LOGO is not set
>> # end of Graphics support
>>
>> # CONFIG_SOUND is not set
>>
>> #
>> # HID support
>> #
>> CONFIG_HID=y
>> CONFIG_HID_BATTERY_STRENGTH=y
>> CONFIG_HIDRAW=y
>> CONFIG_UHID=y
>> # CONFIG_HID_GENERIC is not set
>>
>> #
>> # Special HID drivers
>> #
>> CONFIG_HID_A4TECH=y
>> # CONFIG_HID_ACCUTOUCH is not set
>> # CONFIG_HID_ACRUX is not set
>> # CONFIG_HID_APPLE is not set
>> CONFIG_HID_APPLEIR=y
>> CONFIG_HID_ASUS=y
>> CONFIG_HID_AUREAL=y
>> CONFIG_HID_BELKIN=y
>> # CONFIG_HID_BETOP_FF is not set
>> # CONFIG_HID_BIGBEN_FF is not set
>> CONFIG_HID_CHERRY=y
>> CONFIG_HID_CHICONY=y
>> CONFIG_HID_CORSAIR=y
>> CONFIG_HID_COUGAR=y
>> # CONFIG_HID_MACALLY is not set
>> # CONFIG_HID_CMEDIA is not set
>> CONFIG_HID_CP2112=y
>> # CONFIG_HID_CREATIVE_SB0540 is not set
>> CONFIG_HID_CYPRESS=y
>> # CONFIG_HID_DRAGONRISE is not set
>> # CONFIG_HID_EMS_FF is not set
>> CONFIG_HID_ELAN=y
>> # CONFIG_HID_ELECOM is not set
>> # CONFIG_HID_ELO is not set
>> CONFIG_HID_EZKEY=y
>> CONFIG_HID_GEMBIRD=y
>> CONFIG_HID_GFRM=y
>> # CONFIG_HID_GLORIOUS is not set
>> CONFIG_HID_HOLTEK=y
>> # CONFIG_HOLTEK_FF is not set
>> CONFIG_HID_GOOGLE_HAMMER=y
>> CONFIG_HID_GT683R=y
>> CONFIG_HID_KEYTOUCH=y
>> # CONFIG_HID_KYE is not set
>> CONFIG_HID_UCLOGIC=y
>> CONFIG_HID_WALTOP=y
>> # CONFIG_HID_VIEWSONIC is not set
>> # CONFIG_HID_GYRATION is not set
>> # CONFIG_HID_ICADE is not set
>> CONFIG_HID_ITE=y
>> CONFIG_HID_JABRA=y
>> # CONFIG_HID_TWINHAN is not set
>> # CONFIG_HID_KENSINGTON is not set
>> CONFIG_HID_LCPOWER=y
>> CONFIG_HID_LED=y
>> CONFIG_HID_LENOVO=y
>> # CONFIG_HID_LOGITECH is not set
>> CONFIG_HID_MAGICMOUSE=y
>> # CONFIG_HID_MALTRON is not set
>> CONFIG_HID_MAYFLASH=y
>> CONFIG_HID_REDRAGON=y
>> CONFIG_HID_MICROSOFT=y
>> CONFIG_HID_MONTEREY=y
>> CONFIG_HID_MULTITOUCH=y
>> # CONFIG_HID_NTI is not set
>> CONFIG_HID_NTRIG=y
>> CONFIG_HID_ORTEK=y
>> # CONFIG_HID_PANTHERLORD is not set
>> # CONFIG_HID_PENMOUNT is not set
>> CONFIG_HID_PETALYNX=y
>> # CONFIG_HID_PICOLCD is not set
>> # CONFIG_HID_PLANTRONICS is not set
>> CONFIG_HID_PRIMAX=y
>> CONFIG_HID_RETRODE=y
>> # CONFIG_HID_ROCCAT is not set
>> # CONFIG_HID_SAITEK is not set
>> CONFIG_HID_SAMSUNG=y
>> CONFIG_HID_SONY=y
>> CONFIG_SONY_FF=y
>> # CONFIG_HID_SPEEDLINK is not set
>> CONFIG_HID_STEAM=y
>> CONFIG_HID_STEELSERIES=y
>> # CONFIG_HID_SUNPLUS is not set
>> CONFIG_HID_RMI=y
>> CONFIG_HID_GREENASIA=y
>> # CONFIG_GREENASIA_FF is not set
>> CONFIG_HID_SMARTJOYPLUS=y
>> # CONFIG_SMARTJOYPLUS_FF is not set
>> CONFIG_HID_TIVO=y
>> CONFIG_HID_TOPSEED=y
>> CONFIG_HID_THINGM=y
>> CONFIG_HID_THRUSTMASTER=y
>> # CONFIG_THRUSTMASTER_FF is not set
>> CONFIG_HID_UDRAW_PS3=y
>> # CONFIG_HID_WACOM is not set
>> CONFIG_HID_WIIMOTE=y
>> CONFIG_HID_XINMO=y
>> CONFIG_HID_ZEROPLUS=y
>> # CONFIG_ZEROPLUS_FF is not set
>> CONFIG_HID_ZYDACRON=y
>> # CONFIG_HID_SENSOR_HUB is not set
>> # CONFIG_HID_ALPS is not set
>> # CONFIG_HID_MCP2221 is not set
>> # end of Special HID drivers
>>
>> #
>> # USB HID support
>> #
>> CONFIG_USB_HID=y
>> CONFIG_HID_PID=y
>> CONFIG_USB_HIDDEV=y
>> # end of USB HID support
>>
>> #
>> # I2C HID support
>> #
>> CONFIG_I2C_HID=y
>> # end of I2C HID support
>> # end of HID support
>>
>> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
>> CONFIG_USB_SUPPORT=y
>> CONFIG_USB_COMMON=y
>> # CONFIG_USB_LED_TRIG is not set
>> CONFIG_USB_ULPI_BUS=y
>> # CONFIG_USB_CONN_GPIO is not set
>> CONFIG_USB_ARCH_HAS_HCD=y
>> CONFIG_USB=y
>> # CONFIG_USB_PCI is not set
>> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
>>
>> #
>> # Miscellaneous USB options
>> #
>> # CONFIG_USB_DEFAULT_PERSIST is not set
>> CONFIG_USB_DYNAMIC_MINORS=y
>> CONFIG_USB_OTG=y
>> # CONFIG_USB_OTG_PRODUCTLIST is not set
>> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
>> CONFIG_USB_OTG_FSM=y
>> # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
>> CONFIG_USB_AUTOSUSPEND_DELAY=2
>> # CONFIG_USB_MON is not set
>>
>> #
>> # USB Host Controller Drivers
>> #
>> CONFIG_USB_C67X00_HCD=y
>> # CONFIG_USB_XHCI_HCD is not set
>> CONFIG_USB_EHCI_HCD=y
>> CONFIG_USB_EHCI_ROOT_HUB_TT=y
>> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
>> # CONFIG_USB_EHCI_FSL is not set
>> CONFIG_USB_EHCI_HCD_PLATFORM=y
>> CONFIG_USB_OXU210HP_HCD=y
>> # CONFIG_USB_ISP116X_HCD is not set
>> CONFIG_USB_FOTG210_HCD=y
>> CONFIG_USB_OHCI_HCD=y
>> CONFIG_USB_OHCI_HCD_PLATFORM=y
>> # CONFIG_USB_U132_HCD is not set
>> # CONFIG_USB_SL811_HCD is not set
>> # CONFIG_USB_R8A66597_HCD is not set
>> CONFIG_USB_HCD_BCMA=y
>> # CONFIG_USB_HCD_TEST_MODE is not set
>>
>> #
>> # USB Device Class drivers
>> #
>> # CONFIG_USB_ACM is not set
>> # CONFIG_USB_PRINTER is not set
>> CONFIG_USB_WDM=y
>> CONFIG_USB_TMC=y
>>
>> #
>> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
>> #
>>
>> #
>> # also be needed; see USB_STORAGE Help for more info
>> #
>>
>> #
>> # USB Imaging devices
>> #
>> # CONFIG_USB_MDC800 is not set
>> CONFIG_USBIP_CORE=y
>> CONFIG_USBIP_VHCI_HCD=y
>> CONFIG_USBIP_VHCI_HC_PORTS=8
>> CONFIG_USBIP_VHCI_NR_HCS=1
>> CONFIG_USBIP_HOST=y
>> CONFIG_USBIP_DEBUG=y
>> # CONFIG_USB_CDNS3 is not set
>> CONFIG_USB_MUSB_HDRC=y
>> CONFIG_USB_MUSB_HOST=y
>>
>> #
>> # Platform Glue Layer
>> #
>>
>> #
>> # MUSB DMA mode
>> #
>> CONFIG_MUSB_PIO_ONLY=y
>> CONFIG_USB_DWC3=y
>> CONFIG_USB_DWC3_ULPI=y
>> CONFIG_USB_DWC3_HOST=y
>>
>> #
>> # Platform Glue Driver Support
>> #
>> CONFIG_USB_DWC2=y
>> CONFIG_USB_DWC2_HOST=y
>>
>> #
>> # Gadget/Dual-role mode requires USB Gadget support to be enabled
>> #
>> # CONFIG_USB_DWC2_DEBUG is not set
>> # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
>> CONFIG_USB_CHIPIDEA=y
>> CONFIG_USB_CHIPIDEA_HOST=y
>> CONFIG_USB_CHIPIDEA_MSM=y
>> CONFIG_USB_CHIPIDEA_GENERIC=y
>> CONFIG_USB_ISP1760=y
>> CONFIG_USB_ISP1760_HCD=y
>> CONFIG_USB_ISP1760_HOST_ROLE=y
>>
>> #
>> # USB port drivers
>> #
>> # CONFIG_USB_USS720 is not set
>> # CONFIG_USB_SERIAL is not set
>>
>> #
>> # USB Miscellaneous drivers
>> #
>> CONFIG_USB_EMI62=y
>> CONFIG_USB_EMI26=y
>> CONFIG_USB_ADUTUX=y
>> CONFIG_USB_SEVSEG=y
>> # CONFIG_USB_LEGOTOWER is not set
>> # CONFIG_USB_LCD is not set
>> CONFIG_USB_CYPRESS_CY7C63=y
>> CONFIG_USB_CYTHERM=y
>> CONFIG_USB_IDMOUSE=y
>> CONFIG_USB_FTDI_ELAN=y
>> # CONFIG_USB_APPLEDISPLAY is not set
>> # CONFIG_APPLE_MFI_FASTCHARGE is not set
>> # CONFIG_USB_SISUSBVGA is not set
>> CONFIG_USB_LD=y
>> CONFIG_USB_TRANCEVIBRATOR=y
>> CONFIG_USB_IOWARRIOR=y
>> CONFIG_USB_TEST=y
>> CONFIG_USB_EHSET_TEST_FIXTURE=y
>> CONFIG_USB_ISIGHTFW=y
>> CONFIG_USB_YUREX=y
>> # CONFIG_USB_EZUSB_FX2 is not set
>> CONFIG_USB_HUB_USB251XB=y
>> # CONFIG_USB_HSIC_USB3503 is not set
>> CONFIG_USB_HSIC_USB4604=y
>> # CONFIG_USB_LINK_LAYER_TEST is not set
>> # CONFIG_USB_ATM is not set
>>
>> #
>> # USB Physical Layer drivers
>> #
>> CONFIG_USB_PHY=y
>> CONFIG_NOP_USB_XCEIV=y
>> CONFIG_USB_GPIO_VBUS=y
>> CONFIG_USB_ISP1301=y
>> # end of USB Physical Layer drivers
>>
>> # CONFIG_USB_GADGET is not set
>> CONFIG_TYPEC=y
>> CONFIG_TYPEC_TCPM=y
>> CONFIG_TYPEC_TCPCI=y
>> CONFIG_TYPEC_RT1711H=y
>> CONFIG_TYPEC_FUSB302=y
>> # CONFIG_TYPEC_UCSI is not set
>> # CONFIG_TYPEC_HD3SS3220 is not set
>> # CONFIG_TYPEC_TPS6598X is not set
>>
>> #
>> # USB Type-C Multiplexer/DeMultiplexer Switch support
>> #
>> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
>> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>>
>> #
>> # USB Type-C Alternate Mode drivers
>> #
>> # CONFIG_TYPEC_DP_ALTMODE is not set
>> # end of USB Type-C Alternate Mode drivers
>>
>> CONFIG_USB_ROLE_SWITCH=y
>> # CONFIG_USB_ROLES_INTEL_XHCI is not set
>> CONFIG_MMC=y
>> # CONFIG_SDIO_UART is not set
>> # CONFIG_MMC_TEST is not set
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> # CONFIG_MMC_DEBUG is not set
>> # CONFIG_MMC_SDHCI is not set
>> # CONFIG_MMC_WBSD is not set
>> CONFIG_MMC_TIFM_SD=y
>> CONFIG_MMC_CB710=y
>> CONFIG_MMC_VIA_SDMMC=y
>> CONFIG_MMC_VUB300=y
>> CONFIG_MMC_USHC=y
>> CONFIG_MMC_USDHI6ROL0=y
>> CONFIG_MMC_REALTEK_PCI=y
>> # CONFIG_MMC_REALTEK_USB is not set
>> CONFIG_MMC_CQHCI=y
>> # CONFIG_MMC_HSQ is not set
>> CONFIG_MMC_TOSHIBA_PCI=y
>> CONFIG_MMC_MTK=y
>> # CONFIG_MEMSTICK is not set
>> CONFIG_NEW_LEDS=y
>> CONFIG_LEDS_CLASS=y
>> CONFIG_LEDS_CLASS_FLASH=y
>> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
>> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
>>
>> #
>> # LED drivers
>> #
>> # CONFIG_LEDS_88PM860X is not set
>> # CONFIG_LEDS_AS3645A is not set
>> CONFIG_LEDS_LM3530=y
>> # CONFIG_LEDS_LM3532 is not set
>> CONFIG_LEDS_LM3533=y
>> CONFIG_LEDS_LM3642=y
>> CONFIG_LEDS_LM3601X=y
>> CONFIG_LEDS_MT6323=y
>> # CONFIG_LEDS_NET48XX is not set
>> CONFIG_LEDS_WRAP=y
>> CONFIG_LEDS_PCA9532=y
>> CONFIG_LEDS_PCA9532_GPIO=y
>> CONFIG_LEDS_GPIO=y
>> CONFIG_LEDS_LP3944=y
>> # CONFIG_LEDS_LP3952 is not set
>> # CONFIG_LEDS_LP8788 is not set
>> CONFIG_LEDS_PCA955X=y
>> CONFIG_LEDS_PCA955X_GPIO=y
>> # CONFIG_LEDS_PCA963X is not set
>> # CONFIG_LEDS_DA903X is not set
>> CONFIG_LEDS_REGULATOR=y
>> # CONFIG_LEDS_BD2802 is not set
>> CONFIG_LEDS_MC13783=y
>> # CONFIG_LEDS_TCA6507 is not set
>> CONFIG_LEDS_TLC591XX=y
>> CONFIG_LEDS_LM355x=y
>> # CONFIG_LEDS_OT200 is not set
>> CONFIG_LEDS_MENF21BMC=y
>>
>> #
>> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
>> #
>> # CONFIG_LEDS_BLINKM is not set
>> CONFIG_LEDS_MLXREG=y
>> # CONFIG_LEDS_USER is not set
>> # CONFIG_LEDS_NIC78BX is not set
>> # CONFIG_LEDS_TI_LMU_COMMON is not set
>> CONFIG_LEDS_TPS6105X=y
>> # CONFIG_LEDS_SGM3140 is not set
>>
>> #
>> # LED Triggers
>> #
>> CONFIG_LEDS_TRIGGERS=y
>> CONFIG_LEDS_TRIGGER_TIMER=y
>> CONFIG_LEDS_TRIGGER_ONESHOT=y
>> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>> CONFIG_LEDS_TRIGGER_CPU=y
>> CONFIG_LEDS_TRIGGER_ACTIVITY=y
>> # CONFIG_LEDS_TRIGGER_GPIO is not set
>> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
>>
>> #
>> # iptables trigger is under Netfilter config (LED target)
>> #
>> CONFIG_LEDS_TRIGGER_TRANSIENT=y
>> CONFIG_LEDS_TRIGGER_CAMERA=y
>> # CONFIG_LEDS_TRIGGER_PANIC is not set
>> CONFIG_LEDS_TRIGGER_NETDEV=y
>> # CONFIG_LEDS_TRIGGER_PATTERN is not set
>> # CONFIG_LEDS_TRIGGER_AUDIO is not set
>> # CONFIG_ACCESSIBILITY is not set
>> CONFIG_INFINIBAND=y
>> CONFIG_INFINIBAND_USER_MAD=y
>> CONFIG_INFINIBAND_USER_ACCESS=y
>> CONFIG_INFINIBAND_USER_MEM=y
>> CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
>> CONFIG_INFINIBAND_ADDR_TRANS=y
>> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
>> CONFIG_INFINIBAND_MTHCA=y
>> CONFIG_INFINIBAND_MTHCA_DEBUG=y
>> # CONFIG_MLX4_INFINIBAND is not set
>> # CONFIG_INFINIBAND_OCRDMA is not set
>> CONFIG_RDMA_RXE=y
>> # CONFIG_RDMA_SIW is not set
>> # CONFIG_INFINIBAND_IPOIB is not set
>> # CONFIG_INFINIBAND_RTRS_CLIENT is not set
>> # CONFIG_INFINIBAND_RTRS_SERVER is not set
>> CONFIG_EDAC_ATOMIC_SCRUB=y
>> CONFIG_EDAC_SUPPORT=y
>> # CONFIG_EDAC is not set
>> CONFIG_RTC_LIB=y
>> CONFIG_RTC_MC146818_LIB=y
>> # CONFIG_RTC_CLASS is not set
>> # CONFIG_DMADEVICES is not set
>>
>> #
>> # DMABUF options
>> #
>> CONFIG_SYNC_FILE=y
>> CONFIG_SW_SYNC=y
>> # CONFIG_UDMABUF is not set
>> # CONFIG_DMABUF_MOVE_NOTIFY is not set
>> # CONFIG_DMABUF_SELFTESTS is not set
>> # CONFIG_DMABUF_HEAPS is not set
>> # end of DMABUF options
>>
>> CONFIG_AUXDISPLAY=y
>> # CONFIG_HD44780 is not set
>> # CONFIG_IMG_ASCII_LCD is not set
>> CONFIG_PARPORT_PANEL=y
>> CONFIG_PANEL_PARPORT=0
>> CONFIG_PANEL_PROFILE=5
>> CONFIG_PANEL_CHANGE_MESSAGE=y
>> CONFIG_PANEL_BOOT_MESSAGE=""
>> # CONFIG_CHARLCD_BL_OFF is not set
>> # CONFIG_CHARLCD_BL_ON is not set
>> CONFIG_CHARLCD_BL_FLASH=y
>> CONFIG_PANEL=y
>> CONFIG_CHARLCD=y
>> CONFIG_UIO=y
>> CONFIG_UIO_CIF=y
>> # CONFIG_UIO_PDRV_GENIRQ is not set
>> CONFIG_UIO_DMEM_GENIRQ=y
>> CONFIG_UIO_AEC=y
>> CONFIG_UIO_SERCOS3=y
>> # CONFIG_UIO_PCI_GENERIC is not set
>> CONFIG_UIO_NETX=y
>> # CONFIG_UIO_PRUSS is not set
>> CONFIG_UIO_MF624=y
>> # CONFIG_VIRT_DRIVERS is not set
>> CONFIG_VIRTIO=y
>> CONFIG_VIRTIO_MENU=y
>> CONFIG_VIRTIO_PCI=y
>> CONFIG_VIRTIO_PCI_LEGACY=y
>> CONFIG_VIRTIO_BALLOON=y
>> CONFIG_VIRTIO_INPUT=y
>> # CONFIG_VIRTIO_MMIO is not set
>> CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
>> # CONFIG_VDPA is not set
>> CONFIG_VHOST_IOTLB=y
>> CONFIG_VHOST=y
>> CONFIG_VHOST_MENU=y
>> CONFIG_VHOST_NET=y
>> # CONFIG_VHOST_VSOCK is not set
>> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>>
>> #
>> # Microsoft Hyper-V guest support
>> #
>> # CONFIG_HYPERV is not set
>> # end of Microsoft Hyper-V guest support
>>
>> CONFIG_GREYBUS=y
>> CONFIG_GREYBUS_ES2=y
>> CONFIG_STAGING=y
>> # CONFIG_PRISM2_USB is not set
>> CONFIG_COMEDI=y
>> CONFIG_COMEDI_DEBUG=y
>> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
>> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
>> CONFIG_COMEDI_MISC_DRIVERS=y
>> CONFIG_COMEDI_BOND=y
>> CONFIG_COMEDI_TEST=y
>> CONFIG_COMEDI_PARPORT=y
>> CONFIG_COMEDI_SSV_DNP=y
>> # CONFIG_COMEDI_ISA_DRIVERS is not set
>> CONFIG_COMEDI_PCI_DRIVERS=y
>> CONFIG_COMEDI_8255_PCI=y
>> # CONFIG_COMEDI_ADDI_APCI_1032 is not set
>> CONFIG_COMEDI_ADDI_APCI_1500=y
>> # CONFIG_COMEDI_ADDI_APCI_1516 is not set
>> # CONFIG_COMEDI_ADDI_APCI_1564 is not set
>> CONFIG_COMEDI_ADDI_APCI_16XX=y
>> # CONFIG_COMEDI_ADDI_APCI_2032 is not set
>> # CONFIG_COMEDI_ADDI_APCI_2200 is not set
>> CONFIG_COMEDI_ADDI_APCI_3120=y
>> # CONFIG_COMEDI_ADDI_APCI_3501 is not set
>> # CONFIG_COMEDI_ADDI_APCI_3XXX is not set
>> CONFIG_COMEDI_ADL_PCI6208=y
>> # CONFIG_COMEDI_ADL_PCI7X3X is not set
>> CONFIG_COMEDI_ADL_PCI8164=y
>> CONFIG_COMEDI_ADL_PCI9111=y
>> CONFIG_COMEDI_ADL_PCI9118=y
>> CONFIG_COMEDI_ADV_PCI1710=y
>> CONFIG_COMEDI_ADV_PCI1720=y
>> CONFIG_COMEDI_ADV_PCI1723=y
>> CONFIG_COMEDI_ADV_PCI1724=y
>> CONFIG_COMEDI_ADV_PCI1760=y
>> # CONFIG_COMEDI_ADV_PCI_DIO is not set
>> CONFIG_COMEDI_AMPLC_DIO200_PCI=y
>> CONFIG_COMEDI_AMPLC_PC236_PCI=y
>> CONFIG_COMEDI_AMPLC_PC263_PCI=y
>> CONFIG_COMEDI_AMPLC_PCI224=y
>> CONFIG_COMEDI_AMPLC_PCI230=y
>> # CONFIG_COMEDI_CONTEC_PCI_DIO is not set
>> # CONFIG_COMEDI_DAS08_PCI is not set
>> CONFIG_COMEDI_DT3000=y
>> CONFIG_COMEDI_DYNA_PCI10XX=y
>> CONFIG_COMEDI_GSC_HPDI=y
>> CONFIG_COMEDI_MF6X4=y
>> CONFIG_COMEDI_ICP_MULTI=y
>> CONFIG_COMEDI_DAQBOARD2000=y
>> # CONFIG_COMEDI_JR3_PCI is not set
>> CONFIG_COMEDI_KE_COUNTER=y
>> CONFIG_COMEDI_CB_PCIDAS64=y
>> # CONFIG_COMEDI_CB_PCIDAS is not set
>> # CONFIG_COMEDI_CB_PCIDDA is not set
>> CONFIG_COMEDI_CB_PCIMDAS=y
>> # CONFIG_COMEDI_CB_PCIMDDA is not set
>> CONFIG_COMEDI_ME4000=y
>> CONFIG_COMEDI_ME_DAQ=y
>> CONFIG_COMEDI_NI_6527=y
>> # CONFIG_COMEDI_NI_65XX is not set
>> CONFIG_COMEDI_NI_660X=y
>> CONFIG_COMEDI_NI_670X=y
>> CONFIG_COMEDI_NI_LABPC_PCI=y
>> CONFIG_COMEDI_NI_PCIDIO=y
>> CONFIG_COMEDI_NI_PCIMIO=y
>> CONFIG_COMEDI_RTD520=y
>> CONFIG_COMEDI_S626=y
>> CONFIG_COMEDI_MITE=y
>> CONFIG_COMEDI_NI_TIOCMD=y
>> # CONFIG_COMEDI_USB_DRIVERS is not set
>> CONFIG_COMEDI_8254=y
>> CONFIG_COMEDI_8255=y
>> # CONFIG_COMEDI_8255_SA is not set
>> CONFIG_COMEDI_KCOMEDILIB=y
>> CONFIG_COMEDI_AMPLC_DIO200=y
>> CONFIG_COMEDI_AMPLC_PC236=y
>> CONFIG_COMEDI_NI_LABPC=y
>> CONFIG_COMEDI_NI_TIO=y
>> CONFIG_COMEDI_NI_ROUTING=y
>> # CONFIG_RTL8192U is not set
>> # CONFIG_RTLLIB is not set
>> # CONFIG_RTL8723BS is not set
>> # CONFIG_R8712U is not set
>> # CONFIG_R8188EU is not set
>>
>> #
>> # IIO staging drivers
>> #
>>
>> #
>> # Accelerometers
>> #
>> # end of Accelerometers
>>
>> #
>> # Analog to digital converters
>> #
>> # end of Analog to digital converters
>>
>> #
>> # Analog digital bi-direction converters
>> #
>> CONFIG_ADT7316=y
>> # CONFIG_ADT7316_I2C is not set
>> # end of Analog digital bi-direction converters
>>
>> #
>> # Capacitance to digital converters
>> #
>> CONFIG_AD7150=y
>> # CONFIG_AD7746 is not set
>> # end of Capacitance to digital converters
>>
>> #
>> # Direct Digital Synthesis
>> #
>> # end of Direct Digital Synthesis
>>
>> #
>> # Network Analyzer, Impedance Converters
>> #
>> CONFIG_AD5933=y
>> # end of Network Analyzer, Impedance Converters
>>
>> #
>> # Active energy metering IC
>> #
>> CONFIG_ADE7854=y
>> CONFIG_ADE7854_I2C=y
>> # end of Active energy metering IC
>>
>> #
>> # Resolver to digital converters
>> #
>> # end of Resolver to digital converters
>> # end of IIO staging drivers
>>
>> CONFIG_FB_SM750=y
>> CONFIG_STAGING_MEDIA=y
>>
>> #
>> # Android
>> #
>> # end of Android
>>
>> # CONFIG_LTE_GDM724X is not set
>> # CONFIG_FIREWIRE_SERIAL is not set
>> # CONFIG_GS_FPGABOOT is not set
>> # CONFIG_UNISYSSPAR is not set
>> # CONFIG_MOST_COMPONENTS is not set
>> # CONFIG_KS7010 is not set
>> CONFIG_GREYBUS_BOOTROM=y
>> CONFIG_GREYBUS_HID=y
>> # CONFIG_GREYBUS_LIGHT is not set
>> # CONFIG_GREYBUS_LOG is not set
>> # CONFIG_GREYBUS_LOOPBACK is not set
>> CONFIG_GREYBUS_POWER=y
>> CONFIG_GREYBUS_RAW=y
>> # CONFIG_GREYBUS_VIBRATOR is not set
>> # CONFIG_GREYBUS_BRIDGED_PHY is not set
>>
>> #
>> # Gasket devices
>> #
>> # end of Gasket devices
>>
>> # CONFIG_FIELDBUS_DEV is not set
>> # CONFIG_KPC2000 is not set
>> # CONFIG_QLGE is not set
>> # CONFIG_X86_PLATFORM_DEVICES is not set
>> CONFIG_PMC_ATOM=y
>> CONFIG_MFD_CROS_EC=y
>> CONFIG_CHROME_PLATFORMS=y
>> CONFIG_CHROMEOS_PSTORE=y
>> # CONFIG_CHROMEOS_TBMC is not set
>> CONFIG_CROS_EC=y
>> # CONFIG_CROS_EC_I2C is not set
>> # CONFIG_CROS_EC_LPC is not set
>> CONFIG_CROS_EC_PROTO=y
>> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
>> CONFIG_CROS_EC_CHARDEV=y
>> CONFIG_CROS_EC_LIGHTBAR=y
>> CONFIG_CROS_EC_DEBUGFS=y
>> CONFIG_CROS_EC_SENSORHUB=y
>> CONFIG_CROS_EC_SYSFS=y
>> CONFIG_CROS_EC_TYPEC=y
>> CONFIG_CROS_USBPD_NOTIFY=y
>> CONFIG_MELLANOX_PLATFORM=y
>> # CONFIG_MLXREG_HOTPLUG is not set
>> CONFIG_MLXREG_IO=y
>> CONFIG_HAVE_CLK=y
>> CONFIG_CLKDEV_LOOKUP=y
>> CONFIG_HAVE_CLK_PREPARE=y
>> CONFIG_COMMON_CLK=y
>> CONFIG_COMMON_CLK_MAX9485=y
>> # CONFIG_COMMON_CLK_SI5341 is not set
>> # CONFIG_COMMON_CLK_SI5351 is not set
>> # CONFIG_COMMON_CLK_SI544 is not set
>> CONFIG_COMMON_CLK_CDCE706=y
>> CONFIG_COMMON_CLK_CS2000_CP=y
>> # CONFIG_COMMON_CLK_S2MPS11 is not set
>> CONFIG_CLK_TWL6040=y
>> CONFIG_HWSPINLOCK=y
>>
>> #
>> # Clock Source drivers
>> #
>> CONFIG_CLKSRC_I8253=y
>> CONFIG_CLKEVT_I8253=y
>> CONFIG_I8253_LOCK=y
>> CONFIG_CLKBLD_I8253=y
>> # end of Clock Source drivers
>>
>> CONFIG_MAILBOX=y
>> # CONFIG_PCC is not set
>> # CONFIG_ALTERA_MBOX is not set
>> # CONFIG_IOMMU_SUPPORT is not set
>>
>> #
>> # Remoteproc drivers
>> #
>> CONFIG_REMOTEPROC=y
>> # CONFIG_REMOTEPROC_CDEV is not set
>> # end of Remoteproc drivers
>>
>> #
>> # Rpmsg drivers
>> #
>> CONFIG_RPMSG=y
>> CONFIG_RPMSG_CHAR=y
>> CONFIG_RPMSG_QCOM_GLINK=y
>> CONFIG_RPMSG_QCOM_GLINK_RPM=y
>> CONFIG_RPMSG_VIRTIO=y
>> # end of Rpmsg drivers
>>
>> # CONFIG_SOUNDWIRE is not set
>>
>> #
>> # SOC (System On Chip) specific Drivers
>> #
>>
>> #
>> # Amlogic SoC drivers
>> #
>> # end of Amlogic SoC drivers
>>
>> #
>> # Aspeed SoC drivers
>> #
>> # end of Aspeed SoC drivers
>>
>> #
>> # Broadcom SoC drivers
>> #
>> # end of Broadcom SoC drivers
>>
>> #
>> # NXP/Freescale QorIQ SoC drivers
>> #
>> # end of NXP/Freescale QorIQ SoC drivers
>>
>> #
>> # i.MX SoC drivers
>> #
>> # end of i.MX SoC drivers
>>
>> #
>> # Qualcomm SoC drivers
>> #
>> # end of Qualcomm SoC drivers
>>
>> # CONFIG_SOC_TI is not set
>>
>> #
>> # Xilinx SoC drivers
>> #
>> CONFIG_XILINX_VCU=y
>> # end of Xilinx SoC drivers
>> # end of SOC (System On Chip) specific Drivers
>>
>> # CONFIG_PM_DEVFREQ is not set
>> CONFIG_EXTCON=y
>>
>> #
>> # Extcon Device Drivers
>> #
>> CONFIG_EXTCON_ADC_JACK=y
>> CONFIG_EXTCON_AXP288=y
>> # CONFIG_EXTCON_FSA9480 is not set
>> CONFIG_EXTCON_GPIO=y
>> # CONFIG_EXTCON_INTEL_INT3496 is not set
>> CONFIG_EXTCON_MAX14577=y
>> CONFIG_EXTCON_MAX3355=y
>> # CONFIG_EXTCON_PTN5150 is not set
>> # CONFIG_EXTCON_RT8973A is not set
>> # CONFIG_EXTCON_SM5502 is not set
>> CONFIG_EXTCON_USB_GPIO=y
>> CONFIG_EXTCON_USBC_CROS_EC=y
>> CONFIG_MEMORY=y
>> CONFIG_IIO=y
>> CONFIG_IIO_BUFFER=y
>> CONFIG_IIO_BUFFER_CB=y
>> CONFIG_IIO_BUFFER_HW_CONSUMER=y
>> CONFIG_IIO_KFIFO_BUF=y
>> CONFIG_IIO_TRIGGERED_BUFFER=y
>> CONFIG_IIO_CONFIGFS=y
>> CONFIG_IIO_TRIGGER=y
>> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
>> CONFIG_IIO_SW_DEVICE=y
>> CONFIG_IIO_SW_TRIGGER=y
>>
>> #
>> # Accelerometers
>> #
>> # CONFIG_ADXL372_I2C is not set
>> CONFIG_BMA180=y
>> # CONFIG_BMA400 is not set
>> CONFIG_BMC150_ACCEL=y
>> CONFIG_BMC150_ACCEL_I2C=y
>> CONFIG_DA280=y
>> CONFIG_DA311=y
>> CONFIG_DMARD09=y
>> # CONFIG_DMARD10 is not set
>> # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
>> CONFIG_KXSD9=y
>> CONFIG_KXSD9_I2C=y
>> CONFIG_KXCJK1013=y
>> CONFIG_MC3230=y
>> # CONFIG_MMA7455_I2C is not set
>> CONFIG_MMA7660=y
>> CONFIG_MMA8452=y
>> CONFIG_MMA9551_CORE=y
>> CONFIG_MMA9551=y
>> # CONFIG_MMA9553 is not set
>> CONFIG_MXC4005=y
>> CONFIG_MXC6255=y
>> CONFIG_STK8312=y
>> CONFIG_STK8BA50=y
>> # end of Accelerometers
>>
>> #
>> # Analog to digital converters
>> #
>> # CONFIG_AD7091R5 is not set
>> CONFIG_AD7291=y
>> CONFIG_AD7606=y
>> CONFIG_AD7606_IFACE_PARALLEL=y
>> CONFIG_AD799X=y
>> # CONFIG_ADI_AXI_ADC is not set
>> # CONFIG_AXP20X_ADC is not set
>> # CONFIG_AXP288_ADC is not set
>> CONFIG_CC10001_ADC=y
>> CONFIG_HX711=y
>> # CONFIG_LP8788_ADC is not set
>> # CONFIG_LTC2471 is not set
>> CONFIG_LTC2485=y
>> CONFIG_LTC2497=y
>> CONFIG_MAX1363=y
>> CONFIG_MAX9611=y
>> CONFIG_MCP3422=y
>> # CONFIG_NAU7802 is not set
>> CONFIG_QCOM_SPMI_IADC=y
>> # CONFIG_QCOM_SPMI_VADC is not set
>> # CONFIG_QCOM_SPMI_ADC5 is not set
>> CONFIG_TI_ADC081C=y
>> # CONFIG_TI_ADS1015 is not set
>> CONFIG_TI_AM335X_ADC=y
>> CONFIG_TWL4030_MADC=y
>> # CONFIG_TWL6030_GPADC is not set
>> # CONFIG_VIPERBOARD_ADC is not set
>> # CONFIG_XILINX_XADC is not set
>> # end of Analog to digital converters
>>
>> #
>> # Analog Front Ends
>> #
>> # end of Analog Front Ends
>>
>> #
>> # Amplifiers
>> #
>> # CONFIG_HMC425 is not set
>> # end of Amplifiers
>>
>> #
>> # Chemical Sensors
>> #
>> CONFIG_ATLAS_PH_SENSOR=y
>> # CONFIG_ATLAS_EZO_SENSOR is not set
>> CONFIG_BME680=y
>> CONFIG_BME680_I2C=y
>> # CONFIG_CCS811 is not set
>> CONFIG_IAQCORE=y
>> # CONFIG_PMS7003 is not set
>> # CONFIG_SCD30_CORE is not set
>> # CONFIG_SENSIRION_SGP30 is not set
>> # CONFIG_SPS30 is not set
>> # CONFIG_VZ89X is not set
>> # end of Chemical Sensors
>>
>> CONFIG_IIO_CROS_EC_SENSORS_CORE=y
>> CONFIG_IIO_CROS_EC_SENSORS=y
>> # CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set
>>
>> #
>> # Hid Sensor IIO Common
>> #
>> # end of Hid Sensor IIO Common
>>
>> CONFIG_IIO_MS_SENSORS_I2C=y
>>
>> #
>> # SSP Sensor Common
>> #
>> # end of SSP Sensor Common
>>
>> CONFIG_IIO_ST_SENSORS_I2C=y
>> CONFIG_IIO_ST_SENSORS_CORE=y
>>
>> #
>> # Digital to analog converters
>> #
>> CONFIG_AD5064=y
>> # CONFIG_AD5380 is not set
>> CONFIG_AD5446=y
>> CONFIG_AD5592R_BASE=y
>> CONFIG_AD5593R=y
>> CONFIG_AD5686=y
>> CONFIG_AD5696_I2C=y
>> CONFIG_DS4424=y
>> # CONFIG_M62332 is not set
>> CONFIG_MAX517=y
>> CONFIG_MCP4725=y
>> CONFIG_TI_DAC5571=y
>> # end of Digital to analog converters
>>
>> #
>> # IIO dummy driver
>> #
>> # CONFIG_IIO_SIMPLE_DUMMY is not set
>> # end of IIO dummy driver
>>
>> #
>> # Frequency Synthesizers DDS/PLL
>> #
>>
>> #
>> # Clock Generator/Distribution
>> #
>> # end of Clock Generator/Distribution
>>
>> #
>> # Phase-Locked Loop (PLL) frequency synthesizers
>> #
>> # end of Phase-Locked Loop (PLL) frequency synthesizers
>> # end of Frequency Synthesizers DDS/PLL
>>
>> #
>> # Digital gyroscope sensors
>> #
>> # CONFIG_BMG160 is not set
>> # CONFIG_FXAS21002C is not set
>> # CONFIG_MPU3050_I2C is not set
>> CONFIG_IIO_ST_GYRO_3AXIS=y
>> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
>> CONFIG_ITG3200=y
>> # end of Digital gyroscope sensors
>>
>> #
>> # Health Sensors
>> #
>>
>> #
>> # Heart Rate Monitors
>> #
>> CONFIG_AFE4404=y
>> # CONFIG_MAX30100 is not set
>> CONFIG_MAX30102=y
>> # end of Heart Rate Monitors
>> # end of Health Sensors
>>
>> #
>> # Humidity sensors
>> #
>> CONFIG_AM2315=y
>> CONFIG_DHT11=y
>> CONFIG_HDC100X=y
>> CONFIG_HTS221=y
>> CONFIG_HTS221_I2C=y
>> # CONFIG_HTU21 is not set
>> # CONFIG_SI7005 is not set
>> # CONFIG_SI7020 is not set
>> # end of Humidity sensors
>>
>> #
>> # Inertial measurement units
>> #
>> CONFIG_BMI160=y
>> CONFIG_BMI160_I2C=y
>> # CONFIG_FXOS8700_I2C is not set
>> # CONFIG_KMX61 is not set
>> # CONFIG_INV_ICM42600_I2C is not set
>> # CONFIG_INV_MPU6050_I2C is not set
>> # CONFIG_IIO_ST_LSM6DSX is not set
>> # end of Inertial measurement units
>>
>> #
>> # Light sensors
>> #
>> # CONFIG_ACPI_ALS is not set
>> CONFIG_ADJD_S311=y
>> # CONFIG_ADUX1020 is not set
>> # CONFIG_AL3010 is not set
>> CONFIG_AL3320A=y
>> # CONFIG_APDS9300 is not set
>> CONFIG_APDS9960=y
>> CONFIG_BH1750=y
>> CONFIG_BH1780=y
>> CONFIG_CM32181=y
>> # CONFIG_CM3232 is not set
>> # CONFIG_CM3323 is not set
>> CONFIG_CM36651=y
>> # CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
>> # CONFIG_GP2AP002 is not set
>> # CONFIG_GP2AP020A00F is not set
>> # CONFIG_SENSORS_ISL29018 is not set
>> CONFIG_SENSORS_ISL29028=y
>> CONFIG_ISL29125=y
>> CONFIG_JSA1212=y
>> CONFIG_RPR0521=y
>> CONFIG_SENSORS_LM3533=y
>> # CONFIG_LTR501 is not set
>> CONFIG_LV0104CS=y
>> CONFIG_MAX44000=y
>> # CONFIG_MAX44009 is not set
>> # CONFIG_NOA1305 is not set
>> CONFIG_OPT3001=y
>> # CONFIG_PA12203001 is not set
>> CONFIG_SI1133=y
>> # CONFIG_SI1145 is not set
>> # CONFIG_STK3310 is not set
>> CONFIG_ST_UVIS25=y
>> CONFIG_ST_UVIS25_I2C=y
>> CONFIG_TCS3414=y
>> CONFIG_TCS3472=y
>> CONFIG_SENSORS_TSL2563=y
>> # CONFIG_TSL2583 is not set
>> # CONFIG_TSL2772 is not set
>> CONFIG_TSL4531=y
>> CONFIG_US5182D=y
>> CONFIG_VCNL4000=y
>> # CONFIG_VCNL4035 is not set
>> # CONFIG_VEML6030 is not set
>> CONFIG_VEML6070=y
>> CONFIG_VL6180=y
>> CONFIG_ZOPT2201=y
>> # end of Light sensors
>>
>> #
>> # Magnetometer sensors
>> #
>> CONFIG_AK8975=y
>> CONFIG_AK09911=y
>> CONFIG_BMC150_MAGN=y
>> CONFIG_BMC150_MAGN_I2C=y
>> # CONFIG_MAG3110 is not set
>> CONFIG_MMC35240=y
>> # CONFIG_IIO_ST_MAGN_3AXIS is not set
>> # CONFIG_SENSORS_HMC5843_I2C is not set
>> # CONFIG_SENSORS_RM3100_I2C is not set
>> # end of Magnetometer sensors
>>
>> #
>> # Multiplexers
>> #
>> # end of Multiplexers
>>
>> #
>> # Inclinometer sensors
>> #
>> # end of Inclinometer sensors
>>
>> #
>> # Triggers - standalone
>> #
>> CONFIG_IIO_HRTIMER_TRIGGER=y
>> CONFIG_IIO_INTERRUPT_TRIGGER=y
>> # CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
>> CONFIG_IIO_SYSFS_TRIGGER=y
>> # end of Triggers - standalone
>>
>> #
>> # Linear and angular position sensors
>> #
>> # end of Linear and angular position sensors
>>
>> #
>> # Digital potentiometers
>> #
>> # CONFIG_AD5272 is not set
>> CONFIG_DS1803=y
>> # CONFIG_MAX5432 is not set
>> # CONFIG_MCP4018 is not set
>> # CONFIG_MCP4531 is not set
>> CONFIG_TPL0102=y
>> # end of Digital potentiometers
>>
>> #
>> # Digital potentiostats
>> #
>> CONFIG_LMP91000=y
>> # end of Digital potentiostats
>>
>> #
>> # Pressure sensors
>> #
>> CONFIG_ABP060MG=y
>> # CONFIG_BMP280 is not set
>> CONFIG_IIO_CROS_EC_BARO=y
>> # CONFIG_DLHL60D is not set
>> # CONFIG_DPS310 is not set
>> CONFIG_HP03=y
>> # CONFIG_ICP10100 is not set
>> # CONFIG_MPL115_I2C is not set
>> # CONFIG_MPL3115 is not set
>> CONFIG_MS5611=y
>> CONFIG_MS5611_I2C=y
>> CONFIG_MS5637=y
>> CONFIG_IIO_ST_PRESS=y
>> CONFIG_IIO_ST_PRESS_I2C=y
>> # CONFIG_T5403 is not set
>> # CONFIG_HP206C is not set
>> CONFIG_ZPA2326=y
>> CONFIG_ZPA2326_I2C=y
>> # end of Pressure sensors
>>
>> #
>> # Lightning sensors
>> #
>> # end of Lightning sensors
>>
>> #
>> # Proximity and distance sensors
>> #
>> CONFIG_ISL29501=y
>> # CONFIG_LIDAR_LITE_V2 is not set
>> # CONFIG_MB1232 is not set
>> # CONFIG_PING is not set
>> CONFIG_RFD77402=y
>> CONFIG_SRF04=y
>> # CONFIG_SX9310 is not set
>> # CONFIG_SX9500 is not set
>> CONFIG_SRF08=y
>> # CONFIG_VCNL3020 is not set
>> # CONFIG_VL53L0X_I2C is not set
>> # end of Proximity and distance sensors
>>
>> #
>> # Resolver to digital converters
>> #
>> # end of Resolver to digital converters
>>
>> #
>> # Temperature sensors
>> #
>> # CONFIG_MLX90614 is not set
>> CONFIG_MLX90632=y
>> # CONFIG_TMP006 is not set
>> CONFIG_TMP007=y
>> # CONFIG_TSYS01 is not set
>> CONFIG_TSYS02D=y
>> # end of Temperature sensors
>>
>> CONFIG_NTB=y
>> CONFIG_NTB_IDT=y
>> CONFIG_NTB_SWITCHTEC=y
>> CONFIG_NTB_PINGPONG=y
>> # CONFIG_NTB_TOOL is not set
>> CONFIG_NTB_PERF=y
>> # CONFIG_NTB_TRANSPORT is not set
>> CONFIG_VME_BUS=y
>>
>> #
>> # VME Bridge Drivers
>> #
>> CONFIG_VME_CA91CX42=y
>> CONFIG_VME_TSI148=y
>> CONFIG_VME_FAKE=y
>>
>> #
>> # VME Board Drivers
>> #
>> # CONFIG_VMIVME_7805 is not set
>>
>> #
>> # VME Device Drivers
>> #
>> # CONFIG_VME_USER is not set
>> # CONFIG_PWM is not set
>>
>> #
>> # IRQ chip support
>> #
>> CONFIG_MADERA_IRQ=y
>> # end of IRQ chip support
>>
>> CONFIG_IPACK_BUS=y
>> CONFIG_BOARD_TPCI200=y
>> # CONFIG_SERIAL_IPOCTAL is not set
>> CONFIG_RESET_CONTROLLER=y
>> # CONFIG_RESET_BRCMSTB_RESCAL is not set
>> CONFIG_RESET_TI_SYSCON=y
>>
>> #
>> # PHY Subsystem
>> #
>> CONFIG_GENERIC_PHY=y
>> # CONFIG_BCM_KONA_USB2_PHY is not set
>> # CONFIG_PHY_PXA_28NM_HSIC is not set
>> CONFIG_PHY_PXA_28NM_USB2=y
>> CONFIG_PHY_CPCAP_USB=y
>> # CONFIG_PHY_QCOM_USB_HS is not set
>> CONFIG_PHY_QCOM_USB_HSIC=y
>> # CONFIG_PHY_SAMSUNG_USB2 is not set
>> CONFIG_PHY_TUSB1210=y
>> # CONFIG_PHY_INTEL_EMMC is not set
>> # end of PHY Subsystem
>>
>> # CONFIG_POWERCAP is not set
>> # CONFIG_MCB is not set
>>
>> #
>> # Performance monitor support
>> #
>> # end of Performance monitor support
>>
>> CONFIG_RAS=y
>> CONFIG_RAS_CEC=y
>> # CONFIG_RAS_CEC_DEBUG is not set
>> # CONFIG_USB4 is not set
>>
>> #
>> # Android
>> #
>> # CONFIG_ANDROID is not set
>> # end of Android
>>
>> # CONFIG_DAX is not set
>> # CONFIG_NVMEM is not set
>>
>> #
>> # HW tracing support
>> #
>> CONFIG_STM=y
>> # CONFIG_STM_PROTO_BASIC is not set
>> # CONFIG_STM_PROTO_SYS_T is not set
>> CONFIG_STM_DUMMY=y
>> CONFIG_STM_SOURCE_CONSOLE=y
>> # CONFIG_STM_SOURCE_HEARTBEAT is not set
>> CONFIG_INTEL_TH=y
>> # CONFIG_INTEL_TH_PCI is not set
>> # CONFIG_INTEL_TH_ACPI is not set
>> CONFIG_INTEL_TH_GTH=y
>> CONFIG_INTEL_TH_STH=y
>> CONFIG_INTEL_TH_MSU=y
>> # CONFIG_INTEL_TH_PTI is not set
>> CONFIG_INTEL_TH_DEBUG=y
>> # end of HW tracing support
>>
>> CONFIG_FPGA=y
>> # CONFIG_ALTERA_PR_IP_CORE is not set
>> CONFIG_FPGA_MGR_ALTERA_CVP=y
>> CONFIG_FPGA_BRIDGE=y
>> # CONFIG_ALTERA_FREEZE_BRIDGE is not set
>> CONFIG_XILINX_PR_DECOUPLER=y
>> CONFIG_FPGA_REGION=y
>> # CONFIG_FPGA_DFL is not set
>> # CONFIG_TEE is not set
>> # CONFIG_SIOX is not set
>> CONFIG_SLIMBUS=y
>> CONFIG_SLIM_QCOM_CTRL=y
>> # CONFIG_INTERCONNECT is not set
>> # CONFIG_COUNTER is not set
>> CONFIG_MOST=y
>> # CONFIG_MOST_USB_HDM is not set
>> # end of Device Drivers
>>
>> #
>> # File systems
>> #
>> CONFIG_DCACHE_WORD_ACCESS=y
>> # CONFIG_VALIDATE_FS_PARSER is not set
>> CONFIG_FS_POSIX_ACL=y
>> CONFIG_EXPORTFS=y
>> # CONFIG_EXPORTFS_BLOCK_OPS is not set
>> CONFIG_FILE_LOCKING=y
>> CONFIG_MANDATORY_FILE_LOCKING=y
>> CONFIG_FS_ENCRYPTION=y
>> # CONFIG_FS_VERITY is not set
>> CONFIG_FSNOTIFY=y
>> CONFIG_DNOTIFY=y
>> CONFIG_INOTIFY_USER=y
>> # CONFIG_FANOTIFY is not set
>> # CONFIG_QUOTA is not set
>> CONFIG_AUTOFS4_FS=y
>> CONFIG_AUTOFS_FS=y
>> CONFIG_FUSE_FS=y
>> # CONFIG_CUSE is not set
>> # CONFIG_VIRTIO_FS is not set
>> CONFIG_OVERLAY_FS=y
>> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
>> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
>> # CONFIG_OVERLAY_FS_INDEX is not set
>> CONFIG_OVERLAY_FS_METACOPY=y
>>
>> #
>> # Caches
>> #
>> CONFIG_FSCACHE=y
>> # CONFIG_FSCACHE_STATS is not set
>> CONFIG_FSCACHE_HISTOGRAM=y
>> # CONFIG_FSCACHE_DEBUG is not set
>> # CONFIG_FSCACHE_OBJECT_LIST is not set
>> # end of Caches
>>
>> #
>> # Pseudo filesystems
>> #
>> CONFIG_PROC_FS=y
>> # CONFIG_PROC_KCORE is not set
>> # CONFIG_PROC_VMCORE is not set
>> CONFIG_PROC_SYSCTL=y
>> CONFIG_PROC_PAGE_MONITOR=y
>> CONFIG_PROC_CHILDREN=y
>> CONFIG_PROC_PID_ARCH_STATUS=y
>> CONFIG_KERNFS=y
>> CONFIG_SYSFS=y
>> CONFIG_TMPFS=y
>> CONFIG_TMPFS_POSIX_ACL=y
>> CONFIG_TMPFS_XATTR=y
>> # CONFIG_HUGETLBFS is not set
>> CONFIG_MEMFD_CREATE=y
>> CONFIG_CONFIGFS_FS=y
>> # end of Pseudo filesystems
>>
>> CONFIG_MISC_FILESYSTEMS=y
>> CONFIG_ORANGEFS_FS=y
>> CONFIG_ECRYPT_FS=y
>> # CONFIG_ECRYPT_FS_MESSAGING is not set
>> # CONFIG_CRAMFS is not set
>> CONFIG_PSTORE=y
>> CONFIG_PSTORE_DEFLATE_COMPRESS=y
>> CONFIG_PSTORE_LZO_COMPRESS=y
>> CONFIG_PSTORE_LZ4_COMPRESS=y
>> CONFIG_PSTORE_LZ4HC_COMPRESS=y
>> CONFIG_PSTORE_842_COMPRESS=y
>> CONFIG_PSTORE_ZSTD_COMPRESS=y
>> CONFIG_PSTORE_COMPRESS=y
>> # CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
>> CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
>> # CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
>> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
>> # CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
>> # CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
>> CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
>> CONFIG_PSTORE_CONSOLE=y
>> CONFIG_PSTORE_PMSG=y
>> CONFIG_PSTORE_RAM=y
>> # CONFIG_NETWORK_FILESYSTEMS is not set
>> CONFIG_NLS=y
>> CONFIG_NLS_DEFAULT="iso8859-1"
>> # CONFIG_NLS_CODEPAGE_437 is not set
>> CONFIG_NLS_CODEPAGE_737=y
>> CONFIG_NLS_CODEPAGE_775=y
>> CONFIG_NLS_CODEPAGE_850=y
>> CONFIG_NLS_CODEPAGE_852=y
>> # CONFIG_NLS_CODEPAGE_855 is not set
>> CONFIG_NLS_CODEPAGE_857=y
>> CONFIG_NLS_CODEPAGE_860=y
>> CONFIG_NLS_CODEPAGE_861=y
>> CONFIG_NLS_CODEPAGE_862=y
>> # CONFIG_NLS_CODEPAGE_863 is not set
>> CONFIG_NLS_CODEPAGE_864=y
>> CONFIG_NLS_CODEPAGE_865=y
>> CONFIG_NLS_CODEPAGE_866=y
>> # CONFIG_NLS_CODEPAGE_869 is not set
>> # CONFIG_NLS_CODEPAGE_936 is not set
>> CONFIG_NLS_CODEPAGE_950=y
>> CONFIG_NLS_CODEPAGE_932=y
>> CONFIG_NLS_CODEPAGE_949=y
>> # CONFIG_NLS_CODEPAGE_874 is not set
>> CONFIG_NLS_ISO8859_8=y
>> # CONFIG_NLS_CODEPAGE_1250 is not set
>> # CONFIG_NLS_CODEPAGE_1251 is not set
>> CONFIG_NLS_ASCII=y
>> CONFIG_NLS_ISO8859_1=y
>> CONFIG_NLS_ISO8859_2=y
>> CONFIG_NLS_ISO8859_3=y
>> CONFIG_NLS_ISO8859_4=y
>> CONFIG_NLS_ISO8859_5=y
>> # CONFIG_NLS_ISO8859_6 is not set
>> CONFIG_NLS_ISO8859_7=y
>> CONFIG_NLS_ISO8859_9=y
>> # CONFIG_NLS_ISO8859_13 is not set
>> CONFIG_NLS_ISO8859_14=y
>> CONFIG_NLS_ISO8859_15=y
>> CONFIG_NLS_KOI8_R=y
>> CONFIG_NLS_KOI8_U=y
>> # CONFIG_NLS_MAC_ROMAN is not set
>> # CONFIG_NLS_MAC_CELTIC is not set
>> # CONFIG_NLS_MAC_CENTEURO is not set
>> CONFIG_NLS_MAC_CROATIAN=y
>> # CONFIG_NLS_MAC_CYRILLIC is not set
>> # CONFIG_NLS_MAC_GAELIC is not set
>> CONFIG_NLS_MAC_GREEK=y
>> # CONFIG_NLS_MAC_ICELAND is not set
>> # CONFIG_NLS_MAC_INUIT is not set
>> # CONFIG_NLS_MAC_ROMANIAN is not set
>> # CONFIG_NLS_MAC_TURKISH is not set
>> CONFIG_NLS_UTF8=y
>> # CONFIG_DLM is not set
>> # CONFIG_UNICODE is not set
>> CONFIG_IO_WQ=y
>> # end of File systems
>>
>> #
>> # Security options
>> #
>> CONFIG_KEYS=y
>> # CONFIG_KEYS_REQUEST_CACHE is not set
>> CONFIG_PERSISTENT_KEYRINGS=y
>> CONFIG_ENCRYPTED_KEYS=y
>> # CONFIG_KEY_DH_OPERATIONS is not set
>> CONFIG_SECURITY_DMESG_RESTRICT=y
>> # CONFIG_SECURITY is not set
>> CONFIG_SECURITYFS=y
>> CONFIG_PAGE_TABLE_ISOLATION=y
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> CONFIG_HARDENED_USERCOPY=y
>> CONFIG_HARDENED_USERCOPY_FALLBACK=y
>> CONFIG_HARDENED_USERCOPY_PAGESPAN=y
>> CONFIG_FORTIFY_SOURCE=y
>> # CONFIG_STATIC_USERMODEHELPER is not set
>> CONFIG_DEFAULT_SECURITY_DAC=y
>> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
>>
>> #
>> # Kernel hardening options
>> #
>>
>> #
>> # Memory initialization
>> #
>> CONFIG_INIT_STACK_NONE=y
>> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
>> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
>> # end of Memory initialization
>> # end of Kernel hardening options
>> # end of Security options
>>
>> CONFIG_CRYPTO=y
>>
>> #
>> # Crypto core or helper
>> #
>> CONFIG_CRYPTO_ALGAPI=y
>> CONFIG_CRYPTO_ALGAPI2=y
>> CONFIG_CRYPTO_AEAD=y
>> CONFIG_CRYPTO_AEAD2=y
>> CONFIG_CRYPTO_SKCIPHER=y
>> CONFIG_CRYPTO_SKCIPHER2=y
>> CONFIG_CRYPTO_HASH=y
>> CONFIG_CRYPTO_HASH2=y
>> CONFIG_CRYPTO_RNG=y
>> CONFIG_CRYPTO_RNG2=y
>> CONFIG_CRYPTO_RNG_DEFAULT=y
>> CONFIG_CRYPTO_AKCIPHER2=y
>> CONFIG_CRYPTO_AKCIPHER=y
>> CONFIG_CRYPTO_KPP2=y
>> CONFIG_CRYPTO_KPP=y
>> CONFIG_CRYPTO_ACOMP2=y
>> CONFIG_CRYPTO_MANAGER=y
>> CONFIG_CRYPTO_MANAGER2=y
>> # CONFIG_CRYPTO_USER is not set
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>> CONFIG_CRYPTO_GF128MUL=y
>> CONFIG_CRYPTO_NULL=y
>> CONFIG_CRYPTO_NULL2=y
>> CONFIG_CRYPTO_PCRYPT=y
>> CONFIG_CRYPTO_CRYPTD=y
>> CONFIG_CRYPTO_AUTHENC=y
>> # CONFIG_CRYPTO_TEST is not set
>> CONFIG_CRYPTO_SIMD=y
>> CONFIG_CRYPTO_GLUE_HELPER_X86=y
>> CONFIG_CRYPTO_ENGINE=y
>>
>> #
>> # Public-key cryptography
>> #
>> CONFIG_CRYPTO_RSA=y
>> CONFIG_CRYPTO_DH=y
>> CONFIG_CRYPTO_ECC=y
>> CONFIG_CRYPTO_ECDH=y
>> # CONFIG_CRYPTO_ECRDSA is not set
>> # CONFIG_CRYPTO_CURVE25519 is not set
>>
>> #
>> # Authenticated Encryption with Associated Data
>> #
>> CONFIG_CRYPTO_CCM=y
>> CONFIG_CRYPTO_GCM=y
>> CONFIG_CRYPTO_CHACHA20POLY1305=y
>> CONFIG_CRYPTO_AEGIS128=y
>> CONFIG_CRYPTO_SEQIV=y
>> CONFIG_CRYPTO_ECHAINIV=y
>>
>> #
>> # Block modes
>> #
>> CONFIG_CRYPTO_CBC=y
>> # CONFIG_CRYPTO_CFB is not set
>> CONFIG_CRYPTO_CTR=y
>> CONFIG_CRYPTO_CTS=y
>> CONFIG_CRYPTO_ECB=y
>> CONFIG_CRYPTO_LRW=y
>> # CONFIG_CRYPTO_OFB is not set
>> CONFIG_CRYPTO_PCBC=y
>> CONFIG_CRYPTO_XTS=y
>> # CONFIG_CRYPTO_KEYWRAP is not set
>> # CONFIG_CRYPTO_ADIANTUM is not set
>> # CONFIG_CRYPTO_ESSIV is not set
>>
>> #
>> # Hash modes
>> #
>> CONFIG_CRYPTO_CMAC=y
>> CONFIG_CRYPTO_HMAC=y
>> CONFIG_CRYPTO_XCBC=y
>> CONFIG_CRYPTO_VMAC=y
>>
>> #
>> # Digest
>> #
>> CONFIG_CRYPTO_CRC32C=y
>> # CONFIG_CRYPTO_CRC32C_INTEL is not set
>> CONFIG_CRYPTO_CRC32=y
>> CONFIG_CRYPTO_CRC32_PCLMUL=y
>> # CONFIG_CRYPTO_XXHASH is not set
>> # CONFIG_CRYPTO_BLAKE2B is not set
>> # CONFIG_CRYPTO_BLAKE2S is not set
>> CONFIG_CRYPTO_CRCT10DIF=y
>> CONFIG_CRYPTO_GHASH=y
>> CONFIG_CRYPTO_POLY1305=y
>> CONFIG_CRYPTO_MD4=y
>> CONFIG_CRYPTO_MD5=y
>> # CONFIG_CRYPTO_MICHAEL_MIC is not set
>> CONFIG_CRYPTO_RMD128=y
>> CONFIG_CRYPTO_RMD160=y
>> # CONFIG_CRYPTO_RMD256 is not set
>> # CONFIG_CRYPTO_RMD320 is not set
>> CONFIG_CRYPTO_SHA1=y
>> CONFIG_CRYPTO_SHA256=y
>> CONFIG_CRYPTO_SHA512=y
>> CONFIG_CRYPTO_SHA3=y
>> # CONFIG_CRYPTO_SM3 is not set
>> # CONFIG_CRYPTO_STREEBOG is not set
>> # CONFIG_CRYPTO_TGR192 is not set
>> CONFIG_CRYPTO_WP512=y
>>
>> #
>> # Ciphers
>> #
>> CONFIG_CRYPTO_AES=y
>> CONFIG_CRYPTO_AES_TI=y
>> CONFIG_CRYPTO_AES_NI_INTEL=y
>> CONFIG_CRYPTO_ANUBIS=y
>> # CONFIG_CRYPTO_ARC4 is not set
>> CONFIG_CRYPTO_BLOWFISH=y
>> CONFIG_CRYPTO_BLOWFISH_COMMON=y
>> CONFIG_CRYPTO_CAMELLIA=y
>> CONFIG_CRYPTO_CAST_COMMON=y
>> CONFIG_CRYPTO_CAST5=y
>> CONFIG_CRYPTO_CAST6=y
>> CONFIG_CRYPTO_DES=y
>> CONFIG_CRYPTO_FCRYPT=y
>> CONFIG_CRYPTO_KHAZAD=y
>> CONFIG_CRYPTO_SALSA20=y
>> CONFIG_CRYPTO_CHACHA20=y
>> # CONFIG_CRYPTO_SEED is not set
>> CONFIG_CRYPTO_SERPENT=y
>> CONFIG_CRYPTO_SERPENT_SSE2_586=y
>> # CONFIG_CRYPTO_SM4 is not set
>> # CONFIG_CRYPTO_TEA is not set
>> CONFIG_CRYPTO_TWOFISH=y
>> CONFIG_CRYPTO_TWOFISH_COMMON=y
>> CONFIG_CRYPTO_TWOFISH_586=y
>>
>> #
>> # Compression
>> #
>> CONFIG_CRYPTO_DEFLATE=y
>> CONFIG_CRYPTO_LZO=y
>> CONFIG_CRYPTO_842=y
>> CONFIG_CRYPTO_LZ4=y
>> CONFIG_CRYPTO_LZ4HC=y
>> CONFIG_CRYPTO_ZSTD=y
>>
>> #
>> # Random Number Generation
>> #
>> CONFIG_CRYPTO_ANSI_CPRNG=y
>> CONFIG_CRYPTO_DRBG_MENU=y
>> CONFIG_CRYPTO_DRBG_HMAC=y
>> # CONFIG_CRYPTO_DRBG_HASH is not set
>> CONFIG_CRYPTO_DRBG_CTR=y
>> CONFIG_CRYPTO_DRBG=y
>> CONFIG_CRYPTO_JITTERENTROPY=y
>> CONFIG_CRYPTO_USER_API=y
>> # CONFIG_CRYPTO_USER_API_HASH is not set
>> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
>> # CONFIG_CRYPTO_USER_API_RNG is not set
>> CONFIG_CRYPTO_USER_API_AEAD=y
>> CONFIG_CRYPTO_HASH_INFO=y
>>
>> #
>> # Crypto library routines
>> #
>> CONFIG_CRYPTO_LIB_AES=y
>> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
>> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
>> # CONFIG_CRYPTO_LIB_CHACHA is not set
>> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
>> CONFIG_CRYPTO_LIB_DES=y
>> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
>> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
>> # CONFIG_CRYPTO_LIB_POLY1305 is not set
>> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
>> CONFIG_CRYPTO_LIB_SHA256=y
>> CONFIG_CRYPTO_HW=y
>> CONFIG_CRYPTO_DEV_PADLOCK=y
>> # CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
>> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
>> CONFIG_CRYPTO_DEV_GEODE=y
>> CONFIG_CRYPTO_DEV_ATMEL_I2C=y
>> CONFIG_CRYPTO_DEV_ATMEL_ECC=y
>> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
>> # CONFIG_CRYPTO_DEV_CCP is not set
>> CONFIG_CRYPTO_DEV_QAT=y
>> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
>> CONFIG_CRYPTO_DEV_QAT_C3XXX=y
>> CONFIG_CRYPTO_DEV_QAT_C62X=y
>> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
>> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
>> CONFIG_CRYPTO_DEV_QAT_C62XVF=y
>> CONFIG_CRYPTO_DEV_VIRTIO=y
>> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
>> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
>> CONFIG_ASYMMETRIC_KEY_TYPE=y
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
>> CONFIG_X509_CERTIFICATE_PARSER=y
>> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
>> CONFIG_PKCS7_MESSAGE_PARSER=y
>> # CONFIG_PKCS7_TEST_KEY is not set
>> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
>>
>> #
>> # Certificates for signature checking
>> #
>> CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> CONFIG_SYSTEM_TRUSTED_KEYS=""
>> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
>> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
>> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
>> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
>> # end of Certificates for signature checking
>>
>> CONFIG_BINARY_PRINTF=y
>>
>> #
>> # Library routines
>> #
>> CONFIG_LINEAR_RANGES=y
>> # CONFIG_PACKING is not set
>> CONFIG_BITREVERSE=y
>> CONFIG_GENERIC_STRNCPY_FROM_USER=y
>> CONFIG_GENERIC_STRNLEN_USER=y
>> CONFIG_GENERIC_NET_UTILS=y
>> CONFIG_GENERIC_FIND_FIRST_BIT=y
>> CONFIG_CORDIC=y
>> CONFIG_PRIME_NUMBERS=y
>> CONFIG_RATIONAL=y
>> CONFIG_GENERIC_PCI_IOMAP=y
>> CONFIG_GENERIC_IOMAP=y
>> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
>> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
>> CONFIG_CRC_CCITT=y
>> CONFIG_CRC16=y
>> CONFIG_CRC_T10DIF=y
>> CONFIG_CRC_ITU_T=y
>> CONFIG_CRC32=y
>> # CONFIG_CRC32_SELFTEST is not set
>> # CONFIG_CRC32_SLICEBY8 is not set
>> CONFIG_CRC32_SLICEBY4=y
>> # CONFIG_CRC32_SARWATE is not set
>> # CONFIG_CRC32_BIT is not set
>> CONFIG_CRC64=y
>> CONFIG_CRC4=y
>> # CONFIG_CRC7 is not set
>> CONFIG_LIBCRC32C=y
>> CONFIG_CRC8=y
>> CONFIG_XXHASH=y
>> CONFIG_AUDIT_GENERIC=y
>> CONFIG_RANDOM32_SELFTEST=y
>> CONFIG_842_COMPRESS=y
>> CONFIG_842_DECOMPRESS=y
>> CONFIG_ZLIB_INFLATE=y
>> CONFIG_ZLIB_DEFLATE=y
>> CONFIG_LZO_COMPRESS=y
>> CONFIG_LZO_DECOMPRESS=y
>> CONFIG_LZ4_COMPRESS=y
>> CONFIG_LZ4HC_COMPRESS=y
>> CONFIG_LZ4_DECOMPRESS=y
>> CONFIG_ZSTD_COMPRESS=y
>> CONFIG_ZSTD_DECOMPRESS=y
>> CONFIG_XZ_DEC=y
>> CONFIG_XZ_DEC_X86=y
>> # CONFIG_XZ_DEC_POWERPC is not set
>> # CONFIG_XZ_DEC_IA64 is not set
>> # CONFIG_XZ_DEC_ARM is not set
>> CONFIG_XZ_DEC_ARMTHUMB=y
>> # CONFIG_XZ_DEC_SPARC is not set
>> CONFIG_XZ_DEC_BCJ=y
>> CONFIG_XZ_DEC_TEST=y
>> CONFIG_DECOMPRESS_GZIP=y
>> CONFIG_DECOMPRESS_LZMA=y
>> CONFIG_DECOMPRESS_XZ=y
>> CONFIG_DECOMPRESS_LZ4=y
>> CONFIG_DECOMPRESS_ZSTD=y
>> CONFIG_GENERIC_ALLOCATOR=y
>> CONFIG_REED_SOLOMON=y
>> CONFIG_REED_SOLOMON_ENC8=y
>> CONFIG_REED_SOLOMON_DEC8=y
>> CONFIG_INTERVAL_TREE=y
>> CONFIG_ASSOCIATIVE_ARRAY=y
>> CONFIG_HAS_IOMEM=y
>> CONFIG_HAS_IOPORT_MAP=y
>> CONFIG_HAS_DMA=y
>> CONFIG_DMA_OPS=y
>> CONFIG_NEED_SG_DMA_LENGTH=y
>> CONFIG_NEED_DMA_MAP_STATE=y
>> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
>> CONFIG_DMA_VIRT_OPS=y
>> CONFIG_SWIOTLB=y
>> # CONFIG_DMA_API_DEBUG is not set
>> CONFIG_SGL_ALLOC=y
>> CONFIG_CPU_RMAP=y
>> CONFIG_DQL=y
>> CONFIG_GLOB=y
>> CONFIG_GLOB_SELFTEST=y
>> CONFIG_NLATTR=y
>> CONFIG_CLZ_TAB=y
>> CONFIG_IRQ_POLL=y
>> CONFIG_MPILIB=y
>> CONFIG_DIMLIB=y
>> CONFIG_OID_REGISTRY=y
>> CONFIG_HAVE_GENERIC_VDSO=y
>> CONFIG_GENERIC_GETTIMEOFDAY=y
>> CONFIG_GENERIC_VDSO_32=y
>> CONFIG_GENERIC_VDSO_TIME_NS=y
>> CONFIG_FONT_SUPPORT=y
>> CONFIG_FONT_8x16=y
>> CONFIG_FONT_AUTOSELECT=y
>> CONFIG_ARCH_STACKWALK=y
>> CONFIG_STACKDEPOT=y
>> CONFIG_STRING_SELFTEST=y
>> # end of Library routines
>>
>> #
>> # Kernel hacking
>> #
>>
>> #
>> # printk and dmesg options
>> #
>> CONFIG_PRINTK_TIME=y
>> # CONFIG_PRINTK_CALLER is not set
>> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
>> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>> # CONFIG_BOOT_PRINTK_DELAY is not set
>> CONFIG_DYNAMIC_DEBUG=y
>> CONFIG_DYNAMIC_DEBUG_CORE=y
>> CONFIG_SYMBOLIC_ERRNAME=y
>> CONFIG_DEBUG_BUGVERBOSE=y
>> # end of printk and dmesg options
>>
>> #
>> # Compile-time checks and compiler options
>> #
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_INFO_REDUCED=y
>> # CONFIG_DEBUG_INFO_COMPRESSED is not set
>> # CONFIG_DEBUG_INFO_SPLIT is not set
>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>> # CONFIG_GDB_SCRIPTS is not set
>> # CONFIG_ENABLE_MUST_CHECK is not set
>> CONFIG_FRAME_WARN=1024
>> CONFIG_STRIP_ASM_SYMS=y
>> CONFIG_READABLE_ASM=y
>> # CONFIG_HEADERS_INSTALL is not set
>> CONFIG_DEBUG_SECTION_MISMATCH=y
>> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
>> CONFIG_FRAME_POINTER=y
>> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>> # end of Compile-time checks and compiler options
>>
>> #
>> # Generic Kernel Debugging Instruments
>> #
>> CONFIG_MAGIC_SYSRQ=y
>> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
>> # CONFIG_MAGIC_SYSRQ_SERIAL is not set
>> CONFIG_DEBUG_FS=y
>> CONFIG_DEBUG_FS_ALLOW_ALL=y
>> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
>> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
>> CONFIG_HAVE_ARCH_KGDB=y
>> # CONFIG_KGDB is not set
>> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
>> # CONFIG_UBSAN is not set
>> # end of Generic Kernel Debugging Instruments
>>
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_DEBUG_MISC=y
>>
>> #
>> # Memory Debugging
>> #
>> CONFIG_PAGE_EXTENSION=y
>> # CONFIG_DEBUG_PAGEALLOC is not set
>> # CONFIG_PAGE_OWNER is not set
>> CONFIG_PAGE_POISONING=y
>> CONFIG_PAGE_POISONING_NO_SANITY=y
>> # CONFIG_PAGE_POISONING_ZERO is not set
>> # CONFIG_DEBUG_PAGE_REF is not set
>> CONFIG_DEBUG_RODATA_TEST=y
>> CONFIG_ARCH_HAS_DEBUG_WX=y
>> # CONFIG_DEBUG_WX is not set
>> CONFIG_GENERIC_PTDUMP=y
>> # CONFIG_PTDUMP_DEBUGFS is not set
>> CONFIG_DEBUG_OBJECTS=y
>> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
>> CONFIG_DEBUG_OBJECTS_FREE=y
>> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
>> CONFIG_DEBUG_OBJECTS_WORK=y
>> # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
>> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
>> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
>> CONFIG_DEBUG_SLAB=y
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
>> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
>> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
>> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
>> CONFIG_DEBUG_STACK_USAGE=y
>> CONFIG_SCHED_STACK_END_CHECK=y
>> CONFIG_DEBUG_VM=y
>> # CONFIG_DEBUG_VM_VMACACHE is not set
>> # CONFIG_DEBUG_VM_RB is not set
>> CONFIG_DEBUG_VM_PGFLAGS=y
>> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>> # CONFIG_DEBUG_VIRTUAL is not set
>> CONFIG_DEBUG_MEMORY_INIT=y
>> # CONFIG_DEBUG_PER_CPU_MAPS is not set
>> # CONFIG_DEBUG_HIGHMEM is not set
>> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
>> # CONFIG_DEBUG_STACKOVERFLOW is not set
>> CONFIG_CC_HAS_KASAN_GENERIC=y
>> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
>> # end of Memory Debugging
>>
>> CONFIG_DEBUG_SHIRQ=y
>>
>> #
>> # Debug Oops, Lockups and Hangs
>> #
>> # CONFIG_PANIC_ON_OOPS is not set
>> CONFIG_PANIC_ON_OOPS_VALUE=0
>> CONFIG_PANIC_TIMEOUT=0
>> CONFIG_LOCKUP_DETECTOR=y
>> CONFIG_SOFTLOCKUP_DETECTOR=y
>> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
>> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
>> CONFIG_HARDLOCKUP_DETECTOR=y
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
>> # CONFIG_DETECT_HUNG_TASK is not set
>> # CONFIG_WQ_WATCHDOG is not set
>> # CONFIG_TEST_LOCKUP is not set
>> # end of Debug Oops, Lockups and Hangs
>>
>> #
>> # Scheduler Debugging
>> #
>> CONFIG_SCHED_DEBUG=y
>> CONFIG_SCHED_INFO=y
>> CONFIG_SCHEDSTATS=y
>> # end of Scheduler Debugging
>>
>> CONFIG_DEBUG_TIMEKEEPING=y
>> CONFIG_DEBUG_PREEMPT=y
>>
>> #
>> # Lock Debugging (spinlocks, mutexes, etc...)
>> #
>> CONFIG_LOCK_DEBUGGING_SUPPORT=y
>> CONFIG_PROVE_LOCKING=y
>> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
>> CONFIG_LOCK_STAT=y
>> CONFIG_DEBUG_RT_MUTEXES=y
>> CONFIG_DEBUG_SPINLOCK=y
>> CONFIG_DEBUG_MUTEXES=y
>> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
>> CONFIG_DEBUG_RWSEMS=y
>> CONFIG_DEBUG_LOCK_ALLOC=y
>> CONFIG_LOCKDEP=y
>> # CONFIG_DEBUG_LOCKDEP is not set
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
>> # CONFIG_LOCK_TORTURE_TEST is not set
>> CONFIG_WW_MUTEX_SELFTEST=y
>> # end of Lock Debugging (spinlocks, mutexes, etc...)
>>
>> CONFIG_TRACE_IRQFLAGS=y
>> CONFIG_TRACE_IRQFLAGS_NMI=y
>> CONFIG_STACKTRACE=y
>> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
>> # CONFIG_DEBUG_KOBJECT is not set
>>
>> #
>> # Debug kernel data structures
>> #
>> # CONFIG_DEBUG_LIST is not set
>> # CONFIG_DEBUG_PLIST is not set
>> # CONFIG_DEBUG_SG is not set
>> CONFIG_DEBUG_NOTIFIERS=y
>> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>> # end of Debug kernel data structures
>>
>> # CONFIG_DEBUG_CREDENTIALS is not set
>>
>> #
>> # RCU Debugging
>> #
>> CONFIG_PROVE_RCU=y
>> CONFIG_TORTURE_TEST=y
>> # CONFIG_RCU_PERF_TEST is not set
>> CONFIG_RCU_TORTURE_TEST=y
>> # CONFIG_RCU_REF_SCALE_TEST is not set
>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>> CONFIG_RCU_TRACE=y
>> # CONFIG_RCU_EQS_DEBUG is not set
>> # end of RCU Debugging
>>
>> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
>> CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
>> # CONFIG_LATENCYTOP is not set
>> CONFIG_USER_STACKTRACE_SUPPORT=y
>> CONFIG_NOP_TRACER=y
>> CONFIG_HAVE_FUNCTION_TRACER=y
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
>> CONFIG_HAVE_DYNAMIC_FTRACE=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>> CONFIG_HAVE_C_RECORDMCOUNT=y
>> CONFIG_TRACE_CLOCK=y
>> CONFIG_RING_BUFFER=y
>> CONFIG_EVENT_TRACING=y
>> CONFIG_CONTEXT_SWITCH_TRACER=y
>> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
>> CONFIG_TRACING=y
>> CONFIG_TRACING_SUPPORT=y
>> # CONFIG_FTRACE is not set
>> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
>> # CONFIG_SAMPLES is not set
>> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>> CONFIG_STRICT_DEVMEM=y
>> # CONFIG_IO_STRICT_DEVMEM is not set
>>
>> #
>> # x86 Debugging
>> #
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
>> CONFIG_EARLY_PRINTK_USB=y
>> CONFIG_X86_VERBOSE_BOOTUP=y
>> CONFIG_EARLY_PRINTK=y
>> CONFIG_EARLY_PRINTK_DBGP=y
>> CONFIG_EARLY_PRINTK_USB_XDBC=y
>> CONFIG_DEBUG_TLBFLUSH=y
>> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
>> # CONFIG_X86_DECODER_SELFTEST is not set
>> # CONFIG_IO_DELAY_0X80 is not set
>> # CONFIG_IO_DELAY_0XED is not set
>> # CONFIG_IO_DELAY_UDELAY is not set
>> CONFIG_IO_DELAY_NONE=y
>> # CONFIG_DEBUG_BOOT_PARAMS is not set
>> # CONFIG_CPA_DEBUG is not set
>> # CONFIG_DEBUG_ENTRY is not set
>> # CONFIG_DEBUG_NMI_SELFTEST is not set
>> # CONFIG_X86_DEBUG_FPU is not set
>> CONFIG_PUNIT_ATOM_DEBUG=y
>> CONFIG_UNWINDER_FRAME_POINTER=y
>> # end of x86 Debugging
>>
>> #
>> # Kernel Testing and Coverage
>> #
>> # CONFIG_KUNIT is not set
>> CONFIG_NOTIFIER_ERROR_INJECTION=y
>> # CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
>> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
>> CONFIG_FAULT_INJECTION=y
>> CONFIG_FAILSLAB=y
>> # CONFIG_FAIL_PAGE_ALLOC is not set
>> # CONFIG_FAIL_FUTEX is not set
>> CONFIG_FAULT_INJECTION_DEBUG_FS=y
>> CONFIG_FAIL_MMC_REQUEST=y
>> CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
>> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
>> # CONFIG_RUNTIME_TESTING_MENU is not set
>> # CONFIG_MEMTEST is not set
>> # end of Kernel Testing and Coverage
>> # end of Kernel hacking
>> #!/bin/sh
>>
>> export_top_env()
>> {
>> 	export suite='boot'
>> 	export testcase='boot'
>> 	export category='functional'
>> 	export timeout='10m'
>> 	export job_origin='/lkp-src/allot/rand/vm-snb-i386/boot.yaml'
>> 	export queue_cmdline_keys='branch
>> commit'
>> 	export queue='bisect'
>> 	export testbox='vm-snb-i386-31'
>> 	export tbox_group='vm-snb-i386'
>> 	export branch='linux-review/Zbigniew-Kempczy-ski/drm-i915-Ensure-bo-is-dirty-when-WB-mapped-on-llc-in-pagefault-handler/20200921-115158'
>> 	export commit='6509ca051abf4ff60d63732badcb2173a715f741'
>> 	export kconfig='i386-randconfig-a013-20200921'
>> 	export nr_vm=64
>> 	export submit_id='5f6c58ff32288633e09c3931'
>> 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-31/boot-1-debian-i386-20191205.cgz-6509ca051abf4ff60d63732badcb2173a715f741-20200924-13280-pv2sje-1.yaml'
>> 	export id='56cd19c98425b8f719f3991105ad05e607875dbe'
>> 	export queuer_version='/lkp-src'
>> 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
>> 	export nr_cpu=2
>> 	export memory='8G'
>> 	export need_kconfig='CONFIG_KVM_GUEST=y'
>> 	export ssh_base_port=23032
>> 	export rootfs='debian-i386-20191205.cgz'
>> 	export compiler='gcc-9'
>> 	export enqueue_time='2020-09-24 16:29:52 +0800'
>> 	export _id='5f6c60fe32288633e09c3932'
>> 	export _rt='/result/boot/1/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a013-20200921/gcc-9/6509ca051abf4ff60d63732badcb2173a715f741'
>> 	export user='lkp'
>> 	export result_root='/result/boot/1/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a013-20200921/gcc-9/6509ca051abf4ff60d63732badcb2173a715f741/3'
>> 	export scheduler_version='/lkp/lkp/.src-20200923-125233'
>> 	export LKP_SERVER='inn'
>> 	export arch='i386'
>> 	export max_uptime=600
>> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
>> 	export bootloader_append='root=/dev/ram0
>> user=lkp
>> job=/lkp/jobs/scheduled/vm-snb-i386-31/boot-1-debian-i386-20191205.cgz-6509ca051abf4ff60d63732badcb2173a715f741-20200924-13280-pv2sje-1.yaml
>> ARCH=i386
>> kconfig=i386-randconfig-a013-20200921
>> branch=linux-review/Zbigniew-Kempczy-ski/drm-i915-Ensure-bo-is-dirty-when-WB-mapped-on-llc-in-pagefault-handler/20200921-115158
>> commit=6509ca051abf4ff60d63732badcb2173a715f741
>> BOOT_IMAGE=/pkg/linux/i386-randconfig-a013-20200921/gcc-9/6509ca051abf4ff60d63732badcb2173a715f741/vmlinuz-5.9.0-rc4-00881-g6509ca051abf4
>> max_uptime=600
>> RESULT_ROOT=/result/boot/1/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a013-20200921/gcc-9/6509ca051abf4ff60d63732badcb2173a715f741/3
>> LKP_SERVER=inn
>> selinux=0
>> debug
>> apic=debug
>> sysrq_always_enabled
>> rcupdate.rcu_cpu_stall_timeout=100
>> net.ifnames=0
>> printk.devkmsg=on
>> panic=-1
>> softlockup_panic=1
>> nmi_watchdog=panic
>> oops=panic
>> load_ramdisk=2
>> prompt_ramdisk=0
>> drbd.minor_count=8
>> systemd.log_level=err
>> ignore_loglevel
>> console=tty0
>> earlyprintk=ttyS0,115200
>> console=ttyS0,115200
>> vga=normal
>> rw'
>> 	export modules_initrd='/pkg/linux/i386-randconfig-a013-20200921/gcc-9/6509ca051abf4ff60d63732badcb2173a715f741/modules.cgz'
>> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
>> 	export site='inn'
>> 	export LKP_CGI_PORT=80
>> 	export LKP_CIFS_PORT=139
>> 	export schedule_notify_address=
>> 	export kernel='/pkg/linux/i386-randconfig-a013-20200921/gcc-9/6509ca051abf4ff60d63732badcb2173a715f741/vmlinuz-5.9.0-rc4-00881-g6509ca051abf4'
>> 	export dequeue_time='2020-09-24 17:32:00 +0800'
>> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-31/boot-1-debian-i386-20191205.cgz-6509ca051abf4ff60d63732badcb2173a715f741-20200924-13280-pv2sje-1.cgz'
>>
>> 	[ -n "$LKP_SRC" ] ||
>> 	export LKP_SRC=/lkp/${user:-lkp}/src
>> }
>>
>> run_job()
>> {
>> 	echo $$ > $TMP/run-job.pid
>>
>> 	. $LKP_SRC/lib/http.sh
>> 	. $LKP_SRC/lib/job.sh
>> 	. $LKP_SRC/lib/env.sh
>>
>> 	export_top_env
>>
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
>> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
>> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
>> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
>> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
>> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
>> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
>> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>>
>> 	run_test $LKP_SRC/tests/wrapper sleep 1
>> }
>>
>> extract_stats()
>> {
>> 	export stats_part_begin=
>> 	export stats_part_end=
>>
>> 	$LKP_SRC/stats/wrapper boot-slabinfo
>> 	$LKP_SRC/stats/wrapper boot-meminfo
>> 	$LKP_SRC/stats/wrapper memmap
>> 	$LKP_SRC/stats/wrapper boot-memory
>> 	$LKP_SRC/stats/wrapper boot-time
>> 	$LKP_SRC/stats/wrapper kernel-size
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper sleep
>> 	$LKP_SRC/stats/wrapper meminfo
>>
>> 	$LKP_SRC/stats/wrapper time sleep.time
>> 	$LKP_SRC/stats/wrapper dmesg
>> 	$LKP_SRC/stats/wrapper kmsg
>> 	$LKP_SRC/stats/wrapper last_state
>> 	$LKP_SRC/stats/wrapper stderr
>> 	$LKP_SRC/stats/wrapper time
>> }
>>
>> "$@"
>
>

