Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C032CB4D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLBGFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgLBGFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:05:45 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 22:05:04 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so1381804ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 22:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ch0JARWu/AHIX0r3TzG/RjWXLohfVfCvWUEtdQGQRYI=;
        b=kTSJfU9xXPQZfkXPVEPDgHCNSS2bq03SMmaessGdwQYO7j3PCpFFbQVHYPvVDeZmhM
         04Ud7Fwf2JfNRtkbB5gOAxK3CgukTwU8+mmAx0x1QZ1ICK/NDWfJ1H6VE7ST7SHGM7xo
         NxccZ0qAUXT2NAiX/I4y8xsYOdzMcPcopBj2TjBUIOcsMijPIyxXMN449zvRNXZnQmjN
         7pI2MgBNCGyXWqE9PyoAuMN0nzJGh6z8sGb4TUmrqExu4P1B1GYMvp03F6T7YJQio06h
         P6C9YaH/CQgQhcm/rvbdkoiher6qqn+JEz9GcTKwJapXPbz9eUxt/45kuFkQXaVRyTto
         Fk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ch0JARWu/AHIX0r3TzG/RjWXLohfVfCvWUEtdQGQRYI=;
        b=j8v6BeNs0d5aafva4/wlxDms6uLgiQroaXgs2QTrU2xFhx4BUBH9D1L7uzXZB1EiR0
         /opXG73tx/DHT//bhqE7TSauFoNsY6srnK6Y6ISpoUSUjm1iFaPzuqKJ2p3b6c3EvZDO
         2477frg35BrT7MrxT0KIA8Pcgb9ezrdZx4gLFzkNw4uo78U2VVS79f5SI9IrzdhqxW4K
         YlOcu/rnoDSRHiSHgWd8yeyL3Gg65A0Pxnh7YFoiDni8c18YeqilqgFTJYfPJcwh30bb
         8iaNChWPKxyaXBoQ5+mWMRUCci3+pN2/cMrEVvxMs9xLUGKm3vaRaCwVI3XL5KWV50Ws
         hQYg==
X-Gm-Message-State: AOAM530EVgLDD1qJeE/vyB4+vM+VOcFUvJqlN75Fim18mlfCZtdroE8t
        s9nVx6F5VGtdKxTS7L1DhIF37Y5pAi+Z3TLUMkCfeA==
X-Google-Smtp-Source: ABdhPJw0Wn1iU0u2aF3o0Wq7dlWytmNM4xAqr12lJKAM0rjmChMU7C2l/afL8YwXShc9/s5jhOUqZlaAfrga6cfGAIQ=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr802460eju.375.1606889103122;
 Tue, 01 Dec 2020 22:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20201201084644.803812112@linuxfoundation.org>
In-Reply-To: <20201201084644.803812112@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Dec 2020 11:34:51 +0530
Message-ID: <CA+G9fYtQhPonn_fAgb3=vXdDDWRW-t4ykfDmfrfrPVSZ=s857w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/50] 4.14.210-rc1 review
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

On Tue, 1 Dec 2020 at 14:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.210 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.210-rc1.gz
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.14.210-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 07930d77d7baeac481d5ec4b88f8b26ac810c4bd
git describe: v4.14.209-51-g07930d77d7ba
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.209-51-g07930d77d7ba

No regressions (compared to build v4.14.209)

No fixes (compared to build v4.14.209)

Ran 35483 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-kasan
- mips
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
- sparc
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* v4l2-compliance
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-open-posix-tests
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
