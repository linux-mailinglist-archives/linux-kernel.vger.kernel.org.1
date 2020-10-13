Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1A28CCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgJMLyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgJMLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:40 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7594720870;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=V+7OC5N01urmt6Emf3gt8+IiL5ChKdmodgxNP6tpU1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/cALk6bvMfjuEAFNiTCs//57XePcLwqNJWAXvKGog2YcIlRg6DUGJaGRcvCP2y4N
         svVAvAdI4PcRi3NgPWK/fIEWoq4Xz6KfnQMrYmywOFKuGDqR7RMJ4GTgkA8kNJx4f/
         XD8Zip8ugN0XdsF1nJFt4Bdj5A97RvkjWuzN9IlQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTB-4k; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/80] scripts: kernel-doc: make it more compatible with Sphinx 3.x
Date:   Tue, 13 Oct 2020 13:53:17 +0200
Message-Id: <c0f29bb2ef4f0e8eb4f813f2bd291a58f7abc9e8.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Sphinx 3.x, the ".. c:type:" tag was changed to accept either:

	.. c:type:: typedef-like declaration
	.. c:type:: name

Using it for other types (including functions) don't work anymore.

So, there are newer tags for macro, enum, struct, union, and others,
which doesn't exist on older versions.

Add a check for the Sphinx version and change the produced tags
accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 71 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index adc05406c68e..096317ef2e97 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -271,6 +271,8 @@ if ($#ARGV == -1) {
 }
 
 my $kernelversion;
+my $sphinx_major;
+
 my $dohighlight = "";
 
 my $verbose = 0;
@@ -465,6 +467,43 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 
 # continue execution near EOF;
 
+# The C domain dialect changed on Sphinx 3. So, we need to check the
+# version in order to produce the right tags.
+sub findprog($)
+{
+	foreach(split(/:/, $ENV{PATH})) {
+		return "$_/$_[0]" if(-x "$_/$_[0]");
+	}
+}
+
+sub get_sphinx_version()
+{
+	my $ver;
+	my $major = 1;
+
+	my $cmd = "sphinx-build";
+	if (!findprog($cmd)) {
+		my $cmd = "sphinx-build3";
+		return $major if (!findprog($cmd));
+	}
+
+	open IN, "$cmd --version 2>&1 |";
+	while (<IN>) {
+		if (m/^\s*sphinx-build\s+([\d]+)\.([\d\.]+)(\+\/[\da-f]+)?$/) {
+			$major=$1;
+			last;
+		}
+		# Sphinx 1.2.x uses a different format
+		if (m/^\s*Sphinx.*\s+([\d]+)\.([\d\.]+)$/) {
+			$major=$1;
+			last;
+		}
+	}
+	close IN;
+
+	return $major;
+}
+
 # get kernel version from env
 sub get_kernel_version() {
     my $version = 'unknown kernel version';
@@ -848,7 +887,11 @@ sub output_function_rst(%) {
     my $start = "";
 
     if ($args{'typedef'}) {
-	print ".. c:type:: ". $args{'function'} . "\n\n";
+	if ($sphinx_major < 3) {
+	    print ".. c:type:: ". $args{'function'} . "\n\n";
+	} else {
+	    print ".. c:function:: ". $args{'function'} . "\n\n";
+	}
 	print_lineno($declaration_start_line);
 	print "   **Typedef**: ";
 	$lineprefix = "";
@@ -938,9 +981,14 @@ sub output_enum_rst(%) {
     my ($parameter);
     my $oldprefix = $lineprefix;
     my $count;
-    my $name = "enum " . $args{'enum'};
 
-    print "\n\n.. c:type:: " . $name . "\n\n";
+    if ($sphinx_major < 3) {
+	my $name = "enum " . $args{'enum'};
+	print "\n\n.. c:type:: " . $name . "\n\n";
+    } else {
+	my $name = $args{'enum'};
+	print "\n\n.. c:enum:: " . $name . "\n\n";
+    }
     print_lineno($declaration_start_line);
     $lineprefix = "   ";
     output_highlight_rst($args{'purpose'});
@@ -966,8 +1014,13 @@ sub output_typedef_rst(%) {
     my %args = %{$_[0]};
     my ($parameter);
     my $oldprefix = $lineprefix;
-    my $name = "typedef " . $args{'typedef'};
+    my $name;
 
+    if ($sphinx_major < 3) {
+	$name = "typedef " . $args{'typedef'};
+    } else {
+	$name = $args{'typedef'};
+    }
     print "\n\n.. c:type:: " . $name . "\n\n";
     print_lineno($declaration_start_line);
     $lineprefix = "   ";
@@ -982,9 +1035,14 @@ sub output_struct_rst(%) {
     my %args = %{$_[0]};
     my ($parameter);
     my $oldprefix = $lineprefix;
-    my $name = $args{'type'} . " " . $args{'struct'};
 
-    print "\n\n.. c:type:: " . $name . "\n\n";
+    if ($sphinx_major < 3) {
+	my $name = $args{'type'} . " " . $args{'struct'};
+	print "\n\n.. c:type:: " . $name . "\n\n";
+    } else {
+	my $name = $args{'struct'};
+	print "\n\n.. c:struct:: " . $name . "\n\n";
+    }
     print_lineno($declaration_start_line);
     $lineprefix = "   ";
     output_highlight_rst($args{'purpose'});
@@ -2242,6 +2300,7 @@ sub process_file($) {
 }
 
 
+$sphinx_major = get_sphinx_version();
 $kernelversion = get_kernel_version();
 
 # generate a sequence of code that will splice in highlighting information
-- 
2.26.2

