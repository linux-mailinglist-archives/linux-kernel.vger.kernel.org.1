Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E278725799D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgHaMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 08:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:45:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14342073A;
        Mon, 31 Aug 2020 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598877956;
        bh=8rOIdZ6wqgc1jq2tHq0/nusm6CFDfSurOY8zud5UQN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSvjY00nngC1TPHjSpUATD6l8D/Sl2/MzPfM50BAfgXg+ZlHq6JZ3nihC/s9Rw56b
         YDEGy92KSAzXPL8RG2kur8aqSw+5HbXZdz6lBgXIxbOcllF9r4BTQpoiaNhLBLJ3Z1
         b6GFmfGPWZx4/HqYvExo86YzuVRcRnWSKhbCo4Ko=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/6] Documentation: tracing: Add tracing_on option to boot-time tracer
Date:   Mon, 31 Aug 2020 21:45:52 +0900
Message-Id: <159887795239.1330989.17724824075048692028.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159887792384.1330989.5993224243767476896.stgit@devnote2>
References: <159887792384.1330989.5993224243767476896.stgit@devnote2>
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
 

