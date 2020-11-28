Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38742C71A6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbgK1VvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgK1Sf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:35:58 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBAFC02B8F6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 10:35:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b6so7297677pfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sEQdz9uSskRiHZY3IQdor2sMJ0r9SD+WlRGWjHXAxZw=;
        b=Qah7uiKXtdD1l0TnfPtl9lfHgVl8ySFwXc3E3YovT4OgVb42RsITGjxStCRquMMi6E
         Qt8x4lbM9kElwkC1h1RiRxe41tHmEjm0MLSarBfLDva8ygxPxXRZX5tDc8k5rHbKirys
         YRjpsvHKnoloReivk6rUyAlDIHO7mlyWnvLP8WVfFgkxwSDSdS7rlufKCTzqMu2KqwFa
         XDZ+mpVBvHvDSJ9hZmvXs3dacBTSXO7L20nsq1mnJbGv1PLlgzhu3MEjkaD79+9yLYxN
         paMKtkL3R8QbzJ7T5Av/SPQrHe2VhPZKKJ0EIrTXqtz+uahJeR+h0W8JmAQnmmzRQWIh
         dVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sEQdz9uSskRiHZY3IQdor2sMJ0r9SD+WlRGWjHXAxZw=;
        b=kPRVlZLYD3oJwLCXOE1x17eqmUH0Bvp+TkCP2qIzkCjP9LQwMziRJV5Y63dTqBNSVw
         cHhwwzH7MPOmfZ2dNUEkaFoUMxegMO7MBxYeJrDZ66Y5pocoRuefzTuLUSL2DssAVBEp
         Sc5CPkaRkAAWR/oWLzKBkecRBePll7hY1NIiOASPpOVaNkJnNXvaA1ZAKWJ84vQkmg0x
         DPWco8RQ/TdVE9NHigAMm8ZQ2uo7fPzY6ZAIxNY88HcHfvHYGWX9sc1X4lerkS5GcySE
         x7RpwgGd1DKpGptCJV9gjddncy9wz6Ihr0duQgvdkZ1LB/vuCRTGHsDi6JKlEJf+hLF9
         cBfQ==
X-Gm-Message-State: AOAM5328xIbWyHUzmJNFsKGIl2WxB9V8CiQZ/Z4THib8kymtZMBOm3oy
        uQuViFwEDIkg6bW0B2SsMtSsxk3eMPwXKA==
X-Google-Smtp-Source: ABdhPJx4+N0Q/c3bwyVOJvP6Q2rLu/5CHZta8m/VYPSbf6OAX1AsOz5GcQ6a/W4eElx4t9fCAXfHFA==
X-Received: by 2002:a17:90a:3902:: with SMTP id y2mr17499994pjb.126.1606588518051;
        Sat, 28 Nov 2020 10:35:18 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:410:2e8b:3868:c1d5:d398:f361])
        by smtp.googlemail.com with ESMTPSA id h18sm11443469pfk.17.2020.11.28.10.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 10:35:17 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v5] checkpatch: add fix and improve warning msg for non-standard signature
Date:   Sun, 29 Nov 2020 00:05:08 +0530
Message-Id: <20201128183508.1195-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2f5c625f5f342042ab55902fe4b808bff8dd297b.camel@perches.com>
References: <2f5c625f5f342042ab55902fe4b808bff8dd297b.camel@perches.com>
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

 scripts/checkpatch.pl | 79 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fdfd5ec09be6..e372d26d03dc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -506,6 +506,72 @@ our $signature_tags = qr{(?xi:
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
+		'signed-off-by:', 'co-developed-by:', 'acked-by:', 'tested-by:',
+		'reviewed-by:', 'reported-by:', 'suggested-by:'
+	);
+	my $standard_signature;
+	my $min_edit_distance = 20; # setting default value
+	my $edit_distance;
+	foreach (@standard_signature_tags) {
+		$edit_distance = get_edit_distance($sign_off, $_);
+		if ($edit_distance < $min_edit_distance) {
+			$min_edit_distance = $edit_distance;
+			$standard_signature = $_;
+		}
+	}
+        if ($min_edit_distance <= 2) {
+		return ucfirst($standard_signature);
+	}
+	return "";
+}
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -2773,8 +2839,17 @@ sub process {
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
+						 "Non-standard signature: $sign_off. Perhaps '$suggested_signature'\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
+					}
+				}
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
-- 
2.17.1

