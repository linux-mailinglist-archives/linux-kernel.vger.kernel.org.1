Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E3284D27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgJFOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734B421D94;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=JJygeWysdmSPfkBAPz/lSi66mnFfr/lU+uQc/vOsCCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5h7g4BW21EztleQfEIKod95SVlXntIFhX+AlP54bPU05MqvQuA7MNQ35/k1ZEAed
         2qzhr6UfA0gdBck2QR33m7NepLmSKFmoKsZ44IMEiQPloJFRyG+mXSAhASOwEQgtUD
         eidt8w9ymnrSJlv+yp+REdHGexe3hss0Fg3JMHMw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Ek-8C; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/52] scripts: kernel-doc: reimplement -nofunction argument
Date:   Tue,  6 Oct 2020 16:03:04 +0200
Message-Id: <da8579b1e1d4d48738bfafddf4f059081a3ef6a9.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the build system doesn't use -nofunction, as
it is pretty much useless, because it doesn't consider
the other output modes (extern, internal), working only
with all.

Also, it is limited to exclude functions.

Re-implement it in order to allow excluding any symbols from
the document output, no matter what mode is used.

The parameter was also renamed to "-nosymbol", as it express
better its meaning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index bdd2ebb4ac41..6a7996c96bbb 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -66,9 +66,8 @@ Output selection (mutually exclusive):
   -function NAME	Only output documentation for the given function(s)
 			or DOC: section title(s). All other functions and DOC:
 			sections are ignored. May be specified multiple times.
-  -nofunction NAME	Do NOT output documentation for the given function(s);
-			only output documentation for the other functions and
-			DOC: sections. May be specified multiple times.
+  -nosymbol NAME	Exclude the specified symbols from the output
+		        documentation. May be specified multiple times.
 
 Output selection modifiers:
   -no-doc-sections	Do not output DOC: sections.
@@ -288,9 +287,8 @@ my $modulename = "Kernel API";
 use constant {
     OUTPUT_ALL          => 0, # output all symbols and doc sections
     OUTPUT_INCLUDE      => 1, # output only specified symbols
-    OUTPUT_EXCLUDE      => 2, # output everything except specified symbols
-    OUTPUT_EXPORTED     => 3, # output exported symbols
-    OUTPUT_INTERNAL     => 4, # output non-exported symbols
+    OUTPUT_EXPORTED     => 2, # output exported symbols
+    OUTPUT_INTERNAL     => 3, # output non-exported symbols
 };
 my $output_selection = OUTPUT_ALL;
 my $show_not_found = 0;	# No longer used
@@ -315,6 +313,7 @@ my $man_date = ('January', 'February', 'March', 'April', 'May', 'June',
 # CAVEAT EMPTOR!  Some of the others I localised may not want to be, which
 # could cause "use of undefined value" or other bugs.
 my ($function, %function_table, %parametertypes, $declaration_purpose);
+my %nosymbol_table = ();
 my $declaration_start_line;
 my ($type, $declaration_name, $return_type);
 my ($newsection, $newcontents, $prototype, $brcount, %source_map);
@@ -434,10 +433,9 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	$output_selection = OUTPUT_INCLUDE;
 	$function = shift @ARGV;
 	$function_table{$function} = 1;
-    } elsif ($cmd eq "nofunction") { # output all except specific functions
-	$output_selection = OUTPUT_EXCLUDE;
-	$function = shift @ARGV;
-	$function_table{$function} = 1;
+    } elsif ($cmd eq "nosymbol") { # Exclude specific symbols
+	my $symbol = shift @ARGV;
+	$nosymbol_table{$symbol} = 1;
     } elsif ($cmd eq "export") { # only exported symbols
 	$output_selection = OUTPUT_EXPORTED;
 	%function_table = ();
@@ -570,11 +568,11 @@ sub dump_doc_section {
         return;
     }
 
+    return if (defined($nosymbol_table{$name}));
+
     if (($output_selection == OUTPUT_ALL) ||
-	($output_selection == OUTPUT_INCLUDE &&
-	 defined($function_table{$name})) ||
-	($output_selection == OUTPUT_EXCLUDE &&
-	 !defined($function_table{$name})))
+	(($output_selection == OUTPUT_INCLUDE) &&
+	 defined($function_table{$name})))
     {
 	dump_section($file, $name, $contents);
 	output_blockhead({'sectionlist' => \@sectionlist,
@@ -800,6 +798,8 @@ sub output_blockhead_rst(%) {
     my ($parameter, $section);
 
     foreach $section (@{$args{'sectionlist'}}) {
+	next if (defined($nosymbol_table{$section}));
+
 	if ($output_selection != OUTPUT_INCLUDE) {
 	    print "**$section**\n\n";
 	}
@@ -1115,12 +1115,14 @@ sub output_declaration {
     my $name = shift;
     my $functype = shift;
     my $func = "output_${functype}_$output_mode";
+
+    return if (defined($nosymbol_table{$name}));
+
     if (($output_selection == OUTPUT_ALL) ||
 	(($output_selection == OUTPUT_INCLUDE ||
 	  $output_selection == OUTPUT_EXPORTED) &&
 	 defined($function_table{$name})) ||
-	(($output_selection == OUTPUT_EXCLUDE ||
-	  $output_selection == OUTPUT_INTERNAL) &&
+	($output_selection == OUTPUT_INTERNAL &&
 	 !($functype eq "function" && defined($function_table{$name}))))
     {
 	&$func(@_);
@@ -1301,6 +1303,8 @@ sub show_warnings($$) {
 	my $functype = shift;
 	my $name = shift;
 
+	return 0 if (defined($nosymbol_table{$name}));
+
 	return 1 if ($output_selection == OUTPUT_ALL);
 
 	if ($output_selection == OUTPUT_EXPORTED) {
@@ -1324,13 +1328,6 @@ sub show_warnings($$) {
 			return 0;
 		}
 	}
-	if ($output_selection == OUTPUT_EXCLUDE) {
-		if (!defined($function_table{$name})) {
-			return 1;
-		} else {
-			return 0;
-		}
-	}
 	die("Please add the new output type at show_warnings()");
 }
 
@@ -1952,6 +1949,7 @@ sub process_export_file($) {
 
     while (<IN>) {
 	if (/$export_symbol/) {
+	    next if (defined($nosymbol_table{$2}));
 	    $function_table{$2} = 1;
 	}
     }
-- 
2.26.2

