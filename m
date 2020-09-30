Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A775427E9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgI3N2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbgI3NZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:20 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A311520759;
        Wed, 30 Sep 2020 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472319;
        bh=pjtLSShGVJ4I7BmxpKk6Me+K3EVo/+mLjtcA7g+j7Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R57g7AaMmZxV6Fk3hYcYEse3OV9eItrHtNoG9aZ5fDR4iTcb9cErZBfCFuE4kVSZk
         lmnPuIWDtzpGvN4PcCqtf3exxIl7sIcfnDHJuWOnPQRqw4eh+Dp5/+GrD7LGCajG9R
         DnMIAxyvDMZLDUW9zYXOplQw9ooS2MQporC0zbdc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6f-001XJ8-Q2; Wed, 30 Sep 2020 15:25:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/52] scripts: kernel-doc: fix typedef identification
Date:   Wed, 30 Sep 2020 15:24:31 +0200
Message-Id: <f74e49b8eb75b9b20da2710f861d3f84fe1ece56.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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
index 6588a0d27fe4..a0344c78c641 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1741,30 +1741,48 @@ sub dump_function($$) {
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

