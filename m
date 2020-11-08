Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC52AABB4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgKHPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:01:09 -0500
Received: from mout01.posteo.de ([185.67.36.65]:51390 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHPBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:01:09 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 07AAD16005C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 16:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1604847667; bh=j4NtEyY0TPhEih2tWYK0zsBOnE2tBviMpYDeQpDvF+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=AlXiF0Ue2E3tMkA4s5ybvZ3JzBXLoQaeXfml5GUmD13bDsb0pQqe8SChFxyCi+I5r
         gouIHlG6QkhTahxNFG7QU9XZTp4+qORKCWNBHzfUt/kraM756zrrX19OLG1RH2aRsZ
         YjOEou4yScrOG1DjGGMorQ63YKZXUNlLK9jUPnMNO5DS5Ue/74pqI7dwIJiwZpRazv
         IfF98c1zZZVdoChd6xh+I6BVH/2ttC5OepZUPV9XdnWaKrHZVOg6rweZdoCT1uSrnj
         vsJWadA6yolkuu3i4/Z/MtqNMh0bS8ajlfVfn5RUb8076qswi6BQv8SQMdhiZf5abd
         5jBFC3M5w30ow==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CTcl569Jmz9rxV;
        Sun,  8 Nov 2020 16:01:05 +0100 (CET)
Date:   Sun, 8 Nov 2020 16:01:04 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] documentation: arm: sunxi: add Allwinner H616 documents
Message-ID: <20201108150104.GA66507@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the current and cleaned Allwinner H616 datasheet and user manual.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/arm/sunxi.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
index 0c536ae1d7c2..b85d1e2f2d47 100644
--- a/Documentation/arm/sunxi.rst
+++ b/Documentation/arm/sunxi.rst
@@ -158,3 +158,13 @@ SunXi family
 	* User Manual
 
 	  https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf
+
+      - Allwinner H616
+
+	* Datasheet
+
+	  https://linux-sunxi.org/images/b/b9/H616_Datasheet_V1.0_cleaned.pdf
+
+	* User Manual
+
+	  https://linux-sunxi.org/images/2/24/H616_User_Manual_V1.0_cleaned.pdf
-- 
2.29.2

