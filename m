Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189B21C9BC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgEGUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 16:09:36 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:51086
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728685AbgEGUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:09:34 -0400
X-IronPort-AV: E=Sophos;i="5.73,365,1583190000"; 
   d="scan'208";a="348061030"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 07 May 2020 22:09:32 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Subject: [PATCH] tracing/probe: reverse arguments to list_add
Date:   Thu,  7 May 2020 21:30:08 +0200
Message-Id: <1588879808-24488-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elsewhere in the file, the function trace_kprobe_has_same_kprobe uses
a trace_probe_event.probes object as the second argument of
list_for_each_entry, ie as a list head, while the list_for_each_entry
iterates over the list fields of the trace_probe structures, making
them the list elements.  So, exchange the arguments on the list_add
call to put the list head in the second argument.

Since both list_head structures were just initialized, this problem
did not cause any loss of information.

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ab8b6436d53f..b8a928e925c7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1006,7 +1006,7 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 	INIT_LIST_HEAD(&tp->event->class.fields);
 	INIT_LIST_HEAD(&tp->event->probes);
 	INIT_LIST_HEAD(&tp->list);
-	list_add(&tp->event->probes, &tp->list);
+	list_add(&tp->list, &tp->event->probes);
 
 	call = trace_probe_event_call(tp);
 	call->class = &tp->event->class;

