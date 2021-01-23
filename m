Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D4630139A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 07:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 01:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAWGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 01:34:15 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03C0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 22:33:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g12so10787641ejf.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 22:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L7CLb3c0UsXHddwXEsGKiQSv57N6epKTUZHL2rInCbM=;
        b=CHzFWZqKKV6JoPyVxVy3zGwg0IT4S84JQHoO7kIfPYsYxby3wdnwDXjfF6fAh9rGiE
         yVNTY2j5tU9Ot4VAGIqvGmj82C8gauhZOHFDPuLngq68oEB1YvJVnKZegU5p2PtoEdh0
         KxquURGQBw+5DL0iAUkEM8dtOSq5c2Xev/zL9hDSJ08uGisWVssbkFinXsyt6Ct2BfjX
         rt5s7JBVynQYhJsvKa2ubYK11bEzTpdlYeeOTAuDcogjaAVqAlkAWOVB3rsiuAT28Ts2
         IuZtNCim1sDea3WokC/iudyRZ6ACt2zzkko8LmDL9kqzBfq333GO8abmjKvOP0PgdD+Q
         OQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L7CLb3c0UsXHddwXEsGKiQSv57N6epKTUZHL2rInCbM=;
        b=haw6xu7WIaE1YM6bJMXSZSGF58Dwu13+Xo6Dff6U/ioDDINRsmcxeuG6aoAaFpezqY
         mWeLcEODYpr0E9SVM4XFm4yCinIhMoPKswPSHWS0+pQnTmeaK31gybxDOwKIHfIcX4oR
         7Z1Z3aPNgb7XpcbeWiT6eaYQAKS0df4mimYxDxCzR3hC3TGje2RM1Jp3dlBTggXxA298
         kTIKkm1f6X9UGWKa32FRzXhNAijMZXpGvircjq3WuI1+F5kgQYOjhxKMF0RmbHgcvO22
         Vrqjw0Fr40wAxEQIm+zziuTcgaFTruKu3uGXequbUN6DdnI5QypnWUtEDEvuI0yPrwfx
         PzhQ==
X-Gm-Message-State: AOAM530c0LHjsIXagA7vhDdWlTblVjpFsIkMqBXbSZk5cvejPryMURl8
        aw+aYzrH0VyxEZMVKTzbwEIb8BK2SkjlOLc2g5DC/XKC5WJlF8i4
X-Google-Smtp-Source: ABdhPJyhOaOmhi2Qtm9GkCBdC3vInfwJywk8xja/JJJIdGc4mozG3LWjV/W4YT1Kmm1iaNoAtR7nM64ol0WN6sR84dM=
X-Received: by 2002:a17:906:4443:: with SMTP id i3mr4983441ejp.133.1611383613120;
 Fri, 22 Jan 2021 22:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20210122160828.128883527@linuxfoundation.org>
In-Reply-To: <20210122160828.128883527@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Jan 2021 12:03:22 +0530
Message-ID: <CA+G9fYu41fj0V_Toc6jadedX4--NG=BHKS3D5dZ45tR-0twnPQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/48] 4.14.217-rc2 review
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

On Fri, 22 Jan 2021 at 21:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.217 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Jan 2021 16:08:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.217-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.217-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 10fddc03bd61fb44e84e0fd3550f78e950cbe2a2
git describe: v4.14.216-49-g10fddc03bd61
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.216-49-g10fddc03bd61


No regressions (compared to build v4.14.216)

No fixes (compared to build v4.14.216)

Ran 39231 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* fwts
* ltp-containers-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-tracing-tests
* v4l2-compliance
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* rcutorture

--=20
Linaro LKFT
https://lkft.linaro.org
