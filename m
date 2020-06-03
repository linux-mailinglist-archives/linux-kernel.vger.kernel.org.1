Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE121EC93B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 08:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFCGDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCGDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:03:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F4C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 23:03:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so1124443ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jmLMA0tQ/+7LSChJWNYnX/kkMdrhBbCChvk7UQ0cC80=;
        b=axhP8QgEe5geS3KFES9DzPCcBngZ08gGeJ1GsQ1c3R9Lo0aaO/9N0qI1n271fAWbAm
         kn3Wn/VIIyLYRpZtnk8uVnlfIX4pS8oovTT2+hnSH2zHXDi1ld61FEAMOXliWtM2qihR
         /mltu+HAazX3I/uIimP95jmKK6vvqTjfR9/Es5x+ihbRPkQ2s1cJD+u2Hl5hg2td7Sf3
         S1xyxRpJcxuP4+jSDfjpp9biSKiItutLpDiyx91FZJjaqeI7bl46nSBjr1d++qJrEV3q
         tmRkfn8TYxi+LVSd00opVqDWJtpC3CrqIMduE3V4e7IcDcyXXiK/L0TDyjgk10RZrTyw
         WM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jmLMA0tQ/+7LSChJWNYnX/kkMdrhBbCChvk7UQ0cC80=;
        b=Oh7m3PZO5Zf1YZnWR8C7L+0QjvKWXRgHa+XFrj4k3B9qt+TVjxwqe6U92atO7Lrxda
         dn8iuI4ThEqobn4PlocejUMsURtV1JhXsEMTwwP9k5rE2mZ5X1/7QGoMIZfJ5Y6Jey5x
         JiWJEQCv0UZ6PwPNqLuFRbD5EFXsyiVw15xIW69NKXKcdhiU5HFzFmBhH/c0fOhAb2c3
         yPDLFNjE7aE9EmeUdLMNsLX2TMQ4MTGuNssRnqDLwIsGHnlqg1XlhyDbgLpnsKf7gMG+
         T3VkjIYupDX7qxoc2o7F1IIuRWzrGNbpR7zO3GRHxk8qpJ090u1y4secUwCUR/M0SqTr
         pH1A==
X-Gm-Message-State: AOAM531nPKHuuDxY+AZN1fnmyKTc41grdHV12IOfuZ+Me9zlCPuF8qN/
        2Ob0igVL187zXBPjcOZoXjp99OPFSrrkxeqUBnPLTUF9l6YhcQ==
X-Google-Smtp-Source: ABdhPJxf8vQCndHx0tIve+V2Y9Wx8ASyMh9xHHsaYCAPgDqh79Rj4/Nn4WoRbmXL1JmDmIyQlfCI9DYtc4uH/RBn5Pc=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr1188583ljj.102.1591164229951;
 Tue, 02 Jun 2020 23:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200602101857.556161353@linuxfoundation.org>
In-Reply-To: <20200602101857.556161353@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Jun 2020 11:33:38 +0530
Message-ID: <CA+G9fYvpw-6YLakJTq2jyVMSdTDDhqvubeTzGTsH_HB6zNvsgQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/76] 4.14.183-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 15:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.183 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.183-rc2.gz
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

kernel: 4.14.183-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: e64996742439b0bbe4cbccf2acc0574f1691faa4
git describe: v4.14.182-77-ge64996742439
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.182-77-ge64996742439

No regressions (compared to build v4.14.182)

No fixes (compared to build v4.14.182)

Ran 31461 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
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
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
