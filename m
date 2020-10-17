Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32C029109B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437548AbgJQH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437539AbgJQH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:56:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D4C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:56:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b15so2968680iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eeJRitbwnPEjMGDAswjdWZJQPMXqea0MWxUvLCrKIe8=;
        b=fQTsui2nq+dEQbjtVAi+6auWqLFzWYsJGNhS+sSBVVe9TDbCyasl31EytKoeEMB/TV
         bsTKuyMwufHkTge/xOII5YnG/q+HNLmhLMBCQZzW3COgMsKSLkKBvZfVMod+5LfpDY8I
         2OkvKDnZShKflX/rXSOL69NbsdmLJ9m7a4dvqO37ZqO6XbvNz5yWJ7L3e2ljmag0VAwh
         9uOks2CoWsuT3PnGdFXpSoD1MGSIEtsNuQ0XOlMyATM1Ky/k7QmF1OiwaAEK75UIiQIZ
         Oh0A3vnnNo4NAU+ei7wga7i6o0hhi8pQfBPXsvJS3MT3Jr7M5BeJcifkQO50ku0koWme
         g9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eeJRitbwnPEjMGDAswjdWZJQPMXqea0MWxUvLCrKIe8=;
        b=KlTRkHGwKZ1q4hZR6C53Rq0r6CuNFpcir8+BeljiXeeiSc5Mh4CdVxkSQaYUhIJf6G
         6TLO4KL7/jZnioLP+JsHL0IBizLcE1rp5St6Ta3Y/0TNI71xalGTM2BDAVIyTnB8YkK1
         EWCmZRMfy6IFFIALg49ew3MuJ/iCCl03iEbz5HnJnyziIUISbxGAtb59YADko8+Yitwc
         yUY6t8FtMNC8uMBFtQHQaZtKQkJkQYCAKbkQ60Qe5ScRg58u/W7uCsfO9vnzKKBMMQvl
         clHNfE300GEhj+OlJ3A78jhFBovyxmMlMlke8nfd65CYOc91CjmqtoRbBpTr9kGsXfkg
         izCw==
X-Gm-Message-State: AOAM533aBVk/mOMwKSDxHEwJR8MyQ8nHVu35f3cyZS4OIPch6ih0zPrJ
        kf9y/4PhJ4yztCkdXGKiKr0W4MqsAhBByMhoiZgvbw==
X-Google-Smtp-Source: ABdhPJzL3bAQA0diWHzlJsviIewq/7uIeD6vEKRBQLicAE6d9cDxd8xKWzSzERbY3iPVM86yC4BirP9GkI85BkQLisY=
X-Received: by 2002:a5e:9307:: with SMTP id k7mr5212937iom.129.1602921374727;
 Sat, 17 Oct 2020 00:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201016090437.205626543@linuxfoundation.org>
In-Reply-To: <20201016090437.205626543@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 17 Oct 2020 13:26:02 +0530
Message-ID: <CA+G9fYsWa2=LcL2xsS-kTVgdi9-c=X3V13dzbMvpuXurbjWL7w@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/16] 4.9.240-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 14:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.240 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.240-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.9.240-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: eb0fbe0c6b1c2863b26464de441a406275c47b6d
git describe: v4.9.239-17-geb0fbe0c6b1c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.239-17-geb0fbe0c6b1c

No regressions (compared to build v4.9.239)

No fixes (compared to build v4.9.239)

Ran 17816 total tests in the following environments and test suites.

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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* network-basic-tests
* ltp-syscalls-tests
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
