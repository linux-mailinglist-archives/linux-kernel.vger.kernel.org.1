Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995131A85D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407509AbgDNQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440480AbgDNQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726472137B;
        Tue, 14 Apr 2020 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882978;
        bh=UvXZ+IxoIeeey089XnZGi/88/VdiyQwT0ComwzdImDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntlI9LgX+ytnJs8ED0kZgkN/4SxtCotaGpTTagmvYyUzw9VuyZOjcFC4OWpxPYu1j
         PyM9busMDB2J46H57wrdQm6DdxXKm2+PdfrwwQA7WgwKCAMc/feIm2fS3KauJoXLWz
         Fkktld+KsUlX6EcBCvBCkky93zcvXROOdIzzWXfU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 12/15] tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
Date:   Tue, 14 Apr 2020 13:48:51 -0300
Message-Id: <20200414164854.26026-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  88be76cdafc7 ("drm/i915: Allow userspace to specify ringsize on construction")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 829c0a48577f..2813e579b480 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1619,6 +1619,27 @@ struct drm_i915_gem_context_param {
  * By default, new contexts allow persistence.
  */
 #define I915_CONTEXT_PARAM_PERSISTENCE	0xb
+
+/*
+ * I915_CONTEXT_PARAM_RINGSIZE:
+ *
+ * Sets the size of the CS ringbuffer to use for logical ring contexts. This
+ * applies a limit of how many batches can be queued to HW before the caller
+ * is blocked due to lack of space for more commands.
+ *
+ * Only reliably possible to be set prior to first use, i.e. during
+ * construction. At any later point, the current execution must be flushed as
+ * the ring can only be changed while the context is idle. Note, the ringsize
+ * can be specified as a constructor property, see
+ * I915_CONTEXT_CREATE_EXT_SETPARAM, but can also be set later if required.
+ *
+ * Only applies to the current set of engine and lost when those engines
+ * are replaced by a new mapping (see I915_CONTEXT_PARAM_ENGINES).
+ *
+ * Must be between 4 - 512 KiB, in intervals of page size [4 KiB].
+ * Default is 16 KiB.
+ */
+#define I915_CONTEXT_PARAM_RINGSIZE	0xc
 /* Must be kept compact -- no holes and well documented */
 
 	__u64 value;
-- 
2.21.1

