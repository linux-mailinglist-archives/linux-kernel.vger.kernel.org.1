Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAC2AD0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgKJILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:11:37 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 00:11:37 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id x2so8060633qkd.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=YleeopDaCgXcJmdy4XOEQs2LFG2krgZZ0q7A6+K5Zb4=;
        b=r9GxOzmAmzQQaWAt/+yFLYbYHyhxxLRGGimYAU20+AVeE8DakDhPbv6BD81yZlmwAV
         aWijN3T/Oe/5LaZMduyilZWCPgqw79cloIqB9l6RW8L8LBUJuXNTmxsK3XVghP1etkon
         MDPuXpq42XCNDizGM9rPg7t1Veo16QDQqlPNdM8idYbG171Av02C5zgl052gC8pBtsTp
         CJayAsLpURbvTMotciq/6Onx7fzYk/SbweHDPIdB+lnEg/4wb1JAEY3N+WXib33+DUDE
         xvKGw6DknZT+3MsBgWD/aQ++X9ogR8lL1V7NGbPxqgEAzb7KY0GZYqrNq3/2R4Nyfd7W
         cRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=YleeopDaCgXcJmdy4XOEQs2LFG2krgZZ0q7A6+K5Zb4=;
        b=jujHH+DsujzdhJrn7RqzaKwBcqj2xwgzd8WZRdf5m6WprHMtybefMRtx0HQdnTjuJG
         wLLDc0kNKbT1HdZAtniRh0A8E+xby7PQVHa1632IcihxKEhh5+Iode8qBJT1nmhh2pus
         P2VSq5Oi423yDk+KHo7RpoYjnoD+LFbIdK5G8MM7tVjCW9Wyt6bpD3I4fpCphCqzqGzM
         IuyC2k1cjNLVdOcjNIt4r8o2vI/w8W1JegmHJBVKZzUtbpjA7F1JcgZBDUIbhzZjgAQX
         rtQIqIEz8ciIxUbwbSdjhEHWwpxcn4hJO2NtMnhYlbu794slpbLSgxzJyFH5yOgoKTPb
         pw9Q==
X-Gm-Message-State: AOAM533xrwlwqYE8z+fTL2Cu/VqOh/Tw+9mYCAL1q69T6f5LvYp7FGqI
        K+L4KFmptPrQwywYDJeUzOk/9odW4ORf7A==
X-Google-Smtp-Source: ABdhPJx7IBluQ2rlpM3bGLDjEkqpkA+rySsTjs0NgAafboWL1131VYeWnhmBg69RW8wIFx83Tw6yfEaV7LNxaQ==
Sender: "robinhsu via sendgmr" <robinhsu@robinhsu-p520.ntc.corp.google.com>
X-Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 (user=robinhsu job=sendgmr) by 2002:a0c:e0c9:: with SMTP id
 x9mr18369611qvk.56.1604995896460; Tue, 10 Nov 2020 00:11:36 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:10:39 +0800
Message-Id: <20201110081038.261786-1-robinhsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] f2fs-tools: skipped to end on error syntax error
From:   Robin Hsu <robinhsu@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When error were found, we won't need to do any initialization but
just quit.

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 fsck/main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 32559f1..e70048b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -597,20 +597,22 @@ void f2fs_parse_options(int argc, char *argv[])
 		}
 	}
 
-	add_default_options();
+	if (err == NOERROR) {
+		add_default_options();
 
-	if (optind >= argc) {
-		MSG(0, "\tError: Device not specified\n");
-		error_out(prog);
-	}
+		if (optind >= argc) {
+			MSG(0, "\tError: Device not specified\n");
+			error_out(prog);
+		}
 
-	c.devices[0].path = strdup(argv[optind]);
-	if (argc > (optind + 1)) {
-		c.dbg_lv = 0;
-		err = EUNKNOWN_ARG;
+		c.devices[0].path = strdup(argv[optind]);
+		if (argc > (optind + 1)) {
+			c.dbg_lv = 0;
+			err = EUNKNOWN_ARG;
+		}
+		if (err == NOERROR)
+			return;
 	}
-	if (err == NOERROR)
-		return;
 
 	/* print out error */
 	switch (err) {
-- 
2.29.2.222.g5d2a92d10f8-goog

