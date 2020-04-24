Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1401B7B45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgDXQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 12:15:40 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:44393 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:15:39 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03OGF5bn016130;
        Sat, 25 Apr 2020 01:15:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03OGF5bn016130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587744905;
        bh=0GlBarUBAH1daR/4vl1e4pT6s8xMorg/RgQVxtJPOkg=;
        h=From:To:Cc:Subject:Date:From;
        b=CQObjc8eQaBXXWcSyWQ7L1swCkbnRNCAHReE8iTyHYanFeMAxVtDv2JldOakeI/+e
         a1QkWuo5GskWbSdCkYylfNS8a4qNUugZUbnVg1QuO5u+AqjRW1+p7aJqwgGxa/xcML
         vVQsktCCnR142NglKiqbEbLHtK2kfoQYob0zgcNllZ58rQfOlARDYVI4870sapCVN0
         mbE3t0qmKWZgeb91EjEj/C+RaGxKsWCB0ZrNwzKnl7zIYXoxn1ndq0CLtG+XQN9BxW
         GNGKwpEZank44r+cO38by7amNlDmXRDmemMvIoBrTdH0eDzvvwgoqRVn6w0mrqOlN1
         YwiSoc7HyDhKg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] hexagon: suppress error message for 'make clean'
Date:   Sat, 25 Apr 2020 01:15:02 +0900
Message-Id: <20200424161502.656103-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make ARCH=hexagon clean' emits an error message as follows:

  $ make ARCH=hexagon clean
  gcc: error: unrecognized command line option '-G0'

You can suppress it by setting the correct CROSS_COMPILE=,
but we should not require any compiler for cleaning.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/hexagon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 4c5858b80f0e..c168c6980d05 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -30,7 +30,7 @@ TIR_NAME := r19
 KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -DTHREADINFO_REG=$(TIR_NAME) -D__linux__
 KBUILD_AFLAGS += -DTHREADINFO_REG=$(TIR_NAME)
 
-LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name 2>/dev/null)
 libs-y += $(LIBGCC)
 
 head-y := arch/hexagon/kernel/head.o
-- 
2.25.1

