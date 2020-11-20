Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA82BA05F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKTC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgKTC1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:27:13 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AC022267;
        Fri, 20 Nov 2020 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605839232;
        bh=bu0f4nai4GWUco97RbnqLeOuE/BnaVOIzMAKOz8dcGo=;
        h=From:To:Cc:Subject:Date:From;
        b=tJCB/2jLR5QZTBcUBdFU0RkcyuejBn2VL4VHzLLUVVmPw0RtC+rVjetjs9JeKdJ7g
         S4Cevk22LrS95ohBK0p9QPblfD+5K/O2QJkK4pCa3S4DXgMJ+O3WgkHCCQl7JXE+Ax
         kUiw+QG4J4JRdGE3yLM4Jpx0/cy/bkBl6sJgXcHs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 0/3] bootconfig: Make size and checksum fields le32
Date:   Fri, 20 Nov 2020 11:27:09 +0900
Message-Id: <160583922884.546818.17083813931787774050.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a series of patches to make the size and the checksum fields
in the footer le32 instead of u32.

In the thread for alignment series[1], Steve pointed that the current
footer format didn't specify the endianness thus it is hard to apply
the bootconfig for cross-build initrd if the target endianness is
different from the host machine.

I've proposed that the hexadecimal ASCII string in the previous series
[2] but Linus pointed that making it le32 was enough.

So this just make those fields le32.

Thank you,

[1] https://lore.kernel.org/lkml/20201118112249.30d20147@gandalf.local.home/
[2] https://lore.kernel.org/linux-doc/CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com/

---

Masami Hiramatsu (3):
      bootconfig: Load size and checksum in the footer as le32
      tools/bootconfig: Store size and checksum in footer as le32
      docs: bootconfig: Add the endianness of fields


 Documentation/admin-guide/bootconfig.rst |    4 +++-
 init/main.c                              |    4 ++--
 tools/bootconfig/main.c                  |    7 +++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
