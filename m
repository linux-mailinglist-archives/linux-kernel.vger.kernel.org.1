Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B322C980F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgLAHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgLAHY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:24:27 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF52C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:23:47 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so533485pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62XovuLGP8KgQCNcEZEsMV/0NqzJQ6zEFCXEwgkuSHI=;
        b=YYUWkBfNcbQARP0QF3Xs9Ur4sBY91GGnohJLLydY5/GEVe9zJtNOmS7/yh91Q+Kif7
         R9W4uLopFWn8+/sRuPCUGvILy2Zm4C+bidh3noH76l0iH4p76pgM6oi0m3qhi4fm5l+r
         5TXQkAdcO1RtfT/4PMXTwBIEu+6hxjlOgFWc1mjEEm3gGbV6IULtBB8+pgVPcfQ3FX5w
         VK9mALaumyMCMl5dwqYPZU3BKHrpXBwDq/X7/f1UC6ouXaikBJV3ZIZhhXXAXPl0YCCW
         rD2k/m8hjigVXL3JiuG1Y+jaLLwdo7YvrHzKkYgA22vj0cTQGNblgjvlRAqmjIe9aR1Q
         veew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62XovuLGP8KgQCNcEZEsMV/0NqzJQ6zEFCXEwgkuSHI=;
        b=Vy7R2Bsd0qoX3ziE2sploB0GTGCcaNjdIXS4qnXPHkVe8qFkZMmdASbbN5MPz2H+rJ
         4CGVzI0UqtjN3RljUR84jL2NsC1iiknEyxDhRo6UJcwHznkncAafggXIvvjj3Ca/wLGj
         ans4iY1hChHMUVIo+CLWc136tqU2FSJIcQ61hcngvfo3v325GeB3nFYpCa1TYptycOcp
         TyKl62hOGPiiQ4z5XWnF6u8Pia34b7OkGQFNJvkaMsVwTsHt9FnakFTPYtj80H0se2pF
         PY/J1vmM1UBaei+Fw4cGesOtx1hZZBKt2UsVakcqLNLHm3R3/ESddWsvUrf+/iRjiIAv
         WtZA==
X-Gm-Message-State: AOAM531TpXmM3b9Qeb+1+7PEaIpewq6CQy2lWwkeWWNUe7KXqVFkKEjK
        FW60iQjQn3HNVHXbIbpf+ow=
X-Google-Smtp-Source: ABdhPJwphpb1ohLwz1072VDtVU+EMIcOBVolNX8K1bm+U7Zrj8h3CVWYDFUUAz43YAUeq5DWCLBxQg==
X-Received: by 2002:a63:100e:: with SMTP id f14mr1186665pgl.8.1606807426888;
        Mon, 30 Nov 2020 23:23:46 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60c8:895e:5a85:4183:13b9])
        by smtp.gmail.com with ESMTPSA id 17sm1386603pfu.180.2020.11.30.23.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:23:45 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v2] checkpatch: fix TYPO_SPELLING check for words with apostrophe
Date:   Tue,  1 Dec 2020 12:53:20 +0530
Message-Id: <20201201072320.44544-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reports a false TYPO_SPELLING warning for some words
containing an apostrophe when run with --codespell option.

A false positive is "doesn't". Occurrence of the word causes
checkpatch to emit the following warning:

"WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"

Modify the regex pattern to be more in line with the codespell
default word matching regex. This fixes the word capture and
avoids the false warning.

Suggested-by: Joe Perches <joe@perches.com>
Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v2:
- Use the default codespell word regex.
- Modify commit message to specify --codespell usage

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c86ea737e9c..bd6304f93e0a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3106,7 +3106,7 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
+			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
 				my $typo = $1;
 				my $typo_fix = $spelling_fix{lc($typo)};
 				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
-- 
2.27.0

