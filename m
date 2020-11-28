Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F22C73F6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbgK1Vtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbgK1SAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:00:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1837C0253F4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 09:39:01 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f17so6855553pge.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lr0Q5Uwc3CpXfcZqNsuuT98OLf5ZKK5wEqy52e9CRk=;
        b=BHoZStE5yUD85I3A7PXIN9sCE5AeRtlgGZZx9Crxq5C48tz3dcWRIYTIUwZvKOeymW
         zd5/d7HS/W8gjM5NlP14Fp0eLgfgYo4iuE2zfXG1V+F6MBo7Mpr89AwvahVBsQKmbpn6
         DoT/agWf2RFU7VbCG/vZKxlGQ7QELbAGQ4I2EP+6Vh0HKOy65kaki9w9ezl9EPrpgYJu
         UHx8vMG1ccrpznSVTBADc2YaYF36KAFiR+guF6d8biH9WYJIbn/hQggCvxp4HXvAFyaL
         fx5oBebd2XN5dHl1K2QxQLNUEd71o0xIan1jV4VaZeE8UjFqenmCmKkbIqkEKtJvg9UX
         WRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lr0Q5Uwc3CpXfcZqNsuuT98OLf5ZKK5wEqy52e9CRk=;
        b=RQhkW+GWKb614xnB9IZ7foc/W7oNu7L4m/9sZnN0TWf/gS0hodgNceBoL3O5IvwrXQ
         mIpD5hII6tui1jxePWB/9L8sZqMYEq0l6EnaO1HI4faTPjy0/T2kYsMnBPC9J6wTrjry
         mnt2NmLJI6G166gpuytM1VkZAGwRhZsyeEp5nPmtLX/O5s+HbdDHteKeeU/Fm7NTmDe5
         W3LhdKtxKFV0vGfWBqk7L9YLq9IPJ65MlIVoI1ytAifhmDqx82A7USC1jt5Gtx/VS5kT
         hnj59LGVkXmR3VVtvztDPn10CMNlHEFkMhGLez0TZikDUznlCsxhJ2wJGqymtypdJpau
         TqmQ==
X-Gm-Message-State: AOAM531jGwz6Xs+pu9J6WPsPM6aBG5V8QJ93csN8wk01YbRQgrUag/1t
        YgBds5OwA8NowaEjb1viYI8=
X-Google-Smtp-Source: ABdhPJypXtG+f192A1K6LnjTqSc6pl0yRhSWq+anfN/4Vy1n/09H8nwnmCnm2Yw7rOLgPTNV4LUNjg==
X-Received: by 2002:a63:cb47:: with SMTP id m7mr10941883pgi.395.1606585141088;
        Sat, 28 Nov 2020 09:39:01 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60e2:4a86:2299:c009:477b])
        by smtp.gmail.com with ESMTPSA id q14sm11653885pfl.163.2020.11.28.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 09:39:00 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v3] checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]
Date:   Sat, 28 Nov 2020 23:08:50 +0530
Message-Id: <20201128173850.66509-1-dwaipayanray1@gmail.com>
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

Also add a fix option to the check.

Link: https://lore.kernel.org/lkml/4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com/

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v3:
- Change warning message
- Fix regex match to include capture group
- Warn on every unnecesary use of %h on a line
- Add fix option when the format line matches current line

Changes in v2:
- Use $logFunctions instead of the manual list.
- Relocate the check to after logging continuations check.
- Remove perl_version_ok check

 scripts/checkpatch.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..dc25d32f0c5f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6027,6 +6027,22 @@ sub process {
 			     "Avoid logging continuation uses where feasible\n" . $herecurr);
 		}
 
+# check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
+		if (defined $stat &&
+		    $line =~ /\b$logFunctions\s*\(/) {
+			my $lc = $stat =~ tr@\n@@;
+			for (my $cur_ln = $linenr; $cur_ln <= $linenr + $lc; $cur_ln++) {
+				my $cur_rawline = raw_line($cur_ln, 0);
+				while ($cur_rawline =~ /^\+.*\"[^\"]*(%[\d\.\*\-]*h+[idux])/g) {
+					if (WARN("INTEGER_PROMOTION",
+						 "Using 'h' in $1 is unnecessary\n" . "$cur_rawline\n") &&
+					    $fix && ($cur_ln == $linenr)) {
+						$fixed[$fixlinenr] =~ s/(\"[^\"]*%[\d\.\*\-]*)h+([idux])/$1$2/;
+					}
+				}
+			}
+		}
+
 # check for mask then right shift without a parentheses
 		if ($perl_version_ok &&
 		    $line =~ /$LvalOrFunc\s*\&\s*($LvalOrFunc)\s*>>/ &&
-- 
2.27.0

