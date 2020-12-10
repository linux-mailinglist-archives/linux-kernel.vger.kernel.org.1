Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AB2D6353
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbgLJRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgLJRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:18:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA77C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:18:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id k4so6360461edl.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=MW8U021JzvFtVr7JpE11QNz129nE9ceQfCdsjjgn81w=;
        b=ST7OI3KGaXKCNv/I237cXBj0OAK0RBYvyqCOFoCzO3tAGApnfC9ghRWyg1y7VVSnLG
         H0B1p+NPNv4HoGgvjH5LsUZHHkmyCpkj47LeKoRVgq6IiIXuVQaDg1/W38ty0jNWBpvc
         tAsRX3a6hnyuO08KIf6cByVBtDIZ7gtZdtgBOVGXjxlQbQIq2kDnFU/IrTGVIAIYARpc
         hGsOlVUv1YheyYpo5mAWUi4bDzeiZDi+sQ4xYsPKdOznhojOMGArglM8jrfSRE/OwJWT
         y/sEjWUoqFH8K+xPAd/BWlGhR7dZ0wE1lbVFgSCXpUWEXL0wyNtf/cRXmv7T6HoQaasJ
         Kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MW8U021JzvFtVr7JpE11QNz129nE9ceQfCdsjjgn81w=;
        b=ZiWnG1aO5APp1mvOEaEXEtEhaCWrogyeFuSgbAKmNmj527J9WG1/WV2UCf+uZGeuvp
         VkQgfqYl5rzsNe+v2csU23zg1Xf38a56I4l4JtE2+inuMBodv7RyaA7X0fIhi+JEdn+m
         z+PspNzJcbv8PwIe0VhPi/wp55tpeg8TSriccZRJRD59o9PugJQpeVpjZAPzRA0BoejC
         5pAzpkTLLPNERPNBd0EA5MPoddPQOB+Hw4dAC91wXb3tdy4fiY9gXbCskmTkAJWs4H+I
         w1Fc1Uz7bYLs50Rjg+DkuVkxM4QMhS29hise+uDFJ2y0JmbqiJ5+f/ZdwVHRCNzuhtHi
         2eIw==
X-Gm-Message-State: AOAM533dBRy+jOI1JhSZ2oYJJ/ziU/Goy/Vfmn/bZSeIZwj8COJuAd0S
        jG3lyz0F9cAQwOAjYJq0HKqToyqKYlilesnpXoVQRQ==
X-Google-Smtp-Source: ABdhPJzWSjwxcK67hNpBmR+Vaca3Qj/zbj/zXXxxijocSkPnZ2+VAaU0fCznV/D1ZFAWfSAihYXHmtF2wV20NjUJ8eA=
X-Received: by 2002:aa7:d75a:: with SMTP id a26mr7637348eds.230.1607620694590;
 Thu, 10 Dec 2020 09:18:14 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Dec 2020 22:48:03 +0530
Message-ID: <CA+G9fYuRHoZsW9KyRJVGrXznB8dbt5+ZZTMCpK+3mqcuwHcSMw@mail.gmail.com>
Subject: MIPS + clang-11 + allnoconfig / tinyconfig builds failed
To:     linux-mips@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        tsbogend@alpha.franken.de, xie.he.0141@gmail.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have setup clang build and found that,
MIPS + clang-11 + allnoconfig  build failed
MIPS + clang-11 + tinyconfig  build failed

MIPS + clang-10 + allnoconfig  build failed
MIPS + clang-10 + tinyconfig  build failed

We have noticed these build failures on
 - stable-4.19
 - stable-5.4
 - stable-5.9
 - mainline
 - next-master

FYI, The defconfig builds are successful.
BTW, May I know what are the configs you build often ?

Steps to reproduce build failure:
-----------------------------------------
# sudo pip3 install -U tuxmake
# tuxmake --runtime docker --target-arch mips --toolchain clang-11
--kconfig allnoconfig
# tuxmake --runtime docker --target-arch mips --toolchain clang-11
--kconfig tinyconfig

Build failed log:
ake --silent --keep-going --jobs=16
O=/home/tuxbuild/.cache/tuxmake/builds/2/tmp ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang' allnoconfig
make --silent --keep-going --jobs=16
O=/home/tuxbuild/.cache/tuxmake/builds/2/tmp ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'
/builds/1kl9SVppm6wRdzlQ3UcQKIBaUrx/arch/mips/vdso/elf.S:14:1:
warning: DWARF2 only supports one section per compilation unit
.pushsection .note.Linux, "a",@note ; .balign 4 ; .long 2f - 1f ;
.long 4484f - 3f ; .long 0 ; 1:.asciz "Linux" ; 2:.balign 4 ; 3:
^
/builds/1kl9SVppm6wRdzlQ3UcQKIBaUrx/arch/mips/vdso/elf.S:34:2:
warning: DWARF2 only supports one section per compilation unit
 .section .mips_abiflags, "a"
 ^
/builds/1kl9SVppm6wRdzlQ3UcQKIBaUrx/arch/mips/lib/uncached.c:45:6:
warning: variable 'sp' is uninitialized when used here
[-Wuninitialized]
        if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
            ^~
/builds/1kl9SVppm6wRdzlQ3UcQKIBaUrx/arch/mips/lib/uncached.c:40:18:
note: initialize the variable 'sp' to silence this warning
        register long sp __asm__("$sp");
                        ^
                         = 0
1 warning generated.
WARNING: modpost: vmlinux.o(.text+0x1a124): Section mismatch in
reference from the function r4k_cache_init() to the function
.init.text:loongson3_sc_init()
The function r4k_cache_init() references
the function __init loongson3_sc_init().
This is often because r4k_cache_init lacks a __init
annotation or the annotation of loongson3_sc_init is wrong.
WARNING: modpost: vmlinux.o(.text+0x1f1c8): Section mismatch in
reference from the function mips_sc_init() to the function
.init.text:mips_sc_probe()
The function mips_sc_init() references
the function __init mips_sc_probe().
This is often because mips_sc_init lacks a __init
annotation or the annotation of mips_sc_probe is wrong.
FATAL: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
make[2]: *** [/builds/1kl9SVppm6wRdzlQ3UcQKIBaUrx/scripts/Makefile.modpost:59:
vmlinux.symvers] Error 1

--
Linaro LKFT
https://lkft.linaro.org
