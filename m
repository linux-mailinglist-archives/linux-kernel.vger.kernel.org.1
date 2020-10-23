Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D875297435
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbgJWQfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AA524640;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470829;
        bh=kKdcFIDbvdIdbsg1p/Q0zZPYj9lZBHWVYn7UPRPdRmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNfRxv0N9bT8FY1LJcnC3/1Mk38o6gShcU3ocS0Qh0WQ7dNgJFHZrMjOEMdEeDg0z
         ZR+yeCxJVVpbSzGHkSe0f7oM3CGKYGIYBw5oCf0QopHixbOq8bd0L4Cm/HIzl+53RG
         4tQQek6j+l7RulUlkXnLYJ/b6PU8QcyshTZjRCLg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Axx-TT; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 56/56] scrpits: kernel-doc: validate kernel-doc markup with the actual names
Date:   Fri, 23 Oct 2020 18:33:43 +0200
Message-Id: <a21343a7012c87391c4850bf3151ebd82add8d1c.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
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
index 311d213ee74d..1371cd45f78b 100755
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
 
     if ($declaration_name) {
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
+	    return;
+	}
+
 	my %_members;
 
 	$members =~ s/\s+$//;
@@ -1446,6 +1459,11 @@ sub dump_typedef($$) {
 	$declaration_name = $2;
 	my $args = $3;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    return;
+	}
+
 	create_parameterlist($args, ',', $file, $declaration_name);
 
 	output_declaration($declaration_name,
@@ -1472,6 +1490,11 @@ sub dump_typedef($$) {
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
@@ -1791,6 +1814,11 @@ sub dump_function($$) {
 	return;
     }
 
+    if ($identifier ne $declaration_name) {
+	print STDERR "${file}:$.: warning: expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n";
+	return;
+    }
+
     my $prms = join " ", @parameterlist;
     check_sections($file, $declaration_name, "function", $sectcheck, $prms);
 
@@ -1873,6 +1901,7 @@ sub tracepoint_munge($) {
 			     "$prototype\n";
 	} else {
 		$prototype = "static inline void trace_$tracepointname($tracepointargs)";
+		$identifier = "trace_$identifier";
 	}
 }
 
@@ -2036,7 +2065,6 @@ sub process_normal() {
 #
 sub process_name($$) {
     my $file = shift;
-    my $identifier;
     my $descr;
 
     if (/$doc_block/o) {
@@ -2049,12 +2077,19 @@ sub process_name($$) {
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
@@ -2062,7 +2097,7 @@ sub process_name($$) {
 	$contents = "";
 	$section = $section_default;
 	$new_start_line = $. + 1;
-	if (/-(.*)/) {
+	if (/[-:](.*)/) {
 	    # strip leading/trailing/multiple spaces
 	    $descr= $1;
 	    $descr =~ s/^\s*//;
@@ -2080,20 +2115,15 @@ sub process_name($$) {
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
2.26.2

