Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97082E735D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 21:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgL2UQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 15:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgL2UQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 15:16:14 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D50C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:15:34 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id o11so12900590ote.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ljLGN++nr9P9/bQ/nEsRNU9kLfyULM9FGdJ8j8vmjz4=;
        b=nyOQgQgtyM/NmkH1slyWIpS1mI1dss6DdNq28TcVD3M7gPRaN93rOkiO3omRB992Ez
         gXhHZ3pgZ9J4bs2u9LJ+JSuWzmeh3b9Zc1LdsZt3/+5+RHLQ0A8OCInG8rUQ/yYFeh16
         llsulkGWEa2AzLeVquE8VSa6wAqq6xvegC9bVyh8C0DdgZmfzzB6YVQEIPmVL4gXnGLg
         wgahq0Ib0mXmnzSFTNUVh15DCcgygACP/SAz6Jd/i2jw2DjSOpPMcdp6fysDLDrJ7nBR
         en4QvgMx8AqEIVmwEbyNcl8ROlZ2jcpuFInwORUFSjMkn5jgzuWYfP/PyQbhIECLoiMS
         FRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljLGN++nr9P9/bQ/nEsRNU9kLfyULM9FGdJ8j8vmjz4=;
        b=N5IcmISsB5d1+20je9BMSeSmOKSAh/bkXwncyi9Aoz/KEoCV0S1I1rEzaROlgYy+8X
         oucjRcjt2foptTVvdB45EsyxSHDf9xiJkToPSsvXY9VqApqLj5Xrsjhm5YdXeAmap2j8
         UHahc2B5xAPdVD4ihLH2jvVcqs5allLkbKp8tYwy/m7DbCVpLUr5EHWIwGqIZWJwKQqt
         XNaOO2yWB84K5fL6px+1gn6NWmPATP82JxaEnJvxRGmzY7Z/lpxIYB6192KlPVD6Aru7
         TbMHF8W1U3ewYRwxRCzgUjmJo9SvoHXW7C07DN0Zs10vmoXMFsAZsyrECSWe2oRMhm4w
         fw5w==
X-Gm-Message-State: AOAM530WPVDGtn+6PxivbQSS6i9ajR8yJgKIKv4lMTVEbmfOLP+ogqqx
        9/5lCa4dUzS4MFGwewAeiReRvw==
X-Google-Smtp-Source: ABdhPJwwf5g2IRHJdyVgYBWU+m4p9dkM1+VgwSurV65XB/sbHSiNS6DfmuKG8dLyZcFQsopeKk/pJg==
X-Received: by 2002:a9d:6185:: with SMTP id g5mr36614241otk.273.1609272933921;
        Tue, 29 Dec 2020 12:15:33 -0800 (PST)
Received: from [192.168.17.50] (CableLink-189-219-75-19.Hosts.InterCable.net. [189.219.75.19])
        by smtp.gmail.com with ESMTPSA id e12sm10137695otp.25.2020.12.29.12.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 12:15:33 -0800 (PST)
Subject: Re: [PATCH 5.10 000/716] 5.10.4-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
References: <20201229103832.108495696@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <923e3123-7247-f8e5-8bbb-67f5e43c3b7d@linaro.org>
Date:   Tue, 29 Dec 2020 14:15:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229103832.108495696@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/29/20 4:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.4 release.
> There are 716 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 31 Dec 2020 10:36:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions detected.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 5.10.4-rc2
git repo: ['https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git', 'https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc']
git branch: linux-5.10.y
git commit: 5069132d06b7c5d706b4ef9147aba5f6de422a9b
git describe: v5.10.3-717-g5069132d06b7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.3-717-g5069132d06b7

No regressions (compared to build v5.10.3)

No fixes (compared to build v5.10.3)

Ran 53358 total tests in the following environments and test suites.

Environments
--------------
- arc
- arm
- arm64
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- mips
- parisc
- powerpc
- qemu-arm-clang
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-i386-clang
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu-x86_64-kcsan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- riscv
- s390
- sh
- sparc
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* fwts
* install-android-platform-tools-r2600
* kselftest
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kunit
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fs-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance


Happy new year, greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
