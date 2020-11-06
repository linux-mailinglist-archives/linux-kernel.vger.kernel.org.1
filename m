Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9CA2A8EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKFFOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:14:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56518 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKFFOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:14:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id BD5F01F46653
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/2] arm: lib: xor-neon: Remove warn & disble neon vect
Date:   Fri,  6 Nov 2020 07:14:34 +0200
Message-Id: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This is my attempt to close the loop on a relatively old discussion
[1] caused by a compiler bug [2]. In a nutshell, the Clang build issues
a bogus warning about GCC while it silently botches the neon auto-loop
vectorization. :)

Many thanks to all who have investigated this issue before me. Arnd
posted a workaround for xor.h [3], but I very much like his first
suggestion of disabling the broken feature until the compiler is fixed.

Tested on latest linux next-20201105 using bcm2835 & versatile configs
and Clang 10.0.1

P.S: While testing aarch64/imx8m I also noticed vectorization is broke
there as well, but that deserves its own patch because it's a separate
xor-neon implementation (if this approach is deemed sensible).

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20190528235742.105510-1-natechancellor@gmail.com/
[2] https://bugs.llvm.org/show_bug.cgi?id=40976
[3] https://bugs.llvm.org/show_bug.cgi?id=40976#c6

Kind regards,
Adrian

Adrian Ratiu (1):
  arm: lib: xor-neon: disable clang vectorization

Nathan Chancellor (1):
  arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning

 arch/arm/include/asm/xor.h |  3 ++-
 arch/arm/lib/Makefile      |  3 +++
 arch/arm/lib/xor-neon.c    | 13 +++++--------
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.29.0

