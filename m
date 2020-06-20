Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36A202112
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 05:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFTDpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 23:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFTDpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:45:49 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D175C208DB;
        Sat, 20 Jun 2020 03:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592624749;
        bh=3NEk384KI9ArIRysoQCJRBP7aWUcmSOT9MIIF4rep4E=;
        h=From:To:Cc:Subject:Date:From;
        b=mNfovY4bN8XiNNaYZ3QSuDV8FPfwFJKROWU6dU8kA0Yeol5v/bVii2fVChNIVKivK
         Qv5xiivifP9ZRVdDM4QesXsosHjys98XWqGTPFmBKRBXy/NcIXYgqN7w/oikipYCqw
         IBtpRAWCTzYzAdA15Bl+UpcAGHL2SpR9FYGMUoEU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/2] tracing: Fix config dependency and trigger parser
Date:   Sat, 20 Jun 2020 12:45:44 +0900
Message-Id: <159262474473.185015.177609153974879988.stgit@devnote2>
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

These are some fixes which I found recentry on ftrace.

 - Since the boot-time tracing synthetic event feature is decoupled
   from trigger recenty, it should use CONFIG_SYNTH_EVENT.
 - The parser of event trigger seems rejecting some redundant
   spaces. But it is hard users to find the wrong point. Such
   spaces should be accepted.

BTW, I also found the trigger parser accepts some inputs which
may not correctly formatted, e.g.

 # echo "traceon 1" > events/ftrace/print/trigger

(from the document, it must be "traceon:1")
But I think this does not decrease the usability.

Thank you,

---

Masami Hiramatsu (2):
      tracing/boot: Fix config dependency for synthedic event
      tracing: Fix event trigger to accept redundant spaces


 kernel/trace/trace_boot.c           |    2 +-
 kernel/trace/trace_events_trigger.c |   21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
