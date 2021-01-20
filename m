Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58C2FCAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 07:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbhATGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 01:14:02 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:25185 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbhATGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:11:31 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 10K68VnI013544;
        Wed, 20 Jan 2021 15:08:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 10K68VnI013544
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611122912;
        bh=s4gVpJxfJJe/A/dUoK7kHuR6SveUAfHv8pd40gw1mj0=;
        h=From:To:Cc:Subject:Date:From;
        b=tANFV1JGEfWCuui6jNDgVLjrw1JX5asYrL40cDHMdmH7BNAbYIaL+zsgwLbJJwmHd
         qkvVYRiJSrrbzY4OCy2hNznqW91FKQSNd0lO/UyWtoPLcF+J/Gu2Gc1RRVstM7ClL+
         1dKInSrfYwuoLuvEq/sDPcBK/PuS8eTqma6mrycW2veRbJw8pIHO/edz/gAMgwr5fM
         QIc7QjzZqK5UvMoijwyb7Y8ewJYSuRfgMTUZYhldOQ0gsdpPUJ9CyEU72XN5MavsZX
         kIjf6ZtfGb7a/nIox1q5A+QPjNU1+Ja5IsPu/qcAjrSKT2OlLORPVtzZfNCStUPIOh
         zizR95NJ1RJzQ==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Bill Wendling <morbo@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vdso: remove unneded extra-y addition
Date:   Wed, 20 Jan 2021 15:08:25 +0900
Message-Id: <20210120060825.3009321-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdso linker script is prepocessed on demand. Adding it to 'targets'
is enough, and line 13 of this Makefile does that. This extra-y addition
is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.11-rc1

 arch/arm/vdso/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index b558bee0e1f6..7c9e395b77f7 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -23,7 +23,6 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	    -T
 
 obj-$(CONFIG_VDSO) += vdso.o
-extra-$(CONFIG_VDSO) += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 CFLAGS_REMOVE_vdso.o = -pg
-- 
2.27.0

