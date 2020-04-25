Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376871B83DB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYFtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 01:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYFtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:49:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF2C720724;
        Sat, 25 Apr 2020 05:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587793744;
        bh=4NqYWINnuunoPX9IvhIS+iUNF07BaWx/NUJI+gPGKo8=;
        h=From:To:Cc:Subject:Date:From;
        b=18e56uqerNIa5cd05qoAqdyf50xBj1VyTF05WOx408I+54UotE/qO9JkXPztbA7Kf
         n1k4u079z/SAGEVZmIjMVq/xcYfSBNjSFSnwCfbHw70VciTjWdLu/OGWMKtUfMR0jl
         iY4wTNGVfdtwd9XmAlitjXi3V8io/E4PxT869ppw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/3] tracing/kprobes: Fix event generation API etc.
Date:   Sat, 25 Apr 2020 14:48:59 +0900
Message-Id: <158779373972.6082.16695832932765258919.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are bugfix/cleanup patches for the kprobe tracer, [1/3]
is a typo fix, [2/3] is fixing boot-time tracer and [3/3] is
error checking for the new in-kernel kprobe event API.

Tom, I found that your commit 29a154810546 ("tracing: Change
trace_boot to use kprobe_event interface") broke the boot-time
tracer's kprobe event because of wrong API usage. Could you
review it?

I marked [3/3] as a bugfix, because if the loc == NULL, 
__kprobe_event_gen_cmd_start() obviously does not work.
But it reports actual error at kprobe_event_gen_cmd_end().
That is not good for developers to debug it.

Thank you,

---

Masami Hiramatsu (3):
      tracing/kprobes: Fix a double initialization typo
      tracing/boottime: Fix kprobe event API usage
      tracing/kprobes: Reject new event if loc is NULL


 kernel/trace/trace_boot.c   |   20 ++++++++------------
 kernel/trace/trace_kprobe.c |    8 +++++++-
 2 files changed, 15 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
