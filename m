Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B729DECA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgJ2A40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731623AbgJ1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780782473F;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=jzHm1QtzfpxDKadw+V1YfSIgkojRb8DPJUFpqgleivE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JswyOE4gDRTKpLISSXBMqRcrR6tNy8K+XUIamY0q15Ain5PW5AP9nle2v34paXMq1
         s15zjiyAfatC7wvSBDrNEbPup6jHzwZVsVjE4cmFiM+ZCDeXlKfJrrysSXBnJj4lZ9
         DMZWkMFhbPGBID+ikESfk3Sp57sA6O0/ZSwrihcA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hkp-3q; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/33] scripts: get_abi.pl: fix parsing on ReST mode
Date:   Wed, 28 Oct 2020 15:23:00 +0100
Message-Id: <c24fbeb384b36e00c34786a5a3686a83981f067d.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

When the source ABI file is using ReST notation, the script
should handle whitespaces and lines with care, as otherwise
the file won't be properly recognized.

Address the bugs that are on such part of the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 107672cdacb3..0c403af86fd5 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -151,7 +151,8 @@ sub parse_abi {
 						$content = $2;
 					}
 					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					$data{$what}->{$tag} .= $content;
+
+					$data{$what}->{$tag} .= "$content\n" if ($content);
 				} else {
 					$data{$what}->{$tag} = $content;
 				}
@@ -166,31 +167,28 @@ sub parse_abi {
 		}
 
 		if ($tag eq "description") {
+			my $content = $_;
+			while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
 			if (!$data{$what}->{description}) {
-				s/^($space)//;
-				if (m/^(\s*)(.*)/) {
-					my $sp = $1;
-					while ($sp =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					my $content = "$sp$2";
-
-					$content =~ s/^($space)//;
-
-					$data{$what}->{$tag} .= "$content";
+				# Preserve initial spaces for the first line
+				if ($content =~ m/^(\s*)(.*)$/) {
+					$space = $1;
+					$content = $2;
 				}
+
+				$data{$what}->{$tag} .= "$content\n" if ($content);
 			} else {
-				my $content = $_;
 				if (m/^\s*\n/) {
 					$data{$what}->{$tag} .= $content;
 					next;
 				}
 
-				while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
 				$space = "" if (!($content =~ s/^($space)//));
 
-				# Compress spaces with tabs
-				$content =~ s<^ {8}> <\t>;
-				$content =~ s<^ {1,7}\t> <\t>;
-				$content =~ s< {1,7}\t> <\t>;
+#				# Compress spaces with tabs
+#				$content =~ s<^ {8}> <\t>;
+#				$content =~ s<^ {1,7}\t> <\t>;
+#				$content =~ s< {1,7}\t> <\t>;
 				$data{$what}->{$tag} .= $content;
 			}
 			next;
-- 
2.26.2

