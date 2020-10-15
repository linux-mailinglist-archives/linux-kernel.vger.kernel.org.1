Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8577628EE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbgJOIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgJOIMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:12:18 -0400
Received: from mail.kernel.org (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C472225F;
        Thu, 15 Oct 2020 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602749538;
        bh=Rrf1VCBA+6H+AvBz4ghy3QPFEp+YTsbvEvIh5bSjGOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSOmfreMm2peZmETjQIpLcMLucLerjuVC1bvHbARvxglt6rRjkfC6LUXm7YQUvzrA
         v7oSY5x5kyqGKonhVwEMBeInKKMWuGITxsqZOf+IT41+QWg6EG+CFgFKNyOpQK4TrL
         RMJ8/SPeKhLRplOy1CA90FAcsg4RQbxuP42awKMw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSyMw-000MSn-VT; Thu, 15 Oct 2020 10:12:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sphinx: conf.py: properly handle Sphinx 4.0
Date:   Thu, 15 Oct 2020 10:12:12 +0200
Message-Id: <c8c01144fede9bd7209298bbeb185560eb60b94d.1602749214.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602749214.git.mchehab+huawei@kernel.org>
References: <cover.1602749214.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the checks for Sphinx 3+ is broken, causing some
C warnings to return back with Sphinx 4.0.x.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 4f5d15abd047..a92442e70211 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -50,7 +50,7 @@ if major >= 3:
         support for Sphinx v3.0 and above is brand new. Be prepared for
         possible issues in the generated output.
         ''')
-    if minor > 0 or patch >= 2:
+    if (major > 3) or (minor > 0 or patch >= 2):
         # Sphinx c function parser is more pedantic with regards to type
         # checking. Due to that, having macros at c:function cause problems.
         # Those needed to be scaped by using c_id_attributes[] array
-- 
2.26.2

