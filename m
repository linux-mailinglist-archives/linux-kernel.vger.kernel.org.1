Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DA29A970
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897960AbgJ0KUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897943AbgJ0KUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:20:42 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC75522263;
        Tue, 27 Oct 2020 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603794042;
        bh=Ao3Z/vbaYJEZ8jrhigPpZqxaXb+fWYTAhGa5LhBicd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf/2jPc7Ai88KXqPdvABOHxfzZ51Nau9Ea8/jRjxAY8lyENimqH0IM3BCNGBv9pOW
         Ohxvc+4JAsU5RbrEo5lEXPIfwQzxhSP1OPSN9hmps+Y8piqk+sMfNTQeb2ygmo6oK/
         UrjTBLBGaM2Qy1pDoz875CpKjbk7objsFCBAIR64=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXM5n-003Fgi-HG; Tue, 27 Oct 2020 11:20:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] scripts: kernel-doc: split typedef complex regex
Date:   Tue, 27 Oct 2020 11:20:37 +0100
Message-Id: <3a4af999a0d62d4ab9dfae1cdefdfcad93383356.1603792384.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603792384.git.mchehab+huawei@kernel.org>
References: <cover.1603792384.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typedef regex for function prototypes are very complex.
Split them into 3 separate regex and then join them using
qr.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 698835909ac1..f699cf05d409 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1431,17 +1431,21 @@ sub dump_enum($$) {
     }
 }
 
+my $typedef_type = qr { ((?:\s+[\w\*]+){1,8})\s* }x;
+my $typedef_ident = qr { \*?\s*(\w\S+)\s* }x;
+my $typedef_args = qr { \s*\((.*)\); }x;
+
+my $typedef1 = qr { typedef$typedef_type\($typedef_ident\)$typedef_args }x;
+my $typedef2 = qr { typedef$typedef_type$typedef_ident$typedef_args }x;
+
 sub dump_typedef($$) {
     my $x = shift;
     my $file = shift;
 
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
 
-    # Parse function prototypes
-    if ($x =~ /typedef((?:\s+[\w\*]+){1,8})\s*\(\*?\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
-	$x =~ /typedef((?:\s+[\w\*]+\s+){1,8})\s*\*?(\w\S+)\s*\s*\((.*)\);/) {
-
-	# Function typedefs
+    # Parse function typedef prototypes
+    if ($x =~ $typedef1 || $x =~ $typedef2) {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
-- 
2.26.2

