Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730C32ED2F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbhAGOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbhAGOp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:45:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C7F22EBF;
        Thu,  7 Jan 2021 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610030716;
        bh=UrtBwbNl3KTMjPS4ZKLHYs5cieuGklbJG0esIcMtj/A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gKGCzO2yzY1oBGXUCa9auRg5eZG9VEgOwM9rc4Q+hW2TK0xY8u3D5jlYZlaPihq3O
         yYtVz3PrgclFoYVNW3tEmECD1QSKhmK10lStaE3cNB8e4OD2PjsGvVwBXo719Hm5QU
         gwq1hoHWxRjTRh+DjIZDVkZJZAs5a0cEyvfsl306MqvAMKa2/EWaaAObZ9a17kM3oR
         u4kBP/AjoKXIAm81hW1RbEHqK06X3C0Ef2dFWg4wVNnJyGMjKeotC5Xq3/QKK9ZBNx
         vfnoSXDydWQeFZiiVW97+kuNT63u54YOX+5K2ywRVQ4BKE5bFRc72d0pDDHJN/tO9a
         8xJFxBDPK4jVQ==
Subject: Re: commit ("1e860048c53ee gcc-plugins: simplify GCC plugin-dev
 capability test")
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <2368d10b-85df-728f-675a-7a082ed0f54c@kernel.org>
 <202101061512.E0F3D28@keescook>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <25ae82e1-e864-807f-9ca5-f6571ef3a12b@kernel.org>
Date:   Thu, 7 Jan 2021 08:45:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202101061512.E0F3D28@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/21 5:14 PM, Kees Cook wrote:
> On Wed, Jan 06, 2021 at 08:44:58AM -0600, Dinh Nguyen wrote:
>> Hi Masahiro,
>>
>> With v5.11-rc1 and commit("1e860048c53ee gcc-plugins: simplify GCC
>> plugin-dev capability test"), I get this error for my arm socfpga_defconfig
>> build. I have been building the kernel the same way for many years now. Do
>> you know what I might be doing wrong?
>>
>> $ make ARCH=arm CROSS_COMPILE=${CROSS_COMPILE}
>>    SYNC    include/config/auto.conf.cmd
>>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
>>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
>>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
>>    REMOVE  arch/arm/include/generated/asm/mm-arch-hooks.h
>>    HOSTCXX scripts/gcc-plugins/arm_ssp_per_task_plugin.so
>> In file included from scripts/gcc-plugins/gcc-common.h:103:0,
>>                   from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:
>> /home/dinguyen/linux_dev/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf/bin/../lib/gcc/arm-none-linux-gnueabihf/10.2.1/plugin/include/builtins.h:23:10:
>> fatal error: mpc.h: No such file or directory
>> #include <mpc.h>
>>            ^~~~~~~
>> compilation terminated.
>> scripts/gcc-plugins/Makefile:47: recipe for target
>> 'scripts/gcc-plugins/arm_ssp_per_task_plugin.so' failed
>> make[2]: *** [scripts/gcc-plugins/arm_ssp_per_task_plugin.so] Error 1
>> scripts/Makefile.build:496: recipe for target 'scripts/gcc-plugins' failed
>> make[1]: *** [scripts/gcc-plugins] Error 2
>> Makefile:1190: recipe for target 'scripts' failed
>> make: *** [scripts] Error 2
>> make: *** Waiting for unfinished jobs....
>>    UPD     include/config/kernel.release
>>
>> Thanks,
>> Dinh
> 
> Hi! Thanks for the report. Other folks have also encountered this,
> and it appears to be a problem with distro packaging of the gcc plugin
> development packages. You'll need to install the GNU multiprecision
> libraries ("gmp-devel" on most rpm-based systems, "libgmp-dev" on most
> debian systems)[1].
> 
> Hopefully that'll work!
> 

Thanks, that worked! I also had to install libmpc-dev as well.

Dinh
