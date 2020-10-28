Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7729D6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgJ1WRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731615AbgJ1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0EE24762;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=WDrW5cgGfVq5Sg/5CIYBmqthC9evi33PkL3XOL4x3Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EcSjW/Kkoo2kAaMaQa0etxna29Fd3RaToT7PGvj7rbqmzrRR+zDlGh0ycCXs9Y7J
         EcQjT27l29M6/GGJuJf5Dnw0ENQO5DsSVGDQ6ArH+Leq9SfHz47i3SYJG10PgUSaMp
         nH3Frau/v/rLr4mcSz808Jmrlx/nYUjGV5hQluvs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hky-9v; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/33] scripts: get_abi.pl: detect duplicated ABI definitions
Date:   Wed, 28 Oct 2020 15:23:04 +0100
Message-Id: <973ab227f500e3e7d4743523a40c5df8246b5fb0.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABI should define only once each What. The current script
logic assumes that.

However, that's not the case, currently: there are several
symbols with a generic definition, and per-driver ones.

Better handle such cases, by preserving the cross-references
with the files that define them, but also track such
cases, producing warnings, as they should be fixed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 85 +++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index df2efad11d88..c88cb8ee6bfd 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -114,6 +114,8 @@ sub parse_abi {
 				$space = "";
 				$content =~ s/[,.;]$//;
 
+				push @{$symbols{$content}->{file}}, " $content:" . ($ln - 1);
+
 				if ($tag =~ m/what/) {
 					$what .= ", " . $content;
 				} else {
@@ -121,7 +123,7 @@ sub parse_abi {
 						parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
 
 						foreach my $w(split /, /, $what) {
-							$symbols{$w} = $what;
+							$symbols{$w}->{xref} = $what;
 						};
 					}
 
@@ -139,8 +141,6 @@ sub parse_abi {
 			if ($tag ne "" && $new_tag) {
 				$tag = $new_tag;
 
-				$data{$what}->{line_no} = $ln;
-
 				if ($new_what) {
 					@{$data{$what}->{label_list}} = @labels if ($data{$nametag}->{what});
 					@labels = ();
@@ -148,9 +148,19 @@ sub parse_abi {
 					$new_what = 0;
 
 					$data{$what}->{type} = $type;
-					$data{$what}->{file} = $name;
-					$data{$what}->{filepath} = $file;
+					if (!defined($data{$what}->{file})) {
+						$data{$what}->{file} = $name;
+						$data{$what}->{filepath} = $file;
+					} else {
+						if ($name ne $data{$what}->{file}) {
+							$data{$what}->{file} .= " " . $name;
+							$data{$what}->{filepath} .= " " . $file;
+						}
+					}
 					print STDERR "\twhat: $what\n" if ($debug > 1);
+					$data{$what}->{line_no} = $ln;
+				} else {
+					$data{$what}->{line_no} = $ln if (!defined($data{$what}->{line_no}));
 				}
 
 				if (!$what) {
@@ -218,7 +228,7 @@ sub parse_abi {
 		parse_error($file, $ln, "What '$what' doesn't have a description", "") if (!$data{$what}->{description});
 
 		foreach my $w(split /, /,$what) {
-			$symbols{$w} = $what;
+			$symbols{$w}->{xref} = $what;
 		};
 	}
 	close IN;
@@ -267,29 +277,20 @@ sub output_rest {
 				$a cmp $b
 			       } keys %data) {
 		my $type = $data{$what}->{type};
-		my $file = $data{$what}->{file};
-		my $filepath = $data{$what}->{filepath};
+
+		my @file = split / /, $data{$what}->{file};
+		my @filepath = split / /, $data{$what}->{filepath};
 
 		if ($enable_lineno) {
 			printf "#define LINENO %s%s#%s\n\n",
-			       $prefix, $data{$what}->{file},
+			       $prefix, $file[0],
 			       $data{$what}->{line_no};
 		}
 
 		my $w = $what;
 		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
-		$filepath =~ s,.*/(.*/.*),$1,;;
-		$filepath =~ s,[/\-],_,g;;
-		my $fileref = "abi_file_".$filepath;
-
-		if ($type eq "File") {
-			my $bar = $w;
-			$bar =~ s/./-/g;
-
-			print ".. _$fileref:\n\n";
-			print "$w\n$bar\n\n";
-		} else {
+		if ($type ne "File") {
 			printf ".. _%s:\n\n", $data{$what}->{label};
 
 			my @names = split /, /,$w;
@@ -307,7 +308,26 @@ sub output_rest {
 				print "+-" . "-" x $len . "-+\n";
 			}
 
-			print "\nDefined on file :ref:`$file <$fileref>`\n\n";
+			print "\n";
+		}
+
+		for (my $i = 0; $i < scalar(@filepath); $i++) {
+			my $path = $filepath[$i];
+			my $f = $file[$i];
+
+			$path =~ s,.*/(.*/.*),$1,;;
+			$path =~ s,[/\-],_,g;;
+			my $fileref = "abi_file_".$path;
+
+			if ($type eq "File") {
+				my $bar = $w;
+				$bar =~ s/./-/g;
+
+				print ".. _$fileref:\n\n";
+				print "$w\n$bar\n\n";
+			} else {
+				print "Defined on file :ref:`$f <$fileref>`\n\n";
+			}
 		}
 
 		my $desc = "";
@@ -343,7 +363,7 @@ sub output_rest {
 			printf "Has the following ABI:\n\n";
 
 			foreach my $content(@{$data{$what}->{symbols}}) {
-				my $label = $data{$symbols{$content}}->{label};
+				my $label = $data{$symbols{$content}->{xref}}->{label};
 
 				# Escape special chars from content
 				$content =~s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
@@ -387,7 +407,7 @@ sub search_symbols {
 		printf "Date:\t\t\t%s\n", $date if ($date);
 		printf "Contact:\t\t%s\n", $contact if ($contact);
 		printf "Users:\t\t\t%s\n", $users if ($users);
-		print "Defined on file:\t$file\n\n";
+		print "Defined on file(s):\t$file\n\n";
 		print "Description:\n\n$desc";
 	}
 }
@@ -407,13 +427,24 @@ print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
 #
 # Handles the command
 #
-if ($cmd eq "rest") {
-	output_rest;
-} elsif ($cmd eq "search") {
+if ($cmd eq "search") {
 	search_symbols;
+} else {
+	if ($cmd eq "rest") {
+		output_rest;
+	}
+
+	# Warn about duplicated ABI entries
+	foreach my $what(sort keys %symbols) {
+		my @files = @{$symbols{$what}->{file}};
+
+		next if (scalar(@files) == 1);
+
+		printf STDERR "Warning: $what is defined %d times: @files\n",
+		    scalar(@files);
+	}
 }
 
-
 __END__
 
 =head1 NAME
-- 
2.26.2

