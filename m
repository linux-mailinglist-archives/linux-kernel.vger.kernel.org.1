Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521A226C1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIPLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgIPKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:34:36 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9461C061221
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 03:33:09 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id e5so1606972vkm.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IdwPR/fAtGHVUXwUACzu3D7oPcwbftl8nlxw5CpXeeg=;
        b=Rk1zENdievy3OPj0w4Ah0mWQLQ/hSxlmZx6Cl2denpI7VcHeRSZJDR4m4wGImXLtEv
         gWrSxx2/F837Ptdyypa3WFMIIUM+xj9t/wPxyJ84vfIqNT93WGa1obcYjOjTw4FJjRUC
         nCW9xwmw7sNsB05IVuHYYCUUP8dK7fbs58JpL2G0yffhi/XOMueAodHy/Tv75lNzT/Tb
         JkIgkGQ7FpPIVSYCVBlNh7yJ4434eWCuHmvLSHklTbHQsuEaQJ4BDya64rRUCjHvGpzG
         /dggkfJQfD1MZ5jTPYxaAzwFYM6C/Y4DgK2zxNp7HVXFocfPa34t68rG3IMxuP3rlOjG
         53gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IdwPR/fAtGHVUXwUACzu3D7oPcwbftl8nlxw5CpXeeg=;
        b=XbWsKPoD1KXusoik8UzZvayQzg2c/UiFYInQqtHsSEBJ7STAoaU62+u3BlXiIJUC+3
         ABNEzGmTvQvXly585oF5uOto6G0ROYOZx3SOAidYOJIHB3eGWN00Hsy+ElxNz3izm/t/
         gGFxXgk7+5A21mcfu54qkHi4Bb0bJ8751yDazFLNXGY9h/5QG3aOAHAJ46Mzvl1UmATr
         CtsshhY2P9rh+immbb1tF16jQXPB75WPJpdQEsB9qMH0F23OdKIf41cndr7Ht/eknwWb
         /PZD2haTtIEpJ4nB4fpEHi9oB3ivc1RrVFKCAc5d5gVVIesv+SsZmqWyXHjm2DaLLsmo
         iRzQ==
X-Gm-Message-State: AOAM5338zhSh4LtdxRVgLn2rZlBpfWIC/7rEMHvTcmXLORYGLz6tVESH
        wJlBdtdnaxi85+QChK9gqNI/DUXMZTU3K8Cqkm9zwg==
X-Google-Smtp-Source: ABdhPJx0nXi7W8VyrI2mBWrJMc3OCZURS+LjHCKbM+5zAs4NqnASZaKJZVEz00bgLG0l3VQpM/1A+6WrCk5Dzb6F85c=
X-Received: by 2002:ac5:ccd3:: with SMTP id j19mr13192651vkn.8.1600252388703;
 Wed, 16 Sep 2020 03:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200915140653.610388773@linuxfoundation.org>
In-Reply-To: <20200915140653.610388773@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Sep 2020 16:02:57 +0530
Message-ID: <CA+G9fYtQ6w-J46aRY9i5CAfOq0jMAxpxYv-JXibeXf-tnDLDzQ@mail.gmail.com>
Subject: Re: [PATCH 5.8 000/177] 5.8.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 19:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.8.10 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Sep 2020 14:06:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.8.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.8.y
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

kernel: 5.8.10-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.8.y
git commit: 337aafeeb4cdb1868fff6b6689b715ff376249a2
git describe: v5.8.9-178-g337aafeeb4cd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.8.=
y/build/v5.8.9-178-g337aafeeb4cd

No regressions (compared to build v5.8.9)


No fixes (compared to build v5.8.9)

Ran 37876 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* ltp-cve-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
