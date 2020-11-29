Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561252C78A6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 11:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgK2Kmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 05:42:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgK2Kmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 05:42:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 762D9AC2E;
        Sun, 29 Nov 2020 10:42:09 +0000 (UTC)
Date:   Sun, 29 Nov 2020 11:42:09 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.10-rc6
Message-ID: <20201129104209.GB12056@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull more forwarded EFI urgent fixes.

Thx.

---
The following changes since commit c2fe61d8be491ff8188edaf22e838f819999146b:

  efi/x86: Free efi_pgd with free_pages() (2020-11-10 19:18:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.10-rc5

for you to fetch changes up to 36a237526cd81ff4b6829e6ebd60921c6f976e3b:

  efi: EFI_EARLYCON should depend on EFI (2020-11-25 16:55:02 +0100)

----------------------------------------------------------------
More EFI fixes for v5.10-rc:
- revert efivarfs kmemleak fix again - it was a false positive;
- make CONFIG_EFI_EARLYCON depend on CONFIG_EFI explicitly so it does not
  pull in other dependencies unnecessarily if CONFIG_EFI is not set
- defer attempts to load SSDT overrides from EFI vars until after the
  efivar layer is up.

----------------------------------------------------------------
Amadeusz Sławiński (1):
      efi/efivars: Set generic ops before loading SSDT

Ard Biesheuvel (1):
      efivarfs: revert "fix memory leak in efivarfs_create()"

Geert Uytterhoeven (1):
      efi: EFI_EARLYCON should depend on EFI

 drivers/firmware/efi/Kconfig | 2 +-
 drivers/firmware/efi/efi.c   | 2 +-
 fs/efivarfs/inode.c          | 2 ++
 fs/efivarfs/super.c          | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 36ec1f718893..d9895491ff34 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -270,7 +270,7 @@ config EFI_DEV_PATH_PARSER
 
 config EFI_EARLYCON
 	def_bool y
-	depends on SERIAL_EARLYCON && !ARM && !IA64
+	depends on EFI && SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5e5480a0a32d..6c6eec044a97 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -390,10 +390,10 @@ static int __init efisubsys_init(void)
 
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
 				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
-		efivar_ssdt_load();
 		error = generic_ops_register();
 		if (error)
 			goto err_put;
+		efivar_ssdt_load();
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 96c0c86f3fff..0297ad95eb5c 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -7,6 +7,7 @@
 #include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/ctype.h>
+#include <linux/kmemleak.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
 
@@ -103,6 +104,7 @@ static int efivarfs_create(struct inode *dir, struct dentry *dentry,
 	var->var.VariableName[i] = '\0';
 
 	inode->i_private = var;
+	kmemleak_ignore(var);
 
 	err = efivar_entry_add(var, &efivarfs_list);
 	if (err)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index f943fd0b0699..15880a68faad 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -21,7 +21,6 @@ LIST_HEAD(efivarfs_list);
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
-	kfree(inode->i_private);
 }
 
 static const struct super_operations efivarfs_ops = {

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
