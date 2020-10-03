Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0472B281FE0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 02:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJCAzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 20:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJCAzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 20:55:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86F7206F8;
        Sat,  3 Oct 2020 00:55:12 +0000 (UTC)
Date:   Fri, 2 Oct 2020 20:55:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] tracing: Add dynamic strings for synthetic
 events
Message-ID: <20201002205510.229a25bc@oasis.local.home>
In-Reply-To: <cover.1601588066.git.zanussi@kernel.org>
References: <cover.1601588066.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Oct 2020 16:46:43 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi,
> 
> This is v3 of the dynamic string support for synthetic events.
> 
> No code changes since v2, just added Fixes: tag for 'tracing: Fix
> parse_synth_field() error handling' as suggested by Masami along with
> his Reviewed-by, and Axel's Tested-bys.
> 

I added the following to make it work with trace-cmd. Dynamic strings
must have __get_str() for events in the print_fmt otherwise it can't be
parsed correctly.

-- Steve

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4b3ec570147a..24bc6d61aa40 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -489,8 +489,13 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
 	for (i = 0; i < event->n_fields; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO,
-				", REC->%s", event->fields[i]->name);
+		if (event->fields[i]->is_dynamic &&
+		    event->fields[i]->is_dynamic)
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", __get_str(%s)", event->fields[i]->name);
+		else
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+					", REC->%s", event->fields[i]->name);
 	}
 
 #undef LEN_OR_ZERO
