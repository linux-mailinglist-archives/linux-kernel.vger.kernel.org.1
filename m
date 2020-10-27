Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE429A4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506723AbgJ0Gan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:30:43 -0400
Received: from multi-universum.de ([46.4.106.216]:45030 "EHLO
        nano.multi-universum.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2443733AbgJ0Gaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:30:30 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 02:30:30 EDT
Received: from monster.powergraphx.local (125-137-165-046.ip-addr.inexio.net [46.165.137.125])
        by nano.multi-universum.de (Postfix) with ESMTPSA id 23BAA2C0229;
        Tue, 27 Oct 2020 07:24:10 +0100 (CET)
Date:   Tue, 27 Oct 2020 07:24:08 +0100
From:   Wilken Gottwalt <wilken.gottwalt@linux-addicted.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2] documentation: arm: sunxi: add Allwinner H6 documents
Message-ID: <20201027062408.GA6761@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the current Allwinner H6 datasheet and user manual.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@linux-addicted.net>
---
Changes in v2:
	- changed email because of serious problems between my old email
	  provider and the lkml
---
 Documentation/arm/sunxi.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
index 62b533d0ba94..0c536ae1d7c2 100644
--- a/Documentation/arm/sunxi.rst
+++ b/Documentation/arm/sunxi.rst
@@ -148,3 +148,13 @@ SunXi family
         * User Manual
 
           http://dl.linux-sunxi.org/A64/Allwinner%20A64%20User%20Manual%20v1.0.pdf
+
+      - Allwinner H6
+
+	* Datasheet
+
+	  https://linux-sunxi.org/images/5/5c/Allwinner_H6_V200_Datasheet_V1.1.pdf
+
+	* User Manual
+
+	  https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf
-- 
2.29.0

