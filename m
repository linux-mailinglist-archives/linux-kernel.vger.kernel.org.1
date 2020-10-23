Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1122970C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465066AbgJWNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375335AbgJWNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:39:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05588C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:39:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e10so1325717pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uws+JYyiHml5EpGq+vV5iyy96yuu5XLUr066AbKDfI8=;
        b=MbsGjegxzI0teFzRZSVx9j0E/NXIRk8k6/wqGbQVRxWnh+AN0PUP5wbti2gfnqtSI7
         Kl7WxroJxfCeq4CknbLZShPVbc/BaHXsrHfs7Q79S96SJz5FoDtoxTZvb/DQcYGuEH1w
         3Vjz2Iq1j7p3qAMgRx8CZyU+PbCmnf46Hd9WCjviXkHPEr2FQ1z4p5yo1H8hSNUYZktr
         2yH2RVVrrg2N7iDaDYt5rLAlwJ9uzNDpA3CnCZboQwWuOF191pim1coL6uHwap5Ll1Rk
         hs5i0a9t1RL967ZT3JT2GdYTsurO3aFVdQ4+p38BpgAAtraLnOju0HS7bGFxGXJdxWUX
         JpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uws+JYyiHml5EpGq+vV5iyy96yuu5XLUr066AbKDfI8=;
        b=cnscYJOa+8/dsu/TnUV7c53jOhJUjCTMOPinICCIEDJzPzvA9mr6bhGjG5aZr/x0p8
         diovFUAN37ti1b0JQS7hHqADjtwnzmyaHnlorQrUedkRdChzxD1K0BKmhBg1RjtudAkS
         O6GHROketkeuR2Xz0dCEjo/GzdPCTSvKKjFLuJD4BjLjjrY+6RIoRYIXCR+ilpxb7N+S
         /8aTMg0PBDTC5d+8MQUwr0Tl4YyZM15qW8XWRMWkCIP1NXiPZskDhcWJP/8OE1u55bqx
         xwjQ75BOrCnURDr/Ff5o7KDQOwHXdLOsoEwpK7lzaF1tj0V2kUC2a1Uw3HjI72WQDuIL
         SDPA==
X-Gm-Message-State: AOAM530Opf8Kjnh81KGjMHfHIsT/4vaeJ84xTO3i458H+Sv4t5BEXyzt
        5wKUz/Xp0IfUULSJ/KCzcaw=
X-Google-Smtp-Source: ABdhPJzublLYTRPjOB1KBR4G7XBHj4nlp5zrC+neZQ8N2fPuRMGgDLGyJrnPYHDaUprRnfLalqn5TA==
X-Received: by 2002:a17:90a:65cc:: with SMTP id i12mr2569971pjs.193.1603460338119;
        Fri, 23 Oct 2020 06:38:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:429:6ba7:30ef:4722:a786:585f])
        by smtp.googlemail.com with ESMTPSA id z23sm1932467pgf.12.2020.10.23.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:38:57 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD warning
Date:   Fri, 23 Oct 2020 19:08:28 +0530
Message-Id: <20201023133828.19609-1-yashsri421@gmail.com>
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
index 9b9ffd876e8a..3bd8205c48d8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3051,7 +3051,9 @@ sub process {
 		}
 
 # check for repeated words separated by a single space
-		if ($rawline =~ /^\+/ || $in_commit_log) {
+# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+				$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
 				my $first = $1;
@@ -3065,6 +3067,17 @@ sub process {
 				next if ($first ne $second);
 				next if ($first eq 'long');
 
+				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
+				my @non_hex_words = (
+					"add", "added", "ace", "aced", "bad", "be", "bed", "bead",
+					"beaded", "bedded", "cab", "cabbed", "cede", "ceded",
+					"dead", "deaf", "deb", "decade", "deed", "deface", "defaced", "efface",
+					"effaced", "face", "faced", "fade", "faded", "fed", "fee", "feed"
+				);
+				if ($first =~ /\b[0-9a-f]{2,}\b/) {
+					next if (!grep(/^$first$/, @non_hex_words));
+				}
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.17.1

