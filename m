Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15F01EA0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFAJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:15 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51592 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727959AbgFAJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:11 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:19:08 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSv003135;
        Mon, 1 Jun 2020 12:19:07 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 7/8] platform_data/mlxreg: Add presence register field for FAN devices
Date:   Mon,  1 Jun 2020 12:18:50 +0300
Message-Id: <20200601091851.5491-8-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601091851.5491-1-vadimp@mellanox.com>
References: <20200601091851.5491-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new field 'reg_prsnt' to the structure 'mlxreg_core_data' to
provide the number FAN drawers equpped within the system. The purpose
is to allow mapping between FAN drawers and FAN rotors (tachometer),
since FAN drawer can be eqipped with a few rotors.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 include/linux/platform_data/mlxreg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index a2adc3ad45f2..9cffa9a64ab3 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -75,6 +75,7 @@ struct mlxreg_hotplug_device {
  * @mask: attribute access mask;
  * @bit: attribute effective bit;
  * @capability: attribute capability register;
+ * @reg_prsnt: attribute presence register;
  * @mode: access mode;
  * @np - pointer to node platform associated with attribute;
  * @hpdev - hotplug device data;
@@ -88,6 +89,7 @@ struct mlxreg_core_data {
 	u32 mask;
 	u32 bit;
 	u32 capability;
+	u32 reg_prsnt;
 	umode_t	mode;
 	struct device_node *np;
 	struct mlxreg_hotplug_device hpdev;
-- 
2.11.0

