Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD01A8653
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391933AbgDNQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407441AbgDNQtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:07 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814A3208E0;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=ooW89rST4GmeQXzLWvXim86Mk5Dn0bBASsKnbkuiJgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/h4bzHwGxyqczskNEQfRZpxxAgfBmmh2Z3GMM8x/8X1Xd+/yfC5/zQGgvxpGG4+v
         LRxocrqPTpJpT4s5UHBKgNUhIV/tZ+HZAgQeITtYXLCo1IBFHi6mf+j6rNlj+lPvkX
         mydsV7t/6s1kBhxL4eV7TdNqdJ3HaIyvrmzgKHfs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lX-Of; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yuti Amonkar <yamonkar@cadence.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 08/33] docs: dt: fix broken reference to phy-cadence-torrent.yaml
Date:   Tue, 14 Apr 2020 18:48:34 +0200
Message-Id: <3f1cf6d74e392f3ee9f894d82cb7ee29d04c1b6d.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was removed, and another file was added instead of
it, on two separate commits.

Splitting a single logical change (doc conversion) on two
patches is a bad thing, as it makes harder to discover what
crap happened.

Anyway, this patch fixes the broken reference, making it
pointing to the new location of the file.

Fixes: 922003733d42 ("dt-bindings: phy: Remove Cadence MHDP PHY dt binding")
Fixes: c6d8eef38b7f ("dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index fd1982c56104..3f913d6d1c3d 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -146,7 +146,7 @@ patternProperties:
       bindings specified in
       Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
       Torrent SERDES should follow the bindings specified in
-      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+      Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 
 required:
   - compatible
-- 
2.25.2

