Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4022510F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgHYE4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:56:50 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:38442 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbgHYE4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:56:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5B1DE182CED2A;
        Tue, 25 Aug 2020 04:56:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:2898:3138:3139:3140:3141:3142:3352:3865:3866:3868:3872:4321:4605:5007:6119:6261:10004:10848:11026:11658:11914:12043:12297:12438:12555:12895:12986:13870:13894:13972:14181:14394:14721:21080:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cover96_0806a5227059
X-Filterd-Recvd-Size: 3208
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, Robert Richter <rric@kernel.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: [PATCH 02/29] alpha: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:55:59 -0700
Message-Id: <4facd57f80c70437f085ba3a1bcf13ae0b63c3bc.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/alpha/kernel/pci_iommu.c      |  8 +++++---
 arch/alpha/oprofile/op_model_ev4.c | 22 ++++++++++++++--------
 arch/alpha/oprofile/op_model_ev5.c |  8 +++++---
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 81037907268d..b8af7ad6c607 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -161,10 +161,12 @@ iommu_arena_find_pages(struct device *dev, struct pci_iommu_arena *arena,
 			goto again;
 		}
 
-		if (ptes[p+i])
-			p = ALIGN(p + i + 1, mask + 1), i = 0;
-		else
+		if (ptes[p+i]) {
+			p = ALIGN(p + i + 1, mask + 1);
+			i = 0;
+		} else {
 			i = i + 1;
+		}
 	}
 
 	if (i < n) {
diff --git a/arch/alpha/oprofile/op_model_ev4.c b/arch/alpha/oprofile/op_model_ev4.c
index 086a0d5445c5..004f80a4291f 100644
--- a/arch/alpha/oprofile/op_model_ev4.c
+++ b/arch/alpha/oprofile/op_model_ev4.c
@@ -46,18 +46,24 @@ ev4_reg_setup(struct op_register_config *reg,
 	   map it onto one of the possible values, and write it back.  */
 
 	count = ctr[0].count;
-	if (count <= 4096)
-		count = 4096, hilo = 1;
-	else
-		count = 65536, hilo = 0;
+	if (count <= 4096) {
+		count = 4096;
+		hilo = 1;
+	} else {
+		count = 65536;
+		hilo = 0;
+	}
 	ctr[0].count = count;
 	ctl |= (ctr[0].enabled && hilo) << 3;
 
 	count = ctr[1].count;
-	if (count <= 256)
-		count = 256, hilo = 1;
-	else
-		count = 4096, hilo = 0;
+	if (count <= 256) {
+		count = 256;
+		hilo = 1;
+	} else {
+		count = 4096;
+		hilo = 0;
+	}
 	ctr[1].count = count;
 	ctl |= (ctr[1].enabled && hilo);
 
diff --git a/arch/alpha/oprofile/op_model_ev5.c b/arch/alpha/oprofile/op_model_ev5.c
index c300f5ef3482..6f52244e1181 100644
--- a/arch/alpha/oprofile/op_model_ev5.c
+++ b/arch/alpha/oprofile/op_model_ev5.c
@@ -92,9 +92,11 @@ common_reg_setup(struct op_register_config *reg,
 		if (!ctr[i].enabled)
 			continue;
 
-		if (count <= 256)
-			count = 256, hilo = 3, max = 256;
-		else {
+		if (count <= 256) {
+			max = 256;
+			hilo = 3;
+			count = 256;
+		} else {
 			max = (i == 2 ? 16384 : 65536);
 			hilo = 2;
 			if (count > max)
-- 
2.26.0

