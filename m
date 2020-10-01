Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B129C28099A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbgJAVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgJAVqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:46:53 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07CD20848;
        Thu,  1 Oct 2020 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588813;
        bh=1BIGM75SsDlNLujG+9HmzMjS9t+tH3f8Hi4eIw8Cay0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IaALbz1RmeG45yzvu32kbVa78cM8+JJYtDQlXJi4C4YtDnNRkmrcgKNss3YJCjGYV
         IwuAKIG3Hz3XOIdof7ClU4/DAsitasfqPXOKszGekG4foLsx2GvdOd86txdbCtRbx2
         tUjKbPpZpryqirxUNvOPd1F2HcYC1P5wnHg05O0c=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] tracing: Fix parse_synth_field() error handling
Date:   Thu,  1 Oct 2020 16:46:45 -0500
Message-Id: <c0e575c30880e11406cee3ddbc1076785fa63a09.1601588066.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601588066.git.zanussi@kernel.org>
References: <cover.1601588066.git.zanussi@kernel.org>
In-Reply-To: <cover.1601588066.git.zanussi@kernel.org>
References: <cover.1601588066.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synth_field_size() returns either a positive size or an error (zero or
a negative value). However, the existing code assumes the only error
value is 0. It doesn't handle negative error codes, as it assigns
directly to field->size (a size_t; unsigned), thereby interpreting the
error code as a valid size instead.

Do the test before assignment to field->size.

[ axelrasmussen@google.com: changelog addition, first paragraph above ]

Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index a9cd7793f7ea..fa8a99828f41 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -465,6 +465,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	int len, ret = 0;
+	ssize_t size;
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -520,11 +521,12 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 			field->type[len - 1] = '\0';
 	}
 
-	field->size = synth_field_size(field->type);
-	if (!field->size) {
+	size = synth_field_size(field->type);
+	if (size <= 0) {
 		ret = -EINVAL;
 		goto free;
 	}
+	field->size = size;
 
 	if (synth_field_is_string(field->type))
 		field->is_string = true;
-- 
2.17.1

