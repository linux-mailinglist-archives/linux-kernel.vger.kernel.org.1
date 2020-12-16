Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF512DBD43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLPJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgLPJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:06:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37584C061793
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:06:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i7so5497061pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY0wCOTVakwsZLOf0cCFPHe34Zt11sHuXV6nUno5T5c=;
        b=OyXt4T9NQ/mqtNmco4duKhKPB0BE5+TBnXJ2TWMQGNVH8LwMHVAt5//h6w3xxrAsd8
         MKc/8fdhTmPDB94CNropXO83id2BuyuEaQ9pYDWWQBzOzLXYNpjRvbz0rVwYFjJVOuQh
         iWJESPiyIv+0A/0fDqK+8qmJZQ6glLStYTEu2L9bFz7Gmu7MdadWC3gbSOr5E9piic3K
         iP+14rGLY0Tuxa7VIaKWAQYpOOF8iaN2cew7qvr0gQyNbwx64sWmXGaZXn3jvoUQ1cj2
         Zb03ukSZuilxBy50YN+vqr7x6swgzNt3x2tIR3p0sKBOSDUC9IRQZ8CYlbeXvgKp9Xq/
         zgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hY0wCOTVakwsZLOf0cCFPHe34Zt11sHuXV6nUno5T5c=;
        b=ayr4h+kfBlh5kxt6xVZ0UmTph1jrI3aRk5GO4vJfeHaLNoXDP/TCu3u7w7Fe9kwcgE
         cgzikpKcIbNVlc0Sp9iM/jOwHsfHBypTWFA4iq6j2K3NcdLuOMHE3H1q9tp+rC7ZyA2s
         4EzF5rr4W1dSWDadUCtTRhcOZnBo5ick7W3s4d+v/b2gT46UqkhMfQbgyYf0caTJ3ucl
         fZ1jgcqGAoeJnzr7zldlJ0ln4tOx0a3uSSLIOWhnoftJwQ8UGOyeTGACxhHEVmMLo4Ca
         1tou3ISrUGsQmkp+DRQmH2JksPxvU93p7HWDqCDXM7EwKJNr8jpks1e9VQ5QjRkPxyRw
         UIUg==
X-Gm-Message-State: AOAM532uJBhY+YjFqkJtVcLfVKbXsZBgg3gDcCD0xzt7EHHWkPJxg0dY
        wiODU6dOYdaOLGcbKJv6pe656Nj6szA=
X-Google-Smtp-Source: ABdhPJziuQDkxWNYoeJC7H6cokuzOsbEVOsjYKs6WWFQcjP448jd9V2DDEZ5Ca33ZVz7FwP3RJMTEA==
X-Received: by 2002:a63:4207:: with SMTP id p7mr32752643pga.287.1608109567856;
        Wed, 16 Dec 2020 01:06:07 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id j14sm1423897pjm.10.2020.12.16.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 01:06:07 -0800 (PST)
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
Subject: [PATCH 2/3] tools/lib/fs: Diet cgroupfs_find_mountpoint()
Date:   Wed, 16 Dec 2020 18:05:55 +0900
Message-Id: <20201216090556.813996-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216090556.813996-1-namhyung@kernel.org>
References: <20201216090556.813996-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the number of buffers and hopefully make it more efficient. :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fs/cgroup.c | 70 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
index 813236d8ca48..262a4229e293 100644
--- a/tools/lib/api/fs/cgroup.c
+++ b/tools/lib/api/fs/cgroup.c
@@ -11,9 +11,10 @@
 int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 {
 	FILE *fp;
-	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
-	char path_v2[PATH_MAX + 1];
-	char *token, *saved_ptr = NULL;
+	char *line = NULL;
+	size_t len = 0;
+	char *p, *path;
+	char mountpoint[PATH_MAX];
 
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
@@ -25,38 +26,57 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	 * the given subsystem.  If we found v1, just use it.  If not we can
 	 * use v2 path as a fallback.
 	 */
-	path_v2[0] = '\0';
+	mountpoint[0] = '\0';
 
-	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
-				__stringify(PATH_MAX)"s %*d %*d\n",
-				mountpoint, type, tokens) == 3) {
+	/*
+	 * The /proc/mounts has the follow format:
+	 *
+	 *   <devname> <mount point> <fs type> <options> ...
+	 *
+	 */
+	while (getline(&line, &len, fp) != -1) {
+		/* skip devname */
+		p = strchr(line, ' ');
+		if (p == NULL)
+			continue;
 
-		if (!strcmp(type, "cgroup")) {
+		/* save the mount point */
+		path = ++p;
+		p = strchr(p, ' ');
+		if (p == NULL)
+			continue;
 
-			token = strtok_r(tokens, ",", &saved_ptr);
+		*p++ = '\0';
 
-			while (token != NULL) {
-				if (subsys && !strcmp(token, subsys)) {
-					/* found */
-					fclose(fp);
+		/* check filesystem type */
+		if (strncmp(p, "cgroup", 6))
+			continue;
 
-					if (strlen(mountpoint) < maxlen) {
-						strcpy(buf, mountpoint);
-						return 0;
-					}
-					return -1;
-				}
-				token = strtok_r(NULL, ",", &saved_ptr);
-			}
+		if (p[6] == '2') {
+			/* save cgroup v2 path */
+			strcpy(mountpoint, path);
+			continue;
 		}
 
-		if (!strcmp(type, "cgroup2"))
-			strcpy(path_v2, mountpoint);
+		/* now we have cgroup v1, check the options for subsystem */
+		p += 7;
+
+		p = strstr(p, subsys);
+		if (p == NULL)
+			continue;
+
+		/* sanity check: it should be separated by a space or a comma */
+		if (!strchr(" ,", p[-1]) || !strchr(" ,", p[strlen(subsys)]))
+			continue;
+
+		strcpy(mountpoint, path);
+		break;
 	}
+	free(line);
 	fclose(fp);
 
-	if (path_v2[0] && strlen(path_v2) < maxlen) {
-		strcpy(buf, path_v2);
+	if (mountpoint[0] && strlen(mountpoint) < maxlen) {
+		strcpy(buf, mountpoint);
 		return 0;
 	}
 	return -1;
-- 
2.29.2.684.gfbc64c5ab5-goog

