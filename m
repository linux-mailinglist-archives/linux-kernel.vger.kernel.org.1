Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5002DCCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 07:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgLQGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 01:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:43:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB15C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 22:43:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw4so36210681ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2E2IRKEI0E+4fYbd4aolEHId9cIRGJRcY4qJxFLCTNY=;
        b=ux7LL3mZctbUVr6Qn/cj+GvAouxYh8Ff4eiwmFaav39GyXLE7UPBbinIoIWgcYgwwa
         SocrNn8RD/yq3Mf7TLe67zW84WyQagmmYT1ui4+X/6P4z+J3KDZJHgarHyxRgvMGiHpA
         xOiA3Avv+7Y1SnhtAY/6IrNun1JvTiNOITROY5qTVR0u+SgWvB7YTEs90xbVGlcEuAuC
         KlurAedgPMqPyogrmSIZmS2K7s1jwx44peoYGuRslxQHmliLscLfDRkHdSMHZv4UrcWH
         uz9fU1Cy9iau28KumIK/PrHOTZPmEG3VpWVx3qX2UFuz0NwITsD1D0GON69kkIjiGdvl
         Q9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2E2IRKEI0E+4fYbd4aolEHId9cIRGJRcY4qJxFLCTNY=;
        b=crFgKEKxEQRFweoTw2mmwpnQS16bDBeTwraPw+rEj82PbyKGO05FZGk6NrsU2UiHuD
         UiO1tlH/O74DukXb/K95TSWLFG9rSGgd49ibKou68P+6JwaKAl2F20SU8fcGf1B+7/Ni
         d85MChy4wd7hc9qWpoh0tco11hyCs2H3IlPP+mBM24tpLg5NHvoYWRmJd77z6OvKkSx4
         CGOiMDHc0rOE2BBwTKteFhxDmy9UmC8WA8CX8MG5oSQmKCAMhLUCr/U+qIuoa6lG0O0n
         VGUy5bdXDfKYuijmFEyQGTJDljF2Y/FG6ad2P1nirSY0Pws1bJcH2EiE98+E6jJm3nyU
         mS1Q==
X-Gm-Message-State: AOAM533PsB2PsSqyX1YRbnVgETeZrW+cEsxxSvdp6WSiJiZMKLOxhpNm
        F1NEHvSGh4u9S910iwd3wKjpak1/1VcIgYOOshyr/A==
X-Google-Smtp-Source: ABdhPJy7HNskfwVp3ThIspYC4Ccdzj43u6x1IlcBsmNfy4vSHjEowpisjy0Wcq0L2d7aiHrnx69C/EEJGi2XhqQMl9g=
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr34272376ejb.247.1608187394890;
 Wed, 16 Dec 2020 22:43:14 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Dec 2020 12:13:03 +0530
Message-ID: <CA+G9fYtHimKZDuJGAzF86OY_F9j93oLPcohJRVLU+RLKEDCrbg@mail.gmail.com>
Subject: arm64: entry.S:774: Error: immediate out of range at operand 3 --
 `and x2,x19,
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 build failed on Linux next 20201217 tag with gcc-8, gcc-9 and gcc-10.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/tmp ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc'
arch/arm64/kernel/entry.S: Assembler messages:
arch/arm64/kernel/entry.S:774: Error: immediate out of range at
operand 3 -- `and
x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<7))'
make[3]: *** [scripts/Makefile.build:360: arch/arm64/kernel/entry.o] Error 1


steps to reproduce:
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

tuxmake --runtime docker --target-arch arm64 --toolchain gcc-9
--kconfig defconfig

Full build log link,
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/917491444


-- 
Linaro LKFT
https://lkft.linaro.org
