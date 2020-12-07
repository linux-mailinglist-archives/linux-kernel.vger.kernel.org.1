Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037F82D1E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgLGXue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:50:34 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43320 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgLGXud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:50:33 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 18:50:33 EST
Received: from cip2b2.informatik.uni-erlangen.de (cip2b2.cip.cs.fau.de [IPv6:2001:638:a000:4130:131:188:30:70])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 9F6EF240B55;
        Tue,  8 Dec 2020 00:43:40 +0100 (CET)
Received: by cip2b2.informatik.uni-erlangen.de (Postfix, from userid 68486)
        id 964B75405DD; Tue,  8 Dec 2020 00:43:40 +0100 (CET)
From:   Philipp Bruegmann <philipp.bruegmann@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@i4.cs.fau.de,
        Philipp Bruegmann <philipp.bruegmann@fau.de>,
        Tobias Langer <langer@cs.fau.de>,
        Ferdinand Schober <ferdinand.schober@fau.de>
Subject: [PATCH] checkpatch: Add checking if from-author sign-off is last
Date:   Tue,  8 Dec 2020 00:42:12 +0100
Message-Id: <20201207234212.26008-1-philipp.bruegmann@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a check if the last Signed-off-by is by the From: author.

submitting-patches.rst states 'the last Signed-off-by: must always be
that of the developer submitting the patch.'.
This patch tries to enforce this, under the assumption that the From:
author is that developer.

Suggested-by: Tobias Langer <langer@cs.fau.de>
Co-developed-by: Ferdinand Schober <ferdinand.schober@fau.de>
Signed-off-by: Ferdinand Schober <ferdinand.schober@fau.de>
Signed-off-by: Philipp Bruegmann <philipp.bruegmann@fau.de>
---
 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..e1be1d8bfb6e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2447,6 +2447,7 @@ sub process {
 	my $author = '';
 	my $authorsignoff = 0;
 	my $author_sob = '';
+	my $last_sign_off = '';
 	my $is_patch = 0;
 	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
@@ -2774,8 +2775,9 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
 			$signoff++;
 			$in_commit_log = 0;
+			$last_sign_off = $1;
 			if ($author ne ''  && $authorsignoff != 1) {
-				if (same_email_addresses($1, $author)) {
+				if (same_email_addresses($last_sign_off, $author)) {
 					$authorsignoff = 1;
 				} else {
 					my $ctx = $1;
@@ -7238,7 +7240,7 @@ sub process {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
 			      "Missing Signed-off-by: line(s)\n");
-		} elsif ($authorsignoff != 1) {
+		} else {
 			# authorsignoff values:
 			# 0 -> missing sign off
 			# 1 -> sign off identical
@@ -7252,6 +7254,10 @@ sub process {
 			if ($authorsignoff == 0) {
 				ERROR("NO_AUTHOR_SIGN_OFF",
 				      "Missing Signed-off-by: line by nominal patch author '$author'\n");
+			} elsif ($authorsignoff == 1 && $last_sign_off ne $author) {
+				CHK("FROM_SIGN_OFF_NOT_LAST",
+					 "Signed-off-by: line by nominal patch author is not the last signature.\n\
+					  The author submitting the patch should be signing last.\n");
 			} elsif ($authorsignoff == 2) {
 				CHK("FROM_SIGN_OFF_MISMATCH",
 				    "From:/Signed-off-by: email comments mismatch: $sob_msg\n");
-- 
2.20.1

