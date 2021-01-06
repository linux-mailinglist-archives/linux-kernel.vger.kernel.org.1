Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1BF2EBFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbhAFOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbhAFOpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDD832311D;
        Wed,  6 Jan 2021 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609944300;
        bh=nEGRWE5CXTsEJZBeYOlq7Qd9Zd9yOdW0iA2LtVHGf3o=;
        h=From:To:Cc:Subject:Date:From;
        b=bdg5qsjCAeriTT7LD/1PJlDAUcFvMcAZRjR5N+qazU4zuzHoh2VBP/8UGLXUEGTz9
         D/lY+qFesC9j6IJt8YH+klUZp3D9jSYEEmLif7b91VSow/FrxnOnXKLRwrIaiPwwvO
         Dr2eHV9ejPI5q92uqzN73zqjvlHK0wJlm2rSDZ/i9g+mAXFPGxUjuvn32TIi+zYFoa
         wLbO2xFmld0MP4LgcsC3NixVW75zxAH82dyUs3f6uyI90OGMRiUjp+NNRmoojhHCUW
         oZXvtajwYp2auI3obRfIUtCCU8YGD3dhKNY7+LJgpibyYZyRuhXJRkDMJ2e7iNzJel
         7enxAgMm6o8uA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahiroy@kernel.org, keescook@chromium.org
Subject: commit ("1e860048c53ee gcc-plugins: simplify GCC plugin-dev
 capability test")
Message-ID: <2368d10b-85df-728f-675a-7a082ed0f54c@kernel.org>
Date:   Wed, 6 Jan 2021 08:44:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

With v5.11-rc1 and commit("1e860048c53ee gcc-plugins: simplify GCC 
plugin-dev capability test"), I get this error for my arm 
socfpga_defconfig build. I have been building the kernel the same way 
for many years now. Do you know what I might be doing wrong?

$ make ARCH=arm CROSS_COMPILE=${CROSS_COMPILE}
   SYNC    include/config/auto.conf.cmd
   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
   REMOVE  arch/arm/include/generated/asm/mm-arch-hooks.h
   HOSTCXX scripts/gcc-plugins/arm_ssp_per_task_plugin.so
In file included from scripts/gcc-plugins/gcc-common.h:103:0,
                  from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:
/home/dinguyen/linux_dev/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf/bin/../lib/gcc/arm-none-linux-gnueabihf/10.2.1/plugin/include/builtins.h:23:10: 
fatal error: mpc.h: No such file or directory
#include <mpc.h>
           ^~~~~~~
compilation terminated.
scripts/gcc-plugins/Makefile:47: recipe for target 
'scripts/gcc-plugins/arm_ssp_per_task_plugin.so' failed
make[2]: *** [scripts/gcc-plugins/arm_ssp_per_task_plugin.so] Error 1
scripts/Makefile.build:496: recipe for target 'scripts/gcc-plugins' failed
make[1]: *** [scripts/gcc-plugins] Error 2
Makefile:1190: recipe for target 'scripts' failed
make: *** [scripts] Error 2
make: *** Waiting for unfinished jobs....
   UPD     include/config/kernel.release

Thanks,
Dinh
