Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C0284CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgJFOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgJFODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:54 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650402078E;
        Tue,  6 Oct 2020 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993033;
        bh=s6S4taexIdWOJS8hIpJ2NenG8qH1N1Tyj7alNwEfNng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KV3QxICPrs5FmTFZLO6q2ciLIj6UWcOE8cOJQlmUkXB2dvugVnUxkuSbQ/Jx5JUR+
         OGQLOV1kMparhZo3iNSKB+ljEUrGE2MyYmUN1b6+ReJNE9zfxDIjQjStOo2iiZ52rs
         3/aoSjF47x++el+82u6bY3YX1CvIleUSsPRA1xeU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Er-AK; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/52] scripts: kernel-doc: don't mangle with parameter list
Date:   Tue,  6 Oct 2020 16:03:06 +0200
Message-Id: <933d25d383d0976693ad80dcdacd68077a456db8.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While kernel-doc needs to parse parameters in order to
identify its name, it shouldn't be touching the type,
as parsing it is very difficult, and errors happen.

One current error is when parsing this parameter:

	const u32 (*tab)[256]

Found at ./lib/crc32.c, on this function:

	u32 __pure crc32_be_generic (u32 crc, unsigned char const *p, size_t len, const u32 (*tab)[256], u32 polynomial);

The current logic mangles it, producing this output:

	const u32 ( *tab

That's something that it is not recognizeable.

So, instead, let's push the argument as-is, and use it
when printing the function prototype and when describing
each argument.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 33ad3ce66f73..09e3e78b9723 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -655,10 +655,10 @@ sub output_function_man(%) {
 	$type = $args{'parametertypes'}{$parameter};
 	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
 	    # pointer-to-function
-	    print ".BI \"" . $parenth . $1 . "\" " . $parameter . " \") (" . $2 . ")" . $post . "\"\n";
+	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
 	} else {
 	    $type =~ s/([^\*])$/$1 /;
-	    print ".BI \"" . $parenth . $type . "\" " . $parameter . " \"" . $post . "\"\n";
+	    print ".BI \"" . $parenth . $type . "\" " . " \"" . $post . "\"\n";
 	}
 	$count++;
 	$parenth = "";
@@ -929,7 +929,7 @@ sub output_function_rst(%) {
 	    # pointer-to-function
 	    print $1 . $parameter . ") (" . $2 . ")";
 	} else {
-	    print $type . " " . $parameter;
+	    print $type;
 	}
     }
     if ($args{'typedef'}) {
@@ -954,7 +954,7 @@ sub output_function_rst(%) {
 	$type = $args{'parametertypes'}{$parameter};
 
 	if ($type ne "") {
-	    print "``$type $parameter``\n";
+	    print "``$type``\n";
 	} else {
 	    print "``$parameter``\n";
 	}
@@ -1479,7 +1479,7 @@ sub create_parameterlist($$$$) {
 	    # Treat preprocessor directive as a typeless variable just to fill
 	    # corresponding data structures "correctly". Catch it later in
 	    # output_* subs.
-	    push_parameter($arg, "", $file);
+	    push_parameter($arg, "", "", $file);
 	} elsif ($arg =~ m/\(.+\)\s*\(/) {
 	    # pointer-to-function
 	    $arg =~ tr/#/,/;
@@ -1488,7 +1488,7 @@ sub create_parameterlist($$$$) {
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*?)\s*$param/$1/;
 	    save_struct_actual($param);
-	    push_parameter($param, $type, $file, $declaration_name);
+	    push_parameter($param, $type, $arg, $file, $declaration_name);
 	} elsif ($arg) {
 	    $arg =~ s/\s*:\s*/:/g;
 	    $arg =~ s/\s*\[/\[/g;
@@ -1513,26 +1513,28 @@ sub create_parameterlist($$$$) {
 	    foreach $param (@args) {
 		if ($param =~ m/^(\*+)\s*(.*)/) {
 		    save_struct_actual($2);
-		    push_parameter($2, "$type $1", $file, $declaration_name);
+
+		    push_parameter($2, "$type $1", $arg, $file, $declaration_name);
 		}
 		elsif ($param =~ m/(.*?):(\d+)/) {
 		    if ($type ne "") { # skip unnamed bit-fields
 			save_struct_actual($1);
-			push_parameter($1, "$type:$2", $file, $declaration_name)
+			push_parameter($1, "$type:$2", $arg, $file, $declaration_name)
 		    }
 		}
 		else {
 		    save_struct_actual($param);
-		    push_parameter($param, $type, $file, $declaration_name);
+		    push_parameter($param, $type, $arg, $file, $declaration_name);
 		}
 	    }
 	}
     }
 }
 
-sub push_parameter($$$$) {
+sub push_parameter($$$$$) {
 	my $param = shift;
 	my $type = shift;
+	my $org_arg = shift;
 	my $file = shift;
 	my $declaration_name = shift;
 
@@ -1596,8 +1598,8 @@ sub push_parameter($$$$) {
 	# "[blah" in a parameter string;
 	###$param =~ s/\s*//g;
 	push @parameterlist, $param;
-	$type =~ s/\s\s+/ /g;
-	$parametertypes{$param} = $type;
+	$org_arg =~ s/\s\s+/ /g;
+	$parametertypes{$param} = $org_arg;
 }
 
 sub check_sections($$$$$) {
-- 
2.26.2

