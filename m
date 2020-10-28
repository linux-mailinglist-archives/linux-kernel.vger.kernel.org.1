Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB729D6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgJ1WRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgJ1WQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:16:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F156AC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:16:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j21so567097ota.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xcYtxhATV9tNgzx/0u/R7WT0cT5PolfDyRZ40j1FlbI=;
        b=zgsUAsMT0yDpwiTyOvKDRHI+scC2U9iPXQzA5yYwY+Tqh8UAupR9WUMi5j7rPAKb0G
         MBot37UhvP8sRYYRvOgUm86e204v15RwQ8HNzZ9o/hzd4Wei6ltsr8yURMsIeJMmt0fh
         9G1X21u3jibbfJmYoUEblBbsG2Dh5PvSnLFLGiohh+01PMCPtvyR+3DmVDI2MWxiX2Nz
         XKnMH1kwOt848xReaMGXXTVvHnND/sSAfk0bRQ5M9++dwwC7boNt61hkeSezDkm0U65p
         y1b93ygDMQQRL0vL9JH0JfGL/WyWk9yj3sfsiR43T9P78VT+Q7PubjaogZZeWp5Tc3VB
         8iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xcYtxhATV9tNgzx/0u/R7WT0cT5PolfDyRZ40j1FlbI=;
        b=X9APbF8zN27uQUddhSCf7dZJJPzLqnlo1k3PEgz3/l3HCAGtsinqCgWWntMWtAzdHL
         pUA4B8uH7msqw4/792o1+QcvcHNs36UlhJZm4LvGs4dz2rx5NGZZ5Dsa/7PSoEsEJOzG
         q6NidfG1IsKBSa89ZSn6hQAsxfzBR84DVfCPmq4RdnqakgPV2TvrKYpSwkQm/7fsAgh5
         9+3UqZCTYe+4aoeMi/6J8KrwHG5eKoKSRFV6UwoOEPwjo/8SXS49bDwNpN5tP1Njt804
         4vt7oCY4n5MNaoJzCEVsbwuo07CKYEATo9S6U1dr1oK6QXzLvrv99pEdIQDy6d6HZLOR
         oFzQ==
X-Gm-Message-State: AOAM5308NhhPe3v90km8aFuRokrmgAEMW4IQkb11XwPsMX7IMx3ffVrW
        FYBLwpJHCNtUqcHyOtjuIvB+86XCLmJ13CjRgCgBA9vPfA55Nz5m
X-Google-Smtp-Source: ABdhPJy6soemAsqMe1KYx+bmBldzxZD4Uw6ebV8TsxQ/bcsplxiFnj7KM2Q6qrJCMRh4pBcok2RmEJjEr5dSkRTzXfY=
X-Received: by 2002:a9d:22e4:: with SMTP id y91mr5240199ota.72.1603893200353;
 Wed, 28 Oct 2020 06:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201027134902.130312227@linuxfoundation.org>
In-Reply-To: <20201027134902.130312227@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Oct 2020 19:23:08 +0530
Message-ID: <CA+G9fYvGVjxrJf=vFzuqhWfcmCUPbeOB3qgL7HWZUBiFAo4KSA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/139] 4.9.241-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 at 19:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.241 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Oct 2020 13:48:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.241-rc1.gz
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

kernel: 4.9.241-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 97bfc73b33b595e89801f5fd849c14af344dccdd
git describe: v4.9.240-140-g97bfc73b33b5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.240-140-g97bfc73b33b5

No regressions (compared to build v4.9.240)

No fixes (compared to build v4.9.240)

Ran 16492 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
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
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* perf
* v4l2-compliance
* ltp-sched-tests
* network-basic-tests
* ltp-containers-tests
* ltp-fs-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests

--=20
Linaro LKFT
https://lkft.linaro.org
