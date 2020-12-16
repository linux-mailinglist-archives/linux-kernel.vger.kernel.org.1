Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136552DBD42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgLPJGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgLPJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:06:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67256C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:06:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 4so12569150plk.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eR5osIuVI8cGfQZQRguffEfNtIza++a0Mrz0oGZGv+w=;
        b=mPr4L9+CTPJNzliOc4iuitAT3ihmo9TFi8fX7J3RBjN2crDT4J8JYCyHLhQmfz+bw3
         M+CrV5rz+Dofmt7I8bTlmelENvVPvehsAlAikvtb5upNFzw+IDFfp6wxyxYT5iy+zreP
         nxA6cFcSAfBvQ6sgMCwxdxmD+mv3GEb0IOPqZ1ukc97fYDu6EXOKRe53mvOpDInpmnC/
         czK16aGKn5tbULRbktbAftVaD/7pN5isZ4QSMmO+mPgtJIkY3JVeJqE7tuxWWQu+OjYu
         2JsLAaVlbPi8dlJNlIoViNGluTKEdZZDuj2nQujybM0ngTbVJRoSaSTjYhxZFMIvYXCj
         1mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eR5osIuVI8cGfQZQRguffEfNtIza++a0Mrz0oGZGv+w=;
        b=E4JpI0rqQiziD/fcYJsvs+GUIxKBXCq8Z7v7vdVAKCRWOBwtTdZUoPdt/rEev/4P7Z
         jOWedlqmi6JaA/7TsZq8rmKyuSs6723fWpqGQ0Gtg49IYa4R/lEeinB8kpHPXMT3BtsK
         A4odwLUNrs6L7FTMhwbJxUJnsE/SUDEqADKH4S6tG6Owe4DjugQPAgiC+uIABDvNszOE
         AxHvkwNOv4TUbftvGd+YZEnfrFeZeirNXFsd8YW/Bi2nKkqfF46zqnQLsPMd9a+WItaI
         3vqfw+J+bB+8rOBQgBAZtShsLPpgiWtCpaaT3yxVF0F+qcP9j3AUcNFJzvS820G4h5Ox
         eFYQ==
X-Gm-Message-State: AOAM530QVU9eaMCVcmFMHHruAHuOZ8Mh2ZsbWFPBKtC834aGQw6IZwCk
        HH3CUHWIIYhRn5mfG369Nw0=
X-Google-Smtp-Source: ABdhPJx2PJb8+Q5Ofag5IP/0awHanyf5tP2jRxhJLC5ft0tnAxLl6IrYgdbo7yrpUrOIoylenrsabQ==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr172035pjz.73.1608109563786;
        Wed, 16 Dec 2020 01:06:03 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id j14sm1423897pjm.10.2020.12.16.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 01:06:02 -0800 (PST)
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
Subject: [PATCH 1/3] tools/lib/fs: Prefer cgroup v1 path
Date:   Wed, 16 Dec 2020 18:05:54 +0900
Message-Id: <20201216090556.813996-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroupfs_find_mountpoint() looks up the /proc/mounts file to find
a directory for the given cgroup subsystem.  It keeps both cgroup v1
and v2 path since there's a possibility of the mixed hierarchly.

But we can simply use v1 path if it's found as it will override the v2
hierarchy.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fs/cgroup.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
index 889a6eb4aaca..813236d8ca48 100644
--- a/tools/lib/api/fs/cgroup.c
+++ b/tools/lib/api/fs/cgroup.c
@@ -12,7 +12,7 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 {
 	FILE *fp;
 	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
-	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
+	char path_v2[PATH_MAX + 1];
 	char *token, *saved_ptr = NULL;
 
 	fp = fopen("/proc/mounts", "r");
@@ -22,45 +22,41 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	/*
 	 * in order to handle split hierarchy, we need to scan /proc/mounts
 	 * and inspect every cgroupfs mount point to find one that has
-	 * perf_event subsystem
+	 * the given subsystem.  If we found v1, just use it.  If not we can
+	 * use v2 path as a fallback.
 	 */
-	path_v1[0] = '\0';
 	path_v2[0] = '\0';
 
 	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
 				__stringify(PATH_MAX)"s %*d %*d\n",
 				mountpoint, type, tokens) == 3) {
 
-		if (!path_v1[0] && !strcmp(type, "cgroup")) {
+		if (!strcmp(type, "cgroup")) {
 
 			token = strtok_r(tokens, ",", &saved_ptr);
 
 			while (token != NULL) {
 				if (subsys && !strcmp(token, subsys)) {
-					strcpy(path_v1, mountpoint);
-					break;
+					/* found */
+					fclose(fp);
+
+					if (strlen(mountpoint) < maxlen) {
+						strcpy(buf, mountpoint);
+						return 0;
+					}
+					return -1;
 				}
 				token = strtok_r(NULL, ",", &saved_ptr);
 			}
 		}
 
-		if (!path_v2[0] && !strcmp(type, "cgroup2"))
+		if (!strcmp(type, "cgroup2"))
 			strcpy(path_v2, mountpoint);
-
-		if (path_v1[0] && path_v2[0])
-			break;
 	}
 	fclose(fp);
 
-	if (path_v1[0])
-		path = path_v1;
-	else if (path_v2[0])
-		path = path_v2;
-	else
-		return -1;
-
-	if (strlen(path) < maxlen) {
-		strcpy(buf, path);
+	if (path_v2[0] && strlen(path_v2) < maxlen) {
+		strcpy(buf, path_v2);
 		return 0;
 	}
 	return -1;
-- 
2.29.2.684.gfbc64c5ab5-goog

