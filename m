Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC22C713E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbgK1VzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387635AbgK1UBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:01:35 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D1C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:00:55 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id n137so7410869pfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nZU8qf4YgD6zzI9n1LIw7CWJC/0Je3ODzydn48QlHPM=;
        b=H14FXKXpkIVQ0pwwBAhxN7Byw/nmqxb22FlD21mBVlQDOrB/YrD2CnNvGNfDv/+tT/
         mkd5VaVKhDu1x4TYr8nNOZSCbN/jSRhhEmBaM7Cpgybo7/QzS2AofQRNvyN5Cc29b9zf
         P5QvM+5HgiBw/rg3ONHdLcMso5lkWI+7V9qQTletNZQUX0C5nmjkCNY38tAUh7TW7tbA
         qGtSfzeDa0QJzdy90pWfgvgMArF11rqXuydRBJcdxXZOFYO4ftU3zRdhqRCAFx/wTlmO
         Uar1GCfIM6nw+mnG2bpbXnAXl7nxiuoPdUuNqtLaxtOYVKnfaxTjHhGLrb/e2iHeYbX9
         g/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nZU8qf4YgD6zzI9n1LIw7CWJC/0Je3ODzydn48QlHPM=;
        b=GMvp03I6Yk/ItH3mFaRtHbBXmle8VtLbxd/+9DsXeI2OzLl0syylFGF+wkvleKDXA4
         9Rxb8KVX+GzUorS4jsjuq/EmTj1xzP8O/Sz4Ab3dP9hipCpEi7LjWA00ZQIcmLi92PYQ
         e3I3Lo0f6gsWs45gLv/I2ikOojM6+dLewIBtfjQ31S2PLmS5s3Gmx2yaLqu9bZBpOxGc
         DN7csx84YRkNjbnH7iXvJvCuhteIlzlgUyJWKwGQNoYwvW+qAo1xbX1yKWMGNR3TCdpr
         oflkWQthkjP7evKZNWButDmBVWVuvn2EzsrbxUpHML1sHYQSK3lXHRiFZvWYhHdpp2ND
         D39w==
X-Gm-Message-State: AOAM533IS8kF9RDbHbXIdTkizIvlGBq1RLh0ps+UZPT9QjRijzX34tbU
        zUCQDw4s7iwYLtSPR5GG6LI=
X-Google-Smtp-Source: ABdhPJzGfT6TnNIkWw4wmxuh5ospbXqG8HO5n37D6R3i5y+O/21sL+ABmSlEBKf85z/xi/THPCpC+A==
X-Received: by 2002:a17:90b:2344:: with SMTP id ms4mr3584506pjb.43.1606593654833;
        Sat, 28 Nov 2020 12:00:54 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60e2:4a86:2299:c009:477b])
        by smtp.gmail.com with ESMTPSA id o2sm2946450pgq.63.2020.11.28.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 12:00:53 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v4] checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]
Date:   Sun, 29 Nov 2020 01:30:46 +0530
Message-Id: <20201128200046.78739-1-dwaipayanray1@gmail.com>
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
Changes in v4:
- Change warning type and message
- Use $stat_real and calculate line offset during matches
- fix option now works for any patch line
- # was added to format block to match %#06hh

Changes in v3:
- Change warning message
- Fix regex match to include capture group
- Warn on every unnecesary use of %h on a line
- Add fix option when the format line matches current line

Changes in v2:
- Use $logFunctions instead of the manual list.
- Relocate the check to after logging continuations check.
- Remove perl_version_ok check


 scripts/checkpatch.pl | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..3c86ea737e9c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6027,6 +6027,28 @@ sub process {
 			     "Avoid logging continuation uses where feasible\n" . $herecurr);
 		}
 
+# check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
+		if (defined $stat &&
+		    $line =~ /\b$logFunctions\s*\(/ &&
+		    index($stat, '"') >= 0) {
+			my $lc = $stat =~ tr@\n@@;
+			$lc = $lc + $linenr;
+			my $stat_real = get_stat_real($linenr, $lc);
+			pos($stat_real) = index($stat_real, '"');
+			while ($stat_real =~ /[^\"%]*(%[\#\d\.\*\-]*(h+)[idux])/g) {
+				my $pspec = $1;
+				my $h = $2;
+				my $lineoff = substr($stat_real, 0, $-[1]) =~ tr@\n@@;
+				if (WARN("UNNECESSARY_MODIFIER",
+					 "Integer promotion: Using '$h' in '$pspec' is unnecessary\n" . "$here\n$stat_real\n") &&
+				    $fix && $fixed[$fixlinenr + $lineoff] =~ /^\+/) {
+					my $nspec = $pspec;
+					$nspec =~ s/h//g;
+					$fixed[$fixlinenr + $lineoff] =~ s/\Q$pspec\E/$nspec/;
+				}
+			}
+		}
+
 # check for mask then right shift without a parentheses
 		if ($perl_version_ok &&
 		    $line =~ /$LvalOrFunc\s*\&\s*($LvalOrFunc)\s*>>/ &&
-- 
2.27.0

