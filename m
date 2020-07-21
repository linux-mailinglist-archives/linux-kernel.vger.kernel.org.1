Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D47228328
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgGUPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgGUPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:07:08 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B734C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:07:08 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 66so4609950vka.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TttBCUltyx/MCWMitfeQkl3FeqjlrfXX2hlzOjft3gI=;
        b=D3eKj4HPsOHwmNcKBkkKHMp/Nw4v+PtZNvUvy9OCmKmt50IQB66eZhlGVpfuSSN2Bg
         T2UT3+3DIUMb7A2Asnw0uwt24qGEzz1SG+BRpOMYwy2SYdUif4guHSIbLxDl+/+sH3Y4
         CvYzHfRtb7SoVx7L1bgkQugm28VObydby3vyYyPm9M9W/K3UY/2PECza1kxPVLyRQAQM
         KbPZCX9Y8PJG9fIdzoFuIuTk4INnppNRBGQGHv+dECgCenOGGC5Hef3GOA0Bfbi5GWB1
         Rv1Tkiciurwlm/64PG6nCmYQ2gJFKeTOuhgeaWPfTJhaDuMdvmxyL/VZesijSYiWXI8F
         dVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TttBCUltyx/MCWMitfeQkl3FeqjlrfXX2hlzOjft3gI=;
        b=lA2MuhmGB/uT2naKPmpnGLVoLVCT4TUwHeTjkbQknk5Yy49qHlnYyhP1GjhkBmgCDU
         K3e8V5BwYpHpe+eEzEhj6gKaiUTPa8htNtKB+sJok3lDXgG94hLyWwsYFvf0ny5+/8u6
         cWOaPNOLo5M3LdM0sWsWUaD31KJCTtV2G4mnOsVz9rAjPXHC6qLipCuuD+KT7bxjOAzd
         cYs9n/MbOxvaWa1psb96XmI1G03okqWjmL6lVHFJNDX/qb/2FKllrYeET94k0+rHjpuA
         QYhSga+gUtSvogVZedIT5YOBk6iEfaGlTJFz4zYxHqc69szCIc+gcCYiC2GnY7Zx4acC
         i7Fg==
X-Gm-Message-State: AOAM531Z3cgC8ztENN745N3tN2UoNznk0tVs+PWR9RQdZfVt0Ps/x8s3
        TJANSPcD4ugwTJO74s9Px4+Y7hH97PF3dZWuKLimEw==
X-Google-Smtp-Source: ABdhPJyXrQnOSY70aA2W5YyJyUTuOwuINYI8oRmcOBhWqk7PPLA/W1YNwyaAqdJBPEct0LUz8fOq1mDkQge2T8RitkM=
X-Received: by 2002:a1f:5e14:: with SMTP id s20mr14805414vkb.63.1595344027281;
 Tue, 21 Jul 2020 08:07:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Jul 2020 20:36:55 +0530
Message-ID: <CA+G9fYtYPA7jHPNB5D+JFHpmtB5+Wj+YG8W33GhffHjmFaMiUg@mail.gmail.com>
Subject: arm: tinyconfig: entry-common.S:156: Error: r13 not allowed here --
 `bic tsk,sp,#(((1<<12)<<1)-1)&~63'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>, vladimir.murzin@arm.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This might add little value.

arm build sets failed on linux next 20200721.
The defconfig ( +config fragments ) builds PASS.
The tinyconfig and allnoconfig FAILED with gcc-8, gcc-9 and gcc-10.

make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j32 ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- HOSTCC=gcc CC="sccache
arm-linux-gnueabihf-gcc" O=build zImage
#
../arch/arm/kernel/entry-common.S: Assembler messages:
../arch/arm/kernel/entry-common.S:156: Error: r13 not allowed here --
`bic tsk,sp,#(((1<<12)<<1)-1)&~63'
../arch/arm/kernel/entry-common.S:243: Error: r13 not allowed here --
`bic tsk,sp,#(((1<<12)<<1)-1)&~63'
make[3]: *** [../scripts/Makefile.build:361:
arch/arm/kernel/entry-common.o] Error 1
../arch/arm/kernel/entry-v7m.S: Assembler messages:
../arch/arm/kernel/entry-v7m.S:60: Error: r13 not allowed here -- `bic
tsk,sp,#(((1<<12)<<1)-1)&~63'
../arch/arm/kernel/entry-v7m.S:86: Error: r13 not allowed here -- `bic
tsk,sp,#(((1<<12)<<1)-1)&~63'
make[3]: *** [../scripts/Makefile.build:361:
arch/arm/kernel/entry-v7m.o] Error 1

full build link,
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/648560264

-- 
Linaro LKFT
https://lkft.linaro.org
