Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7E2B4AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgKPQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbgKPQWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:22:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EE9221F8;
        Mon, 16 Nov 2020 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605543762;
        bh=eR6zscg6Arl9FkK3Ha9/NugV/OqQXgk3kCRiYPBAcP8=;
        h=From:To:Cc:Subject:Date:From;
        b=UmssQ+viTqgDUXTa8cBHcq5ipZuUh+sFr+34ecU9Czjexi/4QawVTtPJZ89pqcs4t
         F17wmdp3RMhhJYFBv8jCk9uBiNPwhqrPY1CdvJj51sl9EDGxd2GKsxNw5S0Bdac+F7
         Q1YgSn5kEEg0xvN7FTp+0DiwSC+pwN+lpidvJZCU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 0/2] tools/bootconfig: Align the bootconfig applied initrd
Date:   Tue, 17 Nov 2020 01:22:38 +0900
Message-Id: <160554375807.96595.16142008590130221699.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 2nd version of the bootconfig tool update to align
the total size of initrd +  bootconfig to 4.

In this version, I've fixed to count the footer size into the
total file size.

To adjust the file size, the bootconfig tool adds padding null
characters in between the boot configuration data and the footer.

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


 tools/bootconfig/main.c             |   36 ++++++++++++++++++++++++++++++-----
 tools/bootconfig/test-bootconfig.sh |    6 +++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
