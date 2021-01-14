Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0AE2F5C19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbhANIGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbhANIGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4482123A1D;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=3MJx+wE/msD1K+V7JwUI9CV7ixGi+LKktDOF1MdqG/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM2i4Psvt8b3RpiLxkVbTA/Agpz4iGO4r+CQzYcd/FI8SbPMbobmmEWCYkWCtXnX1
         wIowSJ+Z4oEouU0nErc/75uariku9+wzyiXayi9TrvNDD2+/lZdPX+i/6pNa8HxzZt
         qgd5xTEQtuq81U2HMK6q2ZGf/ju9DBTRpWj8p6vLD0XUyJD2qsVCfAAQ+x75CW9kpe
         YwScahqwyAK4InCobtJ8oT7y2h89Ve9MwxUGeHDuGdVvgqMfs4iRzK9OLg+X5a+DIp
         9AfcjQU57PBibz/an4u8fEiBMDblpbBYxCoXt3Hqwwmm+H4q4segIgZpaY4r18oO7U
         XolzUB1W820+A==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ6q-7z; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/16] scripts: kernel-doc: validate kernel-doc markup with the actual names
Date:   Thu, 14 Jan 2021 09:04:47 +0100
Message-Id: <081546f141a496d6cabb99a4adc140444c705e93.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc currently expects that the kernel-doc markup to come
just before the function/enum/struct/union/typedef prototype.

Yet, if it find things like:

	/**
	 * refcount_add - add a value to a refcount
	 * @i: the value to add to the refcount
	 * @r: the refcount
	 */
	static inline void __refcount_add(int i, refcount_t *r, int *oldp);
	static inline void refcount_add(int i, refcount_t *r);

Kernel-doc will do the wrong thing:

	foobar.h:6: warning: Function parameter or member 'oldp' not described in '__refcount_add'
	.. c:function:: void __refcount_add (int i, refcount_t *r, int *oldp)

	   add a value to a refcount

	**Parameters**

	``int i``
	  the value to add to the refcount

	``refcount_t *r``
	  the refcount

	``int *oldp``
	  *undescribed*

Basically, it will document "__refcount_add" with the kernel-doc
markup for refcount_add.

If both functions have the same arguments, this won't even
produce any warning!

Add a logic to check if the kernel-doc identifier matches the actual
name of the C function or data structure that will be documented.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 62 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 6325bec3f66f..a9a92e623dbc 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -382,6 +382,9 @@ my $inline_doc_state;
 # 'function', 'struct', 'union', 'enum', 'typedef'
 my $decl_type;
 
+# Name of the kernel-doc identifier for non-DOC markups
+my $identifier;
+
 my $doc_start = '^/\*\*\s*$'; # Allow whitespace at end of comment start.
 my $doc_end = '\*/';
 my $doc_com = '\s*\*\s*';
@@ -1203,6 +1206,11 @@ sub dump_struct($$) {
 	$declaration_name = $2;
 	my $members = $3;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
+	    return;
+	}
+
 	# ignore members marked private:
 	$members =~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
 	$members =~ s/\/\*\s*private:.*//gosi;
@@ -1391,6 +1399,11 @@ sub dump_enum($$) {
     }
 
     if ($members) {
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
+	    return;
+	}
+
 	my %_members;
 
 	$members =~ s/\s+$//;
@@ -1451,6 +1464,11 @@ sub dump_typedef($$) {
 	my $args = $3;
 	$return_type =~ s/^\s+//;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    return;
+	}
+
 	create_parameterlist($args, ',', $file, $declaration_name);
 
 	output_declaration($declaration_name,
@@ -1477,6 +1495,11 @@ sub dump_typedef($$) {
     if ($x =~ /typedef.*\s+(\w+)\s*;/) {
 	$declaration_name = $1;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    return;
+	}
+
 	output_declaration($declaration_name,
 			   'typedef',
 			   {'typedef' => $declaration_name,
@@ -1796,6 +1819,11 @@ sub dump_function($$) {
 	return;
     }
 
+    if ($identifier ne $declaration_name) {
+	print STDERR "${file}:$.: warning: expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n";
+	return;
+    }
+
     my $prms = join " ", @parameterlist;
     check_sections($file, $declaration_name, "function", $sectcheck, $prms);
 
@@ -1878,6 +1906,7 @@ sub tracepoint_munge($) {
 			     "$prototype\n";
 	} else {
 		$prototype = "static inline void trace_$tracepointname($tracepointargs)";
+		$identifier = "trace_$identifier";
 	}
 }
 
@@ -2041,7 +2070,6 @@ sub process_normal() {
 #
 sub process_name($$) {
     my $file = shift;
-    my $identifier;
     my $descr;
 
     if (/$doc_block/o) {
@@ -2054,12 +2082,19 @@ sub process_name($$) {
 	} else {
 	    $section = $1;
 	}
-    }
-    elsif (/$doc_decl/o) {
+    } elsif (/$doc_decl/o) {
 	$identifier = $1;
-	if (/\s*([\w\s]+?)(\(\))?\s*-/) {
+	if (/\s*([\w\s]+?)(\(\))?\s*([-:].*)?$/) {
 	    $identifier = $1;
 	}
+	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
+	    $decl_type = $1;
+	    $identifier = $2;
+	} else {
+	    $decl_type = 'function';
+	    $identifier =~ s/^define\s+//;
+	}
+	$identifier =~ s/\s+$//;
 
 	$state = STATE_BODY;
 	# if there's no @param blocks need to set up default section
@@ -2067,7 +2102,7 @@ sub process_name($$) {
 	$contents = "";
 	$section = $section_default;
 	$new_start_line = $. + 1;
-	if (/-(.*)/) {
+	if (/[-:](.*)/) {
 	    # strip leading/trailing/multiple spaces
 	    $descr= $1;
 	    $descr =~ s/^\s*//;
@@ -2085,20 +2120,15 @@ sub process_name($$) {
 	    ++$warnings;
 	}
 
-	if ($identifier =~ m/^struct\b/) {
-	    $decl_type = 'struct';
-	} elsif ($identifier =~ m/^union\b/) {
-	    $decl_type = 'union';
-	} elsif ($identifier =~ m/^enum\b/) {
-	    $decl_type = 'enum';
-	} elsif ($identifier =~ m/^typedef\b/) {
-	    $decl_type = 'typedef';
-	} else {
-	    $decl_type = 'function';
+	if ($identifier eq "") {
+	    print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
+	    print STDERR $_;
+	    ++$warnings;
+	    $state = STATE_NORMAL;
 	}
 
 	if ($verbose) {
-	    print STDERR "${file}:$.: info: Scanning doc for $identifier\n";
+	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
 	}
     } else {
 	print STDERR "${file}:$.: warning: Cannot understand $_ on line $.",
-- 
2.29.2

