Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B82B3928
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 21:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKOUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 15:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgKOUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 15:30:05 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2544BC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 12:30:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y7so11386117pfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 12:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uchtDpHIzTRX4R0TzTTXvMsifqvBDrgCOU4Whu1bLBA=;
        b=eTaiHgE1kP9MxX8kHMxyC4jz5qjt8kweGXoui7jzCeB5Jnjgp9fGzRSXo5s+QsIBsZ
         c2h7WIE9l6Ve8zgSIXUYzlztkGJRv31L0KzbbSg5CnrYhZdIsQnLCS+Q5I+cdGNbDDMH
         6UxX59mwvi6BikxcSZYqlGMOKnJHGa544c5JT/NwE3F6SDiaq+Fioan8oWmvYbXx6WOT
         bHsXuv81CiK3jke/03AjBYggFX3kkp1vXCKFj5j0lkV28htQ+HZ4whPf5ZCtEF/DeBRy
         2UKMkemEgQjUDe+13XBCgk3qLsORcepMljx217wh4P+JINId7ESWfdroAnjpfuBlKIGZ
         Ku3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uchtDpHIzTRX4R0TzTTXvMsifqvBDrgCOU4Whu1bLBA=;
        b=n3Va1JCktsMylD6B8qELc9fb6KGUwI4lK5F73HA4KSvvH9ElddzHg6KnRVM2q9IAX7
         sRm3bNWW34isKOxxp9QTFe8/3NEA+vdmVFM0hrCBqlEr9QM3so4rlbzzrD2bad322hKL
         g9rt/Y45EupmRmuiNHkmeyVTD7j9/Vq+0h44YMBOPtqf8fiz1Z27w13DHSYhvG+/f9LH
         5h2xgNN2W9bHvkR/PS1LUZkq9DjS+6sSG5BPoW3jhXvfgKzvknUPae955xp9pFbtY2MT
         jW3cicGm7rwaS8gVjbEiZArZRe30wjweEo0zPPiHx0KjzTNtRiojAaKGvFqWdxxDF3Tx
         2LzA==
X-Gm-Message-State: AOAM531viU2Znm5chjjMJDTWYM1rffxC9KdrL7A0HEibrUhxgKgWiYMF
        kvjXXXkAenIi+RYxxcibWbc=
X-Google-Smtp-Source: ABdhPJxgJCZQBqHb4PFvyN+HU+G4OGLVSvsKzfA4M/r2PDUR2nGQFefU0pcFc0uKnIWhqL9/VuDmxg==
X-Received: by 2002:a62:1901:0:b029:18c:659c:e55f with SMTP id 1-20020a6219010000b029018c659ce55fmr11561621pfz.51.1605472204549;
        Sun, 15 Nov 2020 12:30:04 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6810:256a:6eb7:36cf:abda])
        by smtp.gmail.com with ESMTPSA id l9sm8127573pjy.10.2020.11.15.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:30:03 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: Fix unescaped left brace
Date:   Mon, 16 Nov 2020 01:59:28 +0530
Message-Id: <20201115202928.81955-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unescaped left brace in a regex in OPEN_BRACE
check. This throws a runtime error when checkpatch is run
with --fix flag and the OPEN_BRACE check is executed.

Fix it by escaping the left brace.

Fixes: 8d1824780f2f ("checkpatch: add --fix option for a couple OPEN_BRACE misuses")
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2749f32dffe9..0da6422cd0fd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4505,7 +4505,7 @@ sub process {
 			    $fix) {
 				fix_delete_line($fixlinenr, $rawline);
 				my $fixed_line = $rawline;
-				$fixed_line =~ /(^..*$Type\s*$Ident\(.*\)\s*){(.*)$/;
+				$fixed_line =~ /(^..*$Type\s*$Ident\(.*\)\s*)\{(.*)$/;
 				my $line1 = $1;
 				my $line2 = $2;
 				fix_insert_line($fixlinenr, ltrim($line1));
-- 
2.27.0

