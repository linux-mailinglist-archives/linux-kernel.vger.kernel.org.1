Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959201AAACE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392399AbgDOOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634618AbgDOOp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B4F20936;
        Wed, 15 Apr 2020 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=ZsscMf1AfiINRcBazOWFTEXY2GF/mu4vBXJRAZLmuwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIhwo/yjnbYuhcaHmXv9Vj0iktmwEQdGF4mSg4TsFuSoHgjDj8vkfjtekGmb8RJgd
         XyJzsK3vTtOixEb3ULWtFRZ55aVQfqVivvq3Vh2vxrhiIIwlfYwNuQlWn34W99/y0l
         kHrzk9CTNhZw1dn+qt7Sp3TauwT8eex5A4wAKjes=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZJ-5e; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 03/12] docs: dt: usage_model.rst: fix link for DT usage
Date:   Wed, 15 Apr 2020 16:45:17 +0200
Message-Id: <5af2521377cecc4b5f7cc9253600ff335c596ee2.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree.org doesn't host the Device_Tree_Usage page
anymore. So, fix the link to point to a new address.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/usage-model.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index 326d7af10c5b..e1b42dc63f01 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -12,7 +12,7 @@ This article describes how Linux uses the device tree.  An overview of
 the device tree data format can be found on the device tree usage page
 at devicetree.org\ [1]_.
 
-.. [1] http://devicetree.org/Device_Tree_Usage
+.. [1] https://elinux.org/Device_Tree_Usage
 
 The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
 structure and language for describing hardware.  More specifically, it
-- 
2.25.2

