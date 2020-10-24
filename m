Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB7F297BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760924AbgJXKXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760916AbgJXKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 06:23:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805AEC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 03:23:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r10so3128631pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TW0QDJwCpRN+e9wSIAwnUCXLcSQzbcqS3iQfCVGdyHI=;
        b=tebyPb+UpZYBlJOP808zL4Tpl4gDzkJRzwZimWEA4zaEV9IW8sG8P1+mYZXYszOx90
         IQhlq4aCOaIRce9LE3E8xQpjDoBt7Mu2BqOn9uCCEmdeMnWqqPFF0B+tRO3AXYVSzb0C
         fCNtilLtJaElIW5oMgFxuOx9fPbEGlvjradg50ytzCACwjcHQ9VJez8RiFMEGl0WbJJJ
         QtXTCWjsHlpG57bjUfoclQxgoXHI0BjJTF15vxmBVPATQqtORsfYBEMt6+9merl40OCz
         qt6XJVpJmihUPEcWca6cmd4w06kh7kglS8JBEzUnPUv2WAeOh1mFXHx/XysmJx1BKDks
         wQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TW0QDJwCpRN+e9wSIAwnUCXLcSQzbcqS3iQfCVGdyHI=;
        b=O5qi7G+rJ0Su7zfTXdGFFCrb5WczIvEl79Kk36Lnmet1SPp62rxdW0wfIFx5jpBTrA
         MKB4JC4rFz249+8tViv6QRfvYVyC9IN2YBhPromf6Qn4sTiFCBbKSv8pRq1bdGkj/I36
         6yS8niSnaDySjagd+jiT6U85UKtLqCBQq9LncQFchOcJc3s+DoWJ40Ga7MRAeyGAq1of
         kLXYfhO7h5Tk7tWQYMcD6QS9L77wd3oapqLPHb/4o+XOLzEmyR670/xHQAV+dha2XdEF
         CwW8sMVp74oABe25qcwXhsZaU1MHr7AVeam+P0GKt0YrD3Jf27nEtq+Rpp4DWFz2sko3
         vkRg==
X-Gm-Message-State: AOAM530XU60pe1doVxMhiQvCBnPhfV2ZoEkixNaaTK1kIf+bbQFj2Zef
        HtUWSJ4kJsF+HmP9XLlsEVc=
X-Google-Smtp-Source: ABdhPJy5l3E3Hsspr8E8VNeRm7cjQv3TA/Xr1wJfE++FJKlNVg7aejHcDC1bikXbQFU1Pnh/IcspZw==
X-Received: by 2002:aa7:96ce:0:b029:155:8c02:e74a with SMTP id h14-20020aa796ce0000b02901558c02e74amr3136988pfq.32.1603534987552;
        Sat, 24 Oct 2020 03:23:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:40f:9156:55ee:fad5:f15e:347e])
        by smtp.googlemail.com with ESMTPSA id v65sm4405024pgv.21.2020.10.24.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 03:23:06 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com, Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH v5] checkpatch: fix false positives in REPEATED_WORD warning
Date:   Sat, 24 Oct 2020 15:52:53 +0530
Message-Id: <20201024102253.13614-1-yashsri421@gmail.com>
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

Here, it reports 'ff' and 'root' to be repeated, but it is in fact part
of some address or code, where it has to be repeated.

In these cases, the intent of the warning to find stylistic issues in
commit messages is not met and the warning is just completely wrong in
this case.

To avoid these warnings, add an additional regex check for the
directory permission pattern and avoid checking the line for this
class of warning. Similarly, to avoid hex pattern, check if the word
consists of hex symbols and skip this warning if it is not among the
common english words formed using hex letters.

A quick evaluation on v5.6..v5.8 showed that this fix reduces
REPEATED_WORD warnings by the frequency of 1890.

A quick manual check found all cases are related to hex output or
list command outputs in commit messages.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e505688257a..519da711cb12 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -853,6 +853,13 @@ our $declaration_macros = qr{(?x:
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
 )};
 
+our %allow_repeated_words = (
+	add => '',
+	added => '',
+	bad => '',
+	be => '',
+);
+
 sub deparenthesize {
 	my ($string) = @_;
 	return "" if (!defined($string));
@@ -3049,7 +3056,9 @@ sub process {
 		}
 
 # check for repeated words separated by a single space
-		if ($rawline =~ /^\+/ || $in_commit_log) {
+# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+		    $rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
 			pos($rawline) = 1 if (!$in_commit_log);
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
@@ -3074,6 +3083,11 @@ sub process {
 				next if ($start_char =~ /^\S$/);
 				next if (index(" \t.,;?!", $end_char) == -1);
 
+                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
+                                if ($first =~ /\b[0-9a-f]{2,}\b/i) {
+                                        next if (!exists($allow_repeated_words{lc($first)}));
+                                }
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.17.1

