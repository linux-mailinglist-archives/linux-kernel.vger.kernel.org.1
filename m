Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896C629FEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgJ3HmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgJ3HlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:06 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E33722456;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=V5DPYhc49mlxP3YFnJP/L8cYMprKFZhjzhQ2U2Q0q9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTb6mB0K1PZPTGNRA9isFrkAePQJlFh67Vm02ZEqFDHcCm9Ljj9NoXk+RsBNsDnHu
         1cByqZjJNgTxVT7UyHvtZqYfDpBvZXmaNtdy7v05ns8nhEFNmbCjYKFBZLz9MTROsy
         IjChAWgXqLCFEBmc6BsBuczkDaO+FDygmVzm1Lh0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004OfR-DA; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/39] scripts: get_abi.pl: detect duplicated ABI definitions
Date:   Fri, 30 Oct 2020 08:40:25 +0100
Message-Id: <d7a73b8b3aae5b2bff9279996ff9ca4cdfc89196.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
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
index d134cc1692ee..1d1408fad130 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -114,6 +114,8 @@ sub parse_abi {
 				$space = "";
 				$content =~ s/[,.;]$//;
 
+				push @{$symbols{$content}->{file}}, " $file:" . ($ln - 1);
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
@@ -390,7 +410,7 @@ sub search_symbols {
 		printf "Date:\t\t\t%s\n", $date if ($date);
 		printf "Contact:\t\t%s\n", $contact if ($contact);
 		printf "Users:\t\t\t%s\n", $users if ($users);
-		print "Defined on file:\t$file\n\n";
+		print "Defined on file(s):\t$file\n\n";
 		print "Description:\n\n$desc";
 	}
 }
@@ -410,13 +430,24 @@ print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
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

