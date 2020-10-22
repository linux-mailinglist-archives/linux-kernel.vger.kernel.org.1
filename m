Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9F29611E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508257AbgJVOuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444617AbgJVOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:50:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E3BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:50:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y1so1079887plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MaModaN+/sVf8Cgdp6hffgsQePCGB5G1xW2BzLPiDLI=;
        b=ATORAaEHRLju/xDhnBYQSd9eUdaapI2TLLsacoAfLCpdq9lnS6eOHqC4pEVo+zrfhr
         usStwU5K1pnL2dS/ZY0aa1ahfQDbFB4jmNDYRsUfJ6QMvZxHpQJoECnPkvsXjbSNIIWk
         lmZWq+PGjIRktcem4Ubt98ReS4My/MIuA2kH7R1NpYRYTR/YTSAR+IeAPvt2bOUmjFi7
         vg7/F6lhXoQWvdXltMIQ5CqZCuiGMSk8G9/7axIqsUQoMOfKlHrga4nDhAkUBSAroNFX
         uq3Tw5+36IYjY08Lm6bgTUGs+uEU3HXow1kWcKdTFEKw252ZJBglcXhuRqU4+O8PkIhV
         JgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MaModaN+/sVf8Cgdp6hffgsQePCGB5G1xW2BzLPiDLI=;
        b=awocmDPCXr3DxE2NyWQnM05oRJe1Ft7ktgcqAFXEbA2ldaLnLH1/AbyJN2eJbg6JxF
         oACwcL/Tjk4T5iP0cgtH5trDvksdjsFUVfDYQfD0Sm+w16mcAQfEbYK3huAH0XmylZKF
         vYNDL/wifYAg60GOmlshcWHJdu0dxCNcZ4XvUZrLd6MbQnU5jgIT3c4LFu1HOI7iVCBW
         rKcsMDk0CV2QQQFvY9pvoQ2Ac1DAGbyXFBSsfyZK829OwPvfan7KaL7qfPuzDSrb8zUy
         QoqUIl5z/IYWPvL5uDEHuFonNEPUMBNoY8ASKdM+lglFbS+KwnggR9hMqU787r6YQ6w4
         ciqw==
X-Gm-Message-State: AOAM533H1y3JXPleTp8jF7B2Qi0lXXkBYrHshGQgbp3Rvd6DkIqAi0R2
        4xtcD2N4rGCVRX0xeDt3jnSBU5jMT4sQT5Fo
X-Google-Smtp-Source: ABdhPJz/5oVSh4IIHytnN2Co+bqhq3sqEBCvWFuNxfM3wiApT3nuTVQ9lgs4YfCQ/fBAGeeF81a3TA==
X-Received: by 2002:a17:90a:3007:: with SMTP id g7mr2692283pjb.58.1603378247164;
        Thu, 22 Oct 2020 07:50:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1])
        by smtp.googlemail.com with ESMTPSA id c187sm2871677pfc.153.2020.10.22.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:50:46 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD warning
Date:   Thu, 22 Oct 2020 20:20:21 +0530
Message-Id: <20201022145021.28211-1-yashsri421@gmail.com>
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
consists of hex symbols and skip this warning if, it forms a pattern
of repeating sequence or contains more special character after pattern
than non hex characters.

A quick evaluation on v5.6..v5.8 showed that this fix reduces
REPEATED_WORD warnings from 2797 to 907.

A quick manual check found all cases are related to hex output or
list command outputs in commit messages.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9b9ffd876e8a..0f57e99ed670 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3051,7 +3051,10 @@ sub process {
 		}
 
 # check for repeated words separated by a single space
-		if ($rawline =~ /^\+/ || $in_commit_log) {
+# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
+			my @hex_seq = $rawline =~ /\b[0-9a-f]{2,} \b/g;
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
 				my $first = $1;
@@ -3065,6 +3068,34 @@ sub process {
 				next if ($first ne $second);
 				next if ($first eq 'long');
 
+				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
+				if ($first =~ /\b[0-9a-f]{2,}/) {
+					# if such sequence occurs more than 4, it is most probably part of some of code
+					next if ((scalar @hex_seq)>4);
+
+					# for hex occurrences which are less than 4
+					# get first hex word in the line
+					if ($rawline =~ /\b[0-9a-f]{2,} /) {
+						my $post_hex_seq = $';
+
+						# set suffieciently high default values to avoid ignoring or counting in absence of another
+						my $non_hex_char_pos = 1000;
+						my $special_chars_pos = 500;
+
+						if ($post_hex_seq =~ /[g-z]+/) {
+							# first non hex character in post_hex_seq
+							$non_hex_char_pos = $-[0];
+						}
+						if($post_hex_seq =~ /[^a-zA-Z0-9]{2,}/) {
+							# first occurrence of 2 or more special chars
+							$special_chars_pos = $-[0];
+						}
+
+						# as such occurrences are not common, it is more likely to be a part of some code
+						next if ($special_chars_pos<$non_hex_char_pos);
+					}
+				}
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.17.1

