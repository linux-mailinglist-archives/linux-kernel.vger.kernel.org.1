Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2092C887C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgK3Pnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgK3Pnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:43:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bo9so22554702ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oA+fEndH75xbc0OixuyB04zTGqn2xK8SCRoPv3aj8MA=;
        b=VlcNZOAfjG+HQtuk6fo/9fQYCKuyQe9rEUMGaXLAE234oriJbsuS8G0ndef2EOr1yb
         VJ4KUbD71vRQHQe8MDYNycwA4O9YAjb39MNqTiIs/MSqJYDvo7JikfTDne0V57Q+de7B
         PKMmo6qDGbpFVx8bOAxWsXSdN0L0EwFT2EowUojI0OEUqB+RCXruGOYpqE1N0bbogg96
         AZX/DMmr5Oxr7toDJmZxhQsfkG6Kod1CVOiyW5Lqop2KDD1eWz0DnHudMthYfQR4qZm8
         aLIpmD5/Y5zc3dmB3t5bEzDcersDawsMQLwjhv+s6iy9etYwaDox0hUVC72dkwuhnyhV
         L97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oA+fEndH75xbc0OixuyB04zTGqn2xK8SCRoPv3aj8MA=;
        b=H6vFMDi61ATGF0mHLeU3dxOZfcjWbz7+Whn4ZHYpPuqmZHmt3BNVCWzActAVHPt01/
         FzE0cvb6F8SBY6GZWjZvYCUsUbtAm/LUm6ahpJHAbUaTD0zfsk2G/czbQsFzEzA2ZNnk
         Obss1klf1Am2t99HN818sxV/G1LFGMn/hSs3xdFgaNcA+OTCDjYXra3wYTEOSDbWDJND
         1G1rtFj77N4LRFLzlEPTQ03AEbINE5+JuKXVyNz0sklaZTLTjQYTuRU5V8opCrVjD+2q
         pIHrPtZS6Qmx2psEmMj7HQUTl/HZCnQPQqGYKqZx3Bxz0J76TWmmcs8W5xEk5rqiqPHO
         EsUA==
X-Gm-Message-State: AOAM533sVcf/R1nuKKnHdtbgHYtrXXd91BbOv4khuhvHuad3JWkvvFlZ
        WIbKjqtQHJGwYvFTFIo671BFWyIFC5L2WzukrEaDCQ==
X-Google-Smtp-Source: ABdhPJzQfSIa9uM7M8D0mUHtBGmywxzFSREkGpnVtMnJ5xHF1SFnvIRFVybpn/ikF+SwaJaDcb0A2i/02ui2Ff/Kmqk=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr21284947ejg.503.1606750990014;
 Mon, 30 Nov 2020 07:43:10 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 30 Nov 2020 21:12:58 +0530
Message-ID: <CA+G9fYuTS-Kmwy4wfNrFMLnon0v5No3KQeu262c9L91wOrcxkA@mail.gmail.com>
Subject: [next] arm64: mte.c:176:17: error: 'struct thread_struct' has no
 member named 'sctlr_tcf0'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>, andreyknvl@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Collingbourne <pcc@google.com>, steven.price@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next tag 20201130 arm64 build failed due to below error,
  - gcc-9, gcc-10 and clang-10 build FAIL
  - gcc-8 build PASS.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/tmp ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc'
arch/arm64/kernel/mte.c: In function 'set_sctlr_el1_tcf0':
arch/arm64/kernel/mte.c:176:17: error: 'struct thread_struct' has no
member named 'sctlr_tcf0'
  176 |  current->thread.sctlr_tcf0 = tcf0;
      |                 ^
At top level:
arch/arm64/kernel/mte.c:168:13: warning: 'set_sctlr_el1_tcf0' defined
but not used [-Wunused-function]
  168 | static void set_sctlr_el1_tcf0(u64 tcf0)
      |             ^~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:283: arch/arm64/kernel/mte.o] Error 1
make[3]: Target '__build' not remade because of errors.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

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
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1l0FGU7GBRQu6kT79iDAwsHkQ6d/config


-- 
Linaro LKFT
https://lkft.linaro.org
