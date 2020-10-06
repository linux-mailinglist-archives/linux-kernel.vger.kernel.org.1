Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B07284D50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgJFOHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgJFODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:54 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6882F207EA;
        Tue,  6 Oct 2020 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993033;
        bh=u0Ejw1NVIXMtPdidzb9uDuQjyovU4BtMfQmfTFTMrZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztrQBk1GT4cz/v2OncBiplVlQfmgzUnDzcrAE5Sza0Yb+09ewjXtYRK/kYMjl0ALU
         PmQUhFnBNf22mo9mLavIjt2L/njmjj91ntVIIrLbIo0xQp+Hjkk0Nc7EAPP/6KX8sH
         2AyHDM6KPHtHxbAUgKlXeSqXj8d1HW8cm7E+Sek8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Eg-5d; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/52] scripts: kernel-doc: use a less pedantic markup for funcs on Sphinx 3.x
Date:   Tue,  6 Oct 2020 16:03:02 +0200
Message-Id: <f3bee471d451281f954958f0546dcd56c67f5a35.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, Sphinx 3.x parser for c functions is too pedantic:

	https://github.com/sphinx-doc/sphinx/issues/8241

While it could be relaxed with some configurations, there are
several corner cases that it would make it hard to maintain,
and will require teaching conf.py about several macros.

So, let's instead use the :c:macro notation. This will
produce an output that it is not as nice as currently, but it
should still be acceptable, and will provide cross-references,
removing thousands of warnings when building with newer
versions of Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 096317ef2e97..d9783c98f33b 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -886,19 +886,29 @@ sub output_function_rst(%) {
     my $oldprefix = $lineprefix;
     my $start = "";
 
-    if ($args{'typedef'}) {
-	if ($sphinx_major < 3) {
+    if ($sphinx_major < 3) {
+	if ($args{'typedef'}) {
 	    print ".. c:type:: ". $args{'function'} . "\n\n";
+	    print_lineno($declaration_start_line);
+	    print "   **Typedef**: ";
+	    $lineprefix = "";
+	    output_highlight_rst($args{'purpose'});
+	    $start = "\n\n**Syntax**\n\n  ``";
 	} else {
-	    print ".. c:function:: ". $args{'function'} . "\n\n";
+	    print ".. c:function:: ";
 	}
-	print_lineno($declaration_start_line);
-	print "   **Typedef**: ";
-	$lineprefix = "";
-	output_highlight_rst($args{'purpose'});
-	$start = "\n\n**Syntax**\n\n  ``";
     } else {
-	print ".. c:function:: ";
+	print ".. c:macro:: ". $args{'function'} . "\n\n";
+
+	if ($args{'typedef'}) {
+	    print_lineno($declaration_start_line);
+	    print "   **Typedef**: ";
+	    $lineprefix = "";
+	    output_highlight_rst($args{'purpose'});
+	    $start = "\n\n**Syntax**\n\n  ``";
+	} else {
+	    print "``";
+	}
     }
     if ($args{'functiontype'} ne "") {
 	$start .= $args{'functiontype'} . " " . $args{'function'} . " (";
@@ -925,7 +935,11 @@ sub output_function_rst(%) {
     if ($args{'typedef'}) {
 	print ");``\n\n";
     } else {
-	print ")\n\n";
+	if ($sphinx_major < 3) {
+	    print ")\n\n";
+	} else {
+	    print ")``\n";
+	}
 	print_lineno($declaration_start_line);
 	$lineprefix = "   ";
 	output_highlight_rst($args{'purpose'});
-- 
2.26.2

