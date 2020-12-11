Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658FB2D7545
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391198AbgLKMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390651AbgLKMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:04:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC74C061793
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:03:34 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so11981175ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XyvKOKf3WS7C3+cCZU/wllX3BMQJaXQiv6jHN6fWPKs=;
        b=BKJA/YqATX+Tu3Zq80kQfakQ/IGTBjl4UxeSmGfFyaimbXq1vb+jNKXsV2FTAoehNO
         DqrJ9mjUK+knnoyTn4HARgi3M4VkJGu16+qc4FVKcFL2E9JQCwV3PTl2qIL1jF4cvRcv
         VtKP2bUwbtqlvkrkCMGn5nXxZJr15RT2k8hAV87VCFBYoPmCLhN7bnz1ze0LHOYE+FQ/
         wM9R9ZaiEJYi6WU55/nZryfitAwpV4PtEwwEFkZog003VrQnV12aOJG2F7hENh8zIVJD
         XPykb9t1vYvY341/NvLHbGwXsT0GgZtLC+CwOk70gjjOU+cbkoHWd1pcridGL3sFMlGG
         nz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XyvKOKf3WS7C3+cCZU/wllX3BMQJaXQiv6jHN6fWPKs=;
        b=XSOFSa19e3zGIG+NegOU4GTSrcm8jW6wZt65Krel8fW1BbH7/MaBPL/TnYwyzSfyTH
         i1aPZvvipgFJpqnn2CZpkFYyh8j4npWjjMtCiUzguKutVa6RYlfHk7QytpSj//s6If7a
         yChRNYIizrXl4wR1Mpru84eBKfcGHcJPeSbzlpbWHXF1V12bVOagGTtbxWO3rRg185ig
         QtwEAplebe0nbVzMzfAArXmTBYB6rJCKgeqgo0LtZWS8yUM2tgLV3DVJRN2KI7piVXe0
         NjBU6Z8UjdtimEpsRDlQq3YbGTdoGB3wtnFZ8lALIQukkEru++O6zvGYoVSENDegbZ1I
         1L+w==
X-Gm-Message-State: AOAM530Mx/c7S/qm3hcztIfQOsmhs3imqRXpfbzUPy78SuKvqbsIIJhC
        AmY0pf1yOJloV0LrqjZ+2xLuonwvMeREflQyBlwFsg==
X-Google-Smtp-Source: ABdhPJwAZJKxbcnHbNyr3uYJoJzI9wtdG7oTOeox31k+0orOubA3b8swnk6phsxeO36Jt2dUA0JHFwW38/teq8qHzAE=
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr10669772ejb.247.1607688213218;
 Fri, 11 Dec 2020 04:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20201210142602.361598591@linuxfoundation.org>
In-Reply-To: <20201210142602.361598591@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Dec 2020 17:33:21 +0530
Message-ID: <CA+G9fYtvvKVaA6SALu0cn1o=nKn6ppF7obvtRA+kFomGecf_NQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/45] 4.9.248-rc1 review
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

On Thu, 10 Dec 2020 at 20:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.248 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 12 Dec 2020 14:25:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.248-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.248-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d6c029b435470eec6ccf5c2065b0512b75d92419
git describe: v4.9.247-45-gd6c029b43547
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.247-45-gd6c029b43547

No regressions (compared to build v4.9.247)

No fixes (compared to build v4.9.247)

Ran 25777 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
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

Test Suites
-----------
* build
* linux-log-parser
* igt-gpu-tools
* install-android-platform-tools-r2600
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* ltp-controllers-tests
* ltp-syscalls-tests
* fwts
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
