Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE012B0B42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKLR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgKLR1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:27:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3C0206E3;
        Thu, 12 Nov 2020 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605202055;
        bh=urU3aH0It6scRF1tkqFLeTyV8ysZWvq0v8UlroBr8Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/uHxEx13+TaKej0WaPFvrkDuQCUiZ2sQzBRKI5tLFCj9VuJ8RDgYEBeTov2e81MB
         q1epoKj3tmae+JCzeKYjj+vt0vsgUX3Sqjhbusgwn8bd8NA5ZCbQfAiFQvRlhx6m5F
         M5ZFiY4eHsWqrlzaAQkKTf/CkGljMvbo0cz5U6Ks=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Extend the magic check range to the preceding 3 bytes
Date:   Fri, 13 Nov 2020 02:27:31 +0900
Message-Id: <160520205132.303174.4876760192433315429.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org>
References: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Grub may align the size of initrd to 4 if user pass
initrd from cpio, we have to check the preceding 3 bytes as well.

Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
Reported-by: Chen Yu <yu.chen.surf@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 130376ec10ba..20baced721ad 100644
--- a/init/main.c
+++ b/init/main.c
@@ -269,14 +269,24 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 	u32 size, csum;
 	char *data;
 	u32 *hdr;
+	int i;
 
 	if (!initrd_end)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
-	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
-		return NULL;
+	/*
+	 * Since Grub may align the size of initrd to 4, we must
+	 * check the preceding 3 bytes as well.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (!memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
+			goto found;
+		data--;
+	}
+	return NULL;
 
+found:
 	hdr = (u32 *)(data - 8);
 	size = hdr[0];
 	csum = hdr[1];

