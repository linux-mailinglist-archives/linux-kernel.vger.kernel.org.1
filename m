Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB802D641E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392941AbgLJRy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:54:29 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:27119 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392905AbgLJRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:54:22 -0500
Received: from localhost.localdomain ([93.22.150.71])
        by mwinf5d35 with ME
        id 2hsb2400F1YgGEM03hscul; Thu, 10 Dec 2020 18:52:37 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 Dec 2020 18:52:37 +0100
X-ME-IP: 93.22.150.71
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     apw@canonical.com, joe@perches.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] checkpatch: Fix "Missing a blank line after declarations" test on patches
Date:   Thu, 10 Dec 2020 18:52:35 +0100
Message-Id: <20201210175235.65657-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Missing a blank line after declarations" is not triggered on patches.
Tweak the regex to match such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is mostly a PoC. I don't know enough about checkpatch.pl to be
sure that the fix is the right thing to do.
At least, it works for me :)

The [\+ ] is taken from the test just above.

I also wonder if there is a missing ^ in the last test:
  (($prevline =~ /[\+ ](\s+)\S/) && $sline =~ /^[\+ ]$1\S/))
                  ^
                  |___ here
---
 scripts/checkpatch.pl | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..854868b5dbbc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3783,39 +3783,39 @@ sub process {
 		}
 
 # check for missing blank lines after declarations
-		if ($sline =~ /^\+\s+\S/ &&			#Not at char 1
+		if ($sline =~ /^[\+ ]\s+\S/ &&			#Not at char 1
 			# actual declarations
-		    ($prevline =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
+		    ($prevline =~ /^[\+ ]\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
 			# function pointer declarations
-		     $prevline =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
+		     $prevline =~ /^[\+ ]\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
 			# foo bar; where foo is some local typedef or #define
-		     $prevline =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
+		     $prevline =~ /^[\+ ]\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
 			# known declaration macros
-		     $prevline =~ /^\+\s+$declaration_macros/) &&
+		     $prevline =~ /^[\+ ]\s+$declaration_macros/) &&
 			# for "else if" which can look like "$Ident $Ident"
-		    !($prevline =~ /^\+\s+$c90_Keywords\b/ ||
+		    !($prevline =~ /^[\+ ]\s+$c90_Keywords\b/ ||
 			# other possible extensions of declaration lines
 		      $prevline =~ /(?:$Compare|$Assignment|$Operators)\s*$/ ||
 			# not starting a section or a macro "\" extended line
 		      $prevline =~ /(?:\{\s*|\\)$/) &&
 			# looks like a declaration
-		    !($sline =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
+		    !($sline =~ /^[\+ ]\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
 			# function pointer declarations
-		      $sline =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
+		      $sline =~ /^[\+ ]\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
 			# foo bar; where foo is some local typedef or #define
-		      $sline =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
+		      $sline =~ /^[\+ ]\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
 			# known declaration macros
-		      $sline =~ /^\+\s+$declaration_macros/ ||
+		      $sline =~ /^[\+ ]\s+$declaration_macros/ ||
 			# start of struct or union or enum
-		      $sline =~ /^\+\s+(?:static\s+)?(?:const\s+)?(?:union|struct|enum|typedef)\b/ ||
+		      $sline =~ /^[\+ ]\s+(?:static\s+)?(?:const\s+)?(?:union|struct|enum|typedef)\b/ ||
 			# start or end of block or continuation of declaration
-		      $sline =~ /^\+\s+(?:$|[\{\}\.\#\"\?\:\(\[])/ ||
+		      $sline =~ /^[\+ ]\s+(?:$|[\{\}\.\#\"\?\:\(\[])/ ||
 			# bitfield continuation
-		      $sline =~ /^\+\s+$Ident\s*:\s*\d+\s*[,;]/ ||
+		      $sline =~ /^[\+ ]\s+$Ident\s*:\s*\d+\s*[,;]/ ||
 			# other possible extensions of declaration lines
-		      $sline =~ /^\+\s+\(?\s*(?:$Compare|$Assignment|$Operators)/) &&
+		      $sline =~ /^[\+ ]\s+\(?\s*(?:$Compare|$Assignment|$Operators)/) &&
 			# indentation of previous and current line are the same
-		    (($prevline =~ /\+(\s+)\S/) && $sline =~ /^\+$1\S/)) {
+		    (($prevline =~ /[\+ ](\s+)\S/) && $sline =~ /^[\+ ]$1\S/)) {
 			if (WARN("LINE_SPACING",
 				 "Missing a blank line after declarations\n" . $hereprev) &&
 			    $fix) {
-- 
2.27.0

