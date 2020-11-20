Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282092BA06A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKTC3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgKTC3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:29:08 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7548722277;
        Fri, 20 Nov 2020 02:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605839348;
        bh=L0i1PUP/F3dMpVmlHNW2iL3VxaUW3T6tdumT5XK5cgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9avDR4r4XsJQSgDX9lpr9smj2geHo0WYGCI4ibyjcJphnOXMxHo0XQg11lQSe5+t
         Iu6U2nvr8I771T2tvGqE/zrQAGrGzdytdAcF3JQDfyJyuKx9yO1fUio3cIE8+6vfJw
         sqmv7UFgAuLCRfj43LUspjklSTcypU8CMF/iCV3I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/3] bootconfig: Load size and checksum in the footer as le32
Date:   Fri, 20 Nov 2020 11:29:04 +0900
Message-Id: <160583934457.547349.10504070298990791074.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160583933538.547349.272918354455492444.stgit@devnote2>
References: <160583933538.547349.272918354455492444.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load the size and the checksum fields in the footer as le32
instead of u32. This will allow us to apply bootconfig to the
cross build initrd without caring the endianness.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 20baced721ad..32b2a8affafd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -288,8 +288,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 found:
 	hdr = (u32 *)(data - 8);
-	size = hdr[0];
-	csum = hdr[1];
+	size = le32_to_cpu(hdr[0]);
+	csum = le32_to_cpu(hdr[1]);
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < initrd_start) {

