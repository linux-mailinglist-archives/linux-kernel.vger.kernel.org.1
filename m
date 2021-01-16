Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC22F8C1A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 08:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbhAPHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 02:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAPHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 02:48:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F0C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 23:47:24 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hs11so14214884ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 23:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z2djUeHW29PTHcAEATrXB6Rh6D3MKzCt0CW0H5NmlIE=;
        b=H4OO9pau+K++OnZfwglsrDV0vo0ZhkPRyorppHcHYRmwiOwAo7WfYKvkr6Ab5DITNo
         XQBc/WX0TWAvd9DNLoRfdIAvrGEgyR5GTTaKglL1Teb9JJO55rKiw+tqk89r2YGMFAWg
         lLAccA9s1AXDh3gKCSF3jQThFx1SCMvzsucewMUgzzCr5esmEoIpf6EtXi3hY5SfMtHY
         C7vlytO40ucCk8+A9CBL/SZTpMFTbahD3n0LKP7DNK85PksuyV4YktRYYnIZmphjQzMZ
         fKT2IojnTPU6XD+nHm4l5NPt0A2R+AooJH3BFLAiqV9QCgBrnUZe68HFIfhbtWVJurmr
         /CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z2djUeHW29PTHcAEATrXB6Rh6D3MKzCt0CW0H5NmlIE=;
        b=kZpPlU+l9hQ4qY+UlDHl+LwGQHm9TogCAOsjbbvITtG5hnrDC7G85xb/CKspP0Fz5Z
         hxrl4+DIA+M7Y+06XvGr/9G/3Q7OKqm3Qf9QUqQP3gpzUeOMnkv15JFLIjDP0GG3hsSG
         kav7zP6yRR5rg+BNbK8LQilCpL3hl42qTqT6esdsSHktSo5wyA/dfXCmxzGFmYwHmkgB
         X5/953rK6dEOq5ttgFnQxTZRaYDceb8RSO/hw+G0iXt6JXfeQGLQgacDiyeRgvqggJ9a
         ATq4w+r1vrfflb9jo7s2yb8Fgd5fAl2LFzCA2SUwfe2gCV+Sg50ESDXdko0rcIyUgXDL
         A77A==
X-Gm-Message-State: AOAM533Oj6JKV5VkBiquoH7KuVanHij3HlaLyjCMOO3+olEf2eLIkX0F
        sdtxBKtfk9bzYhuJL84S35OAcVkqTZ23BHq7yoLMz0gGUgmFf3bH
X-Google-Smtp-Source: ABdhPJxJWGoveSlfEPO/P1QYLiRauSD7iFf3lgyX9dShnuAWCrdE9QOfuqYum/ncQNlSFtpoEZlcVtQPVGn4fdEVpIs=
X-Received: by 2002:a17:906:1498:: with SMTP id x24mr11055946ejc.170.1610783243181;
 Fri, 15 Jan 2021 23:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20210115121955.112329537@linuxfoundation.org>
In-Reply-To: <20210115121955.112329537@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 16 Jan 2021 13:17:11 +0530
Message-ID: <CA+G9fYtzpFF-Q9p5mDmcjjczVXvKgrqEWDjwk5eb=pz7UOrQ_w@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/18] 4.4.252-rc1 review
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

On Fri, 15 Jan 2021 at 18:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.252 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.252-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.4.252-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: bca740d5a2a15e70a7b3cba962dc1d27f26204f7
git describe: v4.4.251-19-gbca740d5a2a1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.=
y/build/v4.4.251-19-gbca740d5a2a1

No regressions (compared to build v4.4.251)


No fixes (compared to build v4.4.251)

Ran 31040 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- sparc
- x15 - arm
- x86_64
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* libhugetlbfs
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
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
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
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* fwts

Summary
------------------------------------------------------------------------

kernel: 4.4.252-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.252-rc1-hikey-20210115-897
git commit: 9a7f50b4ecb8e05511460280c4e43f3d9e7f01c1
git describe: 4.4.252-rc1-hikey-20210115-897
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.252-rc1-hikey-20210115-897


No regressions (compared to build 4.4.251-rc1-hikey-20210111-893)


No fixes (compared to build 4.4.251-rc1-hikey-20210111-893)

Ran 623 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
