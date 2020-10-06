Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDD284547
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 07:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgJFF1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFF1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 01:27:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3BC0613A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 22:27:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y13so11727028iow.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 22:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tOPnUBSHpiimDo21hqwEcbS1XVLcCOXvPAFDyfbXLuM=;
        b=eCXcq+ZtB79udbCN6OWJ0Dq7d+KSJkTwg8z0rO7cBcuTUGR++tM/IGobgrv4OVYZ1c
         PinzDfuVcYMmItmpo5sWGTNVcmMruzwSpBcgT05EP1BgbsP1mTMPrk7eM1qnoQK7f9qb
         ZUJHxEMacY3OKma49Lp9D7jJMWK5r8aGauiXrABfNYAHSKr8+pK3kWR/vota21YgIur6
         qLUOhvHviWDPEgSIA/g32VeCmwcfwNGf9ylhVKTwql96TtDNnewkQtvuHbMNa28qOJnW
         z+BiNUvQXXrXoKdj+3V+LeiDO4gCJoSBTmaGAq2+KhggZoO7RDXIGDH0ApfBbpclTMi6
         XcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tOPnUBSHpiimDo21hqwEcbS1XVLcCOXvPAFDyfbXLuM=;
        b=Aqr9SfCp+/VgonLeYetlkhPF1N0Y0g7oeBubkK8ZYc3rPtXLXB1ltpPAL4SBek9K4M
         bHW++aWAmnB9OCOpKhwyXpMZy/e3TSefgS6aBPoHsGACG55g8aIvfeNE2P/p3zK7SWbY
         PLrPodDURxVXZXHRW0WQmDGkj0YhwkSUMChgPN1wldLqyDSSPYsiCDDYHgSABPcC0L1J
         C7pk0Vq1jqNCcBLvshBdTB1A36H4pboucIcmZrKIgdicJN5s7vgktHOfuwfysbsyhy8y
         wxXO4yEGSdAxsMknrPMrq2kdsQldjrMIg7vpfrGzolrpwGUNqTziH0cc3B3QH2sZFJ2L
         gjkg==
X-Gm-Message-State: AOAM530gPbBXWMB6QWf4IrTl5lDt9q4F0pZCS8hFgSsTP1t3Y9dRq+tR
        1EC/N+nMABZbwtOlYL8jB9hrCDRxE9c4A3R1i4W0ew==
X-Google-Smtp-Source: ABdhPJxWglIG9defFCTau5PjuBV03PRm25XZZi3GD6+RLpcCcXWykKBbbjk0zGaElLkY/ie//IsEoesfGi0JpjpnBxQ=
X-Received: by 2002:a02:7817:: with SMTP id p23mr3030159jac.57.1601962052170;
 Mon, 05 Oct 2020 22:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201005142114.732094228@linuxfoundation.org>
In-Reply-To: <20201005142114.732094228@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Oct 2020 10:57:21 +0530
Message-ID: <CA+G9fYuma1oe3GuAjQUtWwqHwshpzZsS-2h0u2R450X-m=mSzg@mail.gmail.com>
Subject: Re: [PATCH 5.8 00/85] 5.8.14-rc1 review
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 at 21:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.8.14 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 07 Oct 2020 14:20:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.8.14-rc1.gz
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

kernel: 5.8.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.8.y
git commit: 8bb413de12d0ad809391ab5a965b0fcf1b9bb3fb
git describe: v5.8.13-86-g8bb413de12d0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.8.=
y/build/v5.8.13-86-g8bb413de12d0

No regressions (compared to build v5.8.13)

No fixes (compared to build v5.8.13)

Ran 39163 total tests in the following environments and test suites.

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
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* network-basic-tests
* v4l2-compliance
* ltp-containers-tests
* ltp-open-posix-tests
* ltp-sched-tests
* ltp-tracing-tests
* timesync-off
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
