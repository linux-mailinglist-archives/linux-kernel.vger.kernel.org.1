Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915AC2F5B67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhANHgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhANHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:36:18 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128AC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:35:32 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so3204131pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owDSUfxjCGNV7feym8SWdxYVebJhgpkhx2YM4l3iFLA=;
        b=qHVtSpQGZutLPHTqE7h7h3Uc/79S/uPr3YwZQ0YQpMyIx/GLpPYu8JoLg6/IEMvIlP
         mExDcVq2K3/JyXfYoGQR6XhhC3uT8Ym903BsZydRsbfdqio1ChI/xE1BAUB1wenye/fr
         4W7x9VhrxfpsvebuHFbHHy798FSilY+WIn5roDrm3TKM6uwOJefznt6JXYBT6e0yt6ga
         OXNF2OLlTigs7SlEKCzTkNpq3lbZCN3kwVlO/E541kKsJshD9gV7kc1jVEuaV2oZYWdZ
         tXXLFnjpQE8o7HRoNjk0xbEv68bYZhR7SKeRiGcM7lIo7fwE2YnG30eiJVzcGk8lKzC4
         qeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owDSUfxjCGNV7feym8SWdxYVebJhgpkhx2YM4l3iFLA=;
        b=kthV9c2Rv3bRA76REDQ5dAcewYfNDTU4LN2/4xkVhHkdfLHhcquZQ7d5nI9t4kn3TP
         iFaRmxH/WL9ymz+Tcvm2SWA5m0OF2xUS2wL+kxjDEpMXk84i13KJkUiYvY5q78PoqKsU
         TpP+eV2wQ5H72u51uTcWwS1OAUJpiNDmdtlvKVQEL0MMiHaUvG1GsI5vO9l64eh8T1Og
         tCxlViwT61jg32cvIAhBq1OIBw338K8ktfdzjbmrVoO4zYevFY3bAPiE7LHvos+8xzHi
         NBDuqEQq2sygtRRElIB1/22huybqqAAJE1CGTYpEyoAmWQ13XjLIkWxrcKl5w/uboOVv
         Vvfw==
X-Gm-Message-State: AOAM5301c3CeSoW3frPxUTA0uuXmSmn3767xic/ac6ZOdPqZVS3qz5Jk
        n/rkO/dHSEvAO27YwXmOKGA=
X-Google-Smtp-Source: ABdhPJztSKcPGxNuYd6U4KMEQbw94p6VkgElcmgov+fS5kEHTspA5yLgor11wltFXOwjtLL8TyTa7A==
X-Received: by 2002:a63:1142:: with SMTP id 2mr6230072pgr.263.1610609731903;
        Wed, 13 Jan 2021 23:35:31 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:b1fd:acc0:2bb9:df96])
        by smtp.googlemail.com with ESMTPSA id x20sm4442145pfc.3.2021.01.13.23.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:35:31 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] checkpatch: add fix option for COMMIT_LOG_LONG_LINE with URLs
Date:   Thu, 14 Jan 2021 13:05:13 +0530
Message-Id: <20210114073513.15773-3-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114073513.15773-1-yashsri421@gmail.com>
References: <84492ae9-7452-d296-49ab-4d37eed3b968@gmail.com>
 <20210114073513.15773-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns for long line in commit messages even for
URL lines.

An evaluation over v5.6..v5.8 found that out of 1703 warnings reported
by this class, 161 are due to the line containg URLs. Out of these 161,
53 are due to lines where URL is the first non-whitespace character of
the line.

E.g. running checkpatch on commit 3cde818cd02b ("ASoC: topology:
Consolidate how dtexts and dvalues are freed") reports this warning:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html

Provide a simple fix option by prefixing the first non-whitespace
character of the line with "Link:"

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e8851ce73149..7030c4d6d126 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3023,9 +3023,12 @@ sub process {
 		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
-			if ($line =~ /^\s*[a-z][\w\.\+\-]*:\/\/\S+/i) {
-				WARN("COMMIT_LOG_LONG_LINE",
-				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
+			if ($line =~ /^\s*([a-z][\w\.\+\-]*:\/\/\S+)/i) {
+				if (WARN("COMMIT_LOG_LONG_LINE",
+					 "Consider prefixing the URL with 'Link:'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] = "Link: $1";
+				}
 			} else {
 				WARN("COMMIT_LOG_LONG_LINE",
 				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
-- 
2.17.1

