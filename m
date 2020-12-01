Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA102CAB70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbgLATIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:08:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:07:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7so729971pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k8wUreye3hCNgABtnnchdmZJU7MZ67yxVUTCzDbwog=;
        b=lhG+TSz3ardhgBQ9dPVuDdxEIl1Ve6Ccd1W9EqdIgLHW/SZMygOp9OfwtIWYrl4AlR
         Ql4GlNd7kbNDtHcXedFUk676XxkIQJLv/W3EhzLi8H4PfRL08pDThptzWSsK+4asyAHI
         WEjIF+7wEuPDfoEqi/phQflBBzh3wKc2aZfbhJmKgt95iUFkikctJL4XEe5mlbDfzRGy
         yMeuK0NAw38gPooe+qoK/sm93vL58T4gH3qoTzq6BId9uqqG2IjrAr4OrHWhEmyF7oId
         aEdtVgvBBl0YFNvktODpJYj4o2mErAWCmg26KhP9uFM8w1QASfyIO6xXdn0IvHLwKki0
         OCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k8wUreye3hCNgABtnnchdmZJU7MZ67yxVUTCzDbwog=;
        b=WaVEi85E5iePJKRGxr9Ac40G9JDxQxmQPp5eRJI30IN5Vww7OyrT0Q6FmcH9diUdAW
         CILHNMBBA8YT294IF1xhIF99TavT2zwQNQPHEb6Qukx1WtDQbw6+fgrG5maf64BhR6ld
         t3NC+lpROFy+b2XWuT0uHo2mmPeHAPshXPnzDc5wUlB9SPHDgXuYnZmwfThVI3nvKA76
         K3Kr1qr+LcmuKuED9D1IIy/whEK5MdnH+LDU+v7d/MtAqJVAbtFHTYYFobN9/dooEuKb
         eYAvKQX1aK9UVfkGXzYh5iYuzcfuQ0XxWmT/BGGK/wx3kxlfAdRQbF4QH/Cmlar+3PG7
         /dhQ==
X-Gm-Message-State: AOAM530kOiKWRuTLSZuOIfLZ2vh/48FzvXQ5lNxmEsrNP7ke5okmAaI5
        FaVEbuO5+N+eNpd3+sZTI1Y=
X-Google-Smtp-Source: ABdhPJw7JUuqwHqfCFuKuypu53c9dXCyg9LdIc+Dy2wj/D/8atMP2VmSUDxkTQ/PwS6U9Bdrgk4tKw==
X-Received: by 2002:a17:902:9049:b029:d5:eadd:3d13 with SMTP id w9-20020a1709029049b02900d5eadd3d13mr4062836plz.15.1606849678311;
        Tue, 01 Dec 2020 11:07:58 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60c8:895e:5a85:4183:13b9])
        by smtp.gmail.com with ESMTPSA id p1sm486815pff.131.2020.12.01.11.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:07:57 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3] checkpatch: fix TYPO_SPELLING check for words with apostrophe
Date:   Wed,  2 Dec 2020 00:37:29 +0530
Message-Id: <20201201190729.169733-1-dwaipayanray1@gmail.com>
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

In addition, highlight the misspelled word location by adding a
caret below the word.

Suggested-by: Joe Perches <joe@perches.com>
Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v3:
- Highlight misspelled word location using a caret

Changes in v2:
- Use the default codespell word regex.
- Modify commit message to specify --codespell usage

 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c86ea737e9c..e8c1ed0b1fad 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3106,15 +3106,18 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
+			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
 				my $typo = $1;
+				my $blank = copy_spacing($rawline);
+				my $ptr = substr($blank, 0, $-[1]) . "^";
+				my $hereptr = "$hereline$ptr\n";
 				my $typo_fix = $spelling_fix{lc($typo)};
 				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
 				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
 				my $msg_level = \&WARN;
 				$msg_level = \&CHK if ($file);
 				if (&{$msg_level}("TYPO_SPELLING",
-						  "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $herecurr) &&
+						  "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $hereptr) &&
 				    $fix) {
 					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($typo)($|[^A-Za-z@])/$1$typo_fix$3/;
 				}
-- 
2.27.0

