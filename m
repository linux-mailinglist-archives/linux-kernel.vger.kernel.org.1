Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B52287C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgJHTSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHTSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:18:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0761C21789;
        Thu,  8 Oct 2020 19:18:50 +0000 (UTC)
Date:   Thu, 8 Oct 2020 15:18:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Tom Zanussi <zanussi@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH] tracing: Fix synthetic print fmt check for use of
 __get_str()
Message-ID: <20201008151849.375ae2b7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 9d8739bc05f6d0f3ad21dc5d56f1edfbb9aa7585


Steven Rostedt (VMware) (1):
      tracing: Fix synthetic print fmt check for use of __get_str()

----
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 9d8739bc05f6d0f3ad21dc5d56f1edfbb9aa7585
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Oct 7 10:34:34 2020 -0400

    tracing: Fix synthetic print fmt check for use of __get_str()
    
    A cut and paste error had the check to use __get_str() test "is_dynamic"
    twice, instead of checking "is_string && is_dynamic".
    
    Link: https://lore.kernel.org/r/d34dccd5-96ba-a2d9-46ea-de8807525deb@canonical.com
    
    Reported-by: Colin Ian King <colin.king@canonical.com>
    Acked-by: Tom Zanussi <zanussi@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 742ce5f62d6d..3b2dcc42b8ee 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -491,7 +491,7 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
 	for (i = 0; i < event->n_fields; i++) {
-		if (event->fields[i]->is_dynamic &&
+		if (event->fields[i]->is_string &&
 		    event->fields[i]->is_dynamic)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", __get_str(%s)", event->fields[i]->name);
