Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6B1EA0C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgFAJTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:09 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51542 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbgFAJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:06 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:19:01 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSr003135;
        Mon, 1 Jun 2020 12:19:00 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 3/8] platform_data/mlxreg: Add support for complex attributes
Date:   Mon,  1 Jun 2020 12:18:46 +0300
Message-Id: <20200601091851.5491-4-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601091851.5491-1-vadimp@mellanox.com>
References: <20200601091851.5491-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new field 'regnum' to the structure 'mlxreg_core_data' to specify
the number of registers occupied by multi-register attribute.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 include/linux/platform_data/mlxreg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index b8da8aef2446..a2adc3ad45f2 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -80,6 +80,7 @@ struct mlxreg_hotplug_device {
  * @hpdev - hotplug device data;
  * @health_cntr: dynamic device health indication counter;
  * @attached: true if device has been attached after good health indication;
+ * @regnum: number of registers occupied by multi-register attribute;
  */
 struct mlxreg_core_data {
 	char label[MLXREG_CORE_LABEL_MAX_SIZE];
@@ -92,6 +93,7 @@ struct mlxreg_core_data {
 	struct mlxreg_hotplug_device hpdev;
 	u8 health_cntr;
 	bool attached;
+	u8 regnum;
 };
 
 /**
-- 
2.11.0

