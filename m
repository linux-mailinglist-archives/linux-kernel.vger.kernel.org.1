Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D52C59C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404030AbgKZRBG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Nov 2020 12:01:06 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:37848 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403995AbgKZRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:01:05 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-L8dFtoDZMuqwYSUk4-lllw-1; Thu, 26 Nov 2020 12:00:58 -0500
X-MC-Unique: L8dFtoDZMuqwYSUk4-lllw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D977E105207A;
        Thu, 26 Nov 2020 17:00:55 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75E960BFA;
        Thu, 26 Nov 2020 17:00:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/25] tools lib: Adopt memchr_inv() from kernel
Date:   Thu, 26 Nov 2020 18:00:06 +0100
Message-Id: <20201126170026.2619053-6-jolsa@kernel.org>
In-Reply-To: <20201126170026.2619053-1-jolsa@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll use it to check for undefined/zero data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/linux/string.h |  1 +
 tools/lib/string.c           | 58 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index 5e9e781905ed..db5c99318c79 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -46,4 +46,5 @@ extern char * __must_check skip_spaces(const char *);
 
 extern char *strim(char *);
 
+extern void *memchr_inv(const void *start, int c, size_t bytes);
 #endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index f645343815de..8b6892f959ab 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -168,3 +168,61 @@ char *strreplace(char *s, char old, char new)
 			*s = new;
 	return s;
 }
+
+static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
+{
+	while (bytes) {
+		if (*start != value)
+			return (void *)start;
+		start++;
+		bytes--;
+	}
+	return NULL;
+}
+
+/**
+ * memchr_inv - Find an unmatching character in an area of memory.
+ * @start: The memory area
+ * @c: Find a character other than c
+ * @bytes: The size of the area.
+ *
+ * returns the address of the first character other than @c, or %NULL
+ * if the whole buffer contains just @c.
+ */
+void *memchr_inv(const void *start, int c, size_t bytes)
+{
+	u8 value = c;
+	u64 value64;
+	unsigned int words, prefix;
+
+	if (bytes <= 16)
+		return check_bytes8(start, value, bytes);
+
+	value64 = value;
+	value64 |= value64 << 8;
+	value64 |= value64 << 16;
+	value64 |= value64 << 32;
+
+	prefix = (unsigned long)start % 8;
+	if (prefix) {
+		u8 *r;
+
+		prefix = 8 - prefix;
+		r = check_bytes8(start, value, prefix);
+		if (r)
+			return r;
+		start += prefix;
+		bytes -= prefix;
+	}
+
+	words = bytes / 8;
+
+	while (words) {
+		if (*(u64 *)start != value64)
+			return check_bytes8(start, value, 8);
+		start += 8;
+		words--;
+	}
+
+	return check_bytes8(start, value, bytes % 8);
+}
-- 
2.26.2

