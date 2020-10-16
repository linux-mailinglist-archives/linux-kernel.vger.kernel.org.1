Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0144290AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390689AbgJPRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbgJPRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:53:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA81C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:53:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c196so3235455ybf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=q7DWLNuboaXQBizRCQAQyueFvatCQ/DSdeo5vJZMrAY=;
        b=rgKPCbJGLgft+BSGYv5zU9/B8Fy2RR+adQX6+Xf0skJuSDykgcLy8PP/FGtBkOdBVH
         AMijgr+kUt7Uh/XEvDxBd88PmIts4b//UJxphGkJZF1Ff9w+JakMuXNcWxSLmcVtB6pD
         h1cZB00Da89unxkxHrGSVGS3k7Tmd1IruIE5WBsvfYvzRX1Cx7pGVub+I1oLAB5nPt07
         PpAlbde98kNk23Fk9uikgX+xf9/rgGF7ohlQ0t4Tg2lSVlndiphVNJq326MpPER0xCQo
         zRb0fcxyqIgFTxXVplWLPJVFPGERwp2nHs6Nfg0pms8kJHw1PNN2ixfEvAuY4C3w0biJ
         8o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=q7DWLNuboaXQBizRCQAQyueFvatCQ/DSdeo5vJZMrAY=;
        b=Idw7GjOPfCtB6rJr9KGvznVKR6td1ibzWdq7dPc8GVHjhy9uh7ScBqfmetoJAfresM
         esrVihXulYoNeJhLpNnLuPG0cCYgFuofaZRuQWkKT7dYR8eYKJZJiyaP02RCUmr45qpV
         sYGPSx5k1cr9zQfeNSQKPWrdC4ob/qcQ3iPazrXd7AWUI4YvD2DL6NI4UG4Na5FLkqt+
         njczo8ZOF4aBO10+B+tRlMe8TWao+JdXrURzhoX4LxvajPV4DSHKuuHciD/CRtLUTq7K
         fUMriYKwL0kBeSOVC/Q6hRMcAPRj3ZuWly55ZMVNXh6X3fyFNhxq4BQv73xpeItVU6CM
         SqdA==
X-Gm-Message-State: AOAM532uoAXsYU8iG5Ejm940ffWhPMBFZKdRxZbmluJcnSRl6g3Wsmj9
        BYPLdMUbB5r0baOqBxbPDmab0MnSoMCpLW+ChuI=
X-Google-Smtp-Source: ABdhPJxSuVrQnN6q9GhwE9ZaMkTMGQu9k93WTjejDlDTW3Rfwy3zO1f9pPDT45mRIMg3cPkVRP6J9lEdwpAGYIN1t5Y=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:9009:: with SMTP id
 s9mr7105616ybl.471.1602870822453; Fri, 16 Oct 2020 10:53:42 -0700 (PDT)
Date:   Fri, 16 Oct 2020 10:53:39 -0700
Message-Id: <20201016175339.2429280-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] arm64: link with -z norelro regardless of CONFIG_RELOCATABLE
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Smith <Peter.Smith@arm.com>,
        "=?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?=" <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_EXPERT=y, CONFIG_KASAN=y, CONFIG_RANDOMIZE_BASE=n,
CONFIG_RELOCATABLE=n, we observe the following failure when trying to
link the kernel image with LD=ld.lld:

error: section: .exit.data is not contiguous with other relro sections

ld.lld defaults to -z relro while ld.bfd defaults to -z norelro. This
was previously fixed, but only for CONFIG_RELOCATABLE=y.

Cc: stable@vger.kernel.org
Fixes: commit 3bbd3db86470 ("arm64: relocatable: fix inconsistencies in linker script and options")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
While upgrading our toolchains for Android, we started seeing the above
failure for a particular config that enabled KASAN but disabled KASLR.
This was on a 5.4 stable branch.  It looks like
commit dd4bc6076587 ("arm64: warn on incorrect placement of the kernel by the bootloader")
made RELOCATABLE=y the default and depend on EXPERT=y. With those two
enabled, we can then reproduce the same failure on mainline.


 arch/arm64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f4717facf31e..674241df91ab 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,13 +10,13 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=--no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X -z norelro
 
 ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
 # for relative relocs, since this leads to better Image compression
 # with the relocation offsets always being zero.
-LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext -z norelro \
+LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext \
 			$(call ld-option, --no-apply-dynamic-relocs)
 endif
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

