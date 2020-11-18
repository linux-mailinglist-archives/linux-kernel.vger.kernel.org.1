Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA042B80A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgKRPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgKRPfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:35:21 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 742E92477C;
        Wed, 18 Nov 2020 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605713721;
        bh=YIBd7Q8u/sR9Z/z7ziUGOG9UyMZ1x7BkzlRe9c4fu0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=c7R6w1xvBHsSnDJu7YT8x6viO1JnD5yI6BSHhdR7uuZ34NJKvx2RfOb5MyM8IuExa
         addolZX1lpGwTuPVlhsDX57zGz1aNRSQe1r5dSIVn6y0LtUfGoW5EMJkekD8dFtCYT
         ON9nX2GaWz5mSPNepXUyl7Bh0WTIpXLm67FKXKSQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 0/4] tools/bootconfig: Align the bootconfig applied initrd
Date:   Thu, 19 Nov 2020 00:35:17 +0900
Message-Id: <160571371674.277955.11736890010190945946.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 4th version of the bootconfig tool update to align
the total size of initrd + bootconfig to 4.

Previous version is here;

 https://lkml.kernel.org/r/160560676899.144950.4148778261999789656.stgit@devnote2

This version adds a new errno after printf fix patch as [1/4].

To adjust the file size, the bootconfig tool adds padding null
characters in between the boot configuration data and the footer.

The changing points are
- The bootconfig applied initrd image size is aligned to 4.
- To insert the padding null ('\0') bytes, the size in the footer
  can be bigger than the actual bootconfig file size.
- But the max size of the boot configuration file is same, because
  the max size doesn't include the last null characters.

In this series I keep 4 bytes aligned instead of longer size,
because only I could found was that the grub might align the initrd
filesize to 4, and U-Boot/EDK2 would not change it. So I couldn't
say what is the best size.

Anyway, I updated the documentation too, which clearly says that
the above changing points, and if the bootloader pass the wrong
size, kernel will not find bootconfig from the initrd.

Thank you,

---

Masami Hiramatsu (4):
      tools/bootconfig: Fix errno reference after printf()
      tools/bootconfig: Fix to check the write failure correctly
      tools/bootconfig: Align the bootconfig applied initrd image size to 4
      docs: bootconfig: Update file format on initrd image


 tools/bootconfig/main.c             |  109 ++++++++++++++++++++++-------------
 tools/bootconfig/test-bootconfig.sh |    6 ++
 2 files changed, 75 insertions(+), 40 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
