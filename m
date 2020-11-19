Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D752B94AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgKSOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgKSOcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:32:05 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5BF24698;
        Thu, 19 Nov 2020 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605796324;
        bh=92Xo3XX0A9aX2YZjJ6Dw2mrAOtyQpgkTytlRW5htnF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3SbU4I46hbnvVwNfsKyGmgOubHdTVzXNMGg6j8AAWmn0YSGckjfsLxG4bocn1cWM
         PmVmN7mNMlwh9sfcGZ9UWDcR27sSaMN3RcgDbh24EaNGr78avWuGIzDuJ/gTFVooaq
         zFn7mpiITtU5zUuWINBE6qOCaMJgk3k7/XMS/e7I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 3/3] docs: bootconfig: Use hexadecimal ASCII string for size and checksum
Date:   Thu, 19 Nov 2020 23:32:00 +0900
Message-Id: <160579632075.503380.14698462910603491212.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160579629161.503380.9118263439060046721.stgit@devnote2>
References: <160579629161.503380.9118263439060046721.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the bootconfig format more platform independent, use
8-bytes hexadecimal ASCII string for size and checksum field
in the footer. This will allow us to apply bootconfig to the
cross build initrd without caring the endianness.

This commit updates the document to define the format.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 363599683784..1c6d6919d9e6 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -140,7 +140,11 @@ Since the boot configuration file is loaded with initrd, it will be added
 to the end of the initrd (initramfs) image file with padding, size,
 checksum and 12-byte magic word as below.
 
-[initrd][bootconfig][padding][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+[initrd][bootconfig][padding][size][checksum][#BOOTCONFIG\n]
+
+The size and checksum fields are 8 bytes hexadecimal ASCII numbers fully
+padded with '0' on the left to the full width of the field, for example,
+the integer 1234 is represented by the ASCII string "000004d2".
 
 When the boot configuration is added to the initrd image, the total
 file size is aligned to 4 bytes. To fill the gap, null characters

