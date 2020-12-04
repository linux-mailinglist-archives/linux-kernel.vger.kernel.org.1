Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0809B2CF0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgLDPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbgLDPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:33:15 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] scripts: get_feat.pl: reduce table width for all features output
Date:   Fri,  4 Dec 2020 16:32:30 +0100
Message-Id: <9d39ac3fd51f1360aecc328c01558be88a1d6930.1607095090.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607095090.git.mchehab+huawei@kernel.org>
References: <cover.1607095090.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-adjust the table columns width to better fit under
terminals, by breaking the description on multiple lines
and auto-estimating the minimal size for the
per-architecture status.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_feat.pl | 71 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 3f73c8534059..457712355676 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -19,6 +19,11 @@ $basename =~ s,/[^/]+$,/,;
 
 my $prefix=$basename . "../Documentation/features";
 
+# Used only at for full features output. The script will auto-adjust
+# such values for the minimal possible values
+my $status_size = 1;
+my $description_size = 1;
+
 GetOptions(
 	"debug|d+" => \$debug,
 	"dir=s" => \$prefix,
@@ -77,7 +82,10 @@ my $max_size_kconfig = length($h_kconfig);
 my $max_size_description = length($h_description);
 my $max_size_subsys = length($h_subsys);
 my $max_size_status = length($h_status);
-my $max_size_arch = length($h_arch);
+
+my $max_size_arch = 0;
+my $max_size_arch_with_header;
+my $max_description_word = 0;
 
 sub parse_feat {
 	my $file = $File::Find::name;
@@ -127,6 +135,13 @@ sub parse_feat {
 			if (length($description) > $max_size_description) {
 				$max_size_description = length($description);
 			}
+
+			foreach my $word (split /\s+/, $description) {
+				if (length($word) > $max_description_word) {
+					$max_description_word = length($word);
+				}
+			}
+
 			next;
 		}
 		next if (m/^\\s*$/);
@@ -180,6 +195,8 @@ sub parse_feat {
 	$data{$name}->{description} = $description;
 	$data{$name}->{comments} = $comments;
 	$data{$name}->{table} = \%arch_table;
+
+	$max_size_arch_with_header = $max_size_arch + length($h_arch);
 }
 
 #
@@ -296,7 +313,7 @@ sub output_feature {
 		print "$com\n\n";
 	}
 
-	print "=" x $max_size_arch;
+	print "=" x $max_size_arch_with_header;
 	print "  ";
 	print "=" x $max_size_status;
 	print "\n";
@@ -304,7 +321,7 @@ sub output_feature {
 	printf "%-${max_size_arch}s  ", $h_arch;
 	printf "%-${max_size_status}s", $h_status . "\n";
 
-	print "=" x $max_size_arch;
+	print "=" x $max_size_arch_with_header;
 	print "  ";
 	print "=" x $max_size_status;
 	print "\n";
@@ -315,7 +332,7 @@ sub output_feature {
 		printf "%-${max_size_status}s\n", $arch_table{$arch};
 	}
 
-	print "=" x $max_size_arch;
+	print "=" x $max_size_arch_with_header;
 	print "  ";
 	print "=" x $max_size_status;
 	print "\n";
@@ -351,6 +368,7 @@ sub matrix_lines($$$) {
 
 sub output_matrix {
 	my $title = "Feature status on all architectures";
+	my $notcompat = "Not compatible";
 
 	print "=" x length($title) . "\n";
 	print "$title\n";
@@ -359,10 +377,21 @@ sub output_matrix {
 	my $desc_title = "$h_kconfig / $h_description";
 
 	my $desc_size = $max_size_kconfig + 4;
-	$desc_size = $max_size_description if ($max_size_description > $desc_size);
+	if (!$description_size) {
+		$desc_size = $max_size_description if ($max_size_description > $desc_size);
+	} else {
+		$desc_size = $description_size if ($description_size > $desc_size);
+	}
+	$desc_size = $max_description_word if ($max_description_word > $desc_size);
+
 	$desc_size = length($desc_title) if (length($desc_title) > $desc_size);
 
-	my $status_size = 60;
+	$max_size_status = length($notcompat) if (length($notcompat) > $max_size_status);
+
+	# Ensure that the status will fit
+	my $min_status_size = $max_size_status + $max_size_arch + 6;
+	$status_size = $min_status_size if ($status_size < $min_status_size);
+
 
 	my $cur_subsys = "";
 	foreach my $name (sort {
@@ -394,7 +423,7 @@ sub output_matrix {
 		my %arch_table = %{$data{$name}->{table}};
 		my $cur_status = "";
 
-		my @lines;
+		my (@lines, @descs);
 		my $line = "";
 		foreach my $arch (sort {
 					($arch_table{$b} cmp $arch_table{$a}) or
@@ -404,7 +433,7 @@ sub output_matrix {
 			my $status = $arch_table{$arch};
 
 			if ($status eq "---") {
-				$status = "Not compatible";
+				$status = $notcompat;
 			}
 
 			if ($status ne $cur_status) {
@@ -423,17 +452,35 @@ sub output_matrix {
 		}
 		push @lines, $line if ($line ne "");
 
-		# Ensure that description will be printed
-		push @lines, "" while (scalar(@lines) < 2);
+		my $description = $data{$name}->{description};
+		while (length($description) > $desc_size) {
+			my $d = substr $description, 0, $desc_size;
+
+			# Ensure that it will end on a space
+			# if it can't, it means that the size is too small
+			# Instead of aborting it, let's print what we have
+			if (!($d =~ s/^(.*)\s+.*/$1/)) {
+				$d = substr $d, 0, -1;
+				push @descs, "$d\\";
+				$description =~ s/^\Q$d\E//;
+			} else {
+				push @descs, $d;
+				$description =~ s/^\Q$d\E\s+//;
+			}
+		}
+		push @descs, $description;
+
+		# Ensure that the full description will be printed
+		push @lines, "" while (scalar(@lines) < 2 + scalar(@descs));
 
 		my $ln = 0;
 		for my $line(@lines) {
 			if (!$ln) {
 				printf "|%-${max_size_name}s", $name;
 				printf "|%-${desc_size}s", "``" . $data{$name}->{kconfig} . "``";
-			} elsif ($ln == 2) {
+			} elsif ($ln >= 2 && scalar(@descs)) {
 				printf "|%-${max_size_name}s", "";
-				printf "|%-${desc_size}s", $data{$name}->{description};
+				printf "|%-${desc_size}s", shift @descs;
 			} else {
 				printf "|%-${max_size_name}s", "";
 				printf "|%-${desc_size}s", "";
-- 
2.28.0

