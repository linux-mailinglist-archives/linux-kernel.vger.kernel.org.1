Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FA28CCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgJMLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbgJMLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D9B21D81;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=PWRGzQUvPDkA+Rb+F9cbA6b5Ty5xqANZBUGQmShvoFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBfpxbR/uURWCXgAJlYNetKlNA2kkO5sccLLITBL5pEk2P2o/vn0BOz9B1tU6qF9n
         9aJPIcz+suaNnrVz/d3NPRC8NynH2Snp2FUrt3699brAvJ8k968NJgoD+f7UKvTvTO
         daHNJMrdIjsRcXQuI2B1plmQK8rwYHKsPshwt42Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTL-8J; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/80] scripts: kernel-doc: fix typedef identification
Date:   Tue, 13 Oct 2020 13:53:21 +0200
Message-Id: <ae4ab3c56731fd8c1e2da28ba3f531f9c54e4a50.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

