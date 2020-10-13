Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5811128CDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgJMMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgJMLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:40 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829FD214DB;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=9VEsYhA+IZ9Xtatn4juI3lEEjzxTE03ZUU+Ozq91eE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EREVZu5TRHokVnVgaYWA/610tL8E7P2izsD3bDaM6CRjrrK8YtDJuK+Rk230MSEbH
         b3oQ7OJjcHqg5PvNZuYnC4zSVgf/e+TT7fTP98VLwCz2iIGSYNCja9JW/lQMz4XMyR
         HkIoT2Zfe0rxsEeYVWNDSmTfBmM7GRVhavO0v65o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTQ-A2; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/80] scripts: kernel-doc: allow passing desired Sphinx C domain dialect
Date:   Tue, 13 Oct 2020 13:53:23 +0200
Message-Id: <75d55d04379c5754edbe5d76abd82d91d57861a4.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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
 Documentation/sphinx/kerneldoc.py |  5 +++
 scripts/kernel-doc                | 51 ++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 8 deletions(-)

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
index 09e3e78b9723..ed32883c3221 100755
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
 
@@ -457,6 +464,23 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	    $enable_lineno = 1;
     } elsif ($cmd eq 'show-not-found') {
 	$show_not_found = 1;  # A no-op but don't fail
+    } elsif ($cmd eq "sphinx-version") {
+	my $ver_string = shift @ARGV;
+	if ($ver_string =~ m/^(\d+)(\.\d+)?(\.\d+)?/) {
+	    $sphinx_major = $1;
+	    if (defined($2)) {
+		$sphinx_minor = substr($2,1);
+	    } else {
+		$sphinx_minor = 0;
+	    }
+	    if (defined($3)) {
+		$sphinx_patch = substr($3,1)
+	    } else {
+		$sphinx_patch = 0;
+	    }
+	} else {
+	    die "Sphinx version should either major.minor or major.minor.patch format\n";
+	}
     } else {
 	# Unknown argument
         usage();
@@ -477,29 +501,37 @@ sub findprog($)
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
@@ -2333,7 +2365,10 @@ sub process_file($) {
 }
 
 
-$sphinx_major = get_sphinx_version();
+if ($output_mode eq "rst") {
+	get_sphinx_version() if (!$sphinx_major);
+}
+
 $kernelversion = get_kernel_version();
 
 # generate a sequence of code that will splice in highlighting information
-- 
2.26.2

