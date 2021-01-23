Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB4301373
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 06:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbhAWF6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 00:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAWF6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 00:58:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FCC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 21:58:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so10744246ejz.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1DRHwewnrHRhl2lTMgBYeG2ca3eHenJpXDrlJ4uCygE=;
        b=ajxyEalxfr67m7gO/vv1gh8bsVk5fDqZohI8cFqpSD54xQ5coLDgigZ+vMla4mdV39
         sh81EDmtWCnoaOjnzk4XAGfNcgeW8sr0q+J58RGiwtQmVD+qeFXYgAzLPaa83t2JYO03
         qEhMJTSpZ15gOQIi+eGG5yzHVThODbyAx7NbmLMcvCAILt2aAD6w0NzN6SOy9YfhLq7z
         8uB7j2/feMDrIFdRZAleVyZm5ZrwjRcSOtjPQ265dCjIm9Isms4Umkf/7OLWxTvrS3eU
         n3LVw3g46AAQqUGH2s7+gjXpWaFqidD5MFC6W9C5VNZECFjonTEa0SEMfhotPW5ln2Fh
         HfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1DRHwewnrHRhl2lTMgBYeG2ca3eHenJpXDrlJ4uCygE=;
        b=DPzBT5Qe9PpgneRwxU/6Uo3jCi72BfmgUB2bAK7mh2HqPezThdWANmapJ7ArRwuXso
         JjkiLIkg7F19w/fcZ+RacJEoWMBkvJm+WTsUI9zKcSusffBuE3xmiSBxXhgsfbd0vBx/
         kCRriTniOeEp2PJMIu/3qiEY3XNTR5TrO3eBuxwOUng3aMpi3JdI945zG5tVFEMFPo/H
         wqm3NY1fn3ptCQX7igdG9OxoAuqIUjNARPW1dUI5kkIyEsrzJM8+25nKcSm6Buhx785o
         pzAppdyFoF2vRnh+eGxxBY22lu36xzsYGg1gXMTlM8YQICLgrpQ8nvZMFMnD5Cqtujun
         ciQg==
X-Gm-Message-State: AOAM532TjujcqPKZUnVIDpRixrWVADs4n+sE6IAYkfN2IcZ3w/Iyazn2
        m93QOYOoERSYPrOCrdp3SxFBWmEAqbwnIm3Dx6gVSg==
X-Google-Smtp-Source: ABdhPJxB8GYrzCyR0qFlfQfw+LoLPdvUX377pLWuE6GmrEm5pKqcSgKJp8qNV+WwyjqVwurocX7tOpVUmHOPEMndm5Y=
X-Received: by 2002:a17:906:4443:: with SMTP id i3mr4922157ejp.133.1611381485916;
 Fri, 22 Jan 2021 21:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20210122135733.565501039@linuxfoundation.org>
In-Reply-To: <20210122135733.565501039@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Jan 2021 11:27:54 +0530
Message-ID: <CA+G9fYtr3QveGHTdx9qrLS6W=AfF+vU_nxuE-SnChued5ruWbQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/33] 5.4.92-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 19:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.92 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.92-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.92-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: eb6c2292de97c5c4e51d98767b4c7acaef0522ec
git describe: v5.4.91-34-geb6c2292de97
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.=
y/build/v5.4.91-34-geb6c2292de97


No regressions (compared to build v5.4.91)


No fixes (compared to build v5.4.91)

Ran 53090 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu-arm-clang
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu-x86_64-kcsan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* fwts
* kvm-unit-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-tracing-tests
* network-basic-tests
* ltp-open-posix-tests
* ltp-sched-tests
* rcutorture
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
