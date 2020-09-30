Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0627F17F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgI3SlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgI3Sk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:40:58 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3385620791;
        Wed, 30 Sep 2020 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601491257;
        bh=/6X7+ekH9B9EzbyppXPju2VN9OD+fEAFrbkRAO+F05I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Tq6GHpakSC9tDTi1owgunK+9JGIQP8e0Wacou10W3/53UPNVfGWOxEid6pxW2VgM3
         6l68IuBDu9l/tO3LJOIAu/avDrt17FB5pgv6Qdq531HMGnv9neuVq+tN2c3PFN5CK0
         d/5EP1JYHBhgWC4V7b98TPgVJGv/IjjPSKuY443A=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tracing: Change STR_VAR_MAX_LEN
Date:   Wed, 30 Sep 2020 13:40:50 -0500
Message-Id: <8616d1a2485fee1ae71d27d7c598acf1c9e32abe.1601490263.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
In-Reply-To: <cover.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
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

