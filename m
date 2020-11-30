Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06D12C8831
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgK3Phf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgK3Ph0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:37:26 -0500
Received: from mail.kernel.org (ip5f5ad5b3.dynamic.kabel-deutschland.de [95.90.213.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62F42076C;
        Mon, 30 Nov 2020 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750604;
        bh=6EfeXORA2gickC2Vboo8pg7pzpx5jVNyZ79u/YhJwSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzCxg2Y9uMHPNPUeYaGGW1a6ctYLFAXCC9yU96DIPLIjx0WGdPhpKMvWEfkfNJprB
         Na5Sz5TYOjvWC25q6+ooe+UEfZAgy7GCr5JqIbG2uIcQ+Ihnlq5O63PcdnAnwQsBoI
         qwy/3FepXS96u/NXEwgBUvA6sTyLgTFBV9mxhft8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kjlEI-00CjvL-DX; Mon, 30 Nov 2020 16:36:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] scripts: get_feat.pl: improve matrix output
Date:   Mon, 30 Nov 2020 16:36:31 +0100
Message-Id: <9c3e8c813e8146c5c30e10fa75974f8fbfe6016a.1606748711.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606748711.git.mchehab+huawei@kernel.org>
References: <cover.1606748711.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of producing a too wide table, let's split it per
subsystem, and use a better notation in order to make easier
for the reader to identify how a feature is supported on
multiple architectures.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_feat.pl | 113 +++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 43 deletions(-)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 79d83595addd..7b92ebab7ddd 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -293,68 +293,95 @@ sub output_feature {
 # Output all features for all architectures
 #
 
-sub matrix_lines {
-	print "=" x $max_size_subsys;
-	print "  ";
-	print "=" x $max_size_name;
-	print "  ";
+sub matrix_lines($$) {
+	my $partial = shift;
+	my $header = shift;
+	my $split;
+	my $fill;
+	my $ln_marker;
 
-	foreach my $arch (sort keys %archs) {
-		my $len = $max_size_status;
-
-		$len = length($arch) if ($len < length($arch));
+	if ($header) {
+		$ln_marker = "=";
+	} else {
+		$ln_marker = "-";
+	}
 
-		print "=" x $len;
-		print "  ";
+	if ($partial) {
+		$split = "|";
+		$fill = " ";
+	} else {
+		$split = "+";
+		$fill = $ln_marker;
 	}
-	print "=" x $max_size_kconfig;
-	print "  ";
-	print "=" x $max_size_description;
-	print "\n";
+
+	print $split;
+	print $fill x $max_size_name;
+	print $split;
+	print $fill x $max_size_kconfig;
+	print $split;
+	print $fill x $max_size_description;
+	print "+";
+	print $ln_marker x $max_size_arch;
+	print "+";
+	print $ln_marker x $max_size_status;
+	print "+\n";
 }
 
 sub output_matrix {
-
-	my $title = "Feature List (feature x architecture)";
+	my $title = "Feature status on all architectures";
 
 	print "=" x length($title) . "\n";
 	print "$title\n";
 	print "=" x length($title) . "\n\n";
 
-	matrix_lines;
-
-	printf "%-${max_size_subsys}s  ", $h_subsys;
-	printf "%-${max_size_name}s  ", $h_name;
-
-	foreach my $arch (sort keys %archs) {
-		printf "%-${max_size_status}s  ", $arch;
-	}
-	printf "%-${max_size_kconfig}s  ", $h_kconfig;
-	printf "%-${max_size_description}s\n", $h_description;
-
-	matrix_lines;
-
+	my $cur_subsys = "";
 	foreach my $name (sort {
-				($data{$a}->{subsys} cmp $data{$b}->{subsys}) ||
-				($data{$a}->{name} cmp $data{$b}->{name})
+				($data{$a}->{subsys} cmp $data{$b}->{subsys}) or
+				($a cmp $b)
 			       } keys %data) {
-		printf "%-${max_size_subsys}s  ", $data{$name}->{subsys};
-		printf "%-${max_size_name}s  ", $name;
+
+		if ($cur_subsys ne $data{$name}->{subsys}) {
+			if ($cur_subsys ne "") {
+				printf "\n";
+			}
+
+			$cur_subsys = $data{$name}->{subsys};
+
+			my $title = "Subsystem: $cur_subsys";
+			print "$title\n";
+			print "=" x length($title) . "\n\n";
+
+			matrix_lines(0, 0);
+			printf "|%-${max_size_name}s", $h_name;
+			printf "|%-${max_size_kconfig}s", $h_kconfig;
+			printf "|%-${max_size_description}s", $h_description;
+
+			printf "|%-${max_size_arch}s", $h_arch;
+			printf "|%-${max_size_status}s|\n", $h_status;
+
+			matrix_lines(0, 1);
+		}
 
 		my %arch_table = %{$data{$name}->{table}};
-
+		my $first = 1;
 		foreach my $arch (sort keys %arch_table) {
-			my $len = $max_size_status;
+			if ($first) {
+				printf "|%-${max_size_name}s", $name;
+				printf "|%-${max_size_kconfig}s", $data{$name}->{kconfig};
+				printf "|%-${max_size_description}s", $data{$name}->{description};
+				$first = 0;
+			} else {
+				matrix_lines(1, 0);
 
-			$len = length($arch) if ($len < length($arch));
-
-			printf "%-${len}s  ", $arch_table{$arch};
+				printf "|%-${max_size_name}s", "";
+				printf "|%-${max_size_kconfig}s", "";
+				printf "|%-${max_size_description}s", "";
+			}
+			printf "|%-${max_size_arch}s", $arch;
+			printf "|%-${max_size_status}s|\n", $arch_table{$arch};
 		}
-		printf "%-${max_size_kconfig}s  ", $data{$name}->{kconfig};
-		printf "%-${max_size_description}s\n", $data{$name}->{description};
+		matrix_lines(0, 0);
 	}
-
-	matrix_lines;
 }
 
 
-- 
2.28.0

