Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6239284CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgJFOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgJFODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:54 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5752820760;
        Tue,  6 Oct 2020 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993033;
        bh=PWRGzQUvPDkA+Rb+F9cbA6b5Ty5xqANZBUGQmShvoFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFgX5Wxje9DLIi7IlIKkk7wsX1tCkmZxmRWmM4fBNPGgOMuPjRu7l8pNDSTKCZUii
         cm7M+BvYebsgaR/XTExLtarPGC8xoGLk3xtrR6Obb/rvx1J5tBk8YrY+ueI3rRkjwJ
         9UcGA9lOlUmOQ16HQEFd0qZOUCzBjjp7+eEozjsI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Em-9I; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/52] scripts: kernel-doc: fix typedef identification
Date:   Tue,  6 Oct 2020 16:03:05 +0200
Message-Id: <3bb01199a823782ed211109f36d3704ef66ec792.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some typedef expressions are output as normal functions.

As we need to be clearer about the type with Sphinx 3.x,
detect such cases.

While here, fix a wrongly-indented block.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 62 ++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 6a7996c96bbb..33ad3ce66f73 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1748,30 +1748,48 @@ sub dump_function($$) {
 	return;
     }
 
-	my $prms = join " ", @parameterlist;
-	check_sections($file, $declaration_name, "function", $sectcheck, $prms);
+    my $prms = join " ", @parameterlist;
+    check_sections($file, $declaration_name, "function", $sectcheck, $prms);
 
-        # This check emits a lot of warnings at the moment, because many
-        # functions don't have a 'Return' doc section. So until the number
-        # of warnings goes sufficiently down, the check is only performed in
-        # verbose mode.
-        # TODO: always perform the check.
-        if ($verbose && !$noret) {
-                check_return_section($file, $declaration_name, $return_type);
-        }
+    # This check emits a lot of warnings at the moment, because many
+    # functions don't have a 'Return' doc section. So until the number
+    # of warnings goes sufficiently down, the check is only performed in
+    # verbose mode.
+    # TODO: always perform the check.
+    if ($verbose && !$noret) {
+	    check_return_section($file, $declaration_name, $return_type);
+    }
 
-    output_declaration($declaration_name,
-		       'function',
-		       {'function' => $declaration_name,
-			'module' => $modulename,
-			'functiontype' => $return_type,
-			'parameterlist' => \@parameterlist,
-			'parameterdescs' => \%parameterdescs,
-			'parametertypes' => \%parametertypes,
-			'sectionlist' => \@sectionlist,
-			'sections' => \%sections,
-			'purpose' => $declaration_purpose
-		       });
+    # The function parser can be called with a typedef parameter.
+    # Handle it.
+    if ($return_type =~ /typedef/) {
+	output_declaration($declaration_name,
+			   'function',
+			   {'function' => $declaration_name,
+			    'typedef' => 1,
+			    'module' => $modulename,
+			    'functiontype' => $return_type,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'parametertypes' => \%parametertypes,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+    } else {
+	output_declaration($declaration_name,
+			   'function',
+			   {'function' => $declaration_name,
+			    'module' => $modulename,
+			    'functiontype' => $return_type,
+			    'parameterlist' => \@parameterlist,
+			    'parameterdescs' => \%parameterdescs,
+			    'parametertypes' => \%parametertypes,
+			    'sectionlist' => \@sectionlist,
+			    'sections' => \%sections,
+			    'purpose' => $declaration_purpose
+			   });
+    }
 }
 
 sub reset_state {
-- 
2.26.2

