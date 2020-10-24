Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9182979D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755990AbgJXAIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755868AbgJXAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:08:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E82C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:08:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bf6so1877005plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ELtm28Vl0mdQlp5QVj6XQMpSZ1M2eKnxUctFAp+J6CQ=;
        b=a3N6xit6/Nqlq1MUZFQ4Y4RHVbqiLwuE5DnOMiMnx6J3Hl+SEikhuBmONLM3fVip7m
         G1t/iUoiDvm9b1Sjx+0xmEpftOOx8WJwqsJU+J2V/CAuYD+MvZeo+g45lTglP2iu6Lkv
         ABBHtMSyUJg72p+gGOpfCoF7zItMd5GSCGsywMj37us49OJ+sexg9K1Khw+KFxNhfODL
         NBseTHtY+AQWAlSqfTayEv75UzDNtnLWovz2tSSQVVzH8v/DN8GN9Q4OU7cGxYUYVydw
         MCj98joQUpPnXQL2FAyiFG/CN1pIfMHctbI8Ku07JphaXx31U/zbvPqlP7wzWGK1vYZp
         H2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ELtm28Vl0mdQlp5QVj6XQMpSZ1M2eKnxUctFAp+J6CQ=;
        b=Go89y1cGbHqJSyYF6kh+KAliMkLsf2jVAZyCM+faSMYM+ket7punTdQto3EbcqugE0
         K/CYdfjMExmOm1c0SA+xHcw2l9roi4UTJEhR7syludfXBWC8gJt167OibXYPKXOGPd2L
         pAtIxvZhEUH7QOMclWKutUHkpjMnce4Z8B3r/FS9A+HHL6vxeH/sTbbYffbQUG8CzXsc
         d+KZxYsBlvUxPiIbqtEpLmkUXfTl7ntoDJlZKSdSGXS8Oq6qWzQIl7s1XOs17gbaunGq
         VFtX7oVDQEDQfxKw2xxWEdaJKODcBRK/OoCK0zOYfQ1PFnhJ9D0Hg5WcIdW4eA+yRQEL
         SAVQ==
X-Gm-Message-State: AOAM533OhEKDEGaZdkHAuz9SCvUo1lJn/wZISb29gBqWRef/x3HdaeNf
        DuQ7VJmr3+GUKn4sWXo+SoZlWv4sdZMaPAKt
X-Google-Smtp-Source: ABdhPJy6qXABwqTeRPQqVu4tiegEa8MYXN3fKBzw0WR6Uj9vdOwcRgD59rLTgrjcEGq/luyl4N/0KQ==
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr5073562pjs.181.1603498121409;
        Fri, 23 Oct 2020 17:08:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:429:6ba7:30ef:4722:a786:585f])
        by smtp.googlemail.com with ESMTPSA id bo16sm4252137pjb.41.2020.10.23.17.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 17:08:40 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH v4] checkpatch: fix false positives in REPEATED_WORD warning
Date:   Sat, 24 Oct 2020 05:38:30 +0530
Message-Id: <20201024000830.12871-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presence of hexadecimal address or symbol results in false warning
message by checkpatch.pl.

For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
memory leak in mptcp_subflow_create_socket()") results in warning:

WARNING:REPEATED_WORD: Possible repeated word: 'ff'
    00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....

Similarly, the presence of list command output in commit results in
an unnecessary warning.

For example, running checkpatch on commit 899e5ffbf246 ("perf record:
Introduce --switch-output-event") gives:

WARNING:REPEATED_WORD: Possible repeated word: 'root'
  dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..

Here, it reports 'ff' and 'root to be repeated, but it is in fact part
of some address or code, where it has to be repeated.

In these cases, the intent of the warning to find stylistic issues in
commit messages is not met and the warning is just completely wrong in
this case.

To avoid these warnings, add additional regex check for the
directory permission pattern and avoid checking the line for this
class of warning. Similarly, to avoid hex pattern, check if the word
consists of hex symbols and skip this warning if it is not among the
common english words formed using hex letters.

A quick evaluation on v5.6..v5.8 showed that this fix reduces
REPEATED_WORD warnings from 2797 to 907.

A quick manual check found all cases are related to hex output or
list command outputs in commit messages.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..1d42d08d520b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3049,7 +3049,9 @@ sub process {
 		}
 
 # check for repeated words separated by a single space
-		if ($rawline =~ /^\+/ || $in_commit_log) {
+# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+                    $rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
 			pos($rawline) = 1 if (!$in_commit_log);
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
@@ -3074,6 +3076,17 @@ sub process {
 				next if ($start_char =~ /^\S$/);
 				next if (index(" \t.,;?!", $end_char) == -1);
 
+                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
+                                my %allow_repeated_words = (
+                                        add => '',
+                                        added => '',
+                                        bad => '',
+                                        be => '',
+                                );
+                                if ($first =~ /\b[0-9a-f]{2,}\b/) {
+                                        next if (!exists($allow_repeated_words{lc($first)}));
+                                }
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.17.1

