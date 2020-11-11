Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9012AEE00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKKJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgKKJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:42:42 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:42:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so711921plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HWsx9B0i+km7rETi/ATPtzslVhr3RwpBYH13dBR/3Ho=;
        b=aKabU+d70ye27wRjrFfr+zLkzU7wnCVr3xRHRKWIE7Oq9GDMjvy8utFfxpWMpQBPFs
         3YfKsz8+rgkxal0IkYjsU9OGcszs+1HpGO90e0i5dny0FGSHqHz0rDENOBO8ri83guof
         AAWx+LuEEG4CvzX/MhgwPMNjaZTMBkIM1+Cii+f3+8mMCKSTQ9ezsWb/smYac4M1MafP
         gY+xV99NJcackueC0L6Lbkf5RumOpkFhaQTVCHq6kCMmepexWf72hRpaW+xOgdzRyPXQ
         sH5QOCosy2tgkj8ZeyXlbRigHC/NKh6eGKv0ecQwnZCjrOyb+ITneQakI9fL/7RYE0e+
         cPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HWsx9B0i+km7rETi/ATPtzslVhr3RwpBYH13dBR/3Ho=;
        b=N4ymu5eMw8CdXJIpkrQMuHuyfj+qpkn6zooqqueVfVRmmVQiGkYW8xjyi3Nk2TH8ON
         V7GePvD8klYd4J2FfAkUPwQksBmfW3l6MeyYUNPiHQFvVKerRW23HgIkfgA0jzTISJ02
         kPkaz1+HrJT0TF+zrwlEMAga9BCvsIE2G20V09c7e5VCTaJwdwMpxltT3zHQj4GOzBJZ
         +9LaUGuO/cnltxFwCm/xgyGMZpSB0N45euNTOkdJsMzBm3VutatMd8LGNDflWGJAL8At
         SJ7BPhO2XT3YTdT04gf37y0Hx5LdzCTeWJX8x8FHHNTLPlTvUovbBVJoGCcbfNtVHXZW
         rUoQ==
X-Gm-Message-State: AOAM533yPhz1GYP9Fuz2cFPryx4dHctKBCR8v/nMopRptO1OHTYs4MHe
        W84Ap8hiaDJ/DuIKuh9z+Zg=
X-Google-Smtp-Source: ABdhPJxF9CrnQP3mrjGSrpaI3VkSCPqLt91T6zdmfpg6ZKKbVlMCoPMLu8DxAAjOxRgn5GwVkcpSeQ==
X-Received: by 2002:a17:90b:300a:: with SMTP id hg10mr3134852pjb.30.1605087762350;
        Wed, 11 Nov 2020 01:42:42 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id o132sm1857300pfg.100.2020.11.11.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:42:41 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH] f2fs-tools: skipped to end on error syntax error
Date:   Wed, 11 Nov 2020 17:40:57 +0800
Message-Id: <20201111094057.565522-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

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

