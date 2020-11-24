Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6512C1A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgKXAcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgKXAcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:32:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43626C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LeFNbS+U0ry78QgIejul09O6davSuL+ewgu2VdkERio=; b=Ub4rO6sGFZAO/n1ZPprfKJ9ZHW
        DRjzRbW8qK3zAVRaKHPCQiX3rqh9WChwkl0idIc5TG8Deiyben4PUxsrX75NxfEdrryu9Nap6+02b
        gi9fQMzJMZ7hWrWEQIrLQPGHX3NOsTDeB4Dr5FFjoJUTiYVSGqkVV2C+qJ8PjOwk3mmT5xfdUfKm2
        c/hdQq8lg4lVpTt2BTzKe0kxVBoFQaUsUtD45d79ZMcqx7d/V/+XLBfp5LoQP6cS+3Jd2ZEmhEWu6
        2LLoa3mTT4mQYjsoz5T5mcd6sxCoC1JWv7jJBHeQkipnDah0Bx5P+eKyn8EoDdn83hKF5ddGu1qK7
        UkxlomhQ==;
Received: from [2601:1c0:6280:3f0::953c] (helo=dragon.site)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khMFl-0005Bg-Aq; Tue, 24 Nov 2020 00:32:17 +0000
Subject: Re: undefined reference to `cpu_sa110_suspend_size'
To:     kernel test robot <lkp@intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <202011111904.I8YosVeI-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a255759-3fa5-5aca-e04f-7fa2516afdf0@infradead.org>
Date:   Mon, 23 Nov 2020 16:32:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202011111904.I8YosVeI-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 3:57 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   eccc876724927ff3b9ff91f36f7b6b159e948f0c
> commit: a871be6b8eee13a35a3e8e56c62770ef17ee9220 cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver
> date:   6 months ago
> config: arm-randconfig-c004-20201111 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a871be6b8eee13a35a3e8e56c62770ef17ee9220
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout a871be6b8eee13a35a3e8e56c62770ef17ee9220
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>>> (.text+0x60): undefined reference to `cpu_sa110_suspend_size'
>     arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>>> suspend.c:(.text+0x138): undefined reference to `cpu_sa110_do_suspend'
>>> arm-linux-gnueabi-ld: suspend.c:(.text+0x170): undefined reference to `cpu_sa110_do_resume'
>     arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
>     qcom_scm-smc.c:(.text+0x54): undefined reference to `__arm_smccc_smc'
>     arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
>     qcom_scm-legacy.c:(.text+0x1e8): undefined reference to `__arm_smccc_smc'
>     arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
>     qcom_scm-legacy.c:(.text+0x378): undefined reference to `__arm_smccc_smc'
> 
> ---


Build issues likely caused by this (missing info):

WARNING: unmet direct dependencies detected for QCOM_SCM
   Depends on [n]: ARM [=y] && HAVE_ARM_SMCCC [=n] || ARM64
   Selected by [y]:
   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || 
COMPILE_TEST [=y]) && !ARM64

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
   Selected by [y]:
   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || 
COMPILE_TEST [=y]) && !ARM64


---
~Randy
