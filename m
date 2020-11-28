Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B912C712A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbgK1VyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbgK1TJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:09:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2472C02A198
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 05:05:12 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t21so6502936pgl.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xj/wOuewoXtxSC2fvuTGoHr7LuRtI1vwyFKb4n55N8M=;
        b=Vivdeg63zuyH99Tu6ZodGMLMs2snTtoCeMiCy8Iw9rO6bhqnszPnwStsH2mdk4IV98
         QyuApsUzeJunT4wNwUC35Sk1Bo6Wx6BF3/3HOOFw0ZKFcecybeQ+ABdFE2dA6xqEVFHC
         USZZ4VU+rbtr/kvs0HMJUhCmnPnhpyUn8CglSs7WWEozB9rPDprRML45TOErSPg/55Xg
         VBI/fJtAZMmn9xhQ/e6NzD2TSMiyzihVVttv7sSxwp/YzXtQLpefHEsP7UjCL6YAugWf
         wA3E+ZFtu8uJ2hQLVPKF9rYylSU1hUZZjQpQzGHrer6ftk2IPt8p6dWLRqRdf/rQJyd4
         Uahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xj/wOuewoXtxSC2fvuTGoHr7LuRtI1vwyFKb4n55N8M=;
        b=qOhnSyaNGiJoRXmVJoHzy46A9dBznf8oc7Hfq4Op3q7Mk8gN630vQth8Hm+JMyZOCw
         jYLx6dTY/u+WaLvQZPrv8qucoJZZCpTT6Wgc85PBzNtKRkHTW+BBc24MHbfBRxaSrdFI
         BkYTEh3S91sHWvBYYTEV88l2Inzlt7LxfnVtciHbdU/ZXLcid7f/HA7hZuVmeEaE4yr5
         TWPTFh1JvLcuvouxGvVLdaN1oS4KJIQuyWUj5tO+Ubdl6QGKEerxoNwU1b+nzOEXCKfK
         SFv9ZouiH9ANMEe7+cfd7lc4nM8gqZbsE+uTVUfySdY2apuIJl0bY55U5F09CpoHX5jj
         iKWg==
X-Gm-Message-State: AOAM531K2JsB/Q8TubJqIEzAF+RK4oWwNmNXJpnWpHxcLj0S2eqg+J6J
        EkpyMg1GHDqJdDgK8dL1TuPssOoqVnhDQQ==
X-Google-Smtp-Source: ABdhPJwSLoLLS/cP/1h1WGDVTAGN0DMvMaRmhps5HAWHQtXSEqmS5Io8bMox6NlIa+Cuagqra31G1g==
X-Received: by 2002:a17:90a:c484:: with SMTP id j4mr11130527pjt.69.1606568712219;
        Sat, 28 Nov 2020 05:05:12 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:410:2e8b:3868:c1d5:d398:f361])
        by smtp.googlemail.com with ESMTPSA id 84sm10472123pfu.53.2020.11.28.05.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 05:05:11 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: add fix and improve warning msg for non-standard signature
Date:   Sat, 28 Nov 2020 18:35:01 +0530
Message-Id: <20201128130501.23448-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns for BAD_SIGN_OFF on non-standard signature
styles.

A large number of these warnings occur because of typo mistakes in
signature tags. An evaluation over v4.13..v5.8 showed that out of 539
warnings due to non-standard signatures, 87 are due to typo mistakes.

Following are the standard signature tags which are often incorrectly
used, along with their individual counts of incorrect use (over
v4.13..v5.8):

 Reviewed-by: 42
 Signed-off-by: 25
 Reported-by: 6
 Acked-by: 4
 Tested-by: 4
 Suggested-by: 4

Provide a fix by calculating levenshtein distance for the signature tag
with all the standard signatures and suggest a fix with a signature, whose
edit distance is less than or equal to 2 with the misspelled signature.

Out of the 86 mispelled signatures fixed with this approach, 85 were
found to be good corrections and 1 was bad correction.

Following was found to be a bad correction:
 Tweeted-by (count: 1) => Tested-by

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
changes in v2: modify commit message: replace specific example with overall evaluation, minor changes

changes in v3: summarize commit message

changes in v4: improve commit message; remove signature suggestions of small length (ie 'cc' and 'to')

 scripts/checkpatch.pl | 85 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fdfd5ec09be6..2b1afd763d8d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -506,6 +506,77 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+sub get_min {
+	my (@arr) = @_;
+	my $len = scalar @arr;
+	if((scalar @arr) < 1) {
+		# if underflow, return
+		return;
+	}
+	my $min = $arr[0];
+	for my $i (0 .. ($len-1)) {
+		if ($arr[$i] < $min) {
+			$min = $arr[$i];
+		}
+	}
+	return $min;
+}
+
+sub get_edit_distance {
+	my ($str1, $str2) = @_;
+	my $len1 = length($str1);
+	my $len2 = length($str2);
+	# two dimensional array storing minimum edit distance
+	my @distance;
+	for my $i (0 .. $len1) {
+		for my $j (0 .. $len2) {
+			if ($i == 0) {
+				$distance[$i][$j] = $j;
+			}
+			elsif ($j == 0) {
+				$distance[$i][$j] = $i;
+			}
+			elsif (substr($str1, $i-1, 1) eq substr($str2, $j-1, 1)) {
+				$distance[$i][$j] = $distance[$i - 1][$j - 1];
+			}
+			else {
+				my $dist1 = $distance[$i][$j - 1]; #insert distance
+				my $dist2 = $distance[$i - 1][$j]; # remove
+				my $dist3 = $distance[$i - 1][$j - 1]; #replace
+				$distance[$i][$j] = 1 + get_min($dist1, $dist2, $dist3);
+			}
+		}
+	}
+	return $distance[$len1][$len2];
+}
+
+sub get_standard_signature {
+	my ($sign_off) = @_;
+	$sign_off = lc($sign_off);
+	$sign_off =~ s/\-//g; # to match with formed hash
+	my @standard_signature_tags = (
+		'signed-off-by:', 'co-developed-by:', 'acked-by:', 'tested-by:',
+		'reviewed-by:', 'reported-by:', 'suggested-by:'
+	);
+	# setting default values
+	my $standard_signature = 'signed-off-by';
+	my $min_edit_distance = 20;
+	my $edit_distance;
+	foreach (@standard_signature_tags) {
+		my $signature = $_;
+		$_ =~ s/\-//g;
+		$edit_distance = get_edit_distance($sign_off, $_);
+		if ($edit_distance < $min_edit_distance) {
+			$min_edit_distance = $edit_distance;
+			$standard_signature = $signature;
+		}
+	}
+        if($min_edit_distance<=2) {
+		return ucfirst($standard_signature);
+        }
+	return "";
+}
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -2773,8 +2844,18 @@ sub process {
 			my $ucfirst_sign_off = ucfirst(lc($sign_off));
 
 			if ($sign_off !~ /$signature_tags/) {
-				WARN("BAD_SIGN_OFF",
-				     "Non-standard signature: $sign_off\n" . $herecurr);
+				my $suggested_signature = get_standard_signature($sign_off);
+				if ($suggested_signature eq "") {
+					WARN("BAD_SIGN_OFF",
+					"Non-standard signature: $sign_off\n" . $herecurr);
+				}
+				else {
+					if (WARN("BAD_SIGN_OFF",
+						 "Non-standard signature: $sign_off. Please use '$suggested_signature' instead\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
+					}
+				}
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
-- 
2.17.1

