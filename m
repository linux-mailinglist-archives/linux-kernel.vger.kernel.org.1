Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE679284D43
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgJFOHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FEDA2087E;
        Tue,  6 Oct 2020 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993033;
        bh=KNCXzYh/acJnJFeYKV6JscUEBLkELaNTa2VvLuVSoNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ibb5VP+rgYK3FD13BMcSxiNut08JYy/i3E+lgrykCTnoh9u9nJc38m7OcByhCM+Uc
         KjeSQAb9xrMHRtN3STIPpEqbsz6oie4LIuNphPAQ0qW35q383bsvHHu1rsNXAlwO2b
         NbBxdrq6jbWv4COEVi+R6FZddTEpod/TUhNV6ePs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Et-BP; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/52] scripts: kernel-doc: allow passing desired Sphinx C domain dialect
Date:   Tue,  6 Oct 2020 16:03:07 +0200
Message-Id: <9e9301fadc02986b9c2709db50a4d6b98db3d9fa.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel-doc is called via kerneldoc.py, there's no need to
auto-detect the Sphinx version, as the Sphinx module already
knows it. So, add an optional parameter to allow changing the
Sphinx dialect.

As kernel-doc can also be manually called, keep the auto-detection
logic if the parameter was not specified. On such case, emit
a warning if sphinx-build can't be found at PATH.

I ended using a suggestion from Joe for using a more readable
regex, instead of using a complex one with a hidden group like:

	m/^(\d+)\.(\d+)(?:\.?(\d+)?)/

in order to get the optional <patch> argument.

Thanks-to: Joe Perches <joe@perches.com>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py |  5 ++++
 scripts/kernel-doc                | 44 +++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 4bcbd6ae01cd..1a1b12242a45 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -70,6 +70,11 @@ class KernelDocDirective(Directive):
         env = self.state.document.settings.env
         cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
 
+	# Pass the version string to kernel-doc, as it needs to use a different
+	# dialect, depending what the C domain supports for each specific
+	# Sphinx versions
+        cmd += ['-sphinx-version', sphinx.__version__]
+
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
 
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 09e3e78b9723..9881f08cf75c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -56,6 +56,13 @@ Output format selection (mutually exclusive):
   -rst			Output reStructuredText format.
   -none			Do not output documentation, only warnings.
 
+Output format selection modifier (affects only ReST output):
+
+  -sphinx-version	Use the ReST C domain dialect compatible with an
+			specific Sphinx Version.
+			If not specified, kernel-doc will auto-detect using
+			the sphinx-build version found on PATH.
+
 Output selection (mutually exclusive):
   -export		Only output documentation for symbols that have been
 			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
@@ -270,7 +277,7 @@ if ($#ARGV == -1) {
 }
 
 my $kernelversion;
-my $sphinx_major;
+my ($sphinx_major, $sphinx_minor, $sphinx_patch);
 
 my $dohighlight = "";
 
@@ -457,6 +464,19 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	    $enable_lineno = 1;
     } elsif ($cmd eq 'show-not-found') {
 	$show_not_found = 1;  # A no-op but don't fail
+    } elsif ($cmd eq "sphinx-version") {
+	my $ver_string = shift @ARGV;
+	if ($ver_string =~ m/^(\d+)\.(\d+)(\.\d+)?/) {
+	    $sphinx_major = $1;
+	    $sphinx_minor = $2;
+	    if (defined($3)) {
+		$sphinx_patch = substr($3,1);
+	    } else {
+		$sphinx_patch = 0;
+	    }
+	} else {
+	    die "Sphinx version should either major.minor or major.minor.patch format\n";
+	}
     } else {
 	# Unknown argument
         usage();
@@ -477,29 +497,37 @@ sub findprog($)
 sub get_sphinx_version()
 {
 	my $ver;
-	my $major = 1;
 
 	my $cmd = "sphinx-build";
 	if (!findprog($cmd)) {
 		my $cmd = "sphinx-build3";
-		return $major if (!findprog($cmd));
+		if (!findprog($cmd)) {
+			$sphinx_major = 1;
+			$sphinx_minor = 2;
+			$sphinx_patch = 0;
+			printf STDERR "Warning: Sphinx version not found. Using default (Sphinx version %d.%d.%d)\n",
+			       $sphinx_major, $sphinx_minor, $sphinx_patch;
+			return;
+		}
 	}
 
 	open IN, "$cmd --version 2>&1 |";
 	while (<IN>) {
 		if (m/^\s*sphinx-build\s+([\d]+)\.([\d\.]+)(\+\/[\da-f]+)?$/) {
-			$major=$1;
+			$sphinx_major = $1;
+			$sphinx_minor = $2;
+			$sphinx_patch = $3;
 			last;
 		}
 		# Sphinx 1.2.x uses a different format
 		if (m/^\s*Sphinx.*\s+([\d]+)\.([\d\.]+)$/) {
-			$major=$1;
+			$sphinx_major = $1;
+			$sphinx_minor = $2;
+			$sphinx_patch = $3;
 			last;
 		}
 	}
 	close IN;
-
-	return $major;
 }
 
 # get kernel version from env
@@ -2333,7 +2361,7 @@ sub process_file($) {
 }
 
 
-$sphinx_major = get_sphinx_version();
+get_sphinx_version() if (!$sphinx_major);
 $kernelversion = get_kernel_version();
 
 # generate a sequence of code that will splice in highlighting information
-- 
2.26.2

