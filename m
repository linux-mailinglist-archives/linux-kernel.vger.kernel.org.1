Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB16252B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgHZKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 06:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgHZKri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:38 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE84206EB;
        Wed, 26 Aug 2020 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438857;
        bh=BXGjvj2YrbZhIVzM1s1K593e8KBsZNVDOudP8Rkf7D4=;
        h=From:To:Cc:Subject:Date:From;
        b=GROkWjWSPv5nNmsZ+7TO8qBXYCpdh4x2eaWbJYAS1X7mX3o0GaOvL81W1yGkArcT5
         6vfkyvjMsJ7G+IkTIVv8Rn7WFa6lWIJrgQ5ZY4uMOtisIDt3yobgMlVCXqrlHRIhwz
         +QH5bWpegjCDEribF+L+TWEaLFiwlrlWR3bAcrgw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxr-002EHW-7s; Wed, 26 Aug 2020 12:47:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] net: appletalk: Kconfig: Fix docs location
Date:   Wed, 26 Aug 2020 12:47:34 +0200
Message-Id: <20200826104734.531509-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of ltpc.rst changed. Update it at Kconfig.

Fixes: 4daedf7abb41 ("docs: networking: move AppleTalk / LocalTalk drivers to the hw driver section")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/net/appletalk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
index d4f22a2e5be4..43918398f0d3 100644
--- a/drivers/net/appletalk/Kconfig
+++ b/drivers/net/appletalk/Kconfig
@@ -48,7 +48,7 @@ config LTPC
 	  If you are in doubt, this card is the one with the 65C02 chip on it.
 	  You also need version 1.3.3 or later of the netatalk package.
 	  This driver is experimental, which means that it may not work.
-	  See the file <file:Documentation/networking/ltpc.rst>.
+	  See the file <file:Documentation/networking/device_drivers/appletalk/ltpc.rst>.
 
 config COPS
 	tristate "COPS LocalTalk PC support"
-- 
2.26.2

