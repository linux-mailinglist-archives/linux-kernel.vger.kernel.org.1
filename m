Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1C2DD253
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgLQNnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLQNnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:43:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5C6C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:42:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v3so15149559plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xX8a79Gjb31KcVl9BRU7zIuRKc3nJSmAQkj+J42gmDo=;
        b=IVVED24WxVyEFokYDkZM+re9QFS1ER56bPsSsaUeoZtF74kdLMOrGg6uveNSSEAR6X
         zpNbUs1Dr8UVbc8lR6YKVFW0ZI6i6MGOvWybKTsxcYAdbcX5oY9vber46zK5rk04JprC
         mMOlAf8COuTTh3vKw3EQWGQ2jFOwnLhBQGHL67Hzy60NO+/Ch/beibIZoXrogMgDgNn2
         qL2nx4VDkonJlGbkEwh0omUVj8m2E+vf+2JTXhobeBNmXDF1AgCEDfX23Q82B9xotmZL
         zBMxrLgJtlTHe9Wmx0gdgNbYy4OfnrozX3DVx+/JTa2Ge1SvPYIi0JvvV/DdUm0NEDMU
         SdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xX8a79Gjb31KcVl9BRU7zIuRKc3nJSmAQkj+J42gmDo=;
        b=HJNab9eBr4v2f2Qcb0TjrtxofaHa/47kNgzOO+Ng8IcyxW7JBwsF9MV/hEP3Mck03/
         JAmeNda/tq9XQ/q+aJioifcCCr+O6T3NV8hrq8HqNSUcWsQjXwwPnu0Ux8r+Wbb+K2x4
         vIJGL9JZPR1rg/HxC/9ch7EtEZW00MwKz2cEhSDiGg1b6DsE2VbneAwjQebxJbk8bIwg
         xwLnHqmQF6wdY3RG3VsrMMAzF4Hha8dcUioR/2sI0F2apMl72DbVI88ouUB5C+Nii0hK
         Q2oFqMitD4QsAPSFpYFZTggX8XuZEnMioO/lk3aGNl3K7Bp8W3NkpMrTSiDGs1I6NftT
         1Qwg==
X-Gm-Message-State: AOAM530+wEMAeW6XVuFN7zZWaYFqSv3fXTyzOUjR7F2c8jSCU72UWILy
        hPZgSN3gRvIfG4QPZfUn8f+/qHx4pXiQqw==
X-Google-Smtp-Source: ABdhPJyFttykqEqBExQYV65btoTZGx484eNHaiTltEX264Durh1Mnt15/pR+ALVf5CC+uPkAk5ekkQ==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr8028012pjv.168.1608212551215;
        Thu, 17 Dec 2020 05:42:31 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:403:493:5d38:be:6298:62ae])
        by smtp.googlemail.com with ESMTPSA id j15sm6049719pfn.180.2020.12.17.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 05:42:30 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: fix false positive for COMMIT_LOG_LONG_LINE with URLs
Date:   Thu, 17 Dec 2020 19:12:21 +0530
Message-Id: <20201217134221.16178-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns for long line in commit messages even for
URL lines.

An evaluation over v4.13..v5.8 showed that out of ~11000 warnings for
this class, around 790 are due to the line containing link.

E.g. running checkpatch on commit 3cde818cd02b ("ASoC: topology:
Consolidate how dtexts and dvalues are freed") reports this warning:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html

Avoid giving users warning for character limit, instead suggest them to
prefix the URLs with "Link:"

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index abd5a3d2e913..23da1f50fe6a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3032,8 +3032,14 @@ sub process {
 		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
-			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			if ($line =~ /(?:http|https|ftp):\/\//) {
+				WARN("COMMIT_LOG_LONG_LINE",
+				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
+			}
+			else {
+				WARN("COMMIT_LOG_LONG_LINE",
+				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			}
 			$commit_log_long_line = 1;
 		}
 
-- 
2.17.1

