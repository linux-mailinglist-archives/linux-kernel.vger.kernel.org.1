Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840C82B487B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgKPPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKPPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:05:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A60238E6;
        Mon, 16 Nov 2020 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605539147;
        bh=B25/AykvsH7pIjcKE7T5hO3i16WXyq68Ok3+3xJEM4w=;
        h=From:To:Cc:Subject:Date:From;
        b=q8NUMy6mPGhMrO7+yE6wTUbbBouMeVyRUefsIfBy9PTK/PPyloIRtB6P3v0uPXT8D
         xsHTQ4CK0MjEIJL/+qvNqUj0X20eSwloVfZ2qDIzXRNEws3lshfnchtACyQ/MSlCpK
         9UIYCpBK1mKgRCd/dqy8XnrF29vpIMpzuoddjSOo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/2] tools/bootconfig: Align the bootconfig applied initrd
Date:   Tue, 17 Nov 2020 00:05:43 +0900
Message-Id: <160553914311.90558.426504572691633862.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This updates bootconfig tool to align the total size of initrd + 
bootconfig to 4. To adjust the file size, the bootconfig tool
adds padding null characters in between the boot configuration
data and the footer.

This series include Documentation update. The changing points are
- The bootconfig applied initrd image size is aligned to 4.
- To insert the padding null ('\0') bytes, the size in the footer
  can be bigger than the actual bootconfig file size.
- But the max size of the boot configuration file is same, because
  the max size doesn't include the last null characters.

For this version I decided to keep 4 bytes aligned rather than
longer size. It will be easy to expand it to e.g. 32 bytes (in this
series, we just need to update 3 locations of the code), but I
couldn't find any reason to expand it. Only I could found was
that the grub can align the filesize to 4, and U-Boot/EDK2 will
not change it. So I couldn't say what is the best size.

Anyway, I updated the documentation too, which clearly says that
the above changing points, and if the bootloader pass the wrong
size, kernel will not find bootconfig from the initrd.

Thank you,

---

Masami Hiramatsu (2):
      tools/bootconfig: Align the bootconfig applied initrd image size to 4
      Documentation: bootconfig: Update file format on initrd image


 Documentation/admin-guide/bootconfig.rst |   18 ++++++++++++----
 include/linux/bootconfig.h               |    1 +
 tools/bootconfig/main.c                  |   33 +++++++++++++++++++++++++-----
 tools/bootconfig/test-bootconfig.sh      |    6 +++++
 4 files changed, 47 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
