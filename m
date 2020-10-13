Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A428CD92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgJMMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B2222284;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=U5ZWAf96WfzAbbo+w4enc1NZ9aFx1PAoXHi6/JrfvK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCG1aQBXb2ulQ6tT4inVhLMO3xOyI48WyE4pvDo4yjnA236i0OxOo4f3obezDZRYj
         vsXf73tuSwsyPm9A1wycbfer7KvKgLeqSOeFkAh3RMGkV3mEEcuV/HbdWhzgB6E8cg
         tLOsNerHP2wgks9JzXUp87mdhdqN7+50NsWa4f/c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTU-C9; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/80] scripts: kernel-doc: try to use c:function if possible
Date:   Tue, 13 Oct 2020 13:53:25 +0200
Message-Id: <cde8f06e9b502aaf42001adcec998c58b040952a.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few namespace clashes by using c:macro everywhere:

basically, when using it, we can't have something like:

	.. c:struct:: pwm_capture

	.. c:macro:: pwm_capture

So, we need to use, instead:

	.. c:function:: int pwm_capture (struct pwm_device * pwm, struct pwm_capture * result, unsigned long timeout)

for the function declaration.

The kernel-doc change was proposed by Jakob Lykke Andersen here:

	https://github.com/jakobandersen/linux_docs/commit/6fd2076ec001cca7466857493cd678df4dfe4a65

Although I did a different implementation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 9496abba9538..c8f6b11d5da1 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -917,6 +917,7 @@ sub output_function_rst(%) {
     my ($parameter, $section);
     my $oldprefix = $lineprefix;
     my $start = "";
+    my $is_macro = 0;
 
     if ($sphinx_major < 3) {
 	if ($args{'typedef'}) {
@@ -926,11 +927,17 @@ sub output_function_rst(%) {
 	    $lineprefix = "";
 	    output_highlight_rst($args{'purpose'});
 	    $start = "\n\n**Syntax**\n\n  ``";
+	    $is_macro = 1;
 	} else {
 	    print ".. c:function:: ";
 	}
     } else {
-	print ".. c:macro:: ". $args{'function'} . "\n\n";
+	if ($args{'typedef'} || $args{'functiontype'} eq "") {
+	    $is_macro = 1;
+	    print ".. c:macro:: ". $args{'function'} . "\n\n";
+	} else {
+	    print ".. c:function:: ";
+	}
 
 	if ($args{'typedef'}) {
 	    print_lineno($declaration_start_line);
@@ -939,7 +946,7 @@ sub output_function_rst(%) {
 	    output_highlight_rst($args{'purpose'});
 	    $start = "\n\n**Syntax**\n\n  ``";
 	} else {
-	    print "``";
+	    print "``" if ($is_macro);
 	}
     }
     if ($args{'functiontype'} ne "") {
@@ -964,14 +971,12 @@ sub output_function_rst(%) {
 	    print $type;
 	}
     }
-    if ($args{'typedef'}) {
-	print ");``\n\n";
+    if ($is_macro) {
+	print ")``\n\n";
     } else {
-	if ($sphinx_major < 3) {
-	    print ")\n\n";
-	} else {
-	    print ")``\n";
-	}
+	print ")\n\n";
+    }
+    if (!$args{'typedef'}) {
 	print_lineno($declaration_start_line);
 	$lineprefix = "   ";
 	output_highlight_rst($args{'purpose'});
-- 
2.26.2

