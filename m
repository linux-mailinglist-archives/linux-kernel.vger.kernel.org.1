Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22299271796
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgITTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:33:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgITTdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:33:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E234CAD49;
        Sun, 20 Sep 2020 19:33:49 +0000 (UTC)
Date:   Sun, 20 Sep 2020 21:33:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.9-rc6
Message-ID: <20200920193312.GD13044@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single EFI/urgent fix. I'm simply forwarding Ard's tag, I hope
that's ok.

Thx.

---

The following changes since commit fb1201aececc59990b75ef59fca93ae4aa1e1444:

  Documentation: efi: remove description of efi=old_map (2020-08-20 11:18:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.9-rc5

for you to fetch changes up to 46908326c6b801201f1e46f5ed0db6e85bef74ae:

  efi: efibc: check for efivars write capability (2020-09-15 18:22:47 +0300)

----------------------------------------------------------------
Single EFI fix for v5.9-rc:
- ensure that the EFI bootloader control module only probes successfully
  on systems that support the EFI SetVariable runtime service

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: efibc: check for efivars write capability

 drivers/firmware/efi/efibc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 35dccc88ac0a..15a47539dc56 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -84,7 +84,7 @@ static int __init efibc_init(void)
 {
 	int ret;
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (!efivars_kobject() || !efivar_supports_writes())
 		return -ENODEV;
 
 	ret = register_reboot_notifier(&efibc_reboot_notifier);

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
