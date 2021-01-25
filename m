Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89F302D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbhAYVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:12:34 -0500
Received: from simcoe208srvr.owm.bell.net ([184.150.200.208]:56390 "EHLO
        torfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732061AbhAYVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:09:43 -0500
Received: from bell.net torfep01 184.150.200.158 by torfep01.bell.net
          with ESMTP
          id <20210125210838.GAGQ6892.torfep01.bell.net@torspm01.bell.net>;
          Mon, 25 Jan 2021 16:08:38 -0500
Received: from [192.168.2.49] (really [70.50.109.22]) by torspm01.bell.net
          with ESMTP
          id <20210125210838.SILO29322.torspm01.bell.net@[192.168.2.49]>;
          Mon, 25 Jan 2021 16:08:38 -0500
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
To:     Helge Deller <deller@gmx.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
 <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
 <20210125204720.GA28462@ls3530.fritz.box>
 <4bdf35de-f804-4e9d-cde9-cc6785840a60@gmx.de>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <627d4b69-79cf-371b-9aa7-d87f26e4f088@bell.net>
Date:   Mon, 25 Jan 2021 16:08:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <4bdf35de-f804-4e9d-cde9-cc6785840a60@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-Analysis: v=2.4 cv=ctpeL30i c=1 sm=1 tr=0 ts=600f3356 a=S6gQgrXzeH76ECG4GouVuA==:117 a=S6gQgrXzeH76ECG4GouVuA==:17 a=IkcTkHD0fZMA:10 a=EmqxpYm9HcoA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=i-5SCMXTAAAA:20 a=nRxgo2pvAAAA:8 a=FBHGMhGWAAAA:8 a=LudcmL_S42iirT4DLs4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=hyOiLu3se5BDDO0nYPa2:22 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4xfBm+iWn1x0N/bu8YqxDfecrW/1DprFkEWxGFHQvGGB+eXnb08frWbCa9QNOag0GldZc6Ljm4gL90Y8+oPDNd+jElpfYyrUg9M6XkHPqYWhdaiQqX5Ht3 +Eto+1v25/NtPLhb8uJ7LTlnRPAq4DJUSLxeiA2kSb+2YNtkZHZFQUFKZ0MNM1k9jrHw/LMuVJRWzi77zhjgYkFJveYZ0VTRoo8k/j2E7kSkhSb5wLCS6bVE Ql4f04TWq4+V7eR8C8dVMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would suggest the following for this hunk:

+    ldil    L%intr_restore, %r2
+    BL    preempt_schedule_irq
+    ldo     R%intr_restore(%r2), %r2

    ldil    L%intr_restore, %r1
    b,l    preempt_schedule_irq,%r2
    ldo     R%intr_restore(%r1), %r2

On PA 2.0 hardware that gives a 22-bit call.

Dave

On 2021-01-25 3:59 p.m., Helge Deller wrote:
> On 1/25/21 9:47 PM, Helge Deller wrote:
>>>>> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wrote:
>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
>>>>>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add PGO and AutoFDO input sections
>>>>>> date:   5 months ago
>>>>>> config: parisc-randconfig-r032-20210116 (attached as .config)
>>>>>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>>>>>> reproduce (this is a W=1 build):
>>>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>         chmod +x ~/bin/make.cross
>>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>>         git fetch --no-tags linus master
>>>>>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>>>         # save the attached .config to linux build tree
>>>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>>>>>>
>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All errors (new ones prefixed by >>):
>>>>>>
>>>>>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach unknown
>>>>>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn_printk
>>>>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach printk
>> ....
>>
>> The problem with this .config is, that both CONFIG_MODULES and
>> CONFIG_MLONGCALLS are set to "n".
>> The Kconfig autodetection needs fixing to enable CONFIG_MLONGCALLS in
>> this case.
>>
>>
>> This patch fixes it for me:
>>
>> [PATCH] Require -mlong-calls gcc option for !CONFIG_MODULES
>>
>> When building a kernel without module support, the CONFIG_MLONGCALL
>> option needs to be enabled. This patch fixes the autodetection in the
>> Kconfig script and uses a far call to preempt_schedule_irq() in
>> intr_do_preempt().
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reported-by: kernel test robot <lkp@intel.com>
> There's a small bug in the code below:
> 	BL	preempt_schedule_irq
> needs to be
> 	BL	preempt_schedule_irq, %r0
>
> I'll do some more testing and will push the final version
> through the parisc tree.
>
> Helge
>
>
>> ---
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 78b17621ee4a..278462186ac4 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -202,9 +202,8 @@ config PREFETCH
>>  	depends on PA8X00 || PA7200
>>
>>  config MLONGCALLS
>> -	bool "Enable the -mlong-calls compiler option for big kernels"
>> -	default y if !MODULES || UBSAN || FTRACE
>> -	default n
>> +	def_bool y if !MODULES || UBSAN || FTRACE
>> +	bool "Enable the -mlong-calls compiler option for big kernels" if MODULES && !UBSAN && !FTRACE
>>  	depends on PA8X00
>>  	help
>>  	  If you configure the kernel to include many drivers built-in instead
>> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
>> index beba9816cc6c..6320f6a8397c 100644
>> --- a/arch/parisc/kernel/entry.S
>> +++ b/arch/parisc/kernel/entry.S
>> @@ -997,10 +997,19 @@ intr_do_preempt:
>>  	bb,<,n	%r20, 31 - PSW_SM_I, intr_restore
>>  	nop
>>
>> -	BL	preempt_schedule_irq, %r2
>> -	nop
>> +	/* ssm PSW_SM_I done later in intr_restore */
>> +#ifdef CONFIG_MLONGCALLS
>> +	ldil    L%intr_restore, %r2
>> +	load32	preempt_schedule_irq, %r1
>> +	bv	%r0(%r1)
>> +	ldo     R%intr_restore(%r2), %r2
>> +#else
>> +	ldil    L%intr_restore, %r2
>> +	BL	preempt_schedule_irq
>> +	ldo     R%intr_restore(%r2), %r2
>> +#endif
>> +
>>
>> -	b,n	intr_restore		/* ssm PSW_SM_I done by intr_restore */
>>  #endif /* CONFIG_PREEMPTION */
>>
>>  	/*
>>
>>


-- 
John David Anglin  dave.anglin@bell.net

