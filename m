Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BB27F17E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgI3SlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729905AbgI3Sk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:40:59 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4D62084C;
        Wed, 30 Sep 2020 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601491259;
        bh=R7XcLTABR3RPd0xjQRsJsPFqlytRfHg58eu8nKQza/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XFlKWBXHg4Y35VhgjXJibKAwFPlbRq0tXzaEnlY7HQIFyx5C+HD2e/fkfcSJ9cP69
         C6IeWW5T+nUTVkSi8Y430FCv/XX0fQqvIMEmM9AcJJ3EYEUAP5yILPK9GuOt6QO8MD
         yqIbILoIotX21w4lK7hGYvqu2BGSaOfawgIc2ZD8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] tracing: Fix parse_synth_field() error handling
Date:   Wed, 30 Sep 2020 13:40:51 -0500
Message-Id: <15b1808e1466f378fcf206e61b57c802423f8319.1601490263.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
In-Reply-To: <cover.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
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

