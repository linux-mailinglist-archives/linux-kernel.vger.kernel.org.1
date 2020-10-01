Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E07280998
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbgJAVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgJAVqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:46:52 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A752075F;
        Thu,  1 Oct 2020 21:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588811;
        bh=jnBSmMiea779xsft2JZQPQoZxQ2LYrnJS5lI6VFgvFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZOfF1EWP1SUvXC+Qkr/mLtpuMJJM5oGWXXnF/ueIWQFctJTIAiWsDxNzdGS/yCBBO
         NS64HFcoBiNW+rHg0TJQCGYukC72j0D11CausdQExMioPTSIk7TzM/YMm85CB5/Iio
         ZM2oky2WfylwKb7cHJho3YoCQ/XAPW+iIPUPHsEw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tracing: Change STR_VAR_MAX_LEN
Date:   Thu,  1 Oct 2020 16:46:44 -0500
Message-Id: <34a494e502fe1364b07896ef4d76f1fbbb8d1d1a.1601588066.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601588066.git.zanussi@kernel.org>
References: <cover.1601588066.git.zanussi@kernel.org>
In-Reply-To: <cover.1601588066.git.zanussi@kernel.org>
References: <cover.1601588066.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 is too small for this value, and anyway it makes more sense to use
MAX_FILTER_STR_VAL, as this is also the value used for variable-length
__strings.

Tested-by: Axel Rasmussen <axelrasmussen@google.com>
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

