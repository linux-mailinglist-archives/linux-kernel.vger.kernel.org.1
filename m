Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5512D6E47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404781AbgLKC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403828AbgLKC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:58:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836CC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tTMoTYFvrj5Vu+/cFiYSMv6fZMY38KfILqZTxKmnJP8=; b=GECPXxATnjmbOsG4W0j5X2yZZ4
        +Yo8jyLhXpbh4Rd0N41Nj8GYxI0E1kWgxUQ1vQYAr2YXO8teg1MBJUe4bpabYXcqpwPuXfZuijsZv
        SkKzQOxbPD3a+m4nruO53+ATwso9lEx1ZBnALfMrEY/KuZStbVXYKWFY3NYSLyACTZHgbSHVkrWc/
        lERORZ72uGUPjD2rGQBgQaMcNear3uxqigQGlhdv9+XFQ/gjk2ojAeFKs5IsLlIHIQ2g2VpIKAHm0
        QvsZe6kzG54fNlqopJtmXhOwq2xCaHa9py8ITOx3yM1dmzYQUTNUheAQgjqRkV9reYeeL+pGfw550
        rVhScw+A==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knYdC-0006th-Pb; Fri, 11 Dec 2020 02:58:07 +0000
Subject: Re: undefined reference to `cpu_sa110_suspend_size'
To:     kernel test robot <lkp@intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <202012071244.gmhxfkIp-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e33b214-2416-3030-0308-5987388392eb@infradead.org>
Date:   Thu, 10 Dec 2020 18:58:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202012071244.gmhxfkIp-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/20 8:46 PM, kernel test robot wrote:
> Hi Stephan,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0477e92881850d44910a7e94fc2c46f96faa131f
> commit: a871be6b8eee13a35a3e8e56c62770ef17ee9220 cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver
> date:   7 months ago
> config: arm-randconfig-r005-20201207 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a871be6b8eee13a35a3e8e56c62770ef17ee9220
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a871be6b8eee13a35a3e8e56c62770ef17ee9220
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>>> (.text+0x60): undefined reference to `cpu_sa110_suspend_size'
>    arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>>> suspend.c:(.text+0x140): undefined reference to `cpu_sa110_do_suspend'
>>> arm-linux-gnueabi-ld: suspend.c:(.text+0x168): undefined reference to `cpu_sa110_do_resume'
>    arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
>    qcom_scm-smc.c:(.text+0x5c): undefined reference to `__arm_smccc_smc'
>    arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
>    qcom_scm-legacy.c:(.text+0x1a4): undefined reference to `__arm_smccc_smc'
>    arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
>    qcom_scm-legacy.c:(.text+0x454): undefined reference to `__arm_smccc_smc'
> 
> ---


Missing Kconfig warning:

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64


Patch has been sent for this kconfig warning & build errors.

-- 
~Randy

