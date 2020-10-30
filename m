Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D6F29FEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgJ3Hn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJ3HlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:03 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE6722203;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=n3afBc/Xu0UQI+iYPCaANZ8L/mTWQPp7mjkXXUXg5lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2qIsGV29264bd8ZwqmEpKVL1VcqE477dxWM/dTT21xYYGMfwkvDbl6qW/AQpz3V0
         AopEwnDufxBbjEHT4pzjg2jrLczXBF9jbUB0oVf6G7Ae2UnchCb5I/Id7fHJSsBy4i
         2tbW8FGfZS4f1K2ImlcXj+WUVyn16dW2gZl2Di30=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004OfN-B3; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/39] scripts: get_abi.pl: improve its parser to better catch up indentation
Date:   Fri, 30 Oct 2020 08:40:23 +0100
Message-Id: <eb458bb30be0e5a89192d6057b2e8a7e910dbcb8.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
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

