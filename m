Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29CC296B98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460935AbgJWI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460927AbgJWI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:59:08 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0162168B;
        Fri, 23 Oct 2020 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603443547;
        bh=80m6FlU2KLhIeD33jpZ5MyAV4BAx15zyl8CzBDzSTns=;
        h=From:To:Cc:Subject:Date:From;
        b=pih6UO6VL9gwi7OUQiwmP79WkAgYEpSg4F3CZVwSs0A7ry+jNntW3ulqmSxBG+T1v
         QqpfBfWwwstKJyTWAEnRJoX43eex1Wd0T7VYbmkEiTuloqVutcB99j47wiIeZPEvSb
         zpCZx8TE6/52CTBVVHThcyWlux0gzmHpQDPas3pM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kVsue-001qqw-4h; Fri, 23 Oct 2020 10:59:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel-doc: validate kernel-doc markup with the actual names
Date:   Fri, 23 Oct 2020 10:59:02 +0200
Message-Id: <ebd075324a26f07b801cc47465cff51e9bf5c115.1603443534.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
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
 scripts/kernel-doc | 56 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 99cd8418ff8a..7ffc54dfa5a0 100755
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
@@ -1791,6 +1809,11 @@ sub dump_function($$) {
 	return;
     }
 
+    if ($identifier ne $declaration_name) {
+	print STDERR "${file}:$.: warning: expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n";
+	return;
+    }
+
     my $prms = join " ", @parameterlist;
     check_sections($file, $declaration_name, "function", $sectcheck, $prms);
 
@@ -2036,7 +2059,6 @@ sub process_normal() {
 #
 sub process_name($$) {
     my $file = shift;
-    my $identifier;
     my $descr;
 
     if (/$doc_block/o) {
@@ -2049,12 +2071,19 @@ sub process_name($$) {
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
+	    $identifier =~ s/\(\)//;
+	}
+	$identifier =~ s/\s+$//;
 
 	$state = STATE_BODY;
 	# if there's no @param blocks need to set up default section
@@ -2062,7 +2091,7 @@ sub process_name($$) {
 	$contents = "";
 	$section = $section_default;
 	$new_start_line = $. + 1;
-	if (/-(.*)/) {
+	if (/[-:](.*)/) {
 	    # strip leading/trailing/multiple spaces
 	    $descr= $1;
 	    $descr =~ s/^\s*//;
@@ -2080,20 +2109,15 @@ sub process_name($$) {
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

