Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF819C6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbgDBQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 12:17:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389458AbgDBQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:17:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA61EAE50;
        Thu,  2 Apr 2020 16:17:33 +0000 (UTC)
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt_elf: remove redundant elf_map ifndef
Date:   Thu,  2 Apr 2020 18:15:43 +0200
Message-Id: <20200402161543.4119-1-ailiop@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ifndef was added a long time ago to support archs that would define
their own mapping function. The last user was the metag arch which was
removed from the tree, and as such there are no users left. Let's kill
it.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/binfmt_elf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e82..89428c9732c4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -346,8 +346,6 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	return 0;
 }
 
-#ifndef elf_map
-
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -387,8 +385,6 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
-#endif /* !elf_map */
-
 static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
 {
 	int i, first_idx = -1, last_idx = -1;
-- 
2.16.4

