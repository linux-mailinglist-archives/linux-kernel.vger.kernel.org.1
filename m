Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CDC2782E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgIYIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgIYIii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:38:38 -0400
Received: from mail.kernel.org (ip5f5ad5bf.dynamic.kabel-deutschland.de [95.90.213.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E39208B6;
        Fri, 25 Sep 2020 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601023117;
        bh=bZXcJEGn6enyHGS8lxkZ6bKy81r0Oo99A6VeDeDrw/g=;
        h=From:To:Cc:Subject:Date:From;
        b=oag0JksG34Jew5PeHxbvLO79R8G41CMS8MYc03iPqc7iVHWH3FWh4HBSQXOdo+lf+
         8yRX7BFt2Jar4IVDvfJj5VrPjJioYH2UdlVTJKXMKuC2WyJss41LtgEVJRYYh5YrIA
         y72tPp9dlSphW5+rhq4AE42aY53rsGY3LgZDyQ/o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kLjFS-000TqD-Qo; Fri, 25 Sep 2020 10:38:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] scripts: kernel-doc: use a less pedantic markup for funcs on Sphinx 3.x
Date:   Fri, 25 Sep 2020 10:38:33 +0200
Message-Id: <14bed823b6c6f290705debfe42dfd6bed21c3231.1601022949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, Sphinx 3.x parser for c functions is too pedantic:

	https://github.com/sphinx-doc/sphinx/issues/8241

Making impossible to use it at the Kernel, as otherwise we would
need to add thousands of macros to conf.py, with would require
lots of maintainance.

So, let's instead use the :c:macro notation. This will
produce a worse result, but should provide cross-references and
will remove thousands of warnings when building with newer
versions of Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

Jon,

With this patch, the html doc builds with Sphinx 3.2.1 reduced from
1705 warnings to 624 ones.

The markup is not as nice as with Sphinx 1.x/2.x, but, IMHO, it is still
decent.

What do you think?

Please notice that this patch will affect the automarkup type used for
functions (with is currently broken anyway, with Sphinx 3.x)

 scripts/kernel-doc | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 48301ff41ec5..5b891e5c6338 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -886,15 +886,29 @@ sub output_function_rst(%) {
     my $oldprefix = $lineprefix;
     my $start = "";
 
-    if ($args{'typedef'}) {
-	print ".. c:function:: ". $args{'function'} . "\n\n";
-	print_lineno($declaration_start_line);
-	print "   **Typedef**: ";
-	$lineprefix = "";
-	output_highlight_rst($args{'purpose'});
-	$start = "\n\n**Syntax**\n\n  ``";
+    if ($sphinx_major < 3) {
+	if ($args{'typedef'}) {
+	    print ".. c:function:: ". $args{'function'} . "\n\n";
+	    print_lineno($declaration_start_line);
+	    print "   **Typedef**: ";
+	    $lineprefix = "";
+	    output_highlight_rst($args{'purpose'});
+	    $start = "\n\n**Syntax**\n\n  ``";
+	} else {
+	    print ".. c:function:: ";
+	}
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
@@ -921,7 +935,11 @@ sub output_function_rst(%) {
     if ($args{'typedef'}) {
 	print ");``\n\n";
     } else {
-	print ")\n\n";
+	if ($sphinx_major < 3) {
+	    print ")\n";
+	} else {
+	    print ")``\n\n";
+	}
 	print_lineno($declaration_start_line);
 	$lineprefix = "   ";
 	output_highlight_rst($args{'purpose'});
-- 
2.26.2


