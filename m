Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7023291877
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgJRRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:06:16 -0400
Received: from m12-14.163.com ([220.181.12.14]:56698 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJRRGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=IX5bO
        BLgQ3MVI8RGcDJwWiaWttwwGpXgmD0PVSnmAt4=; b=hcDCtaDvh4kPS2LlEH1km
        L5JUqtKl6dElNGm7Bns0JgF0TzAv4TAbde5CFp5Bi4bETLvfmaL1aBxKr3/pJNwX
        sS9ubA476NEAC44WKpXGfl/mkX5F+7wXRAPkVbDmza24kHV6Zp9kBCFgfPKEhFv8
        DBZ9Hyv6E4AnPMUQfcyW+s=
Received: from localhost (unknown [101.86.214.18])
        by smtp10 (Coremail) with SMTP id DsCowADnnbT2dYxfkWtyQw--.18878S2;
        Mon, 19 Oct 2020 01:05:58 +0800 (CST)
Date:   Mon, 19 Oct 2020 01:05:57 +0800
From:   Hui Su <sh_def@163.com>
To:     corbet@lwn.net, dsterba@suse.com, mchehab+huawei@kernel.org,
        sh_def@163.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/cpu-load: format the example code.
Message-ID: <20201018170557.GA7670@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowADnnbT2dYxfkWtyQw--.18878S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1fCr1xXF47Aw4fZryrJFb_yoW8ZrWUp3
        yUAan2qrZ5Ga4UCa4UA3yxGFnxX34I9an0gr42k3s5t397Aws5ta4Iyr1jyF4fCrWxJay7
        ArZIgF15uF45C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UprW7UUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWRbBX1WBtDepWAAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

format the example code.

Signed-off-by: Hui Su <sh_def@163.com>
---
 Documentation/admin-guide/cpu-load.rst | 63 ++++++++++++++------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/Documentation/admin-guide/cpu-load.rst b/Documentation/admin-guide/cpu-load.rst
index ebdecf864080..f3ada90e9ca8 100644
--- a/Documentation/admin-guide/cpu-load.rst
+++ b/Documentation/admin-guide/cpu-load.rst
@@ -61,43 +61,46 @@ will lead to quite erratic information inside ``/proc/stat``::
 
 	static volatile sig_atomic_t stop;
 
-	static void sighandler (int signr)
+	static void sighandler(int signr)
 	{
-	(void) signr;
-	stop = 1;
+		(void) signr;
+		stop = 1;
 	}
+
 	static unsigned long hog (unsigned long niters)
 	{
-	stop = 0;
-	while (!stop && --niters);
-	return niters;
+		stop = 0;
+		while (!stop && --niters);
+		return niters;
 	}
+
 	int main (void)
 	{
-	int i;
-	struct itimerval it = { .it_interval = { .tv_sec = 0, .tv_usec = 1 },
-				.it_value = { .tv_sec = 0, .tv_usec = 1 } };
-	sigset_t set;
-	unsigned long v[HIST];
-	double tmp = 0.0;
-	unsigned long n;
-	signal (SIGALRM, &sighandler);
-	setitimer (ITIMER_REAL, &it, NULL);
-
-	hog (ULONG_MAX);
-	for (i = 0; i < HIST; ++i) v[i] = ULONG_MAX - hog (ULONG_MAX);
-	for (i = 0; i < HIST; ++i) tmp += v[i];
-	tmp /= HIST;
-	n = tmp - (tmp / 3.0);
-
-	sigemptyset (&set);
-	sigaddset (&set, SIGALRM);
-
-	for (;;) {
-		hog (n);
-		sigwait (&set, &i);
-	}
-	return 0;
+		int i;
+		struct itimerval it = {
+			.it_interval = { .tv_sec = 0, .tv_usec = 1 },
+			.it_value    = { .tv_sec = 0, .tv_usec = 1 } };
+		sigset_t set;
+		unsigned long v[HIST];
+		double tmp = 0.0;
+		unsigned long n;
+		signal(SIGALRM, &sighandler);
+		setitimer(ITIMER_REAL, &it, NULL);
+
+		hog (ULONG_MAX);
+		for (i = 0; i < HIST; ++i) v[i] = ULONG_MAX - hog(ULONG_MAX);
+		for (i = 0; i < HIST; ++i) tmp += v[i];
+		tmp /= HIST;
+		n = tmp - (tmp / 3.0);
+
+		sigemptyset(&set);
+		sigaddset(&set, SIGALRM);
+
+		for (;;) {
+			hog(n);
+			sigwait(&set, &i);
+		}
+		return 0;
 	}
 
 
-- 
2.25.1


