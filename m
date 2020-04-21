Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFA1B29C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgDUObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbgDUObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:12 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5019F206D4;
        Tue, 21 Apr 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479472;
        bh=2hhaL3b04GTa9hGkzgDtd8Jti5DfwEcuKgZiFOrKA4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZgCunWSTEpCKIDm+O41UNN6tUk+WQOXMM5rvDiW/0R/lDdQquI8kDIRdAbZJ92UH
         Z+F0iqQngMOhJ8NMs6h67aYAV/LGs2fAbk/TVB/Z19IVhW8AIK2IxE/9PB3ddLHlBs
         quL3b8zpJprxVm8Ev5e3jt/nHZg1hPew+eJJJthE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQtva-00BkqM-Gm; Tue, 21 Apr 2020 16:31:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/5] scripts: sphinx-pre-install: change the warning for version < 2.4.4
Date:   Tue, 21 Apr 2020 16:31:06 +0200
Message-Id: <79584d317ba16f5d4f37801c5ee57cf04085f962.1587478901.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested by Jon, change the version check, in order to not
emit a warning if version is >= 1.7.9, but below 2.4.4.

After this patch, if someone used an older version, it will
say:

	./scripts/sphinx-pre-install
	Sphinx version 1.7.9
	Note: It is recommended at least Sphinx version 2.4.4 if you need PDF support.
	Detected OS: Fedora release 31 (Thirty One).

	To upgrade Sphinx, use:

		/devel/v4l/docs/sphinx_1.7.9/bin/python3 -m venv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r ./Documentation/sphinx/requirements.txt

	If you want to exit the virtualenv, you can use:
		deactivate

	All optional dependencies are met.
	Needed package dependencies are met.

If Sphinx is not detected at all, it

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 249edb3932af..0d5684c08bbc 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -29,6 +29,8 @@ my $install = "";
 my $virtenv_dir = "";
 my $python_cmd = "";
 my $min_version;
+my $rec_version = "1.7.9";	# PDF won't build here
+my $min_pdf_version = "2.4.4";	# Min version where pdf builds
 
 #
 # Command line arguments
@@ -254,7 +256,7 @@ sub get_sphinx_version($)
 
 sub check_sphinx()
 {
-	my $rec_version;
+	my $default_version;
 	my $cur_version;
 
 	open IN, $conf or die "Can't open $conf";
@@ -271,15 +273,15 @@ sub check_sphinx()
 	open IN, $requirement_file or die "Can't open $requirement_file";
 	while (<IN>) {
 		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
-			$rec_version=$1;
+			$default_version=$1;
 			last;
 		}
 	}
 	close IN;
 
-	die "Can't get recommended sphinx version from $requirement_file" if (!$min_version);
+	die "Can't get default sphinx version from $requirement_file" if (!$default_version);
 
-	$virtenv_dir = $virtenv_prefix . $rec_version;
+	$virtenv_dir = $virtenv_prefix . $default_version;
 
 	my $sphinx = get_sphinx_fname();
 	if ($sphinx eq "") {
@@ -294,7 +296,7 @@ sub check_sphinx()
 
 	if ($cur_version lt $min_version) {
 		printf "ERROR: Sphinx version is %s. It should be >= %s (recommended >= %s)\n",
-		       $cur_version, $min_version, $rec_version;;
+		       $cur_version, $min_version, $default_version;
 		$need_sphinx = 1;
 		return;
 	}
@@ -302,6 +304,13 @@ sub check_sphinx()
 	if ($cur_version lt $rec_version) {
 		printf "Sphinx version %s\n", $cur_version;
 		print "Warning: It is recommended at least Sphinx version $rec_version.\n";
+		print "         If you want pdf, you need at least $min_pdf_version.\n";
+		$rec_sphinx_upgrade = 1;
+		return;
+	}
+	if ($cur_version lt $min_pdf_version) {
+		printf "Sphinx version %s\n", $cur_version;
+		print "Note: It is recommended at least Sphinx version $min_pdf_version if you need PDF support.\n";
 		$rec_sphinx_upgrade = 1;
 		return;
 	}
-- 
2.25.2

