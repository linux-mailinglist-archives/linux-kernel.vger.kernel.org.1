Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3762DBD44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLPJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLPJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:06:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F36C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:06:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lj6so1150403pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LTVme937VtvznUzgXCFKra0V5ujtw9RVW2fQT/fpGM=;
        b=mDBei55fmyby8jT4M8mMuUX77lNkp1PNZvvEQxKaYMb5v5QjYkRSIQUillYBCNyx5Z
         YFv/Pt0JZIQ6ZmVNHIRyWZL0/yvCD5LrKZm5GPzVlc211x2dCbF2WOowNJauegOnAM6Z
         GQv/+BkQi5KZtuavtocHAMYdj6HtWu7K0J5c+7g7Saz3jTsmdFJ56y9JuY1gyRBltncQ
         51Yh4lE37Wb6dkxWZiV5TQKzfY4Zsx0xfysJU2KuLis+G6H1Qqrk3Z5R+fXE9V/6OA7p
         tE/MDOe/2vMQR64fUf7JJXBf7JbOhy7i2D4/Y9I2ZcZNUzQ9qPoPQVRwEf0urHHRC68L
         LGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/LTVme937VtvznUzgXCFKra0V5ujtw9RVW2fQT/fpGM=;
        b=XH87+3aCH/X0bvaWTFiN8rBp5gFGAizQfAjSqkU3/AIg4NNbPcaok7xraCw2IbvIV0
         o19P2a9JV0Xd6xDz7wAlwNoQvbnU65qi1wmWVjd5stsiO5DnRIbeuth2iNLaIa0no031
         nVWbNDG/AL0hMEOfuxGQ+Y1z2aq9/udYx7755R1fqYuPyzvi6wGVeNSnYt2san4e7kW+
         Cu1rD2q7PuMMIq4kjyYbOR2nQyvzDNqMTO9EMNOLxhw52P70X2Dp3H5/C/0uEFfmGDHz
         Q7MR7a2T6KxtmYYhLpIiWDVxSShPOER0M5NJmP+dYLr++0LZRwP4Y7JiStVXtCpSoqSB
         oHrA==
X-Gm-Message-State: AOAM530GzIXrJQ6UeyZlMN3/gB75VnakYsodc9v4wM3SZPYaJwNV69Sg
        6fn7AbNDQYbCWE6xjOoZY5I=
X-Google-Smtp-Source: ABdhPJzOH9KBAyUlSqhwr3GMzBF+alTL7dTZB920rZi5G6McmpSZs9LmLBK3gLIOF+cWurgzIM47yw==
X-Received: by 2002:a17:902:c195:b029:db:c725:2522 with SMTP id d21-20020a170902c195b02900dbc7252522mr30748256pld.83.1608109572285;
        Wed, 16 Dec 2020 01:06:12 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id j14sm1423897pjm.10.2020.12.16.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 01:06:11 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] tools/lib/fs: Cache cgroupfs mount point
Date:   Wed, 16 Dec 2020 18:05:56 +0900
Message-Id: <20201216090556.813996-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216090556.813996-1-namhyung@kernel.org>
References: <20201216090556.813996-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it parses the /proc file everytime it opens a file in the
cgroupfs.  Save the last result to avoid it (assuming it won't be
changed between the accesses).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fs/cgroup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
index 262a4229e293..1573dae4259d 100644
--- a/tools/lib/api/fs/cgroup.c
+++ b/tools/lib/api/fs/cgroup.c
@@ -8,6 +8,14 @@
 #include <string.h>
 #include "fs.h"
 
+struct cgroupfs_cache_entry {
+	char	subsys[32];
+	char	mountpoint[PATH_MAX];
+};
+
+/* just cache last used one */
+static struct cgroupfs_cache_entry cached;
+
 int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 {
 	FILE *fp;
@@ -16,6 +24,14 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	char *p, *path;
 	char mountpoint[PATH_MAX];
 
+	if (!strcmp(cached.subsys, subsys)) {
+		if (strlen(cached.mountpoint) < maxlen) {
+			strcpy(buf, cached.mountpoint);
+			return 0;
+		}
+		return -1;
+	}
+
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
 		return -1;
@@ -75,6 +91,9 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	free(line);
 	fclose(fp);
 
+	strncpy(cached.subsys, subsys, sizeof(cached.subsys) - 1);
+	strcpy(cached.mountpoint, mountpoint);
+
 	if (mountpoint[0] && strlen(mountpoint) < maxlen) {
 		strcpy(buf, mountpoint);
 		return 0;
-- 
2.29.2.684.gfbc64c5ab5-goog

