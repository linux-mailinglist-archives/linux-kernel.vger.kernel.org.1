Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAA29DCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbgJ1WUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731698AbgJ1WRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81ACC2476F;
        Wed, 28 Oct 2020 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895019;
        bh=n3afBc/Xu0UQI+iYPCaANZ8L/mTWQPp7mjkXXUXg5lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbqcFDG1MuEsQcbYvkctnWP3O+S5wbXOXV6RC5QNO2PIL27Qw0PH8aq6Eq/jp01B4
         S9Tmd0BwCBnXiBKZ6cny7j8Tcrt8alFVzD5aU3vvN4lpowtz8X71BvddigeSNJDOB8
         Q/v3ouGY4gMpmkIlWHR4jJD7EAGZ3jlvfnp1+lv0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hkt-6m; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/33] scripts: get_abi.pl: improve its parser to better catch up indentation
Date:   Wed, 28 Oct 2020 15:23:02 +0100
Message-Id: <b7acc1b8664c5c29cb3986ddb4c9058495d1e867.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original parser for indentation were relying on having
just one description for each "what". However, that's not
the case: there are a number of ABI symbols that got defined
multiple times.

Improve the parser for it to better handle descriptions
if entries are duplicated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 6a4d387ebf3b..bd018eb3815b 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -147,17 +147,19 @@ sub parse_abi {
 					parse_error($file, $ln, "'What:' should come first:", $_);
 					next;
 				}
-				if ($tag eq "description") {
-					# Preserve initial spaces for the first line
+				if ($new_tag eq "description") {
+					$sep =~ s,:, ,;
 					$content = ' ' x length($new_tag) . $sep . $content;
-					$content =~ s,^(\s*):,$1 ,;
-					if ($content =~ m/^(\s*)(.*)$/) {
+					while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+					if ($content =~ m/^(\s*)(\S.*)$/) {
+						# Preserve initial spaces for the first line
 						$space = $1;
-						$content = $2;
+						$content = "$2\n";
+						$data{$what}->{$tag} .= $content;
+					} else {
+						undef($space);
 					}
-					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
 
-					$data{$what}->{$tag} .= "$content\n" if ($content);
 				} else {
 					$data{$what}->{$tag} = $content;
 				}
@@ -174,28 +176,22 @@ sub parse_abi {
 		if ($tag eq "description") {
 			my $content = $_;
 			while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-			if (!$data{$what}->{description}) {
+			if (m/^\s*\n/) {
+				$data{$what}->{$tag} .= "\n";
+				next;
+			}
+
+			if (!defined($space)) {
 				# Preserve initial spaces for the first line
-				if ($content =~ m/^(\s*)(.*)$/) {
+				if ($content =~ m/^(\s*)(\S.*)$/) {
 					$space = $1;
-					$content = $2;
+					$content = "$2\n";
 				}
-
-				$data{$what}->{$tag} .= "$content\n" if ($content);
 			} else {
-				if (m/^\s*\n/) {
-					$data{$what}->{$tag} .= $content;
-					next;
-				}
-
 				$space = "" if (!($content =~ s/^($space)//));
-
-#				# Compress spaces with tabs
-#				$content =~ s<^ {8}> <\t>;
-#				$content =~ s<^ {1,7}\t> <\t>;
-#				$content =~ s< {1,7}\t> <\t>;
-				$data{$what}->{$tag} .= $content;
 			}
+			$data{$what}->{$tag} .= $content;
+
 			next;
 		}
 		if (m/^\s*(.*)/) {
-- 
2.26.2

