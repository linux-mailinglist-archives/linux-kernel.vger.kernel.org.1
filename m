Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E528D271320
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgITJRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 05:17:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562FC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 02:17:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so5614014pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLh8jEiP3fcWPoHCO2EhENY21oC8+9SSibluvL2NtU4=;
        b=fmVPGfwwy5eZhM+d8MjZv60YBKPgMpyFq2LDJVDHKIUq37RzzeenWObfbgY+hddE2W
         p3mJFn8tU/kXzNnknxh3U25qIaZtYPa4bNuxhqIK4SxpUy5y8TQQT8+JU42sbhVZSflR
         W45IIchFhppXZq4L3T2Arttnv9NVjOe8a2EHH2jPHRbPYC00ZjR1q+Epqbxts6dopTXR
         ELm5JgF4BJyPr4Tni5Jfn66Iim62IHAF20+yhn3oxW5gRk3ScmEPloV+tsOTEjnYrhaA
         s9mr3uCPTcdhLX4LDgPFniRw6Z9Sdxx4N/uC7XRMd0D2TypYa3v1rCyXiWO3yS5nudVL
         K4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLh8jEiP3fcWPoHCO2EhENY21oC8+9SSibluvL2NtU4=;
        b=pPzroQEcWCyd5mOWfDMrBCZSX6kjBvbpDWHTIJv3SIvnviR/QLiEasdekKvP1yvPCS
         rY0QdHEMCqb7r6ElYMMDJCpCu6v3fSMk4LMJPkFS+Le52MItM2NcbR8MrPpOZppcVkuk
         rkCJeVDpLuzefX9HChmewgOuyiYSIXldX7TpNbNHq0Lk1jGPuzaraNSOKeQwqPbutPyY
         1wob1optWyS898zFQGJomFeeAGB3GS5QqsMRQA9PbwTd7Pwmg+KusRfpuG3ECKlP0dsd
         06+9bP99XN10xnpbHZYU2IXsvd3T8nLDfhmfBAkaVWAHjqnXzf+PIqc8BQ5+TNI3eK61
         mJ0A==
X-Gm-Message-State: AOAM531CGEMjFLZ9n9V/8/5qK8KrDNtL2z/3mXyTQjSsJJinhuS/HVlV
        Icu3ikNkvbzjtKRrGp1hXqE=
X-Google-Smtp-Source: ABdhPJxzIP3Cg0MyB9MnH3OFDdRe2j6bU1fI0acOTGmlSCk4qG0s4wPL0VpNu00L+sBMtRm7R7HKRg==
X-Received: by 2002:a17:90b:4718:: with SMTP id jc24mr19312829pjb.214.1600593461301;
        Sun, 20 Sep 2020 02:17:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6887:77d0:e456:ba13:9d2d])
        by smtp.gmail.com with ESMTPSA id w10sm8658942pgr.27.2020.09.20.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 02:17:40 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: extend author Signed-off-by check for split  From: header
Date:   Sun, 20 Sep 2020 14:47:06 +0530
Message-Id: <20200920091706.56276-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch did not handle cases where the author From: header
was split into multiple lines. The author identity could not
be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
warning.

A typical example is Commit e33bcbab16d1 ("tee: add support for
session's client UUID generation"). When checkpatch was run on
this commit, it displayed:

"WARNING:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal
patch author ''"

This was due to split header lines not being handled properly and
the author himself wrote in Commit cd2614967d8b ("checkpatch: warn
if missing author Signed-off-by"):

"Split From: headers are not fully handled: only the first part
is compared."

Support split From: headers by correctly parsing the header
extension lines. RFC 2822, Section-2.2.3 stated that each extended
line must start with a WSP character (a space or htab). The solution
was therefore to concatenate the lines which start with a WSP to
get the correct long header.

Suggested-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/linux-kernel-mentees/f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com/
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..9e65d21456f1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2661,6 +2661,10 @@ sub process {
 # Check the patch for a From:
 		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
 			$author = $1;
+			my $curline = $linenr;
+			while(defined($rawlines[$curline]) && ($rawlines[$curline++] =~ /^[ \t]\s*(.*)/)) {
+				$author .= $1;
+			}
 			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
 			$author =~ s/"//g;
 			$author = reformat_email($author);
-- 
2.27.0

