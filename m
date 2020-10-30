Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA829FE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgJ3HlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgJ3HlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:04 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800082220B;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=P9iUow101YklT0hfJ7mCIbm2zNWBbw5RQe274ATrc64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bgt5OHtMLKKRvMQ51y4eTisOe028DcFGXUIxAbBk0eZ7ABacZGphhxh74zcZxr0x
         H8LFvJy7N5v2kGZm/qzijcmfrzlC9211kO75lc0nsc6/Qq4okUfqR6FVTEvWIxRf6g
         lLTIs1S/1Fd/ADpZif/ts1PyzMmN6yMJkzK2a8P8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004OfP-C3; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/39] scripts: get_abi.pl: cleanup ABI cross-reference logic
Date:   Fri, 30 Oct 2020 08:40:24 +0100
Message-Id: <dbc97c8c2dfd877921f058134c35b2a8b1f8414b.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the cross-references are generated on a single
step, when doing ReST output.

While this is nice optimization, it prevents auto-creating
cross-references for ABI symbols.

So, split it into a separate logic.

While here, turn on Perl warnings, as it helps to debug
problems inside the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 147 +++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 64 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index bd018eb3815b..d134cc1692ee 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -2,15 +2,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
 use strict;
+use warnings;
 use Pod::Usage;
 use Getopt::Long;
 use File::Find;
 use Fcntl ':mode';
 
-my $help;
-my $man;
-my $debug;
-my $enable_lineno;
+my $help = 0;
+my $man = 0;
+my $debug = 0;
+my $enable_lineno = 0;
 my $prefix="Documentation/ABI";
 
 #
@@ -40,6 +41,7 @@ pod2usage(2) if ($cmd eq "search" && !$arg);
 require Data::Dumper if ($debug);
 
 my %data;
+my %symbols;
 
 #
 # Displays an error message, printing file name and line
@@ -76,12 +78,12 @@ sub parse_abi {
 
 	my $what;
 	my $new_what;
-	my $tag;
+	my $tag = "";
 	my $ln;
 	my $xrefs;
 	my $space;
 	my @labels;
-	my $label;
+	my $label = "";
 
 	print STDERR "Opening $file\n" if ($debug > 1);
 	open IN, $file;
@@ -110,10 +112,18 @@ sub parse_abi {
 
 			if ($new_tag =~ m/what/) {
 				$space = "";
+				$content =~ s/[,.;]$//;
+
 				if ($tag =~ m/what/) {
 					$what .= ", " . $content;
 				} else {
-					parse_error($file, $ln, "What '$what' doesn't have a description", "") if ($what && !$data{$what}->{description});
+					if ($what) {
+						parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
+
+						foreach my $w(split /, /, $what) {
+							$symbols{$w} = $what;
+						};
+					}
 
 					$what = $content;
 					$label = $content;
@@ -122,7 +132,7 @@ sub parse_abi {
 				push @labels, [($content, $label)];
 				$tag = $new_tag;
 
-				push @{$data{$nametag}->{xrefs}}, [($content, $label)] if ($data{$nametag}->{what});
+				push @{$data{$nametag}->{symbols}}, $content if ($data{$nametag}->{what});
 				next;
 			}
 
@@ -132,7 +142,7 @@ sub parse_abi {
 				$data{$what}->{line_no} = $ln;
 
 				if ($new_what) {
-					@{$data{$what}->{label}} = @labels if ($data{$nametag}->{what});
+					@{$data{$what}->{label_list}} = @labels if ($data{$nametag}->{what});
 					@labels = ();
 					$label = "";
 					$new_what = 0;
@@ -203,36 +213,24 @@ sub parse_abi {
 		# Everything else is error
 		parse_error($file, $ln, "Unexpected line:", $_);
 	}
-	$data{$nametag}->{description} =~ s/^\n+//;
+	$data{$nametag}->{description} =~ s/^\n+// if ($data{$nametag}->{description});
+	if ($what) {
+		parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
+
+		foreach my $w(split /, /,$what) {
+			$symbols{$w} = $what;
+		};
+	}
 	close IN;
 }
 
-#
-# Outputs the book on ReST format
-#
+sub create_labels {
+	my %labels;
 
-my %labels;
+	foreach my $what (keys %data) {
+		next if ($data{$what}->{file} eq "File");
 
-sub output_rest {
-	foreach my $what (sort {
-				($data{$a}->{type} eq "File") cmp ($data{$b}->{type} eq "File") ||
-				$a cmp $b
-			       } keys %data) {
-		my $type = $data{$what}->{type};
-		my $file = $data{$what}->{file};
-		my $filepath = $data{$what}->{filepath};
-
-		if ($enable_lineno) {
-			printf "#define LINENO %s%s#%s\n\n",
-			       $prefix, $data{$what}->{file},
-			       $data{$what}->{line_no};
-		}
-
-		my $w = $what;
-		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
-
-
-		foreach my $p (@{$data{$what}->{label}}) {
+		foreach my $p (@{$data{$what}->{label_list}}) {
 			my ($content, $label) = @{$p};
 			$label = "abi_" . $label . " ";
 			$label =~ tr/A-Z/a-z/;
@@ -249,16 +247,39 @@ sub output_rest {
 			}
 			$labels{$label} = 1;
 
-			$data{$what}->{label} .= $label;
-
-			printf ".. _%s:\n\n", $label;
+			$data{$what}->{label} = $label;
 
 			# only one label is enough
 			last;
 		}
+	}
+}
 
+#
+# Outputs the book on ReST format
+#
 
-		$filepath =~ s,.*/(.*/.*),\1,;;
+sub output_rest {
+	create_labels();
+
+	foreach my $what (sort {
+				($data{$a}->{type} eq "File") cmp ($data{$b}->{type} eq "File") ||
+				$a cmp $b
+			       } keys %data) {
+		my $type = $data{$what}->{type};
+		my $file = $data{$what}->{file};
+		my $filepath = $data{$what}->{filepath};
+
+		if ($enable_lineno) {
+			printf "#define LINENO %s%s#%s\n\n",
+			       $prefix, $data{$what}->{file},
+			       $data{$what}->{line_no};
+		}
+
+		my $w = $what;
+		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
+
+		$filepath =~ s,.*/(.*/.*),$1,;;
 		$filepath =~ s,[/\-],_,g;;
 		my $fileref = "abi_file_".$filepath;
 
@@ -269,8 +290,9 @@ sub output_rest {
 			print ".. _$fileref:\n\n";
 			print "$w\n$bar\n\n";
 		} else {
-			my @names = split /\s*,\s*/,$w;
+			printf ".. _%s:\n\n", $data{$what}->{label};
 
+			my @names = split /, /,$w;
 			my $len = 0;
 
 			foreach my $name (@names) {
@@ -284,12 +306,13 @@ sub output_rest {
 				printf "| %s", $name . " " x ($len - length($name)) . " |\n";
 				print "+-" . "-" x $len . "-+\n";
 			}
-			print "\n";
+
+			print "\nDefined on file :ref:`$file <$fileref>`\n\n";
 		}
 
-		print "Defined on file :ref:`$file <$fileref>`\n\n" if ($type ne "File");
-
-		my $desc = $data{$what}->{description};
+		my $desc = "";
+		$desc = $data{$what}->{description} if (defined($data{$what}->{description}));
+		$desc =~ s/\s+$/\n/;
 
 		if (!($desc =~ /^\s*$/)) {
 			if ($description_is_rst) {
@@ -316,18 +339,11 @@ sub output_rest {
 			print "DESCRIPTION MISSING for $what\n\n" if (!$data{$what}->{is_file});
 		}
 
-		if ($data{$what}->{xrefs}) {
+		if ($data{$what}->{symbols}) {
 			printf "Has the following ABI:\n\n";
 
-			foreach my $p(@{$data{$what}->{xrefs}}) {
-				my ($content, $label) = @{$p};
-				$label = "abi_" . $label . " ";
-				$label =~ tr/A-Z/a-z/;
-
-				# Convert special chars to "_"
-				$label =~s/([\x00-\x2f\x3a-\x40\x5b-\x60\x7b-\xff])/_/g;
-				$label =~ s,_+,_,g;
-				$label =~ s,_$,,;
+			foreach my $content(@{$data{$what}->{symbols}}) {
+				my $label = $data{$symbols{$content}}->{label};
 
 				# Escape special chars from content
 				$content =~s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
@@ -355,17 +371,20 @@ sub search_symbols {
 
 		print "\n$what\n$bar\n\n";
 
-		my $kernelversion = $data{$what}->{kernelversion};
-		my $contact = $data{$what}->{contact};
-		my $users = $data{$what}->{users};
-		my $date = $data{$what}->{date};
-		my $desc = $data{$what}->{description};
-		$kernelversion =~ s/^\s+//;
-		$contact =~ s/^\s+//;
-		$users =~ s/^\s+//;
-		$users =~ s/\n//g;
-		$date =~ s/^\s+//;
-		$desc =~ s/^\s+//;
+		my $kernelversion = $data{$what}->{kernelversion} if (defined($data{$what}->{kernelversion}));
+		my $contact = $data{$what}->{contact} if (defined($data{$what}->{contact}));
+		my $users = $data{$what}->{users} if (defined($data{$what}->{users}));
+		my $date = $data{$what}->{date} if (defined($data{$what}->{date}));
+		my $desc = $data{$what}->{description} if (defined($data{$what}->{description}));
+
+		$kernelversion =~ s/^\s+// if ($kernelversion);
+		$contact =~ s/^\s+// if ($contact);
+		if ($users) {
+			$users =~ s/^\s+//;
+			$users =~ s/\n//g;
+		}
+		$date =~ s/^\s+// if ($date);
+		$desc =~ s/^\s+// if ($desc);
 
 		printf "Kernel version:\t\t%s\n", $kernelversion if ($kernelversion);
 		printf "Date:\t\t\t%s\n", $date if ($date);
-- 
2.26.2

