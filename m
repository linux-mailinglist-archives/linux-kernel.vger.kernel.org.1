Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5223A2E2121
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgLWUH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgLWUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:07:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80800C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/XGhmNEZTpPJCX62t02DiBjSjy1hIi2rcp47hYiKmMo=; b=J5/xKlcVg07JYbXnHEqIivqaFS
        KlFdFMEO2PGh9lomH23hEbSTRK4re7NKja3ndEDkwIULyuNaToTLoaHl7Wwdx9SlqRduRtDt3xgFv
        12KipUR/pBR+jmybW0kmBLpqSWgDYCZOzRSynNjpYiZuZWInkcdhu/RP1a9si4TYJXdNykwc+nXYp
        GUMKZky+GBFGKZJdXoIaHc61A5pfuSgIrMwZJ09GgvsQiwgnY+vSmHJ+ZJ2RdjmTeSeGZUr95TPJ6
        1poMzh9OY+mtlf1sF29+yx53ywniheU/IdaZuYjZRXqfLfNT8mPtoJ18u9X8uZ1Ir8OF/dReLzppR
        DdKcJh4w==;
Received: from [2601:1c0:6280:3f0::3758]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksAPE-0008Lb-KQ; Wed, 23 Dec 2020 20:06:44 +0000
Subject: Re: update.c:undefined reference to `irq_work_queue'
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202012221118.j0EcAlVl-lkp@intel.com>
 <20201222050305.GA2657@paulmck-ThinkPad-P72>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02b0dfb2-b3bd-be13-515c-515b49a32fe8@infradead.org>
Date:   Wed, 23 Dec 2020 12:06:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222050305.GA2657@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/20 9:03 PM, Paul E. McKenney wrote:
> On Tue, Dec 22, 2020 at 11:24:22AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   8653b778e454a7708847aeafe689bce07aeeb94e
>> commit: b38f57c1fe64276773b124dffb0a139cc32ab3cb rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
>> date:   8 months ago
>> config: h8300-randconfig-s032-20201220 (attached as .config)
>> compiler: h8300-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-184-g1b896707-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b38f57c1fe64276773b124dffb0a139cc32ab3cb
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout b38f57c1fe64276773b124dffb0a139cc32ab3cb
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     h8300-linux-ld: section .init.text LMA [000000000043a160,0000000000452569] overlaps section .rodata LMA [00000000003ff420,000000000047df2f]
>>     h8300-linux-ld: section .data VMA [0000000000400000,000000000043a15f] overlaps section .rodata VMA [00000000003ff420,000000000047df2f]
>>     h8300-linux-ld: section __ksymtab VMA [000000000047df30,000000000048611f] overlaps section .bss VMA [000000000045ebd0,000000000056a053]
>>     h8300-linux-ld: kernel/rcu/update.o: in function `rcu_read_unlock_trace_special':
>>>> update.c:(.text+0x8f9): undefined reference to `irq_work_queue'
> 
> Does the patch below help?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit cb7220ed05190c9a92df95b52a21525a7e08a449
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Dec 21 21:00:18 2020 -0800
> 
>      rcu: Make TASKS_TRACE_RCU select IRQ_WORK
>      
>      Tasks Trace RCU uses irq_work_queue() to safely awaken its grace-period
>      kthread, so this commit therefore causes the TASKS_TRACE_RCU Kconfig
>      option select the IRQ_WORK Kconfig option.
>      
>      Reported-by: kernel test robot <lkp@intel.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index aa8cc8c9..3128b7c 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -95,6 +95,7 @@ config TASKS_RUDE_RCU
>   
>   config TASKS_TRACE_RCU
>   	def_bool 0
> +	select IRQ_WORK
>   	help
>   	  This option enables a task-based RCU implementation that uses
>   	  explicit rcu_read_lock_trace() read-side markers, and allows
> 

WorksForMe. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
