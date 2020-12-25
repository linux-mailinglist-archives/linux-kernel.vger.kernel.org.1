Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7442E2B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 11:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgLYJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 04:55:32 -0500
Received: from ptr.189.cn ([183.61.185.101]:10944 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgLYJzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 04:55:31 -0500
HMM_SOURCE_IP: 10.64.10.46:56014.1951954204
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.46])
        by 189.cn (HERMES) with SMTP id 4302A1009C3;
        Fri, 25 Dec 2020 17:52:30 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-2jgfg with ESMTP id 87cf8922129a4226b81fe47981ea377f for greg@kroah.com;
        Fri Dec 25 17:52:31 2020
X-Transaction-ID: 87cf8922129a4226b81fe47981ea377f
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH] staging: board: description for CONFIG_STAGING_BOARD
Date:   Fri, 25 Dec 2020 17:52:38 +0800
Message-Id: <1608889958-32118-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A paragraph to describe what CONFIG_STAGING_BOARD is for,
to help developers have better understanding.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 drivers/staging/board/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
index d0c6e42..64c7797 100644
--- a/drivers/staging/board/Kconfig
+++ b/drivers/staging/board/Kconfig
@@ -3,7 +3,10 @@ config STAGING_BOARD
 	bool "Staging Board Support"
 	depends on OF_ADDRESS && OF_IRQ && CLKDEV_LOOKUP
 	help
-	  Select to enable per-board staging support code.
-
-	  If in doubt, say N here.
+	  Staging board base is to support continuous upstream
+	  in-tree development and integration of platform devices.
 
+	  Helps developers integrate devices as platform devices for
+	  device drivers that only provide platform device bindings.
+	  This in turn allows for incremental development of both
+	  hardware feature support and DT binding work in parallel.
-- 
2.7.4

