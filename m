Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22923212AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgGBRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 13:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGBRMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:12:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C883A20760;
        Thu,  2 Jul 2020 17:12:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr2ke-004AoF-RY; Thu, 02 Jul 2020 13:11:56 -0400
Message-ID: <20200702171016.178196716@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 13:10:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/9] tools lib traceevent: Patches from the trace-cmd repo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

We noticed that the libtraceevent in trace-cmd.git is a bit out of sync with
what is in the kernel. These patches can help bring it by in sync again.

-- Steve

Jan Kiszka (1):
      tools lib traceevent: Add more SVM exit reasons

Steven Rostedt (Red Hat) (2):
      tools lib traceevent: Add API to read time information from kbuffer
      tools lib traceevent: Add plugin for tlb_flush

Tom Zanussi (1):
      tools lib traceevent: Add proper KBUFFER_TYPE_TIME_STAMP handling

Tzvetomir Stoyanov (VMware) (5):
      tools lib traceevent: Add tep_load_plugins_hook() API
      tools lib traceevent: Add interface for options to plugins
      tools lib traceevent: Introduced new traceevent API, for adding new plugins directories.
      tools lib traceevent: Add support for more printk format specifiers
      tools lib traceevent: Optimize pretty_print() function

----
 tools/lib/traceevent/event-parse-local.h  |   22 +-
 tools/lib/traceevent/event-parse.c        | 1004 +++++++++++++++++++++--------
 tools/lib/traceevent/event-parse.h        |   18 +
 tools/lib/traceevent/event-plugin.c       |  261 +++++++-
 tools/lib/traceevent/kbuffer-parse.c      |   43 +-
 tools/lib/traceevent/kbuffer.h            |    2 +
 tools/lib/traceevent/plugins/Build        |    1 +
 tools/lib/traceevent/plugins/Makefile     |    1 +
 tools/lib/traceevent/plugins/plugin_kvm.c |   23 +-
 tools/lib/traceevent/plugins/plugin_tlb.c |   81 +++
 10 files changed, 1182 insertions(+), 274 deletions(-)
 create mode 100644 tools/lib/traceevent/plugins/plugin_tlb.c
