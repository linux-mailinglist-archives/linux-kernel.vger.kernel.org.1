Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5E2C28F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgKXOE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:04:29 -0500
Received: from mail8130c14.megamailservers.com ([66.226.81.30]:36388 "EHLO
        mail8130c14.megamailservers.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729631AbgKXOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:04:28 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 09:04:27 EST
Received: from laptop-stagiaire.cogeco.local (205-237-37-161.resi.cgocable.ca [205.237.37.161])
        by mail8130c14.megamailservers.com (mail8130c14) with ESMTP id 71071925B9DFA;
        Tue, 24 Nov 2020 08:57:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cogeco.ca; s=email;
        t=1606226272; bh=5XvQdPYTylaRI8rioJopVJ3xTlgNPLbCIOmMKOpVpRY=;
        h=From:To:Cc:Subject:Date:From;
        b=bL8i71xuq3Qz8+1FzpPtEN25syfDxgGSeux/6glbpQiHKRjC2oHn+o+Tx5uTtOcii
         MwBLo/OsO3hInzJEsXdon+1nIIhT+zUbsqP9AWBvEXybDGwD7uN5VaAzG/18TNX10z
         XSNhZgIKTVTtyCwjRHt6lp0GxGWa6nJcxevNnXZA=
Feedback-ID: pduplessis@effi
From:   Philippe Duplessis-Guindon <pduplessis@efficios.com>
To:     linux-trace-devel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org,
        Philippe Duplessis-Guindon <pduplessis@efficios.com>
Subject: [RFC PATCH v2] tracing: Remove duplicate `type` field from regmap `regcache_sync` trace event
Date:   Tue, 24 Nov 2020 08:57:30 -0500
Message-Id: <20201124135730.9185-1-pduplessis@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CSC:  0
X-CHA:  v=2.3 cv=AtiQI91P c=1 sm=1 tr=0 a=f1nIe4+vFTFun24hu6c7KQ==:117
        a=f1nIe4+vFTFun24hu6c7KQ==:17 a=10vEtgdfLSAA:10 a=7d_E57ReAAAA:8
        a=0rblXdn-GvIh5LTTVtcA:9 a=jhqOcbufqs7Y1TYCrUUU:22
X-CTCH-RefID: str=0001.0A742F1A.5FBD1160.0025,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-VADE-SPAMSTATE: clean
X-VADE-SPAMSCORE: -100
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffquffvqffrkfetpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheprfhhihhlihhpphgvucffuhhplhgvshhsihhsqdfiuhhinhguohhnuceophguuhhplhgvshhsihhssegvfhhfihgtihhoshdrtghomheqnecuggftrfgrthhtvghrnhepleeugfehfeekieekfeetgfehgefhudevhedtveegkedthefgieeggeeiieekhefhnecukfhppedvtdehrddvfeejrdefjedrudeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtdehrddvfeejrdefjedrudeiuddphhgvlhhopehlrghpthhophdqshhtrghgihgrihhrvgdrtghoghgvtghordhlohgtrghlpdhmrghilhhfrhhomheprfhhihhlihhpphgvucffuhhplhgvshhsihhsqdfiuhhinhguohhnuceophguuhhplhgvshhsihhssegvfhhfihgtihhoshdrtghomheqpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtohep
 lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphguuhhplhgvshhsihhssegvfhhfihgtihhoshdrtghomh
X-Origin-Country: CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have an error saying that `regcache_sync` has 2 fields named `type`
while using libtraceevent.

Erase the `int field` type, which is not assigned. This field is
introduced by mistake and this commit removes it.

Fixes commit 593600890110c ("regmap: Add the regcache_sync trace event")

Signed-off-by: Philippe Duplessis-Guindon <pduplessis@efficios.com>
---
 drivers/base/regmap/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
index d4066fa079ab..9abee14df9ee 100644
--- a/drivers/base/regmap/trace.h
+++ b/drivers/base/regmap/trace.h
@@ -126,7 +126,6 @@ TRACE_EVENT(regcache_sync,
 		__string(       name,           regmap_name(map)	)
 		__string(	status,		status			)
 		__string(	type,		type			)
-		__field(	int,		type			)
 	),
 
 	TP_fast_assign(
-- 
2.25.1

