Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2C28CCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgJMLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbgJMLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:40 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A9B21582;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=WH7NQxltJQ8vKrUjPm4oW9OKV59fzbWXlQA+seUql9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdCyIDanYltgh5iY2S9O/jR/JqiaBmzvhMxekMDWHtnUZsW1iUlyiv3DbhHj4b3OD
         YTiT3ruV42gBo9rnghqzypStJ4io0VSw/Xh2+QqhnhBnmybdduElwGUqQwXAOCk4QS
         ZaIbufuXA3blaJNSibzOjsNEYchT/QEVrKEfnjTI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CT5-3x; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jonathan Corbet" <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/80] scripts: kernel-doc: add support for typedef enum
Date:   Tue, 13 Oct 2020 13:53:16 +0200
Message-Id: <2a2ef251d948cda935689473359fe0da8bb9713e.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY kernel-doc markup has gained support for documenting
a typedef enum.

However, right now the parser was not prepared for it.

So, add support for parsing it.

Fixes: 4069a572d423 ("net: phy: Document core PHY structures")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 724528f4b7d6..adc05406c68e 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1265,14 +1265,22 @@ sub show_warnings($$) {
 sub dump_enum($$) {
     my $x = shift;
     my $file = shift;
+    my $members;
+
 
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     # strip #define macros inside enums
     $x =~ s@#\s*((define|ifdef)\s+|endif)[^;]*;@@gos;
 
-    if ($x =~ /enum\s+(\w*)\s*\{(.*)\}/) {
+    if ($x =~ /typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;/) {
+	$declaration_name = $2;
+	$members = $1;
+    } elsif ($x =~ /enum\s+(\w*)\s*\{(.*)\}/) {
 	$declaration_name = $1;
-	my $members = $2;
+	$members = $2;
+    }
+
+    if ($declaration_name) {
 	my %_members;
 
 	$members =~ s/\s+$//;
@@ -1307,8 +1315,7 @@ sub dump_enum($$) {
 			    'sections' => \%sections,
 			    'purpose' => $declaration_purpose
 			   });
-    }
-    else {
+    } else {
 	print STDERR "${file}:$.: error: Cannot parse enum!\n";
 	++$errors;
     }
-- 
2.26.2

