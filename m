Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96C2651DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgIJOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 10:37:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54803 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgIJOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:33:08 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08AEWIaV025201;
        Thu, 10 Sep 2020 23:32:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Thu, 10 Sep 2020 23:32:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08AEWDFb024973
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Sep 2020 23:32:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] checkpatch: accept longer commit description lines
Date:   Thu, 10 Sep 2020 23:32:08 +0900
Message-Id: <20200910143208.3837-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that commit bdc48fa11e46f867 ("checkpatch/coding-style: deprecate
80-column warning") was introduced because nowadays most of us are using
screens that can print more than 100 columns, most of us will be also
using mail clients that can print more than 100 columns. Since 75 chars
limit for commit description lines is sometimes inconvenient for obeying
'commit <12+ chars of sha1> ("<title line>")' style or embedding URLs,
loosen the limit by 20 chars.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..bebeef90fc61 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2800,9 +2800,9 @@ sub process {
 			$commit_log_possible_stack_dump = 1;
 		}
 
-# Check for line lengths > 75 in commit log, warn once
+# Check for line lengths > 95 in commit log, warn once
 		if ($in_commit_log && !$commit_log_long_line &&
-		    length($line) > 75 &&
+		    length($line) > 95 &&
 		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
@@ -2811,7 +2811,7 @@ sub process {
 					# A Fixes: or Link: line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			     "Possible unwrapped commit description (prefer a maximum 95 chars per line)\n" . $herecurr);
 			$commit_log_long_line = 1;
 		}
 
-- 
2.18.4

