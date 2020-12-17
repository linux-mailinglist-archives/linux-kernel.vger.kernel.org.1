Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72542DD265
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgLQNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:46:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57894 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgLQNqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:46:55 -0500
Received: from zn.tnic (p200300ec2f10f600957b9387e8d7e202.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:f600:957b:9387:e8d7:e202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80B2A1EC03FA;
        Thu, 17 Dec 2020 14:46:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608212774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l016qJSbwqpQ92hh6C1qMYdgWn16MEkigDSPdbp2ry8=;
        b=dZaXdjDPwZfFZvbG/Zn8j2TMlyKIkkxTj/8G5QgN8ZAgL3dzd3VInR7yjS9u2ZGAaJRiPE
        1nwHdIE/Blum+Q0kc5EdrnnHBIksFXZ8q6Y34PQliVYcW6r6+8VLS5VF6ZgM3xkaV86mcm
        YySK55cd0EtADPG4lM9ma6HM7/y9PeQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/build: Realign archhelp
Date:   Thu, 17 Dec 2020 14:46:08 +0100
Message-Id: <20201217134608.31811-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217134608.31811-1-bp@alien8.de>
References: <20201217134608.31811-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Realign help text vertically and add spacing so that target help text
is properly separated.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Makefile | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3dae5c90c159..32dcdddc1089 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -292,19 +292,20 @@ archclean:
 	$(Q)$(MAKE) $(clean)=arch/x86/tools
 
 define archhelp
-  echo  '* bzImage      - Compressed kernel image (arch/x86/boot/bzImage)'
-  echo  '  install      - Install kernel using'
-  echo  '                  (your) ~/bin/$(INSTALLKERNEL) or'
-  echo  '                  (distribution) /sbin/$(INSTALLKERNEL) or'
-  echo  '                  install to $$(INSTALL_PATH) and run lilo'
-  echo  '  fdimage      - Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
-  echo  '  fdimage144   - Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
-  echo  '  fdimage288   - Create 2.8MB boot floppy image (arch/x86/boot/fdimage)'
-  echo  '  isoimage     - Create a boot CD-ROM image (arch/x86/boot/image.iso)'
-  echo  '                  bzdisk/fdimage*/isoimage also accept:'
-  echo  '                  FDARGS="..."  arguments for the booted kernel'
-  echo  '                  FDINITRD=file initrd for the booted kernel'
-  echo  '  kvm_guest.config - Enable Kconfig items for running this kernel as a KVM guest'
-  echo  '  xen.config	  - Enable Kconfig items for running this kernel as a Xen guest'
+  echo  '* bzImage		- Compressed kernel image (arch/x86/boot/bzImage)'
+  echo  '  install		- Install kernel using (your) ~/bin/$(INSTALLKERNEL) or'
+  echo  '			  (distribution) /sbin/$(INSTALLKERNEL) or install to '
+  echo  '			  $$(INSTALL_PATH) and run lilo'
+  echo  ''
+  echo  '  fdimage		- Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  fdimage144		- Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  fdimage288		- Create 2.8MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  isoimage		- Create a boot CD-ROM image (arch/x86/boot/image.iso)'
+  echo  '			  bzdisk/fdimage*/isoimage also accept:'
+  echo  '			  FDARGS="..."  arguments for the booted kernel'
+  echo  '                  	  FDINITRD=file initrd for the booted kernel'
+  echo  ''
+  echo  '  kvm_guest.config	- Enable Kconfig items for running this kernel as a KVM guest'
+  echo  '  xen.config		- Enable Kconfig items for running this kernel as a Xen guest'
 
 endef
-- 
2.29.2

