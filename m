Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63742C714C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbgK1V4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgK1Uo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:44:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B5CC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:43:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l1so4340799pld.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cdsJyh5jij8oKn4gXX0267hbBIKcbUaCIrKyrDn2vdA=;
        b=sfOhxjo+yAyhE0eyu5tXl75LHglUPRagWrqh0D7N39bWZEJf4R9CKOXVr6roJAxpfm
         bzjYo4VvDLtdab6adnq6m3pLNpO9gIajlVHK8vuSZhIGNYCClBR7CCy8oUugKiYsZqhB
         dpaejTxCjB9ZNVp+En3ddgjxjixWnLtoEriUDxtLS8DS5M+F8R8j/epMDd7M/PQaFVoH
         UJ/2H2q52lfB408W5AmFZ7SrZBKAcu0M/3ZLEEfJ/ihEtNwYXkG4QVXKzzx1L/pqNPdN
         0fws27VLgM/tTwp3YnEKw1LIwfl5STNHV4KoQt4ARdkEdngyy0f7OiWiSWxiwKcPYTTI
         vYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cdsJyh5jij8oKn4gXX0267hbBIKcbUaCIrKyrDn2vdA=;
        b=AiZ6vzIYOE107STeW3B6lrZxpKYr76O6ejDGuT0q9KB2dECHPgJKdxZe+tyT1aRxsX
         aefLtILX4x4muhXI1KkUihY+N/kOo09EZvNsNVz5VFHGqi/Wsj+79RgQyn3UZ/Hma62t
         +Le/rfUGXS0XSiSeTehGHgOsN5BE47ufAC878jbe/m/I7hK0u0tWRSTWH3ttMOnXIBuP
         Z7VNUXrd1tpI8wp62eY6LuV50VKeQmVWYQZrYmlDhgfl9m3RlpL1xTVxn+S4THrSv31k
         4Yb+Fa+uGbXyFctXQ0Nx0iXpprmLhXttuYOcnvCuaq2OhPXfOpsoqNL620xXvgFNHDQD
         5gpQ==
X-Gm-Message-State: AOAM533Wy95t0GzvbO20LM4xmr1JzHzFjnjwu//q7NiwykT8yov+wHZE
        TGkS1A2cHjZJGf726XyN104=
X-Google-Smtp-Source: ABdhPJykVc8v6DRRnQ+Ewjgfk7w7HIHAoxkADwJC2mR1ucCf1zLgX/4MMsY9+VI3Z5g/yIk39auxrg==
X-Received: by 2002:a17:902:c203:b029:da:725b:fcea with SMTP id 3-20020a170902c203b02900da725bfceamr221745pll.16.1606596223975;
        Sat, 28 Nov 2020 12:43:43 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:410:2e8b:3868:c1d5:d398:f361])
        by smtp.googlemail.com with ESMTPSA id z29sm10745577pgc.68.2020.11.28.12.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 12:43:43 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v6] checkpatch: add fix and improve warning msg for non-standard signature
Date:   Sun, 29 Nov 2020 02:13:33 +0530
Message-Id: <20201128204333.7054-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c2087e41b85c3d45f1d224373b36ecff88d80298.camel@perches.com>
References: <c2087e41b85c3d45f1d224373b36ecff88d80298.camel@perches.com>
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
applies on next-20201120

changes in v2: modify commit message: replace specific example with overall evaluation, minor changes

changes in v3: summarize commit message

changes in v4: improve commit message; remove signature suggestions of small length (ie 'cc' and 'to')

changes in v5: modify coding styles: improve function names, whitespaces

changes in v6: Simplify foreach loop; change standard signature tag values to normal ucfirst; modify warning message

 scripts/checkpatch.pl | 71 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fdfd5ec09be6..4a026926139f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -506,6 +506,64 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+sub edit_distance_min {
+	my (@arr) = @_;
+	my $len = scalar @arr;
+	if ((scalar @arr) < 1) {
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
+	$str1 = lc($str1);
+	$str2 = lc($str2);
+	$str1 =~ s/-//g;
+	$str2 =~ s/-//g;
+	my $len1 = length($str1);
+	my $len2 = length($str2);
+	# two dimensional array storing minimum edit distance
+	my @distance;
+	for my $i (0 .. $len1) {
+		for my $j (0 .. $len2) {
+			if ($i == 0) {
+				$distance[$i][$j] = $j;
+			} elsif ($j == 0) {
+				$distance[$i][$j] = $i;
+			} elsif (substr($str1, $i-1, 1) eq substr($str2, $j-1, 1)) {
+				$distance[$i][$j] = $distance[$i - 1][$j - 1];
+			} else {
+				my $dist1 = $distance[$i][$j - 1]; #insert distance
+				my $dist2 = $distance[$i - 1][$j]; # remove
+				my $dist3 = $distance[$i - 1][$j - 1]; #replace
+				$distance[$i][$j] = 1 + edit_distance_min($dist1, $dist2, $dist3);
+			}
+		}
+	}
+	return $distance[$len1][$len2];
+}
+
+sub find_standard_signature {
+	my ($sign_off) = @_;
+	my @standard_signature_tags = (
+		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
+		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
+	);
+	foreach my $signature (@standard_signature_tags) {
+		return $signature if (get_edit_distance($sign_off, $signature) <= 2);
+	}
+
+	return "";
+}
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -2773,8 +2831,17 @@ sub process {
 			my $ucfirst_sign_off = ucfirst(lc($sign_off));
 
 			if ($sign_off !~ /$signature_tags/) {
-				WARN("BAD_SIGN_OFF",
-				     "Non-standard signature: $sign_off\n" . $herecurr);
+				my $suggested_signature = find_standard_signature($sign_off);
+				if ($suggested_signature eq "") {
+					WARN("BAD_SIGN_OFF",
+					     "Non-standard signature: $sign_off\n" . $herecurr);
+				} else {
+					if (WARN("BAD_SIGN_OFF",
+						 "Non-standard signature: '$sign_off' - perhaps '$suggested_signature'?\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
+					}
+				}
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
-- 
2.17.1

