Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFC228D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgGVBSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbgGVBR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC3122D73;
        Wed, 22 Jul 2020 01:17:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jy3ON-005sIA-I0; Tue, 21 Jul 2020 21:17:55 -0400
Message-ID: <20200722011755.442308322@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 21 Jul 2020 21:16:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [PATCH 21/23 v3] tools lib traceevent: Fixed type in PRINT_FMT_STING
References: <20200722011628.925541477@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

PRINT_FMT_STING -> PRINT_FMT_STRING

Link: https://lore.kernel.org/r/CAM9d7cj1LJ=QO8QxhBo_oDM9APpAswX4BbTwge0JhZ3Y4-Bv9w@mail.gmail.com
Link: https://lore.kernel.org/linux-trace-devel/20200714103027.2477584-7-tz.stoyanov@gmail.com
Link: https://lore.kernel.org/linux-trace-devel/20200716092014.2613403-7-tz.stoyanov@gmail.com

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse-local.h | 2 +-
 tools/lib/traceevent/event-parse.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
index e71296a62236..d805a920af6f 100644
--- a/tools/lib/traceevent/event-parse-local.h
+++ b/tools/lib/traceevent/event-parse-local.h
@@ -86,7 +86,7 @@ struct tep_handle {
 };
 
 enum tep_print_parse_type {
-	PRINT_FMT_STING,
+	PRINT_FMT_STRING,
 	PRINT_FMT_ARG_DIGIT,
 	PRINT_FMT_ARG_POINTER,
 	PRINT_FMT_ARG_STRING,
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 8ee83f1e4e01..af56b60e5f89 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5612,7 +5612,7 @@ static int parse_arg_format(struct tep_print_parse **parse,
 		default:
 			snprintf(print_format, 32, ">%c<", *format);
 			parse_arg_add(parse, print_format,
-					PRINT_FMT_STING, NULL, NULL, 0);
+					PRINT_FMT_STRING, NULL, NULL, 0);
 			ret++;
 			return ret;
 		}
@@ -5664,7 +5664,7 @@ static int parse_arg_string(struct tep_print_parse **parse, const char *format)
 		ret++;
 	}
 	trace_seq_terminate(&s);
-	parse_arg_add(parse, s.buffer, PRINT_FMT_STING, NULL, NULL, 0);
+	parse_arg_add(parse, s.buffer, PRINT_FMT_STRING, NULL, NULL, 0);
 	trace_seq_destroy(&s);
 
 	return ret;
@@ -5722,7 +5722,7 @@ static void print_event_cache(struct tep_print_parse *parse, struct trace_seq *s
 					 parse->len_as_arg ? len_arg : -1,
 					 data, size, event, parse->arg);
 			break;
-		case PRINT_FMT_STING:
+		case PRINT_FMT_STRING:
 		default:
 			trace_seq_printf(s, "%s", parse->format);
 			break;
-- 
2.26.2


