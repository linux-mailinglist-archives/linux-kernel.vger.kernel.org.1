Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88380280D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 07:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgJBFuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 01:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgJBFt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 01:49:59 -0400
Received: from mail.kernel.org (ip5f5ad59f.dynamic.kabel-deutschland.de [95.90.213.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CED20796;
        Fri,  2 Oct 2020 05:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601617798;
        bh=sTwGnquoE6P2N3xCIRO9CZ2Os6A80mTdNqw5RZU1SyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LO/yhVjpcKKYyooCaLTv+Auj+IRmFi1qXp6f+Nlpzm4Dl0nWPYW5Qw0Rk/AFH0e0u
         JAdr2UncxBX6V0kfPK5Br6yHvCdLGxK7bHA+/Dw/GONDcggVRXpK8G+vZf+Bf11lOr
         fum2cdAd3wNLjAcbamr47ooKDjH2QZVemXVPmApA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kODx6-006hit-By; Fri, 02 Oct 2020 07:49:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jonathan Corbet" <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] scripts: kernel-doc: add support for typedef enum
Date:   Fri,  2 Oct 2020 07:49:49 +0200
Message-Id: <f381c13667d8794a941457f5ef771fe34788e831.1601616399.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601616399.git.mchehab+huawei@kernel.org>
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
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
index d94e28fcead0..5ac3749905e5 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1339,14 +1339,22 @@ sub show_warnings($$) {
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
@@ -1381,8 +1389,7 @@ sub dump_enum($$) {
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

