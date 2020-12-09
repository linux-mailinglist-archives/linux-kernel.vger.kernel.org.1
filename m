Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0A2D47EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbgLIR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732762AbgLIR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:27:35 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D27C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 09:26:55 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so2430648edt.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SbpP1XQ1shPBp8DaFALcEJRwJn/qLid/T4j1wfzXX2o=;
        b=RX/3O64wEoA8L5MH4PpczX1DZlxGQaB+9SAa011g5eFqqIvulSZZtV9MPQ1tEUQnki
         0mNybMGkFsBxQl6ei1ZepCoPCgpqoCLHHydoOy1jLf5HJpTROpiBPBmHlt3ed5F6K6Sl
         NxUAdwkIMXrJxrwQd5+z9I/AujZMb6/VnMkcL84PBecYOagcC0wF7maC5LP5OS/RXbA3
         uBHNvUm5NKsAHgC254QDtXXkm6cFpMB1Msxj7yG7yeEvxT8UjdPiGXGlZnWqXYhgszEp
         snm2BZ27CeKdjtJ1U6LjlKQeymX+KjO37ZUufaVA+xIq2ogLR1l/BbZP4yp9oTzU0PhV
         Wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SbpP1XQ1shPBp8DaFALcEJRwJn/qLid/T4j1wfzXX2o=;
        b=CV29PpoxGUJadkz7OmMLhJRP54B/+eNrMroOX73LkaMk1VityMH/eU+WVKQLfZxd8S
         0wigF2QVHdjJDxyw/4LDGPeNVKkcqblJaBaeXhFan2khg2VeabuDrlbGIzNj5bLKXewt
         4NbnOodROfJZMgFiQpPQFyYM890Gb8yTGzRKdx5fUVqzMt/fjSyClM+6OxQOIp2VSZxk
         ZpH4/BUPVce2xvEpCdTrNjfapvaLVVAkLAqTSzeDkQEWQYlcoaQXAyhNFVju3yN5m+4a
         RPVueHDXxigtNMUgne9VeNFIcFkFaULjDdhjr64Pzm6/b7L5QjMhsLeSEzT60MDcFjYt
         n5YQ==
X-Gm-Message-State: AOAM532VcUTWIxBGYZ7aZEP7El26vYHZIMU+IW5aCSkD0UMi8TNBvijJ
        rhLltb0iiY+1xVxtFEYQl/ble4CJY2Ia5LaW1Py1YadqWd4UGosC
X-Google-Smtp-Source: ABdhPJxtFSQIIMnrBsJ0bpGv4WvcU1daI5mAFaXtkcrw7IxWFgjZZ1oHf1G7LYYXJd2CgIGahoa8K9Jf5BHuyZLhA7k=
X-Received: by 2002:aa7:d75a:: with SMTP id a26mr2931708eds.230.1607534813254;
 Wed, 09 Dec 2020 09:26:53 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Dec 2020 22:56:42 +0530
Message-ID: <CA+G9fYuNKqyvku1im6_zS5PjK9nG3Jf6qNwpQjaB8WRWO5BXzA@mail.gmail.com>
Subject: [sh] smp-shx3.c: error: ignoring return value of 'request_irq',
 declared with attribute warn_unused_result
To:     open list <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next 20201209 tag the arch 'sh' defconfig build failed to build with
gcc-8, gcc-9 and gcc-10.

arch/sh/kernel/cpu/sh4a/smp-shx3.c: In function 'shx3_prepare_cpus':
arch/sh/kernel/cpu/sh4a/smp-shx3.c:76:3: error: ignoring return value
of 'request_irq', declared with attribute warn_unused_result
[-Werror=unused-result]
   request_irq(104 + i, ipi_interrupt_handler,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        IRQF_PERCPU, "IPI", (void *)(long)i);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
-------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime docker --target-arch sh --toolchain gcc-9 --kconfig defconfig

metadata:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    target_arch: sh
    toolchain: gcc-9
    git_short_log: 2f1d5c77f13f (\Add linux-next specific files for 20201209\)
    git_sha: 2f1d5c77f13fe64497c2e2601605f7d7ec4da9b1
    git_describe: next-20201209
    download_url: https://builds.tuxbuild.com/1lPwmsuPj4eW5gsLeObYvbXC3fw/

Full build log,
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/899463251

-- 
Linaro LKFT
https://lkft.linaro.org
