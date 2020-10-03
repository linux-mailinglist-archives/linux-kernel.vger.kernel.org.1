Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C03281FE5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCBAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJCBAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:00:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C84A206F8;
        Sat,  3 Oct 2020 01:00:38 +0000 (UTC)
Date:   Fri, 2 Oct 2020 21:00:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] tracing: Add dynamic strings for synthetic
 events
Message-ID: <20201002210036.0200371b@oasis.local.home>
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

I also added this for a bit of paranoid, and probably should be a
separate patch, just to make sure if the string isn't nul terminated,
this will keep it from bleeding pass the end of the string.

-- Steve

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4b3ec570147a..d81739990a53 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -234,7 +234,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%s";
+		fmt = "%.*s";
 
 	return fmt;
 }
@@ -303,11 +303,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				str_field = (char *)entry + data_offset;
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
+						 STR_VAR_LEN_MAX,
 						 str_field,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
+						 STR_VAR_LEN_MAX,
 						 (char *)&entry->fields[n_u64],
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
