Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376B92589E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIAH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 03:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAH5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:57:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB202078B;
        Tue,  1 Sep 2020 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598947025;
        bh=8rOIdZ6wqgc1jq2tHq0/nusm6CFDfSurOY8zud5UQN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VnCZ9ODWJSNR2K0P132KUmk4iDZzcB0DAU9G4uV2YhqXXt6S7t+DnEmHgi9IXJ5v
         DaC/KhykMGqU3jGfkX5O3ROGmC3ACO7waOPj1A3y/E3ZbAvoT/yFlM99rZUPj4IJZZ
         AzjokBFbWkIN3HtmAIdDS3BoaRHkRvIhtxsv6kBY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 3/6] Documentation: tracing: Add tracing_on option to boot-time tracer
Date:   Tue,  1 Sep 2020 16:57:01 +0900
Message-Id: <159894702098.1478826.5410550411432650906.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159894698993.1478826.2813843560314595660.stgit@devnote2>
References: <159894698993.1478826.2813843560314595660.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracing_on option description to the boot-time tracer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index dcb390075ca1..1341b449acaa 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -61,6 +61,10 @@ These options can be used for each instance including global ftrace node.
 ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]]
    Enable given ftrace options.
 
+ftrace.[instance.INSTANCE.]tracing_on = 0|1
+   Enable/Disable tracing on this instance when boot.
+   (you can enable it by the "traceon" event trigger action)
+
 ftrace.[instance.INSTANCE.]trace_clock = CLOCK
    Set given CLOCK to ftrace's trace_clock.
 

