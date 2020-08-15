Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96F24540D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgHOWLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E0B23122;
        Sat, 15 Aug 2020 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500064;
        bh=nTbooeHnOQNWyi9FSAgCRBTzajO/a6wRi+aGZk8krpg=;
        h=From:To:Cc:Subject:Date:From;
        b=z6h07+JlpUWrhQFumuicQbKzh4CeaR0VYBZEkNvFfBXlHpjJbSOmHkdsfrKoENqzj
         vzRYHO6AdXB+b/zqcH16cExNLPauiJzpzUokBSTwGMDwvRBTQlotTuU37dmLezCy7O
         OjHwoxHGphyZrV3GXTMDAP+uwhfqOpwMGA98N0ZQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/6] tools/bootconfig: Add boot-time tracing script
Date:   Sat, 15 Aug 2020 23:01:00 +0900
Message-Id: <159750006069.202708.12439674123720173666.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 2nd version of the series to introduce scripts for the
boot-time tracing. In this version, I just updated 4/6 according to
Steve's comment.

Previous series is here:
 https://lkml.kernel.org/r/159704847064.175360.3292152056631660862.stgit@devnote2


Thank you,

---

Masami Hiramatsu (6):
      tools/bootconfig: Show bootconfig compact tree from bootconfig file
      tools/bootconfig: Add list option
      tools/bootconfig: Make all functions static
      tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig
      tools/bootconfig: Add a script to generates bootconfig from ftrace
      tools/bootconfig: Add --init option for bconf2ftrace.sh


 MAINTAINERS                              |    1 
 tools/bootconfig/main.c                  |  147 +++++++++++++-----
 tools/bootconfig/scripts/bconf2ftrace.sh |  199 ++++++++++++++++++++++++
 tools/bootconfig/scripts/ftrace.sh       |  109 +++++++++++++
 tools/bootconfig/scripts/ftrace2bconf.sh |  244 ++++++++++++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh          |   57 +++++++
 6 files changed, 715 insertions(+), 42 deletions(-)
 create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
 create mode 100644 tools/bootconfig/scripts/ftrace.sh
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh
 create mode 100644 tools/bootconfig/scripts/xbc.sh

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
