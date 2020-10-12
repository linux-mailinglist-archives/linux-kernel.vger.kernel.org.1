Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8348D28B4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbgJLMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388334AbgJLMdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:33:51 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9DB620757;
        Mon, 12 Oct 2020 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602506030;
        bh=tohlfQTkfXdUJtGBBzRCJve9wbCQXBOwa6pkSKA1kb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0eKzCLbp/IYaQeVolU/syVOKtIKrH8bI8p8sBkMzHisSOOWHdUSuqbDlO+Yqw0Ekj
         KaX5f7Fs6IK6LFL00UM/gihX2P6HwSZ8xdOHPAiBONjknipou4XT5sZ8TDOdoLbv+h
         5LVrlLyJNoC+euZjPyHdsOegrLnIKnv73yRUEa/Y=
Date:   Mon, 12 Oct 2020 14:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5.1 10/52] scripts: kernel-doc: allow passing desired
 Sphinx C domain dialect
Message-ID: <20201012143346.3643708c@coco.lan>
In-Reply-To: <9e9301fadc02986b9c2709db50a4d6b98db3d9fa.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
        <9e9301fadc02986b9c2709db50a4d6b98db3d9fa.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

v5.1: 

- Right now, the script only needs to know the Sphinx major version.
  So, relax the regex to allow entering version on 3 different
  formats:
	x
	x.y
	x.y.z
- if Sphinx output mode is not -rst, it shouldn't print a warning
  when the version is not found.

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
