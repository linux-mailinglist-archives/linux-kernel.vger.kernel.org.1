Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2D27D844
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgI2Udu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2Uds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:33:48 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A00120774;
        Tue, 29 Sep 2020 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411628;
        bh=IlCiiXSdFVg26r0cW4LFHMH7vpn3iaT4iQWTImkzK9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=zg+NCCjCB72o+zPYS6kKibkWT6+i1T3vwWIP+UYBYg65KS/w3Fz3zKtkfipygoX75
         Vn2CDK0peuh+/+AsFGHI4crYCLkXmz9Z7zA0ctJDXjnMnPrQxib7RIVVfStfyOBCN4
         qVygflMWoUsuM2q+J4ku1kjj++1NMBwqEvKl4lmU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: Fix parse_synth_field() error handling
Date:   Tue, 29 Sep 2020 15:33:40 -0500
Message-Id: <834e9060c2e7e3272e25d8bfc6e7566639c18aa9.1601410890.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601410890.git.zanussi@kernel.org>
References: <cover.1601410890.git.zanussi@kernel.org>
In-Reply-To: <cover.1601410890.git.zanussi@kernel.org>
References: <cover.1601410890.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synth_field_size() returns either the size or an error.  However, the
code assigns the return val to ssize_t which is unsigned, and then
tests whether it's less than 0, which it isn't so discards the error.

Do the test before assignment to field->size.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index a9cd7793f7ea..6e7282c7b530 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -465,6 +465,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	int len, ret = 0;
+	int size;
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -520,11 +521,12 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 			field->type[len - 1] = '\0';
 	}
 
-	field->size = synth_field_size(field->type);
-	if (!field->size) {
+	size = synth_field_size(field->type);
+	if (size < 0) {
 		ret = -EINVAL;
 		goto free;
 	}
+	field->size = size;
 
 	if (synth_field_is_string(field->type))
 		field->is_string = true;
-- 
2.17.1

