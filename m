Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03911A8661
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbgDNQ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391288AbgDNQ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:56:30 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E541F2078A;
        Tue, 14 Apr 2020 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586883377;
        bh=IUIJv9P8srV7C+WCyXLISGhZx+byokchyezQVFEeQA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQsrjC/bFZnVGrWyi0LUj0Dmo0k0dp1AlEGFDWFlaeqWyf3ejlD4+aFIbHD7DLXHg
         GEjNjThbAfm/zktZPMjEcHD/40Di/vvnu7Wd/AGquVzkRf0itPjK8Ur6EmKfE5ftKy
         l796pRDRP6/5Y/3E9x6HNzkTdTRKrzHUMOGYtFsM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOr9-0068yt-6r; Tue, 14 Apr 2020 18:56:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH v2 6/6] scripts: sphinx-pre-install: add support for python -m venv
Date:   Tue, 14 Apr 2020 18:56:13 +0200
Message-Id: <252cc849c79527ad496247e4c481961478adf41c.1586883286.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586883286.git.mchehab+huawei@kernel.org>
References: <cover.1586883286.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since python 3.3, the recommended way to setup a virtual env is
via "python -m venv".

Set this as a default, if python version is compatible with
such feature.

While here, add more comments to it, as the script is
getting more complex. So, better to add more things, to avoid
accidentally breaking it while improving it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 111 ++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 37 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 89b033285caf..d4dfe1e59989 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 use strict;
 
-# Copyright (c) 2017-2019 Mauro Carvalho Chehab <mchehab@kernel.org>
+# Copyright (c) 2017-2020 Mauro Carvalho Chehab <mchehab@kernel.org>
 #
 
 my $prefix = "./";
@@ -22,9 +22,12 @@ my $need = 0;
 my $optional = 0;
 my $need_symlink = 0;
 my $need_sphinx = 0;
+my $need_venv = 0;
+my $need_virtualenv = 0;
 my $rec_sphinx_upgrade = 0;
 my $install = "";
 my $virtenv_dir = "";
+my $python_cmd = "";
 my $min_version;
 
 #
@@ -147,7 +150,7 @@ sub check_program($$)
 	my $prog = shift;
 	my $is_optional = shift;
 
-	return if findprog($prog);
+	return $prog if findprog($prog);
 
 	add_package($prog, $is_optional);
 }
@@ -168,9 +171,9 @@ sub check_python_module($$)
 	my $prog = shift;
 	my $is_optional = shift;
 
-	my $err = system("python3 -c 'import $prog' 2>/dev/null /dev/null");
-	return if ($err == 0);
-	my $err = system("python -c 'import $prog' 2>/dev/null /dev/null");
+	return if (!$python_cmd);
+
+	my $err = system("$python_cmd -c 'import $prog' 2>/dev/null /dev/null");
 	return if ($err == 0);
 
 	add_package($prog, $is_optional);
@@ -225,16 +228,6 @@ sub get_sphinx_fname()
 		return $fname;
 	}
 
-	if ($virtualenv) {
-		my $prog = findprog("virtualenv-3");
-		$prog = findprog("virtualenv-3.5") if (!$prog);
-
-		check_program("virtualenv", 0) if (!$prog);
-		$need_sphinx = 1;
-	} else {
-		add_package("python-sphinx", 0);
-	}
-
 	return "";
 }
 
@@ -268,7 +261,10 @@ sub check_sphinx()
 	$virtenv_dir = $virtenv_prefix . $rec_version;
 
 	my $sphinx = get_sphinx_fname();
-	return if ($sphinx eq "");
+	if ($sphinx eq "") {
+		$need_sphinx = 1;
+		return;
+	}
 
 	open IN, "$sphinx --version 2>&1 |" or die "$sphinx returned an error";
 	while (<IN>) {
@@ -336,6 +332,7 @@ sub give_debian_hints()
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
 		"sphinx_rtd_theme"	=> "python3-sphinx-rtd-theme",
+		"ensurepip"		=> "python3-venv",
 		"virtualenv"		=> "virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "imagemagick",
@@ -672,13 +669,13 @@ sub check_distros()
 
 sub deactivate_help()
 {
-	printf "\tIf you want to exit the virtualenv, you can use:\n";
+	printf "\nIf you want to exit the virtualenv, you can use:\n";
 	printf "\tdeactivate\n";
 }
 
 sub check_needs()
 {
-	# Check for needed programs/tools
+	# Check if Sphinx is already accessible from current environment
 	check_sphinx();
 
 	if ($system_release) {
@@ -689,6 +686,43 @@ sub check_needs()
 
 	print "To upgrade Sphinx, use:\n\n" if ($rec_sphinx_upgrade);
 
+	# Check python command line, trying first python3
+	$python_cmd = findprog("python3");
+	$python_cmd = check_program("python", 0) if (!$python_cmd);
+
+	# Check the type of virtual env, depending on Python version
+	if ($python_cmd) {
+		if ($virtualenv) {
+			my $tmp = qx($python_cmd --version 2>&1);
+			if ($tmp =~ m/(\d+\.)(\d+\.)/) {
+				if ($1 >= 3 && $2 >= 3) {
+					$need_venv = 1;		# python 3.3 or upper
+				} else {
+					$need_virtualenv = 1;
+				}
+				if ($1 < 3) {
+					# Complain if it finds python2 (or worse)
+					printf "Warning: python$1 support is deprecated. Use it with caution!\n";
+				}
+			} else {
+				die "Warning: couldn't identify $python_cmd version!";
+			}
+		} else {
+			add_package("python-sphinx", 0);
+		}
+	}
+
+	# Set virtualenv command line, if python < 3.3
+	my $virtualenv_cmd;
+	if ($need_virtualenv) {
+		$virtualenv_cmd = findprog("virtualenv-3");
+		$virtualenv_cmd = findprog("virtualenv-3.5") if (!$virtualenv_cmd);
+		if (!$virtualenv_cmd) {
+			check_program("virtualenv", 0);
+			$virtualenv_cmd = "virtualenv";
+		}
+	}
+
 	# Check for needed programs/tools
 	check_perl_module("Pod::Usage", 0);
 	check_program("make", 0);
@@ -702,12 +736,30 @@ sub check_needs()
 	check_program("rsvg-convert", 2) if ($pdf);
 	check_program("latexmk", 2) if ($pdf);
 
+	if ($need_sphinx || $rec_sphinx_upgrade) {
+		check_python_module("ensurepip", 0) if ($need_venv);
+	}
+
+	# Do distro-specific checks and output distro-install commands
 	check_distros();
 
+	if (!$python_cmd) {
+		if ($need == 1) {
+			die "Can't build as $need mandatory dependency is missing";
+		} elsif ($need) {
+			die "Can't build as $need mandatory dependencies are missing";
+		}
+	}
+
+	# Check if sphinx-build is called sphinx-build-3
 	if ($need_symlink) {
 		printf "\tsudo ln -sf %s /usr/bin/sphinx-build\n\n",
 		       which("sphinx-build-3");
 	}
+
+	# NOTE: if the system has a too old Sphinx version installed,
+	# it will recommend installing a newer version using virtualenv
+
 	if ($need_sphinx || $rec_sphinx_upgrade) {
 		my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
 		my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
@@ -721,27 +773,12 @@ sub check_needs()
 			exit (1);
 		} else {
 			my $rec_activate = "$virtenv_dir/bin/activate";
-			my $virtualenv = findprog("virtualenv-3");
-			my $rec_python3 = "";
-			$virtualenv = findprog("virtualenv-3.5") if (!$virtualenv);
-			$virtualenv = findprog("virtualenv") if (!$virtualenv);
-			$virtualenv = "virtualenv" if (!$virtualenv);
 
-			my $rel = "";
-			if (index($system_release, "Ubuntu") != -1) {
-				$rel = $1 if ($system_release =~ /Ubuntu\s+(\d+)[.]/);
-				if ($rel && $rel >= 16) {
-					$rec_python3 = " -p python3";
-				}
+			if ($need_venv) {
+				printf "\t$python_cmd -m venv $virtenv_dir\n";
+			} else {
+				printf "\t$virtualenv_cmd $virtenv_dir\n";
 			}
-			if (index($system_release, "Debian") != -1) {
-				$rel = $1 if ($system_release =~ /Debian\s+(\d+)/);
-				if ($rel && $rel >= 7) {
-					$rec_python3 = " -p python3";
-				}
-			}
-
-			printf "\t$virtualenv$rec_python3 $virtenv_dir\n";
 			printf "\t. $rec_activate\n";
 			printf "\tpip install -r $requirement_file\n";
 			deactivate_help();
-- 
2.25.2

