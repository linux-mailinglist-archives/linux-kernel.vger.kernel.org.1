Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE525758A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHaIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 04:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHaIhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:37:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 470B8B5B1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:37:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     jeyu@suse.de
Subject: [PATCH] module: Add more error message for failed kernel module loading
Date:   Mon, 31 Aug 2020 16:37:05 +0800
Message-Id: <20200831083705.20807-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel module loading failed, user space only get one of the
following error messages:
- -ENOEXEC
  This is the most confusing one. From corrupted ELF header to bad
  WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
  all returns this error number.

- -EPERM
  This is for blacklisted modules. But mod doesn't do extra explain
  on this error either.

- -ENOMEM
  The only error which needs no explain.

This means, if a user got "Exec format error" from modprobe, it provides
no meaningful way for the user to debug, and will take extra time
communicating to get extra info.

So this patch will add extra error messages for -ENOEXEC and -EPERM
errors, allowing user to do better debugging and reporting.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel/module.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 8fa2600bde6a..204bf29437b8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2068,8 +2068,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 	int i;
 
 	for (i = 0; i < hdr->e_shnum; i++) {
-		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
+			pr_err(
+			"Module %s section %d has invalid WRITE|EXEC flags\n",
+				mod->name, i);
 			return -ENOEXEC;
+		}
 	}
 
 	return 0;
@@ -3797,8 +3801,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	char *after_dashes;
 
 	err = elf_header_check(info);
-	if (err)
+	if (err) {
+		pr_err("Module has invalid ELF header\n");
 		goto free_copy;
+	}
 
 	err = setup_load_info(info, flags);
 	if (err)
@@ -3806,6 +3812,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	if (blacklisted(info->name)) {
 		err = -EPERM;
+		pr_err("Module %s is blacklisted\n", info->name);
 		goto free_copy;
 	}
 
-- 
2.28.0

