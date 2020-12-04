Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B422CF0CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgLDPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbgLDPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:33:15 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] scripts: get_feat.pl: change the group by order
Date:   Fri,  4 Dec 2020 16:32:29 +0100
Message-Id: <46d53d138eab8e4a55124323ceb5b212c6eedd08.1607095090.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607095090.git.mchehab+huawei@kernel.org>
References: <cover.1607095090.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, arch compatibility is grouped by status at the
alphabetical order from A to Z, and then from a to z, e. g:.

	---
	TODO
	ok

Revert the order, in order to print first the OK results,
then TODO, and, finally, the not compatible ones.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_feat.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 10bf23fbc9c5..3f73c8534059 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -397,7 +397,7 @@ sub output_matrix {
 		my @lines;
 		my $line = "";
 		foreach my $arch (sort {
-					($arch_table{$a} cmp $arch_table{$b}) or
+					($arch_table{$b} cmp $arch_table{$a}) or
 					("\L$a" cmp "\L$b")
 				       } keys %arch_table) {
 
-- 
2.28.0

