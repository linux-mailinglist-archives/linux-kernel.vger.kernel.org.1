Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19E284D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJFOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgJFOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9B820866;
        Tue,  6 Oct 2020 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993035;
        bh=P6xz8KUdTSHt+tU0hrt3ccZ4JQH52NPEJDhTztH0y+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEFhanrWBen5TBYLafM8BE8CbU9kVJ2PoP0kxpgsJjQwK24YK55SIxTi8GsbbXo5t
         xKABiL+xbh5jHLCN/gn4Ak/Y+MH1GQHgk1Qs/A+MF5gKa7TtLI8ywCR/s4Zv9YvVUn
         /Hyq5Rvz/yhshbQObQnPBixvhAl7tbY1heFLyzI0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZJ-0019Go-53; Tue, 06 Oct 2020 16:03:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 50/52] scripts: kernel-doc: try to use c:function if possible
Date:   Tue,  6 Oct 2020 16:03:47 +0200
Message-Id: <62b87762d9747e9aa5064f70dd216858c721ba41.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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
index 9881f08cf75c..a3453de4495c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -913,6 +913,7 @@ sub output_function_rst(%) {
     my ($parameter, $section);
     my $oldprefix = $lineprefix;
     my $start = "";
+    my $is_macro = 0;
 
     if ($sphinx_major < 3) {
 	if ($args{'typedef'}) {
@@ -922,11 +923,17 @@ sub output_function_rst(%) {
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
@@ -935,7 +942,7 @@ sub output_function_rst(%) {
 	    output_highlight_rst($args{'purpose'});
 	    $start = "\n\n**Syntax**\n\n  ``";
 	} else {
-	    print "``";
+	    print "``" if ($is_macro);
 	}
     }
     if ($args{'functiontype'} ne "") {
@@ -960,14 +967,12 @@ sub output_function_rst(%) {
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

