Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE62270BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgISINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:13:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315DC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:13:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so4988766pfk.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qo1Kncp7nKtQTMgD/J1YluzPmB67ylbz1cdDpQ+cS5k=;
        b=EP8+HzlUvVotYon/NYKsW6/THtUATQp5TfUmOCBvOYwQ9wHqZTKiA6zwD8u/IN7h8W
         ESOAfXDWGqkVGLQSwVPxXqP9Oyba8OFWKsCmvCi5HuqO868vGzHQDxUqu50YrCL19ySY
         uAfhsCrPNB2rqcwU8w3POpzDl43JAMA4BW/BZzKXAtyMSC4c8s39VXOuicaqOvt4rOqq
         5MEZLwPMrmf1KLPoHDpXsmGlHvU+xPZTLY5QWHe1H5jn/BOkjOokvrp6VzFXHPZS8aEZ
         Cna/GDso0xnNpdMrbUM/Qk89u2NlNNQm0Q4FrHUNh04jyLPSQ8AyNiBSE3fBy77uCuIn
         lsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qo1Kncp7nKtQTMgD/J1YluzPmB67ylbz1cdDpQ+cS5k=;
        b=hVLOzFAFAoKIivZsPp4nhYuUdO0duUfurwarHFoVvgRhOhn6J2A91grzgOoX8/aq6P
         OMDm5klhhGc2utYEqZ2TmVnkzir+rw5n0u3mVT+UjQBp9WBxKS8LHCM1blK92l8KmDz9
         qYyzAv0BqhDAccX7Nm2jIZFVwQajWpC6zVVElpY4Dbb7hZpW6YG95vqjqxMuxnGB2J3y
         wnG/TtaaYK/zXSdI2yxK3rMmiWAt21XxqzOXpMvOTHaMK+8MnaTIbTQIDDQP9pyHEOQe
         CmRfWAyAWErOm0ToWKSRFPwl12TvthDcYTkcH9RpTIn4kVo7A6zhW3zeV8CKyyaYvtV6
         KTdA==
X-Gm-Message-State: AOAM530RYwpHdYJe8Pki0WENn/y6R/F1gSwjZ4qb/rtXbvtzH3mN5J5f
        8Y91+DfYlf6ApdYKjVbDWX4=
X-Google-Smtp-Source: ABdhPJxkjZjT5tsSB75IW5oSZ/wI8SxbNKgOOYjkAPAa384Q2qlI/PfR5bdMAORT0BOWL2DqJ2uPYQ==
X-Received: by 2002:a63:2c4:: with SMTP id 187mr24754410pgc.127.1600503212626;
        Sat, 19 Sep 2020 01:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:68b6:22a6:478b:7326:9143])
        by smtp.gmail.com with ESMTPSA id br22sm4853463pjb.35.2020.09.19.01.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:13:32 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: extend author Signed-off-by check for split From: header
Date:   Sat, 19 Sep 2020 13:42:25 +0530
Message-Id: <20200919081225.28624-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch did not handle cases where the author From: header
was split into two lines. The author string went empty and
checkpatch generated a false NO_AUTHOR_SIGN_OFF warning.

Support split From: headers in AUTHOR_SIGN_OFF check by adding
an additional clause to resolve author identity in such cases.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..86975baead22 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1210,6 +1210,16 @@ sub reformat_email {
 	return format_email($email_name, $email_address);
 }
 
+sub format_author_email {
+	my ($email, $from) = @_;
+
+	$email = encode("utf8", $email) if ($from =~ /=\?utf-8\?/i);
+	$email =~ s/"//g;
+	$email = reformat_email($email);
+
+	return $email;
+}
+
 sub same_email_addresses {
 	my ($email1, $email2) = @_;
 
@@ -2347,6 +2357,7 @@ sub process {
 	my $signoff = 0;
 	my $author = '';
 	my $authorsignoff = 0;
+	my $prevheader = '';
 	my $is_patch = 0;
 	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
@@ -2658,12 +2669,21 @@ sub process {
 			}
 		}
 
+# Check the patch for a split From:
+		if($prevheader ne '') {
+			if ($author eq '' && decode("MIME-Header", $prevheader) =~ /^From:\s*(.*)/) {
+				my $email = $1.$line;
+				$author = format_author_email($email, $prevheader);
+			}
+			$prevheader = '';
+		}
+
 # Check the patch for a From:
 		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
-			$author = $1;
-			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
-			$author =~ s/"//g;
-			$author = reformat_email($author);
+			$author = format_author_email($1, $line);
+			if($author eq '') {
+				$prevheader = $line;
+			}
 		}
 
 # Check the patch for a signoff:
-- 
2.27.0

