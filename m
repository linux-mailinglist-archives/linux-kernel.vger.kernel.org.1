Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C875299965
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392394AbgJZWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392365AbgJZWOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:14:12 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E3720878;
        Mon, 26 Oct 2020 22:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603750451;
        bh=5HgpGay1769N+hQB4R88C35uikGXhoSToFZ6LUeyRC0=;
        h=From:To:Cc:Subject:Date:From;
        b=T5MJEepbCL3JfYHXBO8rcIE1dYVpKP2U5MbdM6RzPu9B6PvmY5MVCSVKxKZ0Sol+P
         vl3Qjbua7V8JUNdtkFIZY2WD2qH7PoA/n2Vpz9tAZedEkziCpIjp/+VH+rNc7Ge/Pl
         Gx95gbbn3ePFg3Sx2Kdk7fflMPPAZruZpCIS92fQ=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: atags_compat: avoid -Warray-bounds warning
Date:   Mon, 26 Oct 2020 23:13:16 +0100
Message-Id: <20201026221406.3897734-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 reports a struct member overflow when copying a string
into a single-character array:

In file included from arch/arm/kernel/atags_compat.c:17:
In function 'strcpy',
    inlined from 'build_tag_list' at arch/arm/kernel/atags_compat.c:200:2:
include/linux/string.h:287:29: warning: '__builtin_strcpy' offset 108 from the object at 'taglist' is out of the bounds of referenced subobject 'cmdline' with type 'char[1]' at offset 108 [-Warray-bounds]
  287 | #define __underlying_strcpy __builtin_strcpy
      |                             ^
include/linux/string.h:481:10: note: in expansion of macro '__underlying_strcpy'
  481 |   return __underlying_strcpy(p, q);
      |          ^~~~~~~~~~~~~~~~~~~
In file included from arch/arm/include/asm/setup.h:14,
                 from arch/arm/kernel/atags_compat.c:20:
arch/arm/kernel/atags_compat.c: In function 'build_tag_list':
arch/arm/include/uapi/asm/setup.h:127:7: note: subobject 'cmdline' declared here
  127 |  char cmdline[1]; /* this is the minimum size */
      |       ^~~~~~~

The code is otherwise correct, so just shut up the warning by
not letting the compiler see the underlying type.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/atags_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index 10da11c212cc..3f1f631763ba 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -197,7 +197,7 @@ static void __init build_tag_list(struct param_struct *params, void *taglist)
 	tag->hdr.tag = ATAG_CMDLINE;
 	tag->hdr.size = (strlen(params->commandline) + 3 +
 			 sizeof(struct tag_header)) >> 2;
-	strcpy(tag->u.cmdline.cmdline, params->commandline);
+	strcpy((void*)&tag->u, params->commandline);
 
 	tag = tag_next(tag);
 	tag->hdr.tag = ATAG_NONE;
-- 
2.27.0

