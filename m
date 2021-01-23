Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EBB301382
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 07:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbhAWGF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 01:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAWGFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 01:05:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 22:05:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id rv9so10705747ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 22:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0BsA2lBVT487I4umIOlS4q0OGIOTgQklaRMLR9jBzm0=;
        b=pdGBJnKAMqEehqX39w+5ITI3eZ7iAo0g8sazz85llkI/tn7wT0iDBAfXzuaPMD/a+c
         h0RZx5rXekc9hjK7i87F9Jn76eiyc4S5Ffv/iQHlB+mBmZ4qlwJr8WGLJA6242ya4RRG
         oV20TAb7f+96H5HtVHdvWcNquvAbk5HzIT6Pin5I33f/SXLL3QxuFPRoU62X98yWthIX
         TZmkExE7a6TrVTuhSYqv9ZkL/u8JVVl8Frk6DKUGSW3XnLq5FOQMYdMj7PQAdNUxW38y
         Ona/AfCFxEaEv+yZzw3nfTOh6PhD7HPbZCva3umWxPqDyZ+rK/dJybS9SPjhoZ9/C+n+
         3Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0BsA2lBVT487I4umIOlS4q0OGIOTgQklaRMLR9jBzm0=;
        b=L41qAYhYyQ+Oypgv6/OL0Pfnq9dPERWb2RsWYkDRWYnPAwF06UjRJ2i2170VBjDNsj
         GEbWK9MNS4+MwjQcy3os/uEurNjO/TVA7yzK6kdiEY3hximfg2m3h1Sp2HuaH4fd0aH1
         H/u7Tsw7hH2RfuSK8ogYFrWCDFGtHTApTd+bFDAYp4KjZuK/QBNCOJRHugQuE6svDCFB
         dyfBH6arrnSWJFsF1Npc9riiv8XvPn2hFCxOrmktTxmPKQdlmUGv/5kPKpqHoFwHWjxF
         z6d1Ejo3Cq7DsV+hy+o1npph2T9ficT/vikwAx8bWPKATlNDcnn5ZteuaspL3LZu8Tri
         1JBg==
X-Gm-Message-State: AOAM530mzuTByyz+n+mxd97JHpkCznToB/IMbgT40KjfCqS13C7SIEgi
        vXPb/iR6wpAMw0OAZshYwasFU8j4MtDE1khIZuku0Q==
X-Google-Smtp-Source: ABdhPJwBTlevMN71eFcSU//42QbEuA3rBq8bWS9EwkCluak3+VHMeaW5NPcxOKFVBRtjCTLTgcg+2pneiAZt5B6UtHM=
X-Received: by 2002:a17:906:796:: with SMTP id l22mr5222691ejc.247.1611381906695;
 Fri, 22 Jan 2021 22:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20210122135731.921636245@linuxfoundation.org>
In-Reply-To: <20210122135731.921636245@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Jan 2021 11:34:55 +0530
Message-ID: <CA+G9fYtSJa2TTqBGgcbFXUPR7Qo8QzqVvMTXevqmP+ZCAHmLLw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/22] 4.19.170-rc1 review
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

On Fri, 22 Jan 2021 at 19:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.170 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.170-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.170-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 6cb90163efb77ad3afe6d40720f0b7cdd0a94812
git describe: v4.19.169-23-g6cb90163efb7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.169-23-g6cb90163efb7


No regressions (compared to build v4.19.169)


No fixes (compared to build v4.19.169)

Ran 46904 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
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
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-tracing-tests
* perf
* fwts
* kselftest
* kvm-unit-tests
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* ltp-controllers-tests
* ltp-fs-tests
* ltp-open-posix-tests
* ltp-sched-tests
* rcutorture
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
