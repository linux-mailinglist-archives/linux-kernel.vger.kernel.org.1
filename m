Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC52C50B7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbgKZIqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388950AbgKZIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:46:52 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49864C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:46:52 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so1014078pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWzSXzURBrTCAuFi2ULAXjbNlztUk23uhmIQxLwstA8=;
        b=X1DlBEaRK/h8XSg3W7UR8Me+C5pJU6VMT1yItcdV/RIzDVANmSMyw/QEeuEJPoIF2l
         xY8b3ZHn0dzsVjXwayv5gZ0qgeYNZqiuEOq8IWX/+Flps83NuxjpIPzuIC8Y9meOmhJ8
         jUdS+lqKKntTxmKX1/nsKDTo67u9Mveu0FchtfLp4CtZx9aD/e8/RkjteFbUluVfNr1c
         UypJGEaFiP6gm+pfO8fQpYfWB2NdMFOaTGcWy8Pn/nJIU8Vl0As2UiJXgkpXJvRgXwFe
         EWa7hgd8cRRRtLyF6CozQyGZMSvYCDsr1RnlBY+QAIACYciT6uKi1nFVXctLTqPL1t60
         jZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWzSXzURBrTCAuFi2ULAXjbNlztUk23uhmIQxLwstA8=;
        b=CAv+0w/9kOILQHBlRJPowyRSLKHYqkui6hppN62vtO3toVn4JEFaDdkdMH+wF4mRoI
         n/fQ/+YzORuqZ+pBnjAOz+qggKLLvPc3xXWuUc2jkMj9PDoe/5ku5OR/DybXFTApbhcn
         D1eDnaZmTsQlRq0dreNNbs/U5Gkn2Z3SqpKWxCKLagDeQoe2wjvOwnKcodfF3VZJqOxa
         fk1bnLXJs+CcPtosXTO2RcYQNrwiInU9uOb3CPuhUX+sEMDRit4hmJ5dVOMymA+yzG78
         jy8iu5nlQnr2omW/3WXaWrYpPqmDRaL13HK3ZOB1MmyNpcTxY6e+vUeloFqi0eIAvsjj
         yf/g==
X-Gm-Message-State: AOAM531sR6RYm5c9Sn1dst4dsK86yFBaKH70ePOFrOlq5P3dwY77Zt3k
        zauzbEcY0iD+MWTdOsejlQQ=
X-Google-Smtp-Source: ABdhPJx4UhOmlTuX0n0EMZr4EXVr6vb6UY0JR1UmL0QS8y8FGnPKJlWta/dyiJR7Y2u94IYsJq7q9g==
X-Received: by 2002:a17:90a:5d0d:: with SMTP id s13mr2543585pji.230.1606380411595;
        Thu, 26 Nov 2020 00:46:51 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6052:6026:75db:5ad2:e7b3])
        by smtp.gmail.com with ESMTPSA id i2sm4095132pgj.41.2020.11.26.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:46:50 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v2] checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]
Date:   Thu, 26 Nov 2020 14:16:23 +0530
Message-Id: <20201126084623.39178-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifiers %h and %hh should never be used.

Commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use
of unnecessary %h[xudi] and %hh[xudi]") specifies that:

"Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi]."

"The "h" and "hh" things should never be used. The only reason for them
being used if you have an "int", but you want to print it out as a
"char" (and honestly, that is a really bad reason, you'd be better off
just using a proper cast to make the code more obvious)."

Add a new check to emit a warning on finding an unneeded use of %h or
%hh modifier.

Link: https://lore.kernel.org/lkml/4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com/

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v2:
- Use $logFunctions instead of the manual list.
- Relocate the check to after logging continuations check.
- Remove perl_version_ok condition which is unneeded here.

 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..d1ecb852f384 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6027,6 +6027,18 @@ sub process {
 			     "Avoid logging continuation uses where feasible\n" . $herecurr);
 		}
 
+# check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
+		if (defined $stat &&
+		    $line =~ /\b$logFunctions\s*\(/) {
+			my $lc = $stat =~ tr@\n@@;
+			$lc = $lc + $linenr;
+			my $stat_real = get_stat_real($linenr, $lc);
+			if ($stat_real =~ /\"[^\"]*%[\d\.\*\-]*h+[idux].*\"/i) {
+				WARN("UNNECESSARY_MODIFIER",
+				     "Unnecessary use of modifiers %h[xudi] or %hh[xudi]\n" . "$here\n$stat_real\n");
+			}
+		}
+
 # check for mask then right shift without a parentheses
 		if ($perl_version_ok &&
 		    $line =~ /$LvalOrFunc\s*\&\s*($LvalOrFunc)\s*>>/ &&
-- 
2.27.0

