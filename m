Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC941B83DA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYFrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 01:47:45 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:55920 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYFrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:47:45 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03P5l4L9017497;
        Sat, 25 Apr 2020 14:47:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03P5l4L9017497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587793625;
        bh=9lkXFEvtGlkYPvIYcRpnWYNpi83t6Gjxvz28e7hf/RE=;
        h=From:To:Cc:Subject:Date:From;
        b=jX7215SxQFAOrpxTFJSC0ARxP7N8K59iteGl167e+IXIY0PZhrtxCORqZAdxpuPHw
         +PHk227tlHzAGf87Swb7cpETuFu4os7tyVA06XTC7XgB1F3pErDi4NF2wHMrajVrUg
         /5PHLp1E3bcffRaqzGqoE+77W08d1iRSmWV5VprZ5hoWGPdcbepUzRmXFuv9LsJUC9
         avuHuFUJfBY/BcVTfHaePPP6G0bgyFXu1Q2G4wHGDvY+StiRDtgaMkYg5H1QypUYKS
         9TuuC+uOQgMqj9Mz0AjQ8yF+K6xslabdhGFh59r0nW9ltgOmfPV83/qCen58i8Zbds
         QuoPQqHelr82g==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] parisc: suppress error messages for 'make clean'
Date:   Sat, 25 Apr 2020 14:46:59 +0900
Message-Id: <20200425054659.814774-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make ARCH=parisc clean' emits a tons of error messages as follows:

  $ make ARCH=parisc clean
  gcc: error: unrecognized command line option '-mno-space-regs'
  gcc: error: unrecognized command line option '-mfast-indirect-calls'; did you mean '-mforce-indirect-call'?
  gcc: error: unrecognized command line option '-mdisable-fpregs'
  gcc: error: missing argument to '-Wframe-larger-than='
  gcc: error: unrecognized command line option '-mno-space-regs'
  gcc: error: unrecognized command line option '-mfast-indirect-calls'; did you mean '-mforce-indirect-call'?
  gcc: error: unrecognized command line option '-mdisable-fpregs'
  gcc: error: missing argument to '-Wframe-larger-than='
    ...

You can supporess them except '-Wframe-larger-than' by setting correct
CROSS_COMPILE=, but we should not require any compiler for cleaning.

This $(shell ...) is evaluated so many times because LIBGCC is exported.
Use the ':=' operator to evaluate it just once, and sink the stderr.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 628cd8bb7ad8..d82787da43cd 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -21,7 +21,7 @@ KBUILD_IMAGE := vmlinuz
 
 NM		= sh $(srctree)/arch/parisc/nm
 CHECKFLAGS	+= -D__hppa__=1
-LIBGCC		= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+LIBGCC		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name 2>/dev/null)
 export LIBGCC
 
 ifdef CONFIG_64BIT
-- 
2.25.1

