Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9D27D845
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgI2Udu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbgI2Udr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:33:47 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADCA2076D;
        Tue, 29 Sep 2020 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411626;
        bh=/6X7+ekH9B9EzbyppXPju2VN9OD+fEAFrbkRAO+F05I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NILeGEoESpbimWiBOowP89wBSB4/Vd8PT15/hMX9Y6rQt7SY9T6ZODntUMLkKuvbA
         WrtgTNE/kv0W53mfLT0vc3jxJvPI/qze5SqcQ2Os3w3Sr/YOeMV1NapsopSOlbWXNe
         AgedXYocNm+WIPr7B8olIKsVeQEyicX+V6u9WARw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing: Change STR_VAR_MAX_LEN
Date:   Tue, 29 Sep 2020 15:33:39 -0500
Message-Id: <8616d1a2485fee1ae71d27d7c598acf1c9e32abe.1601410890.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601410890.git.zanussi@kernel.org>
References: <cover.1601410890.git.zanussi@kernel.org>
In-Reply-To: <cover.1601410890.git.zanussi@kernel.org>
References: <cover.1601410890.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 is too small for this value, and anyway it makes more sense to use
MAX_FILTER_STR_VAL, as this is also the value used for variable-length
__strings.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_synth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index ac35c45207c4..5166705d1556 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -7,7 +7,7 @@
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	32
 
-#define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
+#define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be multiple of sizeof(u64) */
 
 struct synth_field {
 	char *type;
-- 
2.17.1

